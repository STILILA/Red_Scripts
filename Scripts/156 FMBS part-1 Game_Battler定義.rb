#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler
  #--------------------------------------------------------------------------
  # ○ 設置常量
  #--------------------------------------------------------------------------  
  # 防禦音
  GUARD_SE = "052-Cannon01" 
  #--------------------------------------------------------------------------
  # ○ 公開變量
  #--------------------------------------------------------------------------  
  attr_accessor :ability                      # 特殊能力
  attr_accessor :before_awake_id     # 獸化前的角色ID
  attr_accessor :awake_time             # 獸化時間
  attr_accessor :awaking                  # 獸化中
  # --- 代入類的變數 --------------------------------------------------------
  attr_accessor :motion              # 模組       (Game_Motion)
  attr_reader   :ai                       # AI            (Game_BattlerAI)
  # --- 運動值 --------------------------------------------------------
  attr_accessor :x_pos                    #  角色 X位置 (正值為右)
  attr_accessor :y_pos                    #  角色 Y位置 (正值為上)
  attr_accessor :z_pos                    #  角色 Z軸 (正值為前)
  attr_accessor :x_max                   # X軸往右移動極限 (懸崖判定)
  attr_accessor :x_min                    # X軸往左移動極限 (懸崖判定)
  attr_accessor :y_min                    #  立足點 (瞬間的)
  attr_accessor :y_min_slope_plus  #  追加斜度的立足點
  attr_accessor :zoom                     #  放大率
  attr_accessor :relative_x_destination   # 強制 X 位移
  attr_accessor :relative_y_destination   # 強制 Y 位移
  attr_accessor :now_x_speed              # 現在 X 速度  
  attr_accessor :now_y_speed              # 現在 Y 速度 
  attr_accessor :hit_slide                      # 命中後往後退的速度
  attr_accessor :edge_spacing          # 抓人時與牆保持的距離 
  attr_accessor :direction                # 面向        (1 向右、-1 向左)
  attr_accessor :body_rect                # 身體判定
  # --- 運動能力 -----------------------------------------------------------
  attr_reader   :walk_x_speed             # 步行 X 速度
  attr_reader   :dash_x_speed             # 跑步 X 速度 
  attr_reader   :frict_x_break            #   X 摩擦力
  attr_reader   :air_x_velocity           # 空中 X 移動速度
  attr_reader   :air_x_maximum          # 空中 X 最大速度
  attr_reader   :air_x_resistance         #   空中 X 空気抵抗
  attr_reader   :air_y_velocity           #    重力加速度
  attr_reader   :air_y_maximum            # 落下最大速度
  attr_reader   :max_jumps                # 最大跳躍回數
  attr_reader   :weight                   # 重量(沒作用)
  attr_reader   :jump_y_init_velocity     # 地上跳躍力
  attr_reader   :airjump_y_init_velocity  # 空中跳躍力
  attr_reader   :stand_body_rect     # 站姿身體判定
  attr_reader   :sit_body_rect          # 坐(蹲)姿身體判定
  attr_reader   :down_body_rect     # 倒地身體判定
  attr_accessor :now_hp              #    現在 hp(戰鬥用)
  attr_accessor :now_sp              #    現在 sp(戰鬥用)
  attr_accessor :select_wait_count  #  選人時等待計數
  attr_accessor :animation   #   角色的戰鬥動畫
  attr_accessor :damage_correction   # 傷害補正
  attr_accessor :battle_shadow_id       # 影子 ID
  attr_accessor :battle_sprite             # 戰鬥Sprite
  attr_accessor :dead_disappear       # 陣亡消失確認
  
  attr_accessor :damage_count         # 累計傷害
  attr_accessor :chain_count         # 累計取消數
  #--------------------------------------------------------------------------
  # ● 物件初始化
  #--------------------------------------------------------------------------
  alias xrxs_bs1_battler_initialize initialize
  def initialize
    # 呼叫原方法
    xrxs_bs1_battler_initialize

    @dead_disappear = false
    @x_min = 0
    @x_max = 0
    @before_awake_id = 1
    @awake_time = -1
    @awaking = false
    # 運動性能初始化
    @dash_x_speed         =  0     # 「走行X速度」
    @frict_x_break        =  0     # 「摩擦Xブレーキ力」
    @walk_x_speed         =  0     # 「歩行X速度」
    @air_x_velocity       =  0     # 「空中X加速度」
    @air_x_maximum        =  0     # 「空中X最大速度」
    @air_x_resistance     =  0     # 「空中X空気抵抗」
    @air_y_velocity       =  0     # 「落下Y加速度」
    @air_y_maximum        =  0     # 「落下Y最大速度」
    @jump_y_init_velocity =  0     # 「ジャンプY初速度」
    @weight               = 100    # 「重さ」
    @max_jumps            =  0     # 「最高連続ジャンプ回数」
    @jump_y_init_velocity    =  0.0   # 「地上ジャンプY初速度」
    @airjump_y_init_velocity =  0.0   # 「空中ジャンプY初速度」
    @ai_defence_level     = 0
    @damage_correction = 100
    @battle_shadow_id = 1
    @hit_slide = 0
    @battle_sprite = nil
    #現在HP
    @now_hp = 0
    # 現在SP
    @now_sp = 0
    # 選人時等待計數
    @select_wait_count = 0
    # 特殊能力
    @ability = []
    # 位置/模組情報初期化
    initialize_positioning
    
    @damage_count = 0
    @chain_count = 0
  end
  #--------------------------------------------------------------------------
  # ○ 位置/模組情報初期化
  #--------------------------------------------------------------------------
  def initialize_positioning
    # 位置
    if self.is_a?(Game_Actor)
      set_position
      @direction          =  1     # 面向
    else
      @direction          = -1     # 面向
    end
    # 運動
    @y_min                =  0
    @y_min_slope_plus = 0
    @now_x_speed          =  0     # 現在X速度
    @now_y_speed          =  0     # 現在Y速度
    @edge_spacing       =  0         # 抓人時離牆的距離
    @relative_x_destination =  0
    @relative_y_destination =  0
    @boardthrough_duration  =  0
    # 運動能力の設定
   # if self.is_a?(Game_Actor) or self.is_a?(Game_Enemy)
  #    setup_reflexes(self.id)
  #  end
    # 戰鬥動畫
    @animation = []
    # 模組/AI初始化
    if self.is_a?(Game_Actor) or self.is_a?(Game_Enemy)
      motion_setup(self.id)
    end
    # 初始戰鬥圖
    transgraphic_basic_form
    # 身體判定
    @body_rect                    = @stand_body_rect
  end

  #--------------------------------------------------------------------------
  # ○ 位置/模組情報 解放
  #--------------------------------------------------------------------------
  def dispose_positioning
    if self.is_a?(Game_Actor)
      @x_pos                = nil
      @y_pos                = nil
      @z_pos                = nil
    end
    @zoom = 1.0
    @now_x_speed          = nil
    @now_y_speed          = nil
    @edge_spacing       = nil
    @direction            = 1
    @now_jumps            = nil
  #  @relative_x_destination = nil
  #  @relative_y_destination = nil
    @boardthrough_duration  = nil
 #   @y_min                =  nil
    @y_min_slope_plus = nil
    
    # 解放模組
    @motion.dispose 
    
    
    # 模組
    @motion               = nil
    # AI
    @ai                   = nil
    # 清除Sprite
    if @battle_sprite != nil
     @battle_sprite.dispose
     @battle_sprite = nil
    end
    transgraphic_basic_form
  end
  
  #--------------------------------------------------------------------------
  # ○ 防御中
  #--------------------------------------------------------------------------
  def guarding?
    return (@motion.guarding?) 
  end

  
  #--------------------------------------------------------------------------
  # ○ 實行特殊防禦効果(未實裝)
  #--------------------------------------------------------------------------
  def guard_action(skill)
  #  case self.shield.id
   # when 1
  #    skill.power /= 2
  #  when 2
    #  skill.power /= 2
  #  when 3
    #  self.motion.do_backstep
    #  skill.power = 0
  #  end
    return skill
   #       if skill_is_a_magic?(skill)
            # 物理無効化
      #      return if @shield.power_reduce == 0
            # 物理軽減
      #      skill.power = (skill.power * @shield.power_reduce / 100).to_i
    #      else
            # 魔招無効化
     #       return if @shield.magic_reduce == 0
            # 魔招軽減
     #       skill.power = (skill.power * @shield.magic_reduce / 100).to_i
  #        end
  end
  #--------------------------------------------------------------------------
  # ● 套用技能結果
  #--------------------------------------------------------------------------
  alias xrxs_bs1_skill_effect skill_effect
  def skill_effect(user, original_skill, hitstopflag)
    # 複製
    skill = original_skill.dup

    # 對倒地狀態無效
    return if self.motion.downing? and !skill["scope"].include?("Down")
    # 對擊飛狀態無效
    return if self.motion.blowning? and !skill["scope"].include?("Blow")
    # 沒攻擊效果無效
    return if skill["no_atk"]
    
    if skill["d_se"].empty?
      p "#{user.name} 的行動 #{skill["skill_data"][0]} 第 #{skill["skill_data"][1]} 格的攻擊效果沒設好，請檢查角色Motino檔的skill_effect" 
      exit
    end
    
    
    
    if skill["power"] >= 0
      # 對方無敵的情況
      if self.motion.hit_invincible_duration > 0
        # 攻擊者套用HitStop
     #   self.motion.hit_stop_duration   = original_skill.dex_f
          user.motion.hit_stop_duration   = skill["t_hitstop"] 
          self.damage = 0
          self.damage_pop = true
        return [false, false]
      end
      
      # 實行特殊傷害處理
      self.motion.extra_damage_process
      
      
      # 瞬間防禦
