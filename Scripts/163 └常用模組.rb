#==============================================================================
# ■ Common Motion
#--------------------------------------------------------------------------
#      常用的模組設定
#==============================================================================
class Game_Motion
  
  #--------------------------------------------------------------------------
  # ◇ 著地
  #--------------------------------------------------------------------------
  def do_landing_step
    if ["damage1", "damage2", "guard", "guard_shock"].include?(@state)
      @me.z_pos = 0
    else
      change_anime("landing")
      @me.z_pos = 0
    end
    Audio.se_play("Audio/SE/" + CROUCH_SE, 75 * $game_config.se_rate / 10, 90)
    @me.now_x_speed = 0
    @me.now_y_speed = 0

    @attack_rect  = [] # 攻擊判定消除
    @command_plan = ""
    @high_jump = false
    @now_jumps = 0
    @airdash_times = 0
    @uncancel_flag = false 
    @y_fixed = false
    @frame_loop[0] = 0
    @frame_loop[1] = 0
    @now_full_lv = 0
    @me.edge_spacing = 0
    @me.animation.push([10+rand(3),true,0,0])
  end
  
  
  #--------------------------------------------------------------------------
  # ◇ 恢復氣量
  #      atker：攻擊者(Game_Battler、Game_BattleBullet)
  #      sp：回收的sp
  #--------------------------------------------------------------------------
  def atk_sp_recover(atker, sp)
    #攻擊者的sp恢復、硬直取消
    if atker.is_a?(Game_BattleBullet)
      atker.root.sp += sp
    else
      atker.sp += sp
      atker.motion.uncancel_flag = false #unless self.motion.guarding?
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 換人
  #      純粹給狼切換別隻時消分身用
  #--------------------------------------------------------------------------
  def change_chara
  end
