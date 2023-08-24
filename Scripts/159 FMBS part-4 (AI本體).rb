# ▽△▽ バトルシステム 1. Full-Move Battle System バトラーAI. ▽△▽ built 033011
# by 桜雅 在土
#==============================================================================
# □ Game_BattlerAI
#==============================================================================
class Game_BattlerAI
  #--------------------------------------------------------------------------
  # ○ 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_accessor :wait_duration         # AI.待ち時間
  attr_accessor :above_duration        # AI.上空の敵に対するジャンプ待ち時間
  attr_reader   :target        # 決定的目標
  attr_accessor :guard_duration        # AI防禦時間

  attr_reader   :dash_flag                 #AI衝刺標誌
  attr_reader   :front_flee_cd           # 前滾翻移動冷卻   
  attr_reader   :timelyguard_cd        # 瞬間防禦冷卻
  attr_accessor :combohold_count        # 連段自重計數
  attr_reader   :jump_cd                     # 不跳躍的時間
  attr_accessor :daze_time         # 不攻擊的時間
  attr_accessor :daze_cold         # 上面時間的禁止時間
  attr_accessor :ai_mode                     # 行為模式(standby：待機、move：移動)
  attr_accessor :mode_change_time    # 轉換行為的時間
  attr_accessor :combo_list 
  
  attr_accessor :ai_trigger           # AI出招判斷變數
  
  attr_reader :target_distance_x_min  # 攻擊行動最低 X 距離
  attr_reader :target_distance_x_max   # 攻擊行動最高 X 距離
  attr_reader :target_distance_y_min   # 攻擊行動最低 Y 距離
  attr_reader :target_distance_y_max   # 攻擊行動最高 Y 距離
  
  
  attr_accessor :attacking_time     # 出招後經過時間
  attr_accessor :hit_time   # 招式命中後經過時間(目押用)
  attr_accessor :contact_time   #招式接觸後經過時間(目押用)
  attr_accessor :guard_time    # 招式命中後經過時間(目押用) (對方擋下的情況)
  attr_accessor :debug_action_result           # 用哪個方式確定行動
  #--------------------------------------------------------------------------
  # ○ 初期化
  #--------------------------------------------------------------------------
  def initialize(battler)
    @me = battler  # 獲取自身的Battler
    @ai_random = 0  # 仿mugen的隨機判定(0~999)  
    # ↑註：如果每個判斷都用各自的隨機數可能會發生每招都用不出來的情形，固統一
    
    set_ai_level
    
    @daze_cold = 0
    @daze_time = 0
    @combohold_count = 0
    @guard_duration = 0
    @wait_duration = 0
    @target_skill =  ""  # 目標使用的技能
    @do_timelyguard = false
    @attacking_time = 0    # 出招後經過時間
    @contact_time = 0        # 招式接觸後經過時間(目押用) 
    @hit_time = 0                # 招式命中後經過時間(目押用) (對方沒擋下的情況)
    @guard_time = 0           # 招式命中後經過時間(目押用) (對方擋下的情況)
    @debug_action_result = 0
    
    # 要注意的對方名稱 (對，就是妳，芮德兒)
    @counter_name = ["Red_Sickle", "Red_SickleEX", "DarkRedS", "EX_DarkRedS"]
    
    clear
  end
  #--------------------------------------------------------------------------
  # ○ 設定AI等級
  #--------------------------------------------------------------------------
  def set_ai_level
    if @me.is_a?(Game_Enemy)
      @ai_level = $game_variables[STILILA::GAME_LEVEL] 
    else
      @ai_level = [$game_variables[STILILA::GAME_LEVEL]-1, 1].max
    end
    # 重設自重度
    case  @ai_level
    when 0
      @combo_limit = 2
    when 1
      @combo_limit = 3
    when 2
      @combo_limit = 5
    when 3
      @combo_limit = 99 # 99
    end
  end
  #--------------------------------------------------------------------------
  # ○ 設定AI等級
  #--------------------------------------------------------------------------
  def check_ai_level
    return @ai_level
  end
  
  
  #--------------------------------------------------------------------------
  # ○ クリア
  #--------------------------------------------------------------------------
  def clear
    @combo_list = []   # 整套連段清單
    @above_duration    = 0
    @front_flee_cd = 0        
    @timelyguard_cd = 0
    @jump_cd = 0
    @target         = nil # 攻擊對象
    @behavior_phase = 0     # 行為階段(0：接近、1：觀察情況、2：攻擊)
    @ai_mode = "move"
    @mode_change_time = 10 + rand(60)
    @timelyguard_knackered = 0  # 瞬防疲勞(防止連發)
  end
  
  
  #--------------------------------------------------------------------------
  # ○ 反制芮德兒地面連
  #--------------------------------------------------------------------------
  def counter_red_ground_combo?
    if ["damage1", "damage2", "guard", "guard_shock"].include?(previous_action)
      return (@ai_level == 3 and @counter_name.include?(@target.name) and @target.motion.state == "6z" and (0..170) === dist_x and @ai_random > 300)
    else
      return (@ai_level == 3 and @counter_name.include?(@target.name) and @target.motion.state == "6z" and (0..170) === dist_x and @target.motion.anime_time < 6 and @ai_random > 800)
    end
    
    
  end 
  
  #--------------------------------------------------------------------------
  # ○ 往下個行動
  #--------------------------------------------------------------------------
  def do_next
    # 重新決定目標
    do_decide_target
  end
  #--------------------------------------------------------------------------
  # ○ 決定目標
  #--------------------------------------------------------------------------
  def do_decide_target
    #
    # --- 行動決定 ---
    #
    
    # 檢查同伴
    if @me.is_a?(Game_Actor)
      friends = $game_party.actors
    else
      friends = $game_troop.enemies
    end
    # ---決定目標 ---
    targets = []
    if @me.is_a?(Game_Actor)
      for target in $game_troop.enemies
        targets.push(target) if target.exist?# unless target.dead?
      end
    else
      for target in $game_party.actors
        targets.push(target) if target.exist?# unless target.dead?
      end
    end
    if targets.size == 0
      @target = nil
      return
    end
    # 初期設定
    decision = targets[0]
    if targets.size >= 0
      max = 6000
      for target in targets
        diff = (target.x_pos - @me.x_pos).abs 
        diff_y = (target.y_pos - @me.y_pos).abs 
        
        if diff <= max and diff_y < 400
          max = diff
          decision_target = target
        end
      end
    end
   @target = decision_target
  end
 
  