#=begin
      if self.motion.timely_guard_time > 0 #and self.motion.state == "guard"
        self.motion.release_catching_target
        self.now_x_speed = 0
        self.now_y_speed = 0
        self.motion.attack_rect.clear
        self.motion.change_anime("guard_shock")
        
        # 累積瞬防次數
        if self.is_a?(Game_Actor) and $game_temp.battle_troop_id < 11
          $game_system.result_exguard += 1
          # 成就解除：沒用沒用沒用沒用
          if $game_system.result_exguard >= 20
            $game_config.get_achievement(3)
          end
        end
        
        self.motion.hit_invincible_duration = 1
        self.motion.knock_back_duration = 0
        self.motion.hit_stop_duration = 6
        self.motion.absolute_uncancel_time = 0
        self.motion.uncancel_flag = false
        self.motion.blur_effect = false
        self.damage = 0
        Audio.se_play("Audio/SE/metal33_a", 90 * $game_config.se_rate / 10, 130)
        # 變更fps
        if self == $scene.xcam_watch_battler or (self != $scene.xcam_watch_battler and ($scene.xcam_watch_battler.x_pos - self.x_pos).abs < 80)
          $game_temp.fps_change = 9
          Graphics.frame_rate = $fps_set - 10#30
        end
        $game_temp.superstop_time += 10
        self.motion.supermove_time += 10
        $game_temp.black_time = [18,50]
        unless $crash_box
      #    $xcam_z = [$xcam_z - 40, 100].max
     #     $xcam_y =  [$xcam_y - 30, 15].max
          $scene.camera_feature = [18,40,30]
        end
        self.animation.push([4, true, 0, 0])
        $scene.focus_plan[0] = 3
        $scene.focus_plan[4] = 3
        $scene.focus_plan[8] = 3
        self.motion.timely_guard_time = 0
        self.sp += 10
        self.motion.physical = true
        self.motion.y_fixed = false
  #      self.ai.daze_time = 0
   #     self.ai.daze_cold = 250
        self.ai.timely_guarded
        self.z_pos = 0
        return [true, false]
      end
