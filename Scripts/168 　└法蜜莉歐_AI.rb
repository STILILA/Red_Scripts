#==============================================================================
# ■ AI
#==============================================================================
class Red_Hunter_AI < Game_BattlerAI
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

    @lock_5z = 0 
    @lock_run = 0
    
    @ai_trigger = {
    "jz_loop" => 0, 
    }  
    
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
    return if @target.motion.guarding? and @ai_random < 600
    if @me.motion.on_air?
      return if @ai_trigger["jz_loop"] > 2
      return @dr = 1 if me_state?(["f_jump", "f_jump_fall", "jump_fall", "j6z"]) and dist_x < 130  and (-10..100) === dist_y
    else
   #   return if @target.motion.blowning? or @target.motion.downing?
   #   return if t_eva?(4)
  #    return if @target.motion.guarding? and @me.motion.attacking?
     # return if @target.combohit > 6
      return if @target.motion.blowning? 
       
      return @dr = 1 if ((0..60) === dist_x and @ai_random < 350) and @me.motion.anime_time > 5 + rand(3) #and !(@lock_5z > 0)
      return @dr = 2 if ((150..300) === dist_x and @ai_random < 350) and !(@lock_5z > 0)
      return @dr = 3 if me_state?(["5z"])# and @ai_random < 940
    end
  end
  #-------------------------------------------------------------------------------
  # ○ →Z (地：前衝拳)
  #-------------------------------------------------------------------------------
  def can_fz?
    return if !confront?
    return if @me.motion.cannot_cancel_act? 
    return if action_prudent
    return if @target.motion.downing?
    return if @target.motion.guarding? and @ai_random < 800
    return if me_state?(["skill2"])
    if @me.motion.on_air?
      return @dr = 1 if me_state?(["jz"])  and dist_x < 130  and (-10..60) === dist_y
    else
      return @dr = 1 if @me.motion.freemove? and (0..250) === dist_x and @ai_level < 2 and (450..700) === @ai_random and @me.motion.anime_time > 10
      return @dr = 2 if @me.motion.freemove? and (20..160) === dist_x and (0..26) === dist_y_frame(6) and (450..750) === @ai_random and @me.motion.anime_time > 5
      return @dr = 5 if me_state?(["2z", "5zz"]) and @ai_random < 540
      return @dr = 4 if  t_damage?(6) and dist_x < 85 and dist_y < 40 and !t_well_down?(6)
    end
    
     
  end
  #-------------------------------------------------------------------------------
  # ○ ↓Z (空：扣打、地：上鉤拳)
  #-------------------------------------------------------------------------------
  def can_dz?
    return if !confront?
    return if @me.motion.cannot_cancel_act?
    return if action_prudent
    return if @target.motion.guarding? and @ai_random < 800
    if @me.motion.on_air?
   #   return @dr = 1 if @ai_trigger["jz_loop"] > 2
      return @dr = 1 if me_state?(["j6z"])
    else
      return @dr = 1 if (0..90) === dist_x and (0..60) === dist_y_frame(4) and @ai_random < 340
      
      return @dr = 2 if (0..90) === dist_x and (0..60) === dist_y_frame(5) and me_state?(["6z"])
    end
  end
  
  #-------------------------------------------------------------------------------
  # ○ ←Z (空：踢腿、地：前衝拳)
  #-------------------------------------------------------------------------------
  def can_bz?
    return if confront?
    return if @me.motion.cannot_cancel_act?  
    return if action_prudent
    return if me_state?(["skill2"])
    if @me.motion.on_air?
      return @dr = 1 if me_state?(["jz"])  and dist_x < 130  and (-10..60) === dist_y
    else
      return @dr = 1 if @me.motion.freemove? and (0..250) === dist_x and @ai_level < 2 and (450..700) === @ai_random and @me.motion.anime_time > 10
      return @dr = 2 if @me.motion.freemove? and (20..160) === dist_x and (0..26) === dist_y_frame(6) and (450..750) === @ai_random and @me.motion.anime_time > 5
      return @dr = 5 if me_state?(["2z", "5zz"]) and @ai_random < 540
      return @dr = 4 if  t_damage?(6) and dist_x < 85 and dist_y < 40 and !t_well_down?(6)
    end
  end
  #-------------------------------------------------------------------------------
  # ○ X (地：連環火砲)
  #-------------------------------------------------------------------------------
  def can_x?
    return if !confront?
    return if @me.motion.cannot_cancel_act?  
    return if @me.motion.on_air?
    return if @target.combohit > @combo_limit + 2
    return if @target.motion.downing?
    return if t_eva?(0)
    return if @me.sp < 60
    return if @ai_level == 0
    # 立回用
    return @dr = 1 if (0..120) === dist_x and dist_y < 40 and @ai_random < 350 and @target.motion.anime_time < 5 and @target.motion.attacking?
    # 防止芮德兒地面鬼畜連
    return @dr = 3 if counter_red_ground_combo?
    # 連段用
    return @dr = 2 if @me.motion.state == "6z" and dist_y < 30
    return @dr = 6 if @target.combohit > @combo_limit and !@target.motion.downing?
      
  end
  #-------------------------------------------------------------------------------
  # ○ →X (空：左輪咆嘯、地：槍林彈雨)
  #-------------------------------------------------------------------------------
  def can_fx?
    return if !confront?
    return if @me.motion.cannot_cancel_act?  
    return if @target.combohit > @combo_limit + 2
    return if t_eva?(0)
    return if @me.sp < 60
    return if @ai_level == 0
    if @me.motion.on_air?
      return if (@me.y_pos - @me.y_min).abs < 30 and @me.now_y_speed < 0
      return @dr = 1 if me_state?(["jz"]) and (8..10) === @hit_time and @ai_random > 700
      return @dr = 6 if me_state?(["j6z"]) and (1..5) === @hit_time and @ai_random < 300 + (@ai_level - 2) * 150
      return @dr = 7 if @target.combohit > @combo_limit and !@target.motion.downing?
    else
      # 立回用
      return @dr = 3 if @me.motion.freemove? and (0..110) === dist_x and @ai_level < 2 and @ai_random > 900  and @me.motion.anime_time > 5
      # 連段用
      return @dr = 4 if me_state?(["5z", "5zz"])  and (0..50) === dist_x and @ai_random > 900
      return @dr = 5 if ["6z"].include?(@me.motion.state) and @hit_time < 4 and rand(5) < 2
      return @dr = 6 if @target.combohit > @combo_limit and !@target.motion.downing?
    end

  end
  #-------------------------------------------------------------------------------
  # ○ ↓X (空/地：昇龍霸)
  #-------------------------------------------------------------------------------
  def can_dx?
    
    return can_fx?
    
    return if !confront?
    return if @me.motion.cannot_cancel_act?  
    return if @me.motion.state == "6s"
    return if @target.combohit > @combo_limit + 2
    return if @target.motion.downing?
    return if @me.sp < 60
    return if @ai_level == 0

  end
  #-------------------------------------------------------------------------------
  # ○ ←X (空：飛車落、地：百烈拳)
  #-------------------------------------------------------------------------------
  def can_bx?
    return if confront?
    return if @me.motion.cannot_cancel_act?  
    return if @me.motion.state == "6s"
    return if @target.combohit > @combo_limit + 2
    return if @me.sp < 60
    return if t_eva?(0)
    return if @ai_level == 0
    if @me.motion.on_air?
      return if (@me.y_pos - @me.y_min).abs < 30 and @me.now_y_speed < 0
      return @dr = 1 if me_state?(["jz"]) and (8..10) === @hit_time and @ai_random > 700
      return @dr = 6 if me_state?(["j6z"]) and (1..6) === @hit_time and @ai_random < 300
      return @dr = 7 if @target.combohit > @combo_limit and !@target.motion.downing?
    else
      return @dr = 3 if @me.motion.freemove? and (0..110) === dist_x and @ai_level < 2 and @ai_random > 900  and @me.motion.anime_time > 5
      return @dr = 4 if me_state?(["5z", "5zz"])  and (0..50) === dist_x and @ai_random > 900
      return @dr = 5 if ["6z"].include?(@me.motion.state) and @hit_time < 4 and rand(5) < 2
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
    return if @me.motion.attacking?
    return if !confront?
    return if @target.motion.damaging?
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
    return if @me.motion.attacking?
    return if !confront?
    return if @target.motion.damaging?
    return if @me.motion.state == "f_flee" or @me.motion.state == "af_flee"
    return if @me.motion.state == "b_flee" or @me.motion.state == "ab_flee"
    return @dr = 4 if @me.motion.frontedge_dist < 7 and (0..30) === dist_x
 #   return @dr = 1 if  (@target.motion.downing? or t_well_down?(3)) and  dist_x < 35
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
    return if @me.motion.on_air?
    return if @me.motion.cannot_cancel_act?
    return if !@me.motion.controllable?
  #  return if @me.motion.attacking?
  #  return unless t_attacking?
   # return @dr = 2 if me_state?(["2z"])
    return if counter_red_ground_combo?
    return @dr = 1 if (700...705) === @ai_random && t_confront?
  end
  #-------------------------------------------------------------------------------
  # ○ 前跳躍
  #-------------------------------------------------------------------------------
  def can_fjump?
    return if @jump_cd > 0
    return if @me.motion.on_air?
    return if @me.motion.cannot_cancel_act?
    return if !@me.motion.controllable?
  #  return if @me.motion.attacking?
  #  return unless t_attacking?
    return if counter_red_ground_combo?
    return @dr = 2 if me_state?(["2z"]) and @target.motion.blowning? and dist_x < 50
   # return @dr = 3 if @target.motion.blowning?
    return @dr = 1 if (311...340) === @ai_random && t_confront? and !@me.motion.attacking?
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
    rate = (@lock_5z > 0) ? 90 : 0
    return @dr = 1 if dist_x >= 360 - rate and @ai_mode == "move"
    return @dr = 2 if dist_x >= 90 and t_damage?(1)
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ 走路
  #-------------------------------------------------------------------------------
  def can_walk?
    return if @me.motion.attacking?
    return if @me.motion.state == "dash_break"
   # return if @me.motion.on_air?
    return if !@me.motion.freemove?
    
    
    rate = (@lock_5z > 0) ? 120 : 0
    
    if @lock_run > 0
      return @dr = 1 if dist_x >= 250 - rate and @ai_mode == "move"
    else
      return @dr = 2 if ((290 - rate)..(351 - rate)) === dist_x and @ai_mode == "move"
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
    rate = (@lock_5z > 0) ? 0 : 150
    
  #  if @lock_run > 0
   #   return @dr = 1 if dist_x >= 120 + rate and @ai_mode == "move"
  #  else
      return @dr = 2 if ((80 + rate)..(131 + rate)) === dist_x and @ai_mode == "move"
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
    when "5z"
      @lock_5z = 390 - rand(80)*@ai_level
    end
    
  end
  
  #--------------------------------------------------------------------------
  # ○ 定期更新 - 特定變數計時
  #--------------------------------------------------------------------------
  def update_value_timecount
    
    # 封鎖開槍
    if @lock_5z > 0
      @lock_5z -= 1 
      @lock_5z = 0 if dist_x > 280 
    else
      @lock_5z = 600 if (@ai_random > 750 and dist_x < 282)
    end
    
    
    @lock_run -= 1 if @lock_run > 0
    @guard_duration -= 1 if @guard_duration > 0
    #turn_to_target if ["stand"].include?(@me.motion.state)
    
    
    
    
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
    
    if @target_skill != @target.motion.state
      @target_skill = @target.motion.state
      @do_timelyguard = ((rand(60 + @timelyguard_knackered)+1 < 9 * (@ai_level - 1)) and @me.motion.controllable?)
    end
    
  end
  
  #--------------------------------------------------------------------------
  # ○ 更新行為
  #--------------------------------------------------------------------------
  def update_behavior_phase(sign)
    
  #  do_next
    
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
     do_action("6c", @dr) if can_fflee?
     do_action("fj", @dr) if can_fjump?
     do_action("44", @dr) if can_bc?
     do_action("6c", @dr) if can_fflee?
     do_action("4c", @dr) if can_bflee?
     do_action("6x", @dr) if can_fx?
     do_action("5z", @dr) if can_z?
     do_action("2z", @dr) if can_dz?
     do_action("6z", @dr) if can_fz?
     do_action("4x", @dr) if can_bx?
     do_action("2z", @dr) if can_dz?
     do_action("66", @dr) if can_fc?  # 追擊
     do_action("44", @dr) if can_bc?
     do_action("88", @dr) if can_uc?
     do_action("22", @dr) if can_dc?
     do_action("5x", @dr) if can_x?
     do_action("4z", @dr) if can_bz?
     
    end
    
    if can_run?
      dir = @me.direction #* ((@target.guarding? or @target.motion.downing?) ? -1 : 1)
      @me.motion.do_dash(sign)
      return
    end
    
    if @me.motion.state == "dash"
      @me.motion.do_dashbreak 
    end
    
    if can_backwalk?
      dir = @me.direction #* ((@target.guarding? or @target.motion.downing?) ? -1 : 1)
      @me.motion.do_dash(-sign)
      return
    end
    
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
    when "fj"
      @me.motion.change_anime("f_jump")
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
