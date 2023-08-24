#==============================================================================
# ■ 教學機，監控教學狀態
#==============================================================================
class Tutorial < Game_Motion
#--------------------------------------------------------------------------
# ○ 人物生成/初始化
#--------------------------------------------------------------------------
def initialize(me,frame=0,anime="stand")
  super


  # 宣告所有動畫
  @anime = {"stand" => [], "fly" => []}
  
  
  # 設定動作的影格
  frame_set
  
  
  # 提示文字
  @help = Sprite.new
  @help.y = 60
  @help.z = 9999
  @help.bitmap = Bitmap.new(640,64)
  @text_flash_time = 0
  @help.opacity = 0
  @help.bitmap.font.size = 26
  # 獲取提示文字長度
  @help_rect = nil
  # 底圖
  @bg = Sprite.new
  @bg.y = @help.y
  @bg.bitmap = Bitmap.new(640,64)
  @bg.z = 9998
  @bg.opacity = 120
  
  @full_limit = 11
  
  
  # 教學進度
  @progress = 0
  
  # 教學階段(0：等待事件、1：等待指令、2：等待動作結束)
  @step = 0
  
  # 教學用變量
  @var = 0

  
end

#==============================================================================
# ■影格設置
#==============================================================================

def frame_set
#-------------------------------------------------------------------------------
# ○ 站立
#-------------------------------------------------------------------------------
@anime["stand"][0] = {"pic" => 999, "wait" => 5, "next" => 1, "body" => @me.stand_body_rect, "z_pos" =>  -1, "penetrate" => true, "shadow_id" => 0, "y_fixed" => true}
@anime["stand"][1] = {"pic" => 999, "wait" => 5, "next" => 1}

@anime["fly"][0] = {"pic" => 999, "wait" => 1, "next" => 1}
@anime["fly"][1] = {"pic" => 999, "wait" => 20, "next" => ["stand"], "atk" => [Rect.new(-500,-480,11600, 680)]}
end




#==============================================================================
# ■ 主模組補強
#==============================================================================
  #--------------------------------------------------------------------------
  # ◇ 著地
  #--------------------------------------------------------------------------
  def do_landing_step
  end
  #--------------------------------------------------------------------------
  # ◇ 攻擊中
  #--------------------------------------------------------------------------
  def attacking?
    return 
  end  
  #--------------------------------------------------------------------------
  # ◇ 輕攻擊
  #--------------------------------------------------------------------------
  def z_skill?
    return 
  end  
  #--------------------------------------------------------------------------
  # ◇ 必殺
  #--------------------------------------------------------------------------
  def x_skill?
    return false
  end  