#=end
      
      #  特殊防禦(未實裝)
      if guarding?
        skill = self.guard_action(skill)
      end
    end
    #
    # 呼叫原方法
    #
    last_hp = self.hp
    bool = xrxs_bs1_skill_effect(user, skill)
    #
    #
    #
    # 回復的情況中斷
    if skill["power"] < 0
      return [bool, false]
    end
    #
    # --- 傷害處理 ---
    #
    # 攻撃成功時
    if bool #and self.damage != "Miss"
      
      # 攻擊方向計算
      if user.is_a?(Game_BattleBullet)
        direction = user.now_x_speed > 0 ? 1 : -1
      else
        direction = user.x_pos < self.x_pos ? 1 : -1
      end

      # 擊飛時模組改變判斷
      dir = ((self.direction == direction) ? -1 :  1)
      # 累計擊倒值
    #  self.motion.now_full_count = [self.motion.now_full_count + skill["full_count"], 0].max if self.motion.blowning? or self.motion.now_full_count > 0

      # 命中停頓時間
      self.motion.hit_stop_duration  = skill["t_hitstop"] # unless self.motion.super_armor > 0
      user.motion.hit_stop_duration  = skill["u_hitstop"] if hitstopflag 

      # 攻擊者的sp恢復、硬直取消
      user.motion.atk_sp_recover(user, skill["sp_recover"])
   #   if user.is_a?(Game_BattleBullet)
    #    user.root.sp += skill["sp_recover"] 
   #   else
    #    user.sp += skill["sp_recover"] 
    #    user.motion.uncancel_flag = false #unless self.motion.guarding?
   #   end
      
      # 改變對方動作
      if self.guarding? and !skill["no_guard"]
        if self.dead?
          Audio.se_play(skill["ko_se"][0], skill["ko_se"][1] * $game_config.se_rate / 10, skill["ko_se"][2])  # KO SE再生
        else              
          self.motion.knock_back_duration = skill["t_knockback"]
          # ガード中 : ガード硬直モーション
          self.motion.do_guard_shock
          # ふっとびを半減
          blow = 0
          Audio.se_play(skill["g_se"][0], skill["g_se"][1] * $game_config.se_rate / 10, skill["g_se"][2])
        end
        self.sp += 2  # 被扁時sp恢復
      elsif self.is_a?(Game_Enemy) and (STILILA::NO_MOVE_ENEMY).include?(self.id) # 不移動的單位
        Audio.se_play(skill["d_se"][0], skill["d_se"][1] * $game_config.se_rate / 10, skill["d_se"][2])
        self.sp += 5
        self.motion.knock_back_duration = skill["t_knockback"] + 15
        self.motion.do_damage(dir, 0, "N", "N", user, skill["t_state"])
        return [bool, false]
      elsif self.motion.super_armor > 0 and !self.dead? and skill["catch_release"]  # 霸體
        Audio.se_play(skill["d_se"][0], skill["d_se"][1] * $game_config.se_rate / 10, skill["d_se"][2])
        self.motion.super_armor -= 1
        self.sp += 5
        return [bool, false]
      else  # 一般受擊處理
        # 正在攻擊的話，設定反擊標誌 / 記憶遭反擊的技能
        if self.motion.attacking?
          self.motion.counter_flag = true 
          self.ai.counter_memory(self.motion.state)
        end
        # 練習模式的強制counter
        if  $game_temp.battle_troop_id == 34 && $game_temp.practice_select1 < 2 && $game_temp.practice_select4 == 1 && self.is_a?(Game_Enemy) && !self.motion.damaging?
          self.motion.counter_flag = true 
        end
        
        # 傷害硬直時間
        case self.combohit 
        when 0..4
          reduce = 0
        when 4..8
          reduce = 2
        when 8..12
          reduce = 4
        else
          reduce = 6
        end
        reduce -= 5 if self.motion.counter_flag
        reduce2 = 0
        reduce2 = 2 if self.motion.knock_back_duration > skill["t_knockback"] - reduce
        
        self.motion.knock_back_duration = [skill["t_knockback"] - reduce, 3].max unless self.motion.super_armor > 0
        self.motion.knock_back_duration += reduce2 
        
        
     #   if self.is_a?(Game_Enemy) and STILILA::NO_BLOW_ENEMY.include?(self.id)
      #    self.motion.knock_back_duration = [30, self.motion.knock_back_duration].min
     #   end
     
        # 沒受到傷害成就取消
        $game_system.result_nodamage = false if self.is_a?(Game_Actor)
        
        # 陣亡的情況
        if self.dead? or self.motion.now_full_count >= self.motion.full_limit
          # KO SE再生
          Audio.se_play(skill["ko_se"][0], skill["ko_se"][1] * $game_config.se_rate / 10, skill["ko_se"][2])
        else
          # 受傷的情況，對應 SE 再生
          Audio.se_play(skill["d_se"][0], skill["d_se"][1] * $game_config.se_rate / 10, skill["d_se"][2])
          # 受傷處理
          self.motion.do_damage(dir, skill["scope"], skill["blow_type"], skill["down_type"], user, skill["t_state"])
          # 被扁時sp恢復
          self.sp += 5
        end
      end
      

      # 攻擊是否釋放捕捉對象
      if skill["catch_release"]
        if user.is_a?(Game_BattleBullet) 
          if !user.root.motion.catching_target.nil?
           user.root.motion.catching_target.motion.catched = false
           user.root.motion.catching_target = nil
          end  
        else
          if !user.motion.catching_target.nil?
           user.motion.catching_target.motion.catched = false
           user.motion.catching_target = nil
          end  
        end
      end  
      
      # 板邊命中滑行
      user.hit_slide = skill["hit_slide"] if (self.motion.frontedge_dist < 10 or self.motion.backedge_dist < 10) and !user.motion.on_air?

      #
      # "blow値 2 以上によるブロー効果"
      #
     # unless skill["blow_type"] == "NONE"
        #if blow == 3
          #if  self.motion.catched
          #  self.motion.do_catch_blow(dir)
         # else
          #  self.motion.do_hard_blow(dir, skill.blow_type)
         # end
        #elsif blow == 2 or self.motion.now_full_count >= self.motion.full_limit
       #   if  self.motion.catched
      #      self.motion.do_catch_damage
     #     else
     #       self.motion.do_light_blow(dir, skill.blow_type)
      #    end
  #      end
   #   end  