#==============================================================================
# ■ 指令設置
#==============================================================================

  #-------------------------------------------------------------------------------
  # ○ 無按鍵
  #-------------------------------------------------------------------------------
  def no_press_action
    return if static?
    change_anime("stand") if @state == "walk"
    do_dashbreak if @state == "dash"
    change_anime("crouch_end") if @state == "crouch" 
    if @state == "guard"
      on_air? ? change_anime("jump_fall") : change_anime("stand")
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 按住→
  #      hold_time：按住時間
  #-------------------------------------------------------------------------------
  def hold_right
    return if static?
    if ["stand", "stand_idle", "walk", "jump_fall"].include?(@state) or (@state == "guard" and @hold_key_c == 0)
      do_walk(1)
    elsif @state == "crouch" 
      change_anime("crouch_end")
    elsif @state == "dash"
      do_dash(1)
    elsif @state == "f_chase" and @me.direction == -1 and @frame_number < 6
      change_anime("f_chase", 6)
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 按住 ←
  #      hold_time：按住時間
  #-------------------------------------------------------------------------------
  def hold_left
    return if static?
    if  ["stand", "stand_idle", "walk", "jump_fall"].include?(@state) or (@state == "guard" and @hold_key_c == 0)
      do_walk(-1)
    elsif @state == "crouch" 
      change_anime("crouch_end")
    elsif @state == "dash"
      do_dash(-1)
    elsif @state == "f_chase" and @me.direction == 1 and @frame_number < 6
      change_anime("f_chase", 6)
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 按住↑
  #      dir：左右方向
  #-------------------------------------------------------------------------------
  def hold_up(dir)
    return if static?
    if ["stand", "stand_idle", "walk", "dash", "f_chase"].include?(@state) or 
      (z_skill? and !cannot_cancel_act? and @now_jumps < @me.max_jumps)
      if dir == 0
        change_anime("jump")
      else
        @me.direction = dir
        ["dash", "f_chase"].include?(@state) ? change_anime("hf_jump") : change_anime("f_jump")
      end
      @now_jumps += 1
    end
    if @knock_back_duration <= 0 and blowning?
      do_ukemi
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 按住↓
  #-------------------------------------------------------------------------------
  def hold_down
    return if static?
    if ["stand", "stand_idle", "walk", "dash"].include?(@state) or (@state == "guard" and @hold_key_c == 0)
      change_anime("crouch_start")
    elsif @state == "crouch_start"
      change_anime("crouch")
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 按住Z
  #-------------------------------------------------------------------------------
  def hold_z
  #  if @state == "6z" and @frame_number == 2
   #  if @hold_key_z > 3
   #     change_anime("g6z")
   #    @hold_key_z = 0
    #  end
    #end
  end
  #-------------------------------------------------------------------------------
  # ○ 按住X
  #-------------------------------------------------------------------------------
  def hold_x
  end
  #-------------------------------------------------------------------------------
  # ○ 按住S
  #-------------------------------------------------------------------------------
  def hold_s
  end 
  #-------------------------------------------------------------------------------
  # ○ 按住C
  #-------------------------------------------------------------------------------
  def hold_c
    
    return if static?
    
    if  ["stand", "stand_idle", "walk", "dash", "dash_break", "jump_fall", "f_jump_fall", "b_jump_fall", "crouch"].include?(@state)
      @command_plan = "" # 指令預約移除
      @blur_effect = false
      change_anime("guard") 
    end
    if @knock_back_duration <= 0 and blowning?
      do_ukemi
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 上
  #-------------------------------------------------------------------------------
  def up_action(dir)
  #  if ["jump_fall", "f_jump_fall", "b_jump_fall", "hf_jump_fall", "hb_jump_fall", "h_jump_fall"].include?(@state) and @now_jumps  < 2
   #   @me.direction = dir if dir != 0
    #   change_anime("double_jump")
    #  @now_jumps  += 1
   # end
  end
  #-------------------------------------------------------------------------------
  # ○ 下
  #-------------------------------------------------------------------------------
  def down_action
  end
  #-------------------------------------------------------------------------------
  # ○ 前
  #-------------------------------------------------------------------------------
  def front_action
  end
  #-------------------------------------------------------------------------------
  # ○ 後
  #-------------------------------------------------------------------------------
  def back_action
  end
  #--------------------------------------------------------------------------
  # ◇ →→
  #--------------------------------------------------------------------------
  def do_66
    return if static?
     if ["stand", "stand_idle", "walk"].include?(@state)
       do_dash(1)
     end    
     if ["jump_fall", "double_jump_fall", "f_jump_fall", "b_jump_fall", "hf_jump_fall", "hb_jump_fall", "h_jump_fall"].include?(@state) and @airdash_times < 2
        change_anime("af_flee")
        @airdash_times += 1
    end
    
    return
     if attacking?
       if on_air?
         return if @state == "af_chase"
         @me.ai.set_ai_trigger("66_lock", true) if do_act("af_chase", "66","chase") and rand(5) > 2 
       else
         return if @state == "f_chase"
         do_act("f_chase", "66","chase") 
       end
     end
     
  end
  #--------------------------------------------------------------------------
  # ◇ ←←
  #--------------------------------------------------------------------------
  def do_44
    return if static?
    if ["stand", "stand_idle", "walk"].include?(@state)
       do_dash(-1)
     end
     if ["jump_fall", "double_jump_fall", "f_jump_fall", "b_jump_fall", "hf_jump_fall", "hb_jump_fall", "h_jump_fall"].include?(@state) and @airdash_times < 2
        change_anime("ab_flee")
        @airdash_times += 1
    end
      
    return  
    if attacking?
      if on_air?
        return if @action_name == "ab_chase"
        do_act("ab_chase", "44","chase") 
      else
        return if @action_name == "b_chase"
        do_act("b_chase", "44","chase") 
      end
    end
  end

  #--------------------------------------------------------------------------
  # ◇ ↑↑
  #--------------------------------------------------------------------------
  def do_88 
    return
     if attacking?
       @me.ai.set_ai_trigger("8xx_lock", true) if do_act("u_chase", "88","chase") and rand(10) > 2
     end
  end
  #--------------------------------------------------------------------------
  # ◇ ↓↓
  #--------------------------------------------------------------------------
  def do_22 
  end
  #-------------------------------------------------------------------------------
  # ○ C
  #-------------------------------------------------------------------------------
  def c_action
    return if !controllable?
    @timely_guard_time = TIMELY_GUARD_TIME
  end
  #-------------------------------------------------------------------------------
  # ○ →C
  #-------------------------------------------------------------------------------
  def fc_action
    return
    if on_air?
      if ["jump_fall", "f_jump_fall", "b_jump_fall", "guard"].include?(@state)
        change_anime("af_flee")
      end
    else
      if ["stand", "stand_idle", "walk", "dash", "dash_break", "guard", "landing"].include?(@state) or 
        (@state == "f_flee" and (4..5) === @frame_number)
        change_anime("f_flee")
      end
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↑C
  #-------------------------------------------------------------------------------
  def uc_action
   # do_high_jump if ["guard", "landing"].include?(@state)
  end
  #-------------------------------------------------------------------------------
  # ○ ↓C
  #-------------------------------------------------------------------------------
  def dc_action
  end
  #-------------------------------------------------------------------------------
  # ○ ←C
  #-------------------------------------------------------------------------------
  def bc_action
    return
    if on_air?
      if ["jump_fall", "f_jump_fall", "b_jump_fall", "guard"].include?(@state)
        change_anime("ab_flee")
      end
    else
      if ["stand", "stand_idle", "walk", "dash", "dash_break", "guard", "landing"].include?(@state) or 
        (@state == "b_flee" and @frame_number == 5) or (@state == "f_flee" and (4..5) === @frame_number)
         change_anime("b_flee")
      end  
    end
  end

end # class end