#==============================================================================
# ■ 指令設置
#==============================================================================

  #-------------------------------------------------------------------------------
  # ○ 無按鍵
  #-------------------------------------------------------------------------------
  def no_press_action
  end
  #-------------------------------------------------------------------------------
  # ○ 按住→
  #      hold_time：按住時間
  #-------------------------------------------------------------------------------
  def hold_right
  end
  #-------------------------------------------------------------------------------
  # ○ 按住 ←
  #      hold_time：按住時間
  #-------------------------------------------------------------------------------
  def hold_left
  end
  #-------------------------------------------------------------------------------
  # ○ 按住↑
  #      dir：左右方向
  #-------------------------------------------------------------------------------
  def hold_up(dir)
  end
  #-------------------------------------------------------------------------------
  # ○ 按住↓
  #-------------------------------------------------------------------------------
  def hold_down
  end
  #-------------------------------------------------------------------------------
  # ○ 按住Z
  #-------------------------------------------------------------------------------
  def hold_z
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
  end
  #-------------------------------------------------------------------------------
  # ○ 上
  #-------------------------------------------------------------------------------
  def up_action(dir)
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
  end
  #--------------------------------------------------------------------------
  # ◇ ←←
  #--------------------------------------------------------------------------
  def do_44
  end

  #--------------------------------------------------------------------------
  # ◇ ↑↑
  #--------------------------------------------------------------------------
  def do_88 
  end
  #--------------------------------------------------------------------------
  # ◇ ↓↓
  #--------------------------------------------------------------------------
  def do_22 
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ Z
  #-------------------------------------------------------------------------------
  def z_action
  end
  #-------------------------------------------------------------------------------
  # ○ →Z
  #-------------------------------------------------------------------------------
  def fz_action
  end
  #-------------------------------------------------------------------------------
  # ○ ↓Z
  #-------------------------------------------------------------------------------
  def dz_action
  end
  #-------------------------------------------------------------------------------
  # ○ ↑Z
  #-------------------------------------------------------------------------------
  def uz_action
  end
  #-------------------------------------------------------------------------------
  # ○ ←Z
  #-------------------------------------------------------------------------------
  def bz_action
  end
  #-------------------------------------------------------------------------------
  # ○ X
  #-------------------------------------------------------------------------------
  def x_action
  end
  #-------------------------------------------------------------------------------
  # ○ →X
  #-------------------------------------------------------------------------------
  def fx_action
  end
  #-------------------------------------------------------------------------------
  # ○ ↓X
  #-------------------------------------------------------------------------------
  def dx_action
  end
  #-------------------------------------------------------------------------------
  # ○ ↑X
  #-------------------------------------------------------------------------------
  def ux_action
  end
  #-------------------------------------------------------------------------------
  # ○ ←X
  #-------------------------------------------------------------------------------
  def bx_action
  end
  #-------------------------------------------------------------------------------
  # ○ S
  #-------------------------------------------------------------------------------
  def s_action
  end
  #-------------------------------------------------------------------------------
  # ○ →S
  #-------------------------------------------------------------------------------
  def fs_action
  end
  #-------------------------------------------------------------------------------
  # ○ ↓S
  #-------------------------------------------------------------------------------
  def ds_action
  end
  #-------------------------------------------------------------------------------
  # ○ ↑S
  #-------------------------------------------------------------------------------
  def us_action
  end
  #-------------------------------------------------------------------------------
  # ○ ←S
  #-------------------------------------------------------------------------------
  def bs_action
  end
  #-------------------------------------------------------------------------------
  # ○ C
  #-------------------------------------------------------------------------------
  def c_action
  end
  #-------------------------------------------------------------------------------
  # ○ →C
  #-------------------------------------------------------------------------------
  def fc_action
  end
  #-------------------------------------------------------------------------------
  # ○ ↑C
  #-------------------------------------------------------------------------------
  def uc_action
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
  end
  
  #-------------------------------------------------------------------------------
  # ○ 常時監視A (不受暫停、受傷定格效果影響)
  #      通常用在調整受傷、倒地這種不確定何時恢復姿勢的情況
  #-------------------------------------------------------------------------------
  def respective_updateA

   @me.hidden = true if !@me.hidden 
   @me.direction = 1 if @me.direction != 1
    $game_party.actors[0].immortal = true
    $game_party.actors[0].hp = $game_party.actors[0].maxhp

   
   # 更新文字閃爍
    if !$game_switches[STILILA::CANNOT_CTRL] and @progress < 12
      @help.opacity += 20 if @help.opacity < 255
       if !@help.visible
         @help.visible = true
         @bg.visible = true
       end
      @text_flash_time = (@text_flash_time + 1) % 120
       if @text_flash_time < 60
         alpha = (60 - @text_flash_time) * 4
       else
         alpha = (@text_flash_time - 60) * 4
       end
      @help.color.set(255, 255, 0, alpha)
    elsif @progress < 12
      if @help.visible and @help.opacity == 0
        @help.visible = false
        @bg.visible = false
      else
        @help.opacity -= 150 if @help.opacity > 0
      end
    end
    
    
 #  @player = $game_party.actors[0]
   
   if @step == 0
     update_step0
   elsif @step == 1
     update_step1
   elsif @step == 2
     update_step2
   end

  end
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學階段0 
  #      只是為了觸發事件、停止事件連續觸發用
  #-------------------------------------------------------------------------------
  def update_step0
     case @progress
     when 0 # 走路
        common_event = $data_common_events[71]
        $game_system.battle_interpreter.setup(common_event.list, 0)
        help_refresh 
     when 1 # 跑
        common_event = $data_common_events[72]
        $game_system.battle_interpreter.setup(common_event.list, 0)
        help_refresh 
     when 2 # 跳
        common_event = $data_common_events[73]
        $game_system.battle_interpreter.setup(common_event.list, 0)
        help_refresh 
     when 3 # 防禦
        common_event = $data_common_events[74]
        $game_system.battle_interpreter.setup(common_event.list, 0)
        help_refresh 
     when 4 # 迴避
        common_event = $data_common_events[75]
        $game_system.battle_interpreter.setup(common_event.list, 0)
        help_refresh 
     when 5 # 受身
        common_event = $data_common_events[76]
        $game_system.battle_interpreter.setup(common_event.list, 0)
        help_refresh 
     when 6 # 攻擊
        common_event = $data_common_events[77]
        $game_system.battle_interpreter.setup(common_event.list, 0)
        help_refresh 
     when 7 # 連續攻擊
        common_event = $data_common_events[78]
        $game_system.battle_interpreter.setup(common_event.list, 0)
        help_refresh 
     when 8 # 取消
        common_event = $data_common_events[79]
        $game_system.battle_interpreter.setup(common_event.list, 0)
        help_refresh 
     when 9 # 絕技
        common_event = $data_common_events[80]
        $game_system.battle_interpreter.setup(common_event.list, 0)
        help_refresh 
     when 10 # 換人
        common_event = $data_common_events[81]
        $game_system.battle_interpreter.setup(common_event.list, 0)
        help_refresh 
     when 11 # 獸化
        common_event = $data_common_events[82]
        $game_system.battle_interpreter.setup(common_event.list, 0)
        help_refresh 
     else
        common_event = $data_common_events[83]
        $game_system.battle_interpreter.setup(common_event.list, 0)
     end
     @step = 1
     
  end
 
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學階段1 
  #      等玩家完成教學內容的階段
  #-------------------------------------------------------------------------------
  def update_step1
     case @progress
     when 0  # 走路
       update_test1
     when 1 # 跑
       update_test2
     when 2 # 跳
       update_test3
     when 3 # 防禦
       update_test4
     when 4 # 迴避
       update_test5
     when 5 # 受身
       update_test6
     when 6 # 攻擊
       update_test7
     when 7 # 連續攻擊
       update_test8
     when 8 # 取消
       update_test9
     when 9 # 絕技
       update_test10
     when 10 # 換人
       update_test11
     when 11 # 獸化
       update_test12
     end
   end
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學階段2
  #      等角色恢復態勢，進行下一個教學的階段
  #-------------------------------------------------------------------------------
  def update_step2
    if $game_party.actors[0].motion.freemove?
      @progress += 1
      @step = 0
      
      # 重設 @var 變量
      case @progress
      when 1 # 跑
        @var = 0
      when 2 # 跳
        @var = 0
      when 3 # 防禦
        @var = [0, 0]
      when 4 # 迴避 
        @var = 0
      when 5 # 受身
        @var = 0
      when 6 # 攻擊
        @var = [false,false,false,false,false,false]
      when 7 # 連續攻擊
        @var = [false,false,false]
      when 8 # 取消
        @var = [false,false,false]
      when 9 # 絕技
        @var = 0
      when 10 # 換人
        @var = 0
      when 11 # 獸化
        @var = 0 
      end
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 教學內容通過
  #-------------------------------------------------------------------------------
  def test_pass
    # 禁止操作
    $game_switches[STILILA::CANNOT_CTRL] = true
    $game_switches[STILILA::CANNOT_AI] = true
    Audio.se_play("Audio/SE/056-Right02", 90 * $game_config.se_rate / 10, 100)
    case @progress
    when 0 # 走路
      $game_party.actors[0].motion.change_anime("stand")
    when 1 # 跑
      $game_party.actors[0].motion.change_anime("dash_break")
    when 2 # 跳
    when 3 # 防禦
      $game_party.actors[0].motion.change_anime("stand")
    when 4 # 迴避
    when 5 # 受身
    when 6 # 攻擊
    when 7 # 連續攻擊
    when 8 # 取消
    when 9 # 絕技
    when 10 # 換人
      $game_party.actors[0].motion.change_anime("stand")
    when 11 # 獸化
      
    end
    
    @step = 2
    
    
  end
  
  
  
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學內容1－練習走路
  #-------------------------------------------------------------------------------
  def update_test1
     $game_party.actors[0].sp = 0
    if player_state?(["walk"])
      @var += 1
      test_pass  if @var >= 120
    else
      @var = 0
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學內容2－練習跑步
  #-------------------------------------------------------------------------------
  def update_test2
    $game_party.actors[0].sp = 0
    if player_state?(["dash"])
      @var += 1
      test_pass if @var >= 120 
    else
      @var = 0
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學內容3－練習跳
  #-------------------------------------------------------------------------------
  def update_test3
    $game_party.actors[0].sp = 0
    if player_state?(["jump", "f_jump"]) and player_anime_time == 1
      @var += 1
      test_pass if @var >= 3
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學內容4－練習防禦
  #-------------------------------------------------------------------------------
  def update_test4
    $game_party.actors[0].sp = 0
    if player_state?(["guard_shock"]) and player_anime_time == 1
      @var[0] += 1
    end
    if $game_party.actors[0].motion.hit_invincible_duration == 1
      @var[1] += 1
    end
    test_pass if @var[0] >= 3 and @var[1] >= 1 
  end
  
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學內容5－練習迴避
  #-------------------------------------------------------------------------------
  def update_test5
    $game_party.actors[0].sp = 0
    if player_state?(["f_flee", "b_flee"]) and player_anime_time == 1 and player_frame_number== 0
      @var += 1
      test_pass if @var >= 3
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學內容6－練習受身
  #-------------------------------------------------------------------------------
  def update_test6
    $game_party.actors[0].sp = 0
    
    $scene.test_windows[2].refresh(@anime_time)
    
    if !$game_switches[STILILA::CANNOT_CTRL] and @var == 0
      @var = 1 
      @anime_time = 0
    end
    
    if @var == 1 and @anime_time == 150
      change_anime("fly")
    end

    if player_state?(["ukemi"]) and player_anime_time == 1
      @var += 1
      test_pass if @var >= 2
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學內容7－練習攻擊
  #-------------------------------------------------------------------------------
  def update_test7
    $game_party.actors[0].sp = 0
    
    if player_state?(["5z"]) and player_anime_time == 1
      @var[0] = true
      $game_screen.pictures[56].set_opacity(90,3)
    end
    
    if player_state?(["6z"]) and player_anime_time == 1
      @var[1] = true
      $game_screen.pictures[57].set_opacity(90,3)
    end
    
    if player_state?(["2z"]) and player_anime_time == 1
      @var[2] = true
      $game_screen.pictures[58].set_opacity(90,3)
    end
    
    if player_state?(["jz"]) and player_anime_time == 1
      @var[3] = true
      $game_screen.pictures[59].set_opacity(90,3)
    end
    
    if player_state?(["j6z"]) and player_anime_time == 1
      @var[4] = true
      $game_screen.pictures[60].set_opacity(90,3)
    end
    
    if player_state?(["j2z"]) and player_anime_time == 1
      @var[5] = true
      $game_screen.pictures[61].set_opacity(90,3)
    end
    
    # 檢測通過
    c = 0
    for v in @var
      c += 1 if v
      # 通過
      if c == 6
        test_pass
        # 消去圖片
        for p in 56..61
          $game_screen.pictures[p].erase
        end
      end
    end
     
    
  end
  
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學內容8－練習連續攻擊
  #-------------------------------------------------------------------------------
  def update_test8
    $game_party.actors[0].sp = 0
    
    if player_state?(["5z"]) and player_anime_time == 1
      @var[0] = true
      $game_screen.pictures[56].set_opacity(90,3)
    end
    
    if player_state?(["5zz"]) and player_anime_time == 1
      @var[1] = true
      $game_screen.pictures[57].set_opacity(90,3)
    end
    
    if player_state?(["5zzz"]) and player_anime_time == 1
      @var[2] = true
      $game_screen.pictures[58].set_opacity(90,3)
    end

    # 檢測通過
    c = 0
    for v in @var
      c += 1 if v
      # 通過
      if c == 3
        test_pass 
        # 消去圖片
        for p in 56..58
          $game_screen.pictures[p].erase
        end
      end
    end

  end
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學內容9－練習取消
  #-------------------------------------------------------------------------------
  def update_test9
    $game_party.actors[0].sp = 0
    
    # 檢測6Z
    if player_state?(["6z"]) and player_anime_time == 1
      @var[0] = true
      $game_screen.pictures[56].set_opacity(90,3)
    end
    # 檢測2Z
    if player_state?(["2z"]) and player_anime_time == 1 and @var[0]
      @var[1] = true
      $game_screen.pictures[57].set_opacity(90,3)
    end
    # 檢測是否有取消
    if $game_party.actors[0].chain_count >= 1
      @var[2] = true
    end

    # 檢測通過
    c = 0
    for v in @var
      c += 1 if v
      # 通過
      if c == 3
        test_pass
        # 消去圖片
        for p in 56..57
          $game_screen.pictures[p].erase
        end
        return
      end
    end

    
    if $game_party.actors[0].motion.freemove?
      @var = [false, false, false]
      $game_screen.pictures[56].set_opacity(255,3)
      $game_screen.pictures[57].set_opacity(255,3)
    end 
    
  end
  
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學內容10－練習絕技
  #-------------------------------------------------------------------------------
  def update_test10
     $game_party.actors[0].sp = 60 if $game_party.actors[0].motion.freemove?
    if player_state?(["5x"])
      @var += 1
      test_pass  if @var >= 1
    else
      @var = 0
    end
  end
  
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學內容11－換人
  #-------------------------------------------------------------------------------
  def update_test11
     $game_party.actors[0].sp = 0
     test_pass if $game_party.actors[0].id == 2
  end
  #-------------------------------------------------------------------------------
  # ○ 定期更新：教學內容12－獸化
  #-------------------------------------------------------------------------------
  def update_test12
     $game_party.actors[0].sp = 0
     $game_party.actors[0].awake_time = 1200
     test_pass if $game_party.actors[0].id == 3
  end
   
  #-------------------------------------------------------------------------------
  # ○ 常時監視B (受暫停、受傷定格效果影響)
  #-------------------------------------------------------------------------------
  def respective_updateB
  end
  
  
  
  #-------------------------------------------------------------------------------
  # ○ 玩家角色目前狀態
  #-------------------------------------------------------------------------------
  def player_state?(states)
    return states.include?($game_party.actors[0].motion.state)
  end
  #-------------------------------------------------------------------------------
  # ○ 玩家角色目前動畫時間
  #-------------------------------------------------------------------------------
  def player_anime_time
    return $game_party.actors[0].motion.anime_time
  end
  #-------------------------------------------------------------------------------
  # ○ 玩家角色目前畫格
  #-------------------------------------------------------------------------------
  def player_frame_number
    return $game_party.actors[0].motion.frame_number
  end
