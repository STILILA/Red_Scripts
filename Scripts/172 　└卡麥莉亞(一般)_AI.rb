#==============================================================================
# ■ AI
#==============================================================================
class Red_Beast_AI < Game_BattlerAI
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
    @lock_x = 0
    @lock_s = 0
    @lock_2s = 0
    @lock_6z = 0
    @lock_6s = 0
    @lock_6x = 0
    @lock_88 = 0
    @lock_jx = 0
    @lock_6c = 0
    @lock_4c = 0
    @lock_run = 0
    # 接技自重度
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
  # ■ 判定用變數
  #--------------------------------------------------------------------------
  def determine_set
    @combohold_count = 0  # 共通，AI接技自重計算
   # p @combo_list unless @combo_list.empty?
    @combo_list = []  # 共通，接技表
    @ai_trigger = {
    "8xx_lock" => false, # 上升系招式封印判定
    "66_lock" => false, 
    "6s_constant" => false,  # 必定使用猛龍千嘯
    "jx_use" => false,     # 飛車落使用判定
    "ground_2x" => false,  #地面使用升龍霸
    "x_constant" => false,
    "used_s_skill" => false
    }  
  end 

#==============================================================================
# ■ 出招判斷
#==============================================================================
  
  #-------------------------------------------------------------------------------
  # ○ Z (空：踢腿、地：小拳)
  #-------------------------------------------------------------------------------
  def can_z?
    return if !confront?
    return if @me.motion.cannot_cancel_act?  
    return if action_prudent
    return if @me.motion.state == "6x"
    return if t_eva?(0)
    if @me.motion.on_air?
   #   return @dr = 1 if  (0..65) === dist_x  and (2..15) === dist_y_frame(4)  and @me.now_y_speed < 0# and !(@target.combohit > 6 and me_state?(["j6x"]))
    else
   #   return if @target.hp < 35
      return if @target.motion.downing?
      return if @target.motion.guarding? and @me.motion.attacking?
      # 立回用
      return @dr = 2 if (@ai_level == 0 and (0..70) === dist_x  and rand(10) < 2)  and @me.motion.anime_time > 5
      return @dr = 3 if ((0..65) === dist_x and (0..30) === dist_y and rand(5-@ai_level) < 1)  and @me.motion.anime_time > 5
      # 連段用
      return @dr = 4 if me_state?(["6z", "5z", "5zz"]) and @ai_random > 700 and @hit_time < 6
      return @dr = 5 if me_state?(["5z", "5zz"]) and @hit_time < 3 and @ai_random > 300
      return @dr = 5 if me_state?(["6z"]) and @hit_time < 5 and dist_x < 40 and @ai_random > 450
      return @dr = 6 if me_state?(["landing"]) and @me.motion.anime_time < 3 and @target.motion.blowning? and @ai_random > 500
    end
  end
  #-------------------------------------------------------------------------------
  # ○ →Z (地：前衝拳)
  #-------------------------------------------------------------------------------
  def can_fz?
    return if !confront?
    return if @me.motion.cannot_cancel_act? 
    return if @me.motion.on_air?
    return if @lock_6z > 0
    return if action_prudent
    return if me_state?(["6x"])
    return if @target.motion.downing?
    return if @target.motion.guarding? # and @me.motion.attacking?
    return if t_eva?(0)
    return @dr = 1 if @me.motion.freemove? and (50..290) === dist_x and @ai_level < 2  and rand(10) > 7 and @me.motion.anime_time > 5 and @target.motion.anime_time > 3
    return @dr = 2 if @me.motion.freemove? and (30..240) === dist_x  and @target.motion.anime_time > 5 and (510..680) === @ai_random 
    return @dr = 3 if (0..150) === dist_x and (0..21) === dist_y_frame(4) and t_damage?(4) and !t_well_down?(4)
    return @dr = 4 if me_state?(["dz2", "landing"]) and t_damage?(9)
   # return @dr = 4 if @me.motion.state == "landing" and t_damage?(6) and dist_x < 45 and dist_y < 37 and !t_well_down?(4)
  end
  #-------------------------------------------------------------------------------
  # ○ ↓Z (空：扣打、地：上鉤拳)
  #-------------------------------------------------------------------------------
  def can_dz?
    return if !confront?
    return if @me.motion.cannot_cancel_act?
    return if action_prudent
    return if @me.motion.state == "6x"
    return if t_eva?(0)
    if @me.motion.on_air?
      return if me_state?(["j2x"])
      return @dr = 2 if me_state?(["dz2"]) #@target.y_pos < @me.y_pos and (24..38) === dist_x and (-30..0) === dist_y
    else 
      return @dr = 1 if t_damage?(9) and (0..94) === dist_x and rand(5-@ai_level) < 1 and !me_state?(["landing"])
      return @dr = 2 if @me.motion.attacking? and me_state?(["5zzz"])
    end
  end
  
  #-------------------------------------------------------------------------------
  # ○ ←Z (空：踢腿、地：前衝拳)
  #-------------------------------------------------------------------------------
  def can_bz?
    return if confront?
    return if @me.motion.cannot_cancel_act? 
    return if @me.motion.on_air?
    return if @lock_6z > 0
    return if action_prudent
    return if me_state?(["6x"])
    return if @target.motion.downing?
    return if @target.motion.guarding? # and @me.motion.attacking?
    return if t_eva?(0)
    # 立回用
    return @dr = 1 if @me.motion.freemove? and (50..290) === dist_x and @ai_level < 2  and rand(10) > 7 and @me.motion.anime_time > 5
    return @dr = 2 if @me.motion.freemove? and (30..240) === dist_x  and @me.motion.anime_time > 5 and (510..680) === @ai_random 
    # 連段用
    return @dr = 3 if (0..150) === dist_x and (0..21) === dist_y_frame(4) and t_damage?(4) and !t_well_down?(4)
    return @dr = 4 if me_state?(["dz2", "landing"]) and t_damage?(9)
  end
  #-------------------------------------------------------------------------------
  # ○ X (沒作用) (地：無)
  #-------------------------------------------------------------------------------
  def can_x?
   # return can_fx?
  end
  #-------------------------------------------------------------------------------
  # ○ →X (空：、地：血腥慾望)
  #-------------------------------------------------------------------------------
  def can_fx?
    return if !confront?
    return if @me.motion.cannot_cancel_act?  
    return if @target.combohit > @combo_limit + 2
    return if t_eva?(0)
    return if @me.sp < 60
    return if @ai_level == 0
    if @me.motion.on_air?
    else
      return if  t_well_down?(10)
      # 立回用
      return @dr = 3 if @me.motion.freemove? and (50..110) === dist_x and @ai_level < 2 and @ai_random < 100 and @me.motion.anime_time > 10 # 低等亂凹
      # 鬼畜超反應
      return @dr = 8 if @me.motion.freemove? and @ai_level == 3 and @target.motion.attacking? and @target.motion.anime_time < 5 and @ai_random < 150 and (0..120) === dist_x and dist_y < 52
      # 防止芮德兒地面鬼畜連
      return @dr = 1 if counter_red_ground_combo?
      # 連段用
      return if @target.combohit < 4  # 不要剛打到就出
      return @dr = 4 if me_state?(["5z", "5zz"]) and @ai_random < 300
      return @dr = 5 if ["6z"].include?(@me.motion.state) and @hit_time < 9 and (@ai_random < @target.combohit*160) and @target.combohit > 4
      return @dr = 7 if @target.hp < 100  and @ai_random < 600 and (0..80) === dist_x and (-5..52) === dist_y
      return @dr = 6 if @target.combohit > @combo_limit and !@target.motion.downing?
      
      
    end

  end
  #-------------------------------------------------------------------------------
  # ○ ↓X (空：巨爪撕裂)
  #-------------------------------------------------------------------------------
  def can_dx?
    return if !confront?
    return if @me.motion.cannot_cancel_act?  
    return if @target.combohit > @combo_limit + 2
    return if @target.motion.downing?
    return if @me.sp < 60
    return if t_eva?(0)
    return if @ai_level == 0
    if @me.motion.on_air?
      return if me_state?(["j2x"])
      # 立回用
      return @dr = 2 if @me.motion.freemove? and (30..80) === dist_x and @ai_level < 2 and rand(10) > 7                  
      # 連段用
      return if @target.combohit < 4  # 不要剛打到就出
      return @dr = 4 if me_state?(["dz2", "j2z"]) and (1..9) === @hit_time and (@ai_random < @target.combohit*100)  #and t_damage?(3)
      return @dr = 6 if @target.combohit > @combo_limit and !@target.motion.downing?
    else
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ←X (空：、地：血腥慾望)
  #-------------------------------------------------------------------------------
  def can_bx?
    return if confront?
    return if @me.motion.cannot_cancel_act?  
    return if @target.combohit > @combo_limit + 2
    return if t_eva?(0)
    return if @me.sp < 60
    return if @ai_level == 0
    if @me.motion.on_air?
    else
      # 立回用
      return @dr = 3 if @me.motion.freemove? and (0..70) === dist_x and @ai_level < 2 and @ai_random < 100 and @me.motion.anime_time > 3 # 低等亂凹
      # 鬼畜超反應
      return @dr = 8 if @me.motion.freemove? and @ai_level == 3 and @target.motion.attacking? and @target.motion.anime_time < 5 and @ai_random < 150 and (0..120) === dist_x and dist_y < 52
      # 連段用
      return if @target.combohit < 4  # 不要剛打到就出
      return @dr = 4 if me_state?(["5z", "5zz"]) and @ai_random < 300
      return @dr = 5 if ["6z"].include?(@me.motion.state) and @hit_time < 9 and (@ai_random < @target.combohit*160) and @target.combohit > 4
      return @dr = 7 if @target.hp < 100  and @ai_random < 600 and (0..80) === dist_x and (-5..52) === dist_y
      return @dr = 6 if @target.combohit > @combo_limit and !@target.motion.downing?
    end

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
    return @dr = 1 if @me.motion.state == "5x" and (1..5) === @hit_time and (20..160) === dist_x  and !t_sa?(1) and rand(5-@ai_level) < 1
    return @dr = 2 if (20..60) === dist_x and rand(5-@ai_level) < 1 and @me.motion.on_air? and @target.motion.blowning? and (10..38) === dist_y
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
      return @dr = 1 if  t_confront? and t_attacking? and (0..60) === dist_x and t_sa?(0) and @ai_level >= 2
      return @dr = 2 if  t_confront? and t_attacking? and (0..40) === dist_x and rand(24-@ai_level**2) < 1
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
      return @dr = 1 if me_state?(["2x"]) and (41..90) === dist_y and rand(5-@ai_level) < 1 and (1..6) === @hit_time
      return @dr = 2 if me_state?(["2s"]) and (1..5) === @hit_time and rand(5-@ai_level) < 1 and (0..8) === dist_x
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
    return if !@me.motion.freemove?
    return if @lock_4c > 0
    return if @me.motion.attacking?
    return if @target.motion.damaging?
    return if !confront?
    return if @me.motion.state == "f_flee" or @me.motion.state == "af_flee"
    # 防止芮德兒地面鬼畜連
    return @dr = 3 if counter_red_ground_combo?
    return @dr = 2 if @me.motion.backedge_dist < 7 and (0..30) === dist_x
    return @dr = 1 if  t_confront? and t_attacking? and (0..60) === dist_x and rand(24-@ai_level**2) < 1
  end
  #-------------------------------------------------------------------------------
  # ○ 後迴避
  #-------------------------------------------------------------------------------
  def can_bflee?
    return if !@me.motion.freemove?
    return if @lock_4c > 0
    return if @me.motion.attacking?
    return if @target.motion.damaging?
    return if !confront?
    return if @me.motion.state == "f_flee" or @me.motion.state == "af_flee"
    return if @me.motion.state == "b_flee" or @me.motion.state == "ab_flee"
 #   return @dr = 1 if  (@target.motion.downing? or t_well_down?(3)) and  dist_x < 35
    return @dr = 4 if @me.motion.frontedge_dist < 7 and (0..30) === dist_x
    return @dr = 2 if  t_confront? and t_attacking? and (50..120) === dist_x and rand(24-@ai_level**2) < 1
   
    return @dr = 3 if t_confront? and @me.motion.freemove? and @target.motion.freemove? and (0..15) === dist_x
    
  end
  #-------------------------------------------------------------------------------
  # ○ 可以受身
  #-------------------------------------------------------------------------------
  def can_ukemi?
    return @dr = 1 if (@me.motion.knock_back_duration <= 0 and @me.motion.blowning?)
  end

  #-------------------------------------------------------------------------------
  # ○ 瞬間防禦
  #-------------------------------------------------------------------------------
  def can_timely_guard?
    return if @me.follower?
    return if @ai_level < 2 
    return @dr = 1 if @do_timelyguard 
  end
  
  #--------------------------------------------------------------------------
  # ○ 偵測飛行道具威脅
  #--------------------------------------------------------------------------
  def search_bullet
    for bullet in $scene.battle_bullets
      next if bullet.root.class == @me.class
      if (bullet.x_pos - @me.x_pos).to_i.abs < 250 and rand(11-@ai_level**2) < 1
        case rand(10)
        when 0..7
          @guard_duration = 7
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
    return @dr = 1 if @me.ai_defence_level > rand(200)  && t_confront?
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
    return @dr = 1 if dist_x >= 150 and @ai_mode == "move"
    return @dr = 2 if dist_x >= 30 and t_damage?(1)
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
      return @dr = 1 if dist_x >= 5 and @ai_mode == "move"
    else
      return @dr = 2 if (40..151) === dist_x and @ai_mode == "move"
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

  #  if @lock_run > 0
   #   return @dr = 1 if dist_x >= 120 + rate and @ai_mode == "move"
  #  else
      return @dr = 2 if (80..131) === dist_x and @ai_mode == "move"
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
    when "6x"
      @lock_6x = 310 - rand(80)*@ai_level
    when "6s"
      @lock_6s = 420 - rand(80)*@ai_level
    when "2s"
      @lock_2s = 400 - rand(90)*@ai_level
    end
    
  end
  
  #--------------------------------------------------------------------------
  # ○ 定期更新 - 特定變數計時
  #--------------------------------------------------------------------------
  def update_value_timecount
    @lock_2s -= 1 if @lock_2s > 0
    @lock_x -= 1 if @lock_x > 0
    @lock_s -= 1 if @lock_s > 0
    @lock_6z -= 1 if @lock_6z > 0
    @lock_6s -= 1 if @lock_6s > 0
    @lock_88 -= 1 if @lock_88 > 0
    @lock_jx -= 1 if @lock_jx > 0
    @lock_6c -= 1 if @lock_6c > 0
    @lock_4c -= 1 if @lock_6c > 0
    @lock_run -= 1 if @lock_run > 0
    @guard_duration -= 1 if @guard_duration > 0
    #turn_to_target if ["stand"].include?(@me.motion.state)
    
    
    
    
    if @me.motion.attacking? and (@now_skill != @me.motion.state)
      @guard_time
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
      @contact_time = 0
      @hit_time = 0
      @guard_time
    end
    
    if @target_skill != @target.motion.state
      @target_skill = @target.motion.state
      @do_timelyguard = ((rand(60 + @timelyguard_knackered)+1 < 9 * (@ai_level - 1)) and @me.motion.controllable?)
    end
    
  end
  
  #--------------------------------------------------------------------------
  # ○ 更新行為
  #--------------------------------------------------------------------------
  def update_behavior_phase(sign)
    
 #   do_next
    
    turn_to_target if ["stand","guard"].include?(@me.motion.state)
    
    do_action("ukemi", @dr) if can_ukemi?  # 受身判定最優先
    
    
    
    if @guard_duration > 0 # 防禦
      do_action("gurad", 99)
      return
    end

    do_action("exguard", @dr) if can_timely_guard?
    do_action("2x", @dr) if can_dx?
    search_bullet   # 迴避飛道
    if can_guard? # 起動防禦
      do_action("gurad", @dr)
      @guard_duration = 8
      return
    end
    
   if can_reaction? 
 #   do_action("44", @dr) if can_bc?
    
    do_action("6c", @dr) if can_fflee?
    do_action("4c", @dr) if can_bflee?
    do_action("5z", @dr) if can_z?
    do_action("6x", @dr) if can_fx?
    do_action("2z", @dr) if can_dz?
    do_action("4x", @dr) if can_bx?
    do_action("6z", @dr) if can_fz?
    do_action("2z", @dr) if can_dz?
    do_action("66", @dr) if can_fc?  # 追擊
    do_action("44", @dr) if can_bc?
    do_action("88", @dr) if can_uc?
    do_action("22", @dr) if can_dc?
    do_action("5x", @dr) if can_x?
    do_action("4z", @dr) if can_bz?
   end

   # end
    
    if can_run?
      dir = @me.direction #* ((@target.guarding? or @target.motion.downing?) ? -1 : 1)
      @me.motion.do_dash(sign)
      return
    end
    
    if @me.motion.state == "dash"
      @me.motion.do_dashbreak 
    end
    
 #   if can_backwalk?
    #  dir = @me.direction #* ((@target.guarding? or @target.motion.downing?) ? -1 : 1)
   #   @me.motion.do_dash(-sign)
    #  return
  #  end
    
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