#==============================================================================
# ■ 連段自重
#==============================================================================
  def action_prudent
    return if @target == nil
   # if ((@ai_level == 0 and @target.combohit > 2) or (@ai_level == 1 and @target.combohit > 4) or 
   #   (@ai_level == 2 and @target.combohit > 6))
      return true if @target.combohit > @combo_limit
  #  end
  end

#==============================================================================
# ■ AI反應
#==============================================================================
  def can_reaction?
    result = true
    case @ai_level
    when 0
      if @me.motion.freemove? and @target.motion.state_time > 40 + rand(40)
        result = true
      elsif @me.motion.attacking? and rand(3) > 1
        result = true 
      else
        result = false
      end
    when 1
      if @me.motion.freemove? and @target.motion.state_time > 15 + rand(10)
        result = true
      elsif @me.motion.attacking? and rand(2) > 0
        result = true
      else
        result = false
      end
    end
    return result
  end 
  
  #--------------------------------------------------------------------------
  # ◇ 設定AI自定義變數
  #--------------------------------------------------------------------------  
  def set_ai_trigger(key, val)
    @ai_trigger[key] = val
  end
  #--------------------------------------------------------------------------
  # ○ 上一次用的招
  #--------------------------------------------------------------------------
  def previous_action
    return @me.motion.pre_state
  end
  
  #--------------------------------------------------------------------------
  # ○ 是否面對目標？
  #--------------------------------------------------------------------------
  def confront?
    return if @target.nil?
    return @me.direction ==  ((@target.x_pos - @me.x_pos) > 0 ? 1 : -1)
  end
  #--------------------------------------------------------------------------
  # ○ 目標是否面對自己？
  #--------------------------------------------------------------------------
  def t_confront?
    return if @target.nil?
    return @target.direction ==  ((@me.x_pos - @target.x_pos) > 0 ? 1 : -1)
  end
  #--------------------------------------------------------------------------
  # ○ 轉向目標
  #--------------------------------------------------------------------------
  def turn_to_target
    return if @target.nil?
    return @me.direction =  ((@target.x_pos - @me.x_pos) > 0 ? 1 : -1)
  end
  
  #--------------------------------------------------------------------------
  # ○ 目前狀態
  #--------------------------------------------------------------------------
  def me_state?(s)
    return s.include?(@me.motion.state)
  end
  
  #--------------------------------------------------------------------------
  # ○ 目標完全迴避中？
  #--------------------------------------------------------------------------
  def t_eva?(f)
    return if @target.nil?
    return (@target.motion.eva_invincible_duration - f > 0)
  end
  #--------------------------------------------------------------------------
  # ○ 目標霸體中？
  #--------------------------------------------------------------------------
  def t_sa?(f)
    return if @target.nil?
    return (@target.motion.super_armor - f > 0)
  end
  #--------------------------------------------------------------------------
  # ◇ 計算目標受身可能
  #--------------------------------------------------------------------------  
  def t_ukemi?(frame)
    return if @target.nil?
    return ((@target.motion.knock_back_duration - frame <= 0) and @target.motion.blowning?)
  end
  #--------------------------------------------------------------------------
  # ○ 目標受傷中？
  #--------------------------------------------------------------------------
  def t_damage?(frame)
    return if @target.nil?
    return (@target.motion.knock_back_duration - frame > 0)
  end
  #--------------------------------------------------------------------------
  # ○ 目標攻擊中？
  #--------------------------------------------------------------------------
  def t_attacking?
    return if @target.nil?
    return (@target.motion.attacking?)
  end
  #--------------------------------------------------------------------------
  # ○ 與目標的X距離差
  #--------------------------------------------------------------------------
  def dist_x
    return 0 if @target.nil?
    sign = ((@target.x_pos - @me.x_pos > 0) ? -1 : 1)
    target_rect = @target.body_rect.dup
    return (@target.x_pos+(target_rect.width*sign) - @me.x_pos).to_i.abs
  end
  #--------------------------------------------------------------------------
  # ○ 與目標的Y距離差(正為上，負為下)
  #--------------------------------------------------------------------------
  def dist_y
    return if @target.nil?

    if @target.y_pos - @me.y_pos >= 0
      n = (@target.y_pos - @me.y_pos).to_i 
    else
      h = (@target.y_pos - @me.y_pos).to_i
      n = [h + @target.body_rect.height, 0].min
    end
    return n#(@target.y_pos - @me.y_pos).to_i
  end
  #--------------------------------------------------------------------------
  # ○ 預測目標是否倒地
  #--------------------------------------------------------------------------
  def t_well_down?(n)
    return if @target.nil?
    return ((contact_to_ground(n, @target) <= 0) and @target.motion.blowning?)
  end
  #--------------------------------------------------------------------------
  # ○ 取得動畫進行禎數(攻擊限定)
  #--------------------------------------------------------------------------
  def t_attack_time(f)
    return if @target.nil?
    return false if !@target.motion.attacking?
    return (f >= @target.motion.state_time)
  end
  #--------------------------------------------------------------------------
  # ○ 目標倒地彈跳中
  #--------------------------------------------------------------------------
  def t_downbounce?
    return if @target.nil?
    return ["bounce_f_down", "bounce_b_down"].include?(@target.motion.state)
  end
  #-------------------------------------------------------------------------------
  # ○ 瞬間防禦實行
  #-------------------------------------------------------------------------------
  def timely_guarded
    @do_timelyguard = false
    @timelyguard_knackered += 10
  end
  #--------------------------------------------------------------------------
  # ○ 與目標第N禎的X距離差 (未使用)
  #--------------------------------------------------------------------------
  def dist_x_frame(n, me_speed = nil)
    return if @target.nil?
    
    me_speed = @me.now_x_speed if (me_speed == nil)
    me_y_speed = @me.now_y_speed
    target_speed = @target.now_x_speed
    fmxs = @me.x_pos
    ftxs = @target.x_pos
    fmys = @me.y_pos
    ftys = @target.y_pos
    
    
    
    me_rect = @me.body_rect.dup
    target_rect = @target.body_rect.dup

    
    for i in 0...n
      unless @target.motion.state == 16 
        if !@target.motion.on_air? 
          if target_speed > 0
            target_speed = [target_speed - @target.frict_x_break, 0].max
          elsif @target.now_x_speed < 0
             target_speed = [target_speed + @target.frict_x_break, 0].min
          end  
        elsif @target.motion.on_air?  and @target.motion.controllable?
          # 空気抵抗         
          if target_speed > 0
             target_speed = [target_speed - @target.air_x_resistance, 0].max
          elsif target_speed < 0
             target_speed = [target_speed + @target.air_x_resistance, 0].min
          end
        end
      end  
      forecast_tys = [@target.now_y_speed - @target.air_y_velocity, -@target.air_y_maximum].max
      forecast_tys = 0 if (@target.motion.state == 16) or @target.motion.y_fixed
      ftys += @target.relative_y_destination + forecast_tys.round  ####
      if ftys <= @target.y_min and forecast_tys.abs > 13.9
        ftys += (forecast_tys *= -2/5.0).round
      end
      ftxs += (@target.relative_x_destination +  target_speed.round) #####
      
      if ftxs.abs > $game_temp.battle_field_w.abs
        if ftxs < 0 
          ftxs = -$game_temp.battle_field_w
        else
          ftxs = $game_temp.battle_field_w
        end
      end
      
      if !@me.motion.on_air? 
        if me_speed > 0
          me_speed = [me_speed - @me.frict_x_break, 0].max
        elsif me_speed < 0
          me_speed = [me_speed + @me.frict_x_break, 0].min
        end  
      elsif @me.motion.on_air?  and @me.motion.controllable?
        # 空気抵抗         
        if me_speed > 0
            me_speed = [me_speed - @target.air_x_resistance, 0].max
        elsif me_speed < 0
            me_speed = [me_speed + @target.air_x_resistance, 0].min
        end
      end
      forecast_mys = [me_y_speed - @me.air_y_velocity, -@me.air_y_maximum].max
      forecast_mys = 0 if (@me.motion.state == 16) or @me.motion.y_fixed
      fmys += @me.relative_y_destination + forecast_mys.round  #####
      if fmys <= @me.y_min and forecast_mys.abs > 13.9
        fmys += (forecast_mys *= -2/5.0).round
      end
      fmxs += (@me.relative_x_destination +  me_speed.round)  #####
      
      if fmxs.abs > $game_temp.battle_field_w.abs
        if fmxs < 0 
          fmxs = -$game_temp.battle_field_w
        else
          fmxs = $game_temp.battle_field_w
        end
      end
      
      
      target_rect.x  += ftxs
      target_rect.y  -= ftys
      me_rect.x  += fmxs
      me_rect.y  -= fmys
        
      if $scene.rects_over?(me_rect, target_rect)
        if fmxs > ftxs
          fmxs += 4 if fmxs < $game_temp.battle_field_w - 4
          ftys -= 4 if ftys > -$game_temp.battle_field_w + 4
        else
          fmxs -= 4 if fmxs > -$game_temp.battle_field_w + 4
          ftys += 4 if ftys < $game_temp.battle_field_w - 4
        end
      end  
      
    end

    

    sign = ((@target.x_pos - @me.x_pos > 0) ? -1 : 1)
    target_rect = @target.body_rect.dup
    n = (ftxs+(target_rect.width*sign) -  fmxs).to_i.abs
    con = (@me.direction ==  ((ftxs - fmxs) > 0 ? 1 : -1))

    
  #  n = n.abs
    n *= -1 unless con
  #  p n
    return  n
    
  end
  #--------------------------------------------------------------------------
  # ○ 與目標第N禎的Y距離差
  #--------------------------------------------------------------------------
  def dist_y_frame(n, me_speed = nil)
    return if @target.nil?
    
    me_speed = @me.now_y_speed if (me_speed == nil)
    forecast_me_y_pos = @me.y_pos
    forecast_target_y_pos = @target.y_pos
    dist =  @target.y_pos - @me.y_pos
    n -= @target.motion.hit_stop_duration
    
    
    # 預測目標和自己的Y座標
    unless n <= 0
      for i in 0...n
        forecast_tys = [@target.now_y_speed - @target.air_y_velocity, -@target.air_y_maximum].max
        forecast_tys = 0 if (@target.motion.state == 16) or @target.motion.y_fixed
        forecast_target_y_pos += @target.relative_y_destination + forecast_tys.round
        if forecast_target_y_pos <= @target.y_min and forecast_tys.abs > 13.9
          forecast_target_y_pos += (forecast_tys *= -2/5.0).round
        end
        forecast_mys = [me_speed - @me.air_y_velocity, -@me.air_y_maximum].max
        forecast_mys = 0 if (@me.motion.state == 16) or @me.motion.y_fixed
        forecast_me_y_pos += @me.relative_y_destination + forecast_mys.round
        if forecast_me_y_pos <= @me.y_min and forecast_mys.abs > 13.9
          forecast_me_y_pos += (forecast_mys *= -2/5.0).round
        end
      end
      if forecast_target_y_pos - forecast_me_y_pos >= 0
        dist = (forecast_target_y_pos - forecast_me_y_pos).to_i 
      else
        h = (forecast_target_y_pos - forecast_me_y_pos).to_i
        dist = [h + @target.body_rect.height, 0].min
      end
    end
      
   # return 99999 if variation2 == 0
    return dist#(variation - variation2).to_i
  end
  
  #--------------------------------------------------------------------------
  # ○ 偵測N禎後離地面的距離
  #--------------------------------------------------------------------------
  def contact_to_ground(n, battler, speed = nil)
    return if battler.nil?
    
    speed = battler.now_y_speed if (speed == nil)
    forecast_y_pos = battler.y_pos
    # 落下Y
 
    for i in 0...n
      speed = [speed - battler.air_y_velocity, -battler.air_y_maximum].max
      forecast_y_pos += battler.relative_y_destination + speed.round
      if forecast_y_pos <= battler.y_min and speed.abs > 13.9
        forecast_y_pos += (speed *= -2/5.0).round
      end
    end

   # end
    # 増減値の算出 : 相対 Y 目的位置 + 現在移動
    result = forecast_y_pos
    return result
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ 防禦判斷
  #-------------------------------------------------------------------------------
  def can_guard?
    return if !@me.motion.guardable?
    return if @guard_duration > 0
    return @dr = 4 if (t_confront? && dist_x < 280 and t_attacking? and @target.motion.x_skill? and rand(@ai_level*4) > 2) and @ai_level != 0
 #   return @dr = 3 if  (t_confront? && dist_x < 160 and @target.motion.anime_time > (4 + @ai_level*3) and t_attacking?)
    return @dr = 1 if  (t_confront?  && dist_x < 180 && dist_y < 80 && rand(11-@ai_level**2) < 1 && @ai_level < 2)
    return @dr = 2 if  (t_confront? && t_attacking? && dist_x < 180 && dist_y < 80 && rand(11-@ai_level**2) < 1)
  end
  
  
  #--------------------------------------------------------------------------
  # ○ 目標攻擊中
  #--------------------------------------------------------------------------
  def target_attacking?
    return if @target.nil?
    return (@target.motion.attacking? and !@target.motion.attack_hit_targets.include?(@me))
  end

  

  #--------------------------------------------------------------------------
  # ○ 進行防禦
  #--------------------------------------------------------------------------
  def do_guard
    if @me.motion.guardable? and @me.motion.freemove? and @target.motion.attacking?
      @me.motion.blur_effect = false
      @me.motion.change_anime("guard")
    end
  end
  
  
  #--------------------------------------------------------------------------
  # ○ 目標危險程度 (沒用)
  #--------------------------------------------------------------------------
  def target_crisis_level
    return if @target.nil?
    
    # 預設危機程度為最低
    level = "safe"
    
    # 偵測目標攻擊狀態
    if @target.motion.attacking?
      case @target.motion.skill_phase
      when 3 # 攻擊中
        if (@target.motion.attack_hit_targets.include?(@me)) 
          level = "safe"
        else
          if t_confront?
            if @target.now_x_speed >= 4
              level = "move_attacking"
            else
              level = "attacking"
            end  
          else
            level = "behind"
          end
        end
      when 2 # 準備攻擊
        if t_confront?
          level = "danger"
        else
          level = "behind"
        end
      when 1 # 起手
        if t_confront?
          level = "careful"
        else
          level = "safe"
        end
      else  # 收手、無攻擊
        level = "safe"
      end
    end
    
    # 目標是否在待機中
    level = "standing" if @target.motion.state == "stand"
    level = "walking" if @target.motion.state == "walk"
  #  level = "running"# if @target.motion.state == 2
    level = "on_air" if @target.motion.on_air? and @target.motion.freemove?
    level = "flee" if @target.motion.state.include?("flee")
    level = "behind" if !t_confront?
    # 目標防禦中
    level = "guarding" if @target.guarding?
    level = "downing" if @target.motion.downing?# and !@target.motion.on_air?
    return level
  end
  
  #--------------------------------------------------------------------------
  # ○ 定期更新
  #--------------------------------------------------------------------------
  def update
    return unless @me.exist?
    
    # 生成隨機數
    @ai_random = rand(1000)
    
    @front_flee_cd -= 1 if front_flee_cd > 0
    @daze_time -= 1 if @daze_time > 0
    @daze_cold -= 1 if @daze_cold > 0

    @timelyguard_cd -= 1 if @timelyguard_cd > 0
    @jump_cd -= 1 if @jump_cd > 0
    
    if @wait_duration > 0
       @wait_duration -= 1 
       return
    end
     
    
    
    if @mode_change_time > 0
      @mode_change_time -= 1
    else
      (rand(2) > 0) ? @ai_mode =  "standby" : @ai_mode = "move"
      @mode_change_time = 10 + rand(60 - (@ai_mode == "standby" ? 23 : 0)) 
    end
    
    
    
    # 受身判斷
   # if (@me.motion.blowning? &&  @me.motion.knock_back_duration <= 0) and @wait_duration <= 0
 ##    if [@me.ai_defence_level + 30,100].min > rand(100) 
     #  @me.motion.do_ukemi  
  #   else
    #   @wait_duration = 8
    #   return
    #  end
   # end
    
    # 「操作不能」
  # return unless @me.motion.controllable?

    # 重新決定目標一次
    do_decide_target
  
  
    # 目標不存在時，終止
    if @target.nil? or @target.dead? or !@target.exist?
   #   do_decide_target
      return
    end
    
    
  #  return if @target.nil?
    
    
    # 判定瞬間防禦
 #  @me.motion.timely_guard_time = 1 if can_timely_guard?
    
   # 判斷無法行動的情形 - part2
 #   if  @me.motion.cannot_cancel_act?  
   #   return
   # end 
    #
    #
    # 掉落場外的情況下努力試圖回歸場上
    #
    #
 #   if @me.y_min == $game_temp.battle_field_b and @me.motion.knock_back_duration <= 0
      # より内側へ
    #  sign = @me.x_pos >= 0 ? -1 : 1
      # 「空中横移動」
    #  @me.motion.do_airwalk(sign)
    #  if @me.now_y_speed < 0
    #    if @me.motion.now_jumps < @me.max_jumps
          # 空中跳躍