#==============================================================================
# ■ 其他
#==============================================================================
  


  #--------------------------------------------------------------------------
  # ● 說明刷新
  #--------------------------------------------------------------------------
  def help_refresh 
    @help.bitmap.clear
    @bg.bitmap.clear
    
    case $game_config.language
    # ======== 繁中
    when "tw"
      case @progress
      when 0
        str = "維持走路狀態 2 秒鐘。"
      when 1
        str = "維持跑步狀態 2 秒鐘。"
      when 2
        str = "進行跳躍 3 次。"
      when 3
        str = "成功防禦敵人攻擊 3 次、成功瞬間防禦 1 次。"
      when 4
        str = "進行迴避移動 3 次。"
      when 5
        str = "進行受身 1 次。"
      when 6..7
        str = "依指示完成所有攻擊指令。"
      when 8
        str = "依指示成功使用↓Z取消。"
      when 9
        str = "使用絕技 1 次。"
      when 10
        str = "進行角色切換。"
      when 11
        str = "進行獸化。"
      else
        return
      end
    # ======== 英文 
    when "en"
      case @progress
      when 0
        str = "Move during 2 seconds."
      when 1
        str = "Run during 2 seconds."
      when 2
        str = "Jump for three times."
      when 3
        str = "Defend 3 times, and defense immediately once."
      when 4
        str = "Dodge three times."
      when 5
        str = "Perform 1 Recovery."
      when 6..7
        str = "Follow the commands"
      when 8
        str = "Follow the commands"
      when 9
        str = "Use your Skill"
      when 10
        str = "Change the character."
      when 11
        str = "Change to the beast mode"
      else
        return
      end
    # ======== 西班牙文
    when "es"
      case @progress
      when 0
        str = "Muévete durante 2 segundos."
      when 1
        str = "Corre durante 2 segundos."
      when 2
        str = "Salta tres veces."
      when 3
        str = "Bloquea 3 veces, y haz uno instantáneo una vez."
      when 4
        str = "Esquiva tres veces."
      when 5
        str = "Recupérate 1 vez"
      when 6..7
        str = "Pulsa los botones en pantalla."
      when 8
        str = "Pulsa los botones en pantalla."
      when 9
        str = "Usa tu Técnica"
      when 10
        str = "Cambia de personaje."
      when 11
        str = "Transfórmate en bestia."
      else
        return
      end
    # ======== 其他  
    else
      case @progress
      when 0
        str = "維持走路狀態 2 秒鐘。"
      when 1
        str = "維持跑步狀態 2 秒鐘。"
      when 2
        str = "進行跳躍 3 次。"
      when 3
        str = "成功防禦敵人攻擊 3 次、成功瞬間防禦 1 次。"
      when 4
        str = "進行迴避移動 3 次。"
      when 5
        str = "進行受身 1 次。"
      when 6..7
        str = "依指示完成所有攻擊指令。"
      when 8
        str = "依指示成功使用↓Z取消。"
      when 9
        str = "使用絕技 1 次。"
      when 10
        str = "進行角色切換。"
      when 11
        str = "進行獸化。"
      else
        return
      end
    end
    

    draw_helptext(str)

    # 描繪底圖
    bg_rect = @help_rect
    bg_rect.x = 320 - bg_rect.width/2 - 24
    bg_rect.width = bg_rect.width + 48
    bg_rect.y += 15
    bg_rect.height += 8
    @bg.bitmap.fill_rect(bg_rect, Color.new(0,0,0,120)) 
    @help_rect = nil
    
  end
  #--------------------------------------------------------------------------
  # ● 描繪提示
  #--------------------------------------------------------------------------
  def draw_helptext(str)
    rect = @help.bitmap.text_size(str)
    @help.bitmap.draw_text(320 - rect.width/2, 0, rect.width, 64, str, 2) 
    @help_rect = rect
  end

  #--------------------------------------------------------------------------
  # ○ 解放
  #--------------------------------------------------------------------------
  def dispose
    @help.bitmap.dispose
    @help.dispose
    @bg.bitmap.dispose
    @bg.dispose
  end
  
  #--------------------------------------------------------------------------
  # ◇ 碰撞判定時的變數設置
  #--------------------------------------------------------------------------  
  def collision_varset(action, target)
  end
  #--------------------------------------------------------------------------
  # ◇ 碰撞行為
  # action：自身的行動
  # target：目標
  # 構想：處刑演出(目標血量or自己血量小於定值)
  #--------------------------------------------------------------------------  
  def collision_action(action, target)
  end
  
  #--------------------------------------------------------------------------
  # ◇ 取得攻擊目標範圍
  #     (1：敵方、2：我方、3：使用者)
  #--------------------------------------------------------------------------  
  def get_skill_scope
    return 1
  end
  
    
  #--------------------------------------------------------------------------
  # ◇ 攻擊效果設定
  #--------------------------------------------------------------------------  
  def skill_effect(skill, target)
      result = super(skill, target)
      
      if skill == "fly"
        result["power"] = 0
        result["limit"] = 0
        result["u_hitstop"] = 20
        result["t_hitstop"] = 20                 
        result["t_knockback"] = 25 
        result["x_speed"] = 0 
        result["y_speed"] = 18       
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 70, 135]  
        result["sp_recover"] = 2
        result["h_shake"] = [1,3,8,1]
        result["d_shake"] = [2,4,8,1]
        result["full_count"] = 2
      end
      
      return result
  end #def end
end # class end
