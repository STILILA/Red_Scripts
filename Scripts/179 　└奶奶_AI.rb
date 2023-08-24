#==============================================================================
# ■ 奶奶二的AI
#==============================================================================
class CoralsFinal_AI < Game_BattlerAI
  #--------------------------------------------------------------------------
  # ○ 物件初始化
  #--------------------------------------------------------------------------
  def initialize(battler)
    @target_distance_x_max = 180  # 攻擊行動最高 X 距離
    @target_distance_x_min = 100   # 攻擊行動最低 X 距離
    @target_distance_y_min = 0   # 攻擊行動最低 Y 距離
    @target_distance_y_max = 10   # 攻擊行動最高 Y 距離
    super(battler)
    determine_set
    @ai_trigger = {"atk_cd1" => 0, "atk_cd2" => 0} 
    @lock_run = 0
    
    # 前哨站用行動變量
    @stroll = 0
    
    # 接技自重度
    case  @ai_level
    when 0
      @combo_limit = 2
    when 1
      @combo_limit = 4
    when 2
      @combo_limit = 6
    when 3
      @combo_limit = 12
    end
  end
  
  #--------------------------------------------------------------------------
  # ■ 判定用變數
  #--------------------------------------------------------------------------
  def determine_set
    @combohold_count = 0  # 共通，AI接技自重計算
    @combo_list = []  # 共通，接技表
  end 
  

   
#==============================================================================
# ■ 連段自重
#==============================================================================
  def action_prudent
    return ((@ai_level == 0 and @target.combohit > 2) or (@ai_level == 1 and @target.combohit > 4) or 
    (@ai_level == 2 and @target.combohit > 6))
  end
  
#==============================================================================
# ■ AI反應
#==============================================================================
  def can_reaction?
    result = true
    case @ai_level
    when 0
      if @me.motion.freemove? and @target.motion.state_time > 10
        result = true
      elsif @me.motion.attacking?
        result = true
      else
        result = false
      end
    when 1
      if @me.motion.freemove? and @target.motion.state_time > 5
        result = true
      elsif @me.motion.attacking?
        result = true
      else
        result = false
      end
    when 2
      if @me.motion.freemove? and @target.motion.state_time > 2
        result = true
      elsif @me.motion.attacking?
        result = true
      else
        result = false
      end
    end
    return result
  end 