#             @me.motion.ready_to_jump 
          #空中大跳躍
      #  elsif  @me.ai_defence_level > rand(100) and @me.ai_defence_level > rand(100) and @me.motion.freemove?
      #    @me.motion.do_high_jump
      #    @wait_duration = 19
       # else 
          # 使用飛空類技能
#          @me.motion.do_act(jump_skill_id?)
      #  end
    #  end
   #   return
   # end  
    
    
    # 防禦中
    #if  @guard_duration > 0
       #@me.motion.change_anime("guard")
   #    do_guard
   #    @guard_duration -= 1
   #    return
  #   end
    #
    #
    # 計算X差
    #
    # 
    sign = ((@target.x_pos - @me.x_pos > 0) ? 1 : -1)
    

    # 偵測飛行道具
   # search_bullet
    
    #@me.motion.do_dashbreak if @me.motion.state == "dash" and @me.now_x_speed.abs < (@me.dash_x_speed / 2)# 2.5
   # @me.motion.change_anime("stand")  if (@me.motion.state == "walk" and  @me.now_x_speed == 0)
    # 戰鬥階段
     #case @behavior_phase
     #when 0
     
    # 練習模式 
     if $game_temp.battle_troop_id == 34
       case $game_temp.practice_select1
       when 0 # 站著
         if $game_temp.practice_select3 == 1  # 可受身
             do_action("ukemi", 99) if can_ukemi?
         end
       when 1 # 只會跳
         if $game_temp.practice_select3 == 1  # 可受身
             do_action("ukemi", 99) if can_ukemi?
         end
         if [11,12,13,35,36,37,40,41,42].include?(@me.id)
           @me.motion.hold_up(0) if !@me.motion.on_air?
         end 
       when 2 # AI
         update_behavior_phase(sign)
       end
     else
       update_behavior_phase(sign)
     end
     
     
       
    # when 1
   #    update_behavior_phase1(sign)
   #  when 2
    #   update_behavior_phase2(sign)
   #  end 
    # if @me.x_pos.abs == $game_temp.battle_field_w and distance_x < 90 and ["stand", "walk", "dash"].include?(@me.motion.state)
      #  if @me.x_pos < 0
      #    @me.direction = -1
      #  else
      #    @me.direction = 1
        #end
    #    @me.motion.bc_action
     #   @behavior_phase = 0 if @behavior_phase == 3
   #  end
 
     # 變數計時
     update_value_timecount
     
   end
end