=begin
      #======================================================================
      #  位移
      #======================================================================

      # 擊退
      self.now_x_speed = skill["x_speed"] * direction
      # 擊飛 / 擊落
      unless self.guarding?
        if !self.motion.on_air? and skill["y_speed"] < 0 
        # 地面時，擊落值=>擊飛值
          self.now_y_speed = (-skill["y_speed"] / 3) 
        else
          self.now_y_speed = skill["y_speed"]
        end
      end
      
      # 陣亡
       if self.dead? #and self.battler_graphic_exist?(91)
        self.now_x_speed += 3.2 * direction if self.now_x_speed > 0
        if self.now_y_speed >= 0
          self.now_y_speed += 4.7
        else
          self.now_y_speed -= 4.7
        end
        if skill["level"] < 2
          skill["level"] = 2
        end
        self.motion.do_damage(dir, skill["level"], skill["blow_type"], skill["down_type"], user, skill["t_state"])
        self.motion.appear_dead_voice(self)
      end
=end



    end
    return [bool, true]
  end
  
  #--------------------------------------------------------------------------
  # ● 處理位移
  #--------------------------------------------------------------------------
  def move_effect(user, skill)
    return if self.motion.super_armor > 0
    return if self.is_a?(Game_Enemy) and (STILILA::NO_MOVE_ENEMY).include?(self.id)
    no_blow = true if (self.is_a?(Game_Enemy) and STILILA::NO_BLOW_ENEMY.include?(self.id))
    
    # 攻擊方向計算
    if user.is_a?(Game_BattleBullet)
      direction = user.x_pos < self.x_pos ? 1 : -1 #user.now_x_speed > 0 ? 1 : -1
    else
      direction = user.x_pos < self.x_pos ? 1 : -1
    end
    
    # 擊飛時面向處理
    if user.is_a?(Game_BattleBullet)
      dir = ((self.direction == direction) ? -1 : 1)
    else
      dir = ((self.direction == direction) ? -1 : 1)
    end
    
    # 擊退
    self.now_x_speed = skill["x_speed"] * direction
    # 擊飛 / 擊落
    if (!self.guarding? or skill["no_guard"]) and !no_blow   #and self.motion.blowning?
      if !self.motion.on_air? and skill["y_speed"] < 0 
      # 地面時，擊落值=>擊飛值
        self.now_y_speed = (-skill["y_speed"] / 3)
      else
        self.now_y_speed = skill["y_speed"]
      end
    end
    
    # 陣亡
      if self.dead? 

      #  self.now_x_speed += 3.2 * direction if self.now_x_speed > 0
        if self.now_y_speed == 0 and !no_blow
          self.now_y_speed += 4.7
       # else
    #      self.now_y_speed -= 4.7
        end
        
        # 該攻擊不會擊飛的話，強制變為擊飛狀態
        if skill["blow_type"] == "None" and !no_blow
          skill["blow_type"] = "N"
        end
        
        
        self.motion.do_damage(dir, skill["scope"], skill["blow_type"], skill["down_type"], user, skill["t_state"])
        self.motion.appear_dead_voice(self)
      end
    
    
    
  end
  
  
  
end