#==============================================================================
# ■ 出招判斷
#==============================================================================
  
  #-------------------------------------------------------------------------------
  # ○ 戳刺
  #-------------------------------------------------------------------------------
  def can_z?
    return if !confront?
    return if @me.motion.cannot_cancel_act?  
    return if action_prudent
    return if me_state?(["skill1"])
    if @me.motion.on_air?
      return true if  (10..112) === dist_x  and (2..33) === dist_y_frame(4)  
    else
      return if @target.motion.blowning? or @target.motion.downing?
      return if @target.motion.guarding? and @me.motion.attacking?
      return @dr = 1 if @ai_random > 750 and dist_x < 370 and @me.motion.anime_time > 5
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 地柱
  #-------------------------------------------------------------------------------
  def can_fz?
    return if !confront?
    return if @me.motion.cannot_cancel_act? 
    return if @me.motion.on_air?
    return if action_prudent
    return if @target.motion.downing?
    return if @target.motion.guarding? and @me.motion.attacking?
    return if me_state?(["skill1"])
    return @dr = 1 if @ai_random <= 300 and dist_x < 180 and @me.motion.anime_time > 5
  end
  #-------------------------------------------------------------------------------
  # ○ 隕石
  #-------------------------------------------------------------------------------
  def can_dz?
    return if !confront?
    return if @me.motion.cannot_cancel_act? 
    return if @me.motion.on_air?
    return if action_prudent
    return if @target.motion.downing?
    return if @target.motion.guarding? and @me.motion.attacking?
    return if @ai_trigger["atk_cd1"] > 0
    return if me_state?(["skill1"])
    return @dr = 1 if (300..500) === @ai_random and dist_x > 220 and @me.motion.anime_time > 5
  end
  #-------------------------------------------------------------------------------
  # ○ 毒尾
  #-------------------------------------------------------------------------------
  def can_uz?
    return if !confront?
    return if @me.motion.cannot_cancel_act? 
    return if @me.motion.on_air?
    return if action_prudent
  #  return if @target.motion.downing?
    return if me_state?(["skill1"])
    return @dr = 1 if (650..800) === @ai_random and (70...220) === dist_x and !me_state?(["atk2"]) and @me.motion.anime_time > 5
    return @dr = 2 if me_state?(["atk2"]) and @hit_time == 32
  end
  #-------------------------------------------------------------------------------
  # ○ ←Z
  #-------------------------------------------------------------------------------
  def can_bz?
    return 
  end
  #-------------------------------------------------------------------------------
  # ○ X  毒尾連刺
  #-------------------------------------------------------------------------------
  def can_x?
    return if !confront?
    return if @me.motion.cannot_cancel_act? 
    return if @me.motion.on_air?
    return if action_prudent
    return if @me.sp < 60
    return if @ai_level == 0
    return @dr = 1 if (0...278) === dist_x  and (630..700) === @ai_random and @me.motion.anime_time > 5
    return @dr = 2 if me_state?(["atk2"]) and @hit_time == 32 and @ai_level > 1
    return @dr = 3 if me_state?(["atk4"]) and @ai_level > 1  #and  @hit_time == 25
    return @dr = 3 if me_state?(["atk1"]) and @ai_level > 2 and (701..999) === @ai_random and @hit_time < 4
  end
  #-------------------------------------------------------------------------------
  # ○ →X   蓄力刺擊
  #-------------------------------------------------------------------------------
  def can_fx?
    return if !confront?
    return if @me.motion.cannot_cancel_act? 
    return if @me.motion.on_air?
    return if action_prudent
    return if @me.sp < 60
    return if @ai_level < 2
    return @dr = 1 if (0...88) === dist_x and (430..500) === @ai_random  and @me.motion.anime_time > 5
    return @dr = 2 if (0...30) === dist_x and @ai_random < 200 and @ai_level > 1
   # return @dr = 2 if me_state?(["atk2"]) and @hit_time == 32 and @ai_level > 1
    return @dr = 3 if me_state?(["atk1"]) and @ai_level > 2 and (0..300) === @ai_random and @hit_time < 4 #and  @hit_time == 25
  end
  #-------------------------------------------------------------------------------
  # ○ ↓X   暗靈魔爆彈
  #-------------------------------------------------------------------------------
  def can_dx?
    return if @me.motion.cannot_cancel_act? 
    return if @me.motion.on_air?
    return if action_prudent
    return if @ai_level < 2
   # return if @target.motion.downing?
   # return if @target.motion.guarding? and @me.motion.attacking?
    return @dr = 1 if (150..500) === @ai_random and @me.awake_time >= 1200
    end
  #-------------------------------------------------------------------------------
  # ○ ←X
  #-------------------------------------------------------------------------------
  def can_bx?
  end
  
  #-------------------------------------------------------------------------------
  # ○ S 
  #-------------------------------------------------------------------------------
  def can_s?
  end
  #-------------------------------------------------------------------------------
  # ○ →S
  #-------------------------------------------------------------------------------
  def can_fs?
  end
  #-------------------------------------------------------------------------------
  # ○ ↓S 
  #-------------------------------------------------------------------------------
  def can_ds?
  end
  
  #-------------------------------------------------------------------------------
  # ○ ←S
  #-------------------------------------------------------------------------------
  def can_bs?
  end
  
  #-------------------------------------------------------------------------------
  # ○ 前追擊
  #-------------------------------------------------------------------------------
  def can_fc?
    return if !@me.motion.attacking?
    return if !confront?
    return if @me.motion.cannot_cancel_act?  
    return if @me.sp < 60
    return if @ai_level == 0
    if @me.motion.on_air?
    else
      return true if (20..160) === dist_x  and !t_sa?(1) and rand(5-@ai_level) < 1
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 後追擊(迴避)
  #-------------------------------------------------------------------------------
  def can_bc?
    return if !@me.motion.attacking?
    return if @me.motion.cannot_cancel_act?  
    return if @me.sp < 60
    if @me.motion.on_air?
    else
      return true if  t_confront? and t_attacking? and (0..40) === dist_x and rand(24-@ai_level**2) < 1
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 上追擊
  #-------------------------------------------------------------------------------
  def can_uc?
    return if !@me.motion.attacking?
    return if !confront?
    return if @me.motion.cannot_cancel_act?  
    return if @me.sp < 90
    return if @ai_level == 0
    if @me.motion.on_air?
      return true if rand(5-@ai_level) < 1 and (1..6) === @hit_time
      return true if rand(5-@ai_level) < 1
    else
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 下追擊
  #-------------------------------------------------------------------------------
  def can_dc?
    return if !@me.motion.attacking?
    return if @me.motion.cannot_cancel_act?  
    return if @me.sp < 60
    if @me.motion.on_air?
    else
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 跳躍追擊
  #-------------------------------------------------------------------------------
  def can_jump_c?
  end
#==============================================================================
# ■ 迴避/防禦判斷
#==============================================================================
  
  #-------------------------------------------------------------------------------
  # ○ 前迴避
  #-------------------------------------------------------------------------------
  def can_fflee?
  end
  #-------------------------------------------------------------------------------
  # ○ 後迴避
  #-------------------------------------------------------------------------------
  def can_bflee?
    return if !@me.motion.freemove?
    return if @lock_4c > 0
    return if @me.motion.attacking?
    return if @me.motion.state == "f_flee" or @me.motion.state == "af_flee"
    return if @me.motion.state == "b_flee" or @me.motion.state == "ab_flee"
    return true if  (@target.motion.downing? or t_well_down?(3)) and  dist_x < 35
    return true if  t_confront? and t_attacking? and (0..40) === dist_x and rand(24-@ai_level**2) < 1
    return true if  t_confront? &&  (0..40) === dist_x  && @target.motion.downing? && rand(24-@ai_level**2) < 1
  end
  #-------------------------------------------------------------------------------
  # ○ 可以受身
  #-------------------------------------------------------------------------------
  def can_ukemi?
    return true if (@me.motion.knock_back_duration <= 0 and @me.motion.blowning?)
  end

  #-------------------------------------------------------------------------------
  # ○ 瞬間防禦
  #-------------------------------------------------------------------------------
  def can_timely_guard?
    return if @me.follower?
    return if @ai_level < 2 
    return if @me.motion.super_armor > 0
    return if me_state?(["skill2"])
    return true if @do_timelyguard 
  end
  
  #-------------------------------------------------------------------------------
  # ○ 防禦判斷
  #-------------------------------------------------------------------------------
  def can_guard?
    return if !@me.motion.guardable?
    return if @guard_duration > 0
    return @dr = 4 if (t_confront? && dist_x < 280 and t_attacking? and @target.motion.x_skill? and rand(@ai_level*4) > 2) and @ai_level != 0
    return @dr = 3 if  (t_confront? && dist_x < 160 and @target.motion.anime_time > (4 + @ai_level*3) and t_attacking?)
    return @dr = 1 if  (t_confront?  && dist_x < 160 && dist_y < 70 && rand(11-@ai_level**2) < 1 && @ai_level < 2)
    return @dr = 2 if  (t_confront? && t_attacking? && dist_x < 130 && dist_y < 70 && rand(11-@ai_level**2) < 1)
  end
  
  #-------------------------------------------------------------------------------
  # ○ 掙脫
  #-------------------------------------------------------------------------------
  def can_break_away?
    return if @me.follower?
 #   return if @ai_level < 2 
    return if @target.motion.x_skill?
    return if @me.motion.hit_stop_duration > 0
    return if @me.motion.catched
    return @dr = 1 if @me.motion.damaging? and @me.combohit > 3 and (200..240) === @ai_random 
  end
  #--------------------------------------------------------------------------
  # ○ 偵測飛行道具威脅
  #--------------------------------------------------------------------------
  def search_bullet
    for bullet in $scene.battle_bullets
      next if bullet.root.class == @me.class
      if (bullet.x_pos - @me.x_pos).to_i.abs < 170 and rand(11-@ai_level**2) < 1
        case rand(10)
        when 0..7
          @guard_duration = 5
        when 8
          @me.motion.fc_action
        when 9
          @me.motion.bc_action
        end
      end
    end
  end
  
  #-------------------------------------------------------------------------------
  # ○ 跳躍
  #-------------------------------------------------------------------------------
  def can_jump?
    return if @jump_cd > 0
    return if @me.motion.attacking?
    return unless t_attacking?
    return if !@me.motion.controllable?
    return true if @me.ai_defence_level > rand(200)  && t_confront?
  end
  #-------------------------------------------------------------------------------
  # ○ 跑步
  #-------------------------------------------------------------------------------
  def can_run?
    return if @lock_run > 0
    return if !@me.motion.freemove?
    return if @me.motion.on_air?
    return if !@me.motion.controllable?
  #  return true if @target.motion.knock_back_duration > 3
  
    return @dr = 1 if dist_x >= 420 and @ai_mode == "move"
    return @dr = 2 if (dist_x < 50 and @ai_random > 800) and confront?#and @me.motion.backedge_dist < 20 and t_confront?
  end
  
  #-------------------------------------------------------------------------------
  # ○ 走路
  #-------------------------------------------------------------------------------
  def can_walk?
    return if @me.motion.attacking?
    return if @me.motion.state == "dash_break"
    return if !@me.motion.freemove?
    return if !@me.motion.controllable?
    if @lock_run > 0
      return true if dist_x >= 220 and @ai_mode == "move"
    else
      return true if (150..666) === dist_x and @ai_mode == "move"
    end
  end

  #-------------------------------------------------------------------------------
  # ○ 後退
  #-------------------------------------------------------------------------------
  def can_backwalk?
    return if @me.motion.attacking?
    return if @me.motion.state == "dash_break"
    return if @me.motion.on_air?
    return if !@me.motion.freemove?
    return if !@me.motion.controllable?
  #  if @lock_run > 0
   #   return @dr = 1 if dist_x >= 120 + rate and @ai_mode == "move"
  #  else
   #   return @dr = 2 if (80..131) === dist_x and @ai_mode == "move"
  #  end
  end

  #-------------------------------------------------------------------------------
  # ○ 什麼也不做
  #-------------------------------------------------------------------------------
  def do_nothing?
    return if @daze_cold > 0
    case  @ai_level
    when 0
      return true if rand(100) > 50
    when 1
      return true if rand(100) > 60
    when 2
      return true if rand(100) > 80
    when 3
   #   return true if rand(100) > 65
    end
  end

  #--------------------------------------------------------------------------
  # ○ 記下被打臉的技能
  #--------------------------------------------------------------------------
  def counter_memory(action)
    case action
    when "6z"
      @lock_6z = 390 - rand(80)*@ai_level
    end
    
  end
  
  #--------------------------------------------------------------------------
  # ○ 定期更新 - 特定變數計時
  #--------------------------------------------------------------------------
  def update_value_timecount
    
    @ai_trigger["atk_cd1"] -= 1 if @ai_trigger["atk_cd1"] > 0 
    @ai_trigger["atk_cd2"] -= 1 if @ai_trigger["atk_cd2"] > 0 
    
    @guard_duration -= 1 if @guard_duration > 0
    if @me.motion.attacking? and (@now_skill != @me.motion.state)
      @guard_time = 0
      @contact_time = 0 
      @hit_time = 0
      @now_skill = @me.motion.state
    end

    if @me.motion.attacking?
      @attacking_time += 1 and @me.motion.hit_stop_duration <= 0
      @hit_time += 1 if @hit_time >= 1 and @me.motion.hit_stop_duration <= 0
      @contact_time += 1 if  @contact_time >= 1 and @me.motion.hit_stop_duration <= 0
      @guard_time += 1 if @guard_time >= 1 and @me.motion.hit_stop_duration <= 0
    else
      @guard_time = 0
      @contact_time = 0
      @hit_time = 0
    end
    
    return if @target == nil
    
    if @target_skill != @target.motion.state
      @target_skill = @target.motion.state
      @do_timelyguard = ((rand(60 + @timelyguard_knackered)+1 < 9 * (@ai_level - 1)) and @me.motion.controllable?)
    end
    
  end
  
  #--------------------------------------------------------------------------
  # ○ 更新行為
  #--------------------------------------------------------------------------
  def update_behavior_phase(sign)
    

    
    if can_guard? # 起動防禦
      do_action("gurad", @dr)
      @guard_duration = 5
      return
    end
    # 防禦
    if @guard_duration > 0 
      do_action("gurad", 99)
      return
    end
    do_action("exguard", @dr) if can_timely_guard?

    turn_to_target if ["stand", "guard"].include?(@me.motion.state)  
    
  #  do_action("break_away", @dr) if can_break_away?
    
    do_action("2x", @dr) if can_dx?
    do_action("6x", @dr) if can_fx?
    do_action("5x", @dr) if can_x?
    
    do_action("8z", @dr) if can_uz?
    do_action("2z", @dr) if can_dz?
    do_action("5z", @dr) if can_z?
    do_action("6z", @dr) if can_fz?
    
    
  #  if can_run?
    #  dir = @me.direction #* ((@target.guarding? or @target.motion.downing?) ? -1 : 1)
    #  @me.motion.do_dash(sign)
    #  return
   # end
    
   # if @me.motion.state == "dash"
    #  @me.motion.do_dashbreak 
    #end

   # if can_backwalk?
     # dir = @me.direction #* ((@target.guarding? or @target.motion.downing?) ? -1 : 1)
     # @me.motion.do_dash(-sign)
    #  return
   # end
    
    if can_walk?
      dir = @me.direction #* ((@target.guarding? or @target.motion.downing?) ? -1 : 1)
      @me.motion.do_walk(sign)
      return
    end
    
   @me.motion.change_anime("stand") if @me.motion.controllable? and @me.motion.freemove? and @me.motion.state != "stand" and !@me.motion.on_air?
    
  end
  
  
  #--------------------------------------------------------------------------
  # ○ 行動實行
  #--------------------------------------------------------------------------
  def do_action(a, result)
    case a
    when "5z" 
      @me.motion.z_action
    when "6z"
      @me.motion.fz_action
    when "2z"
      @me.motion.dz_action
    when "8z"
      @me.motion.uz_action
    when "break_away"
      @me.motion.change_anime("break_away")
      
    when "4z"
      @me.motion.bz_action
    when "5x"
     @me.motion.x_action
    when "6x"
     @me.motion.fx_action
    when "2x"
     @me.motion.dx_action
    when "8x"
     @me.motion.ux_action
    when "4x"
     @me.motion.bx_action
    when "gurad"
      do_guard
    when "6c"
      @me.motion.fc_action
    when "4c"
      @me.motion.bc_action
    when "66"
      @me.motion.do_66
    when "44"
      @me.motion.do_44
    when "88"
      @me.motion.do_88
    when "22"
      @me.motion.do_22
    when "exguard"
      @me.motion.timely_guard_time = 4
    when "ukemi"
      @me.motion.do_ukemi
    end
   # p a, result if a != "exguard"
    @debug_action_result = result if a != "exguard"
  end
  
  
end
