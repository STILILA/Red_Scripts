# 觀賞模式(全自動) 
#class Scene_Battle
  #WATCH_MODE = false
#end





#==============================================================================

# ▽△▽ XRXS_BS 1. Full-Move BattleSystem ver.0.993 ▽△▽ built 033011
# by 桜雅 在土

#==============================================================================
# □ カスタマイズポイント
#==============================================================================
module XRXS_BS1
  # バトルフィールドの下端
  BF_BOTTOM =  -420#-416 
end

class Scene_Battle
  #--------------------------------------------------------------------------
  # 鏡頭放大率( 111～296、185が基準)
  #--------------------------------------------------------------------------
  # カメラ最近距離
  XCAM_DISTANCE_MIN_A       = 185#144 
  # カメラ最遠距離
  XCAM_DISTANCE_MAX_A       = 185 # 185
  #--------------------------------------------------------------------------
  # メテオスマッシュ
  #--------------------------------------------------------------------------
  # 左右端によるダメージ＆復帰を有効にする
  BURST_SMASH_ENABLE = true
  # 上下端によるダメージ＆復帰を有効にする
  METEOR_SMASH_ENABLE = true
  # ダメージ[単位:%]
  METEOR_SMASH_DAMAGE = 2
  #--------------------------------------------------------------------------
  # 系統設定
  #--------------------------------------------------------------------------
  # 倒地聲
  DOWN_SE = "down_se"
  # 「二度押し」反応速度(高いほどゆるい)
  DOUBLE_TRIGGER_DURATION = 20
  
  # 1ターンとするフレーム数 ( 40F = 1秒 )
  FRAMES_PER_TURN         =  $fps_set #40
  
  # キーコンフィグ
  


 
  # 選單
  KEY_MENU                = 27

  # 戰鬥結束漸變
  BATTLE_END_TRANSITION   = ""#"004-Blind04"
  
  #--------------------------------------------------------------------------
  # ○ キャラが壁などに衝突した際に起きるシェイクとSE
  #--------------------------------------------------------------------------
  def do_crashing_shake(type = 0)
    case type 
     when 0
      # シェイクを開始
      $game_screen.start_shake(7,12,9,0)
      when 1
      $game_screen.start_shake(14,27,8)
    end
    # 効果音を再生
    Audio.se_play("Audio/SE/Earth5", 90 * $game_config.se_rate / 10, 120)
  end
end





#==============================================================================
# ■ Scene_Battle
#==============================================================================
class Scene_Battle
  attr_accessor :handle_battler
  attr_accessor :focus_count   #集中線持續時間
  attr_accessor :focus_plan    #集中線預約
  
  attr_accessor :all_stop_time   #定格特效
  attr_accessor :stop_time_plan  #定格預約
  attr_accessor :camera_feature  #特寫變數
  
  attr_reader :phase              # 戰鬥階段
  attr_reader :battle_bullets  # 飛行道具
  attr_reader :battle_items    # 場內小道具
  attr_accessor :battle_field_objects     # 場內其他物件
  attr_reader :status_window             # 我方狀態窗
  attr_reader :spriteset                      # 戰場
  attr_reader :test_windows
  attr_reader :achievement_window   # 成就視窗
  
  #--------------------------------------------------------------------------
  # ● 主處理
  #--------------------------------------------------------------------------
  def main
    
    # 顯示碰撞區域
    if $crash_box
      $xcam_distance_min       = XCAM_DISTANCE_MIN_B
      $xcam_distance_max       = XCAM_DISTANCE_MAX_B
    else
      $xcam_distance_min       = XCAM_DISTANCE_MIN_A
      $xcam_distance_max       = XCAM_DISTANCE_MAX_A
    end    
    # 儲存隊伍目前狀態
    $game_temp.battle_start_save
    # 設定角色的位置
    for actor in $game_party.actors
      actor.set_position
    end
    
    # 禁止操作開關為on
    $game_switches[STILILA::CANNOT_CTRL] = true
    $game_switches[STILILA::CANNOT_AI] = true
    
    # 挑戰模式失敗判定
    @ex_failed = false
    
    # 初始化戰鬥用的各種暫時資料
    $game_temp.in_battle = true
    $game_temp.battle_turn = 0
    $game_temp.battle_event_flags.clear
    $game_temp.battle_abort = false
    $game_temp.battle_main_phase = false
    $game_temp.battleback_name = $game_map.battleback_name
    $game_temp.forcing_battler = nil
    # 初始化戰鬥用事件解釋器
    $game_system.battle_interpreter.setup(nil, 0)
    # 設定區域
    @area = 1
    # 刷黑畫面
    $game_screen.start_tone_change(Tone.new(-255,-255,-255),1) if $game_temp.battle_troop_id != 40
    

    # 準備敵方隊伍
    @troop_id = $game_temp.battle_troop_id
    @stage_script = set_stage_script(@troop_id)
    
     # =============== 練習模式
     if @troop_id == 34
       enemy_array = [[$game_temp.practice_battler, 500, 0, false, true]] 
       # 生成敵人
       $game_troop.setup(@troop_id, enemy_array)
     else # =========== 練習模式以外  
       # 生成敵人
       $game_troop.setup(@troop_id, eval(@stage_script+"::Enemies"))
     end

    # 產生角色命令視窗
    s1 = $data_system.words.attack
    s2 = $data_system.words.skill
    s3 = $data_system.words.guard
    s4 = $data_system.words.item
    @actor_command_window = Window_Command.new(160, [s1, s2, s3, s4])
    @actor_command_window.y = 160
    @actor_command_window.back_opacity = 160
    @actor_command_window.active = false
    @actor_command_window.visible = false
    # 產生隊伍命令視窗、提示視窗
    @party_command_window = Window_PartyCommand.new
    @help_window = Window_Help.new
    @help_window.back_opacity = 160
    @help_window.visible = false
    # 生成我方狀態視窗
    @status_window = Window_BattleStatus.new
    # 生成敵人狀態視窗
    @window_enemystatus = Window_BattleStatusEnemy.new
    @window_enemystatus.visible = false
    # 產生對話視窗
    @message_window = Window_Message.new
    # 產生活動區塊
    @spriteset = Spriteset_Battle.new
    # 產生暫停畫面遮色片
    @battle_stop_pic = Sprite.new
    @battle_stop_pic.visible = false
    @battle_stop_pic.bitmap = RPG::Cache.windowskin("battle_stop")
    @battle_stop_pic.z = 8000
    @battle_stop_pic.opacity = 130
    #@battle_stop_pic.blend_type = 0
    # 生成獸化計時視窗
    @awaketime_window = Window_ShowNumber.new(15,420)
    @awaketime_window.visible = false
    
    # 產生評價內容變量
    @result_windows = []
    
    # 產生成就視窗
    create_achievement
    
    # 生成測試視窗
    @test_windows = []
    test_window_y = 0
    for w in 0..3
      @test_windows[w] = Window_ShowNumber.new(540,300+test_window_y)
      test_window_y += 40
    end
    test_window_y = nil
    
    
   # @bullet_count_window = Window_ShowNumber.new(20,400)
   # @combo_list_window = Window_Combolist.new
    
    # 初始化場內物件
    @battle_field_objects = []
    # 生成場內物件
    setup_battle_field_objects
   
   
    # 完全靜止時間初始化
    @all_stop_time = 0
    @stop_time_plan = []
    # 特寫變數
    @camera_feature = [0,0,0]
    @focus_count = 0
    @focus_plan = []

    # 勝負判定標籤
    $game_temp.battlejudged = false

    # 血量氣量初始化
    for actor in $game_party.actors
      actor.hp = actor.maxhp
      actor.sp = actor.maxsp
      actor.now_hp = actor.hp
      actor.now_sp = actor.sp
    end

    # 初始化等待計數
    @wait_count = 0
    # 執行過渡
    if $data_system.battle_transition == ""
      Graphics.transition(1)
    else
      Graphics.transition(40, "Graphics/Transitions/" +
        $data_system.battle_transition)
    end
    # 開始自由戰鬥回合
    start_phase1
    # 主循環
    loop do
      # 更新遊戲畫面
      Graphics.update 
      # 更新輸入訊息
      Input.update
      # 更新畫面
      if $_Start
        update if $_OnFocus.call != 0
      else
        update
      end
      # 如果畫面切換的話就中斷循環
      if $scene != self
        break
      end
    end
    # 更新地圖
    $game_map.refresh
    # 戰鬥判定消除
    $game_switches[STILILA::BATTLE_FLAG] = false
    
    # 特殊：奶奶前哨戰判定
    $game_switches[STILILA::Corals_FIRST_BATTLE] = false
    
    # 準備過渡
    Graphics.freeze
    

    # 釋放視窗
    @actor_command_window.dispose
    @party_command_window.dispose
    @help_window.dispose
    @status_window.dispose
    @message_window.dispose
    @window_activemenu.dispose
    @window_enemystatus.dispose
    @battle_stop_pic.bitmap.dispose
    @battle_stop_pic.dispose
    if @skill_window != nil
      @skill_window.dispose
    end
    if @item_window != nil
      @item_window.dispose
    end
    if @result_window != nil
      @result_window.dispose
    end

    
    # 勝負判定標籤重置
    $game_temp.battlejudged = false
    # 釋放獸化計時視窗
    @awaketime_window.dispose
    # 釋放測試視窗
    for w in @test_windows
      w.dispose
    end
    
    # 釋放評價內容
    for w2 in @result_windows
      w2.dispose
    end
    # 釋放成就視窗
    for w3 in @achievement_window
      w3.bitmap.dispose
      w3.dispose
    end
    
    
    # 禁止操作開關為off
    $game_switches[STILILA::CANNOT_CTRL] = false
    $game_switches[STILILA::CANNOT_AI] = false
    
    $game_switches[STILILA::BATTLER_PUSHED_LIGHTEN] = false
    $game_switches[STILILA::JUDGE_SLOW] = false
    $game_switches[STILILA::BOSS_FLAG] = false
    
    # 釋放活動區塊
    @spriteset.dispose
    
    
    # 處理我方隊伍
    for actor in $game_party.actors
    # 解除模組與位置
      actor.dispose_positioning
      # 覺醒值歸 0
    #  actor.awake_time = 0
    end

    # 解除敵方模組與位置
    for enemy in $game_troop.enemies
      enemy.dispose_positioning
    end
    
    # 解除場內物件模組
    for obj in battle_field_objects
      obj.motion.dispose
    end

    # 標題畫面切換中的情況
    if $scene.is_a?(Scene_Title) and @ex_failed
      # 淡入淡出畫面
      Graphics.transition(180)
      Graphics.freeze
    end
    # 戰鬥測試或者遊戲結束以外的畫面切換中的情況
    if $BTEST and not $scene.is_a?(Scene_Gameover)
      $scene = nil
    end
    
    # 如果Scene不是GameOver
    if !$scene.is_a?(Scene_Gameover)
      # 如果是挑戰模式
      if $game_temp.battle_troop_id >= 39 and @ex_failed
        Graphics.transition(60) 
        Graphics.freeze
        for i in 0...60
          Graphics.update
        end
      else
        Graphics.transition(20) 
        Graphics.freeze
        for i in 0...20
          Graphics.update
        end
      end
    end

  end
  

  #--------------------------------------------------------------------------
  # ● 戰鬥開始準備
  #--------------------------------------------------------------------------
  alias xrxs_bs1_start_phase1 start_phase1
  def start_phase1
    # 呼び戻す
    xrxs_bs1_start_phase1
    # 把畫面刷黑
    $game_screen.start_tone_change(Tone.new(-255,-255,-255, 0),1) if $game_temp.battle_troop_id != 40
    # 設定鏡頭追蹤角色
    @xcam_watch_battler        = $game_party.actors[0]#@handle_battler

    # 強制執行一次戰鬥事件
    setup_battle_event
    $game_system.battle_interpreter.update
    
    # 回合數進入1
    $game_temp.battle_turn = 1
    
    # 設定操縱者(1號開關不打開的情況)
    @handle_battler            = $game_party.actors[0]# unless $game_switches[1]
    
    # 生成敵方模組
    for battler in $game_troop.enemies
      battler.initialize_positioning
    end
    # 生成我方模組
    for battler in $game_party.actors
      battler.initialize_positioning
    end
    
    
    # 連打按鍵偵測
    @trigger_key_left = 0
    @trigger_key_right = 0
    @trigger_key_up   = 0
    @trigger_key_down = 0
    
    
    #空中衝刺指令判定
    #@trigger_airdash_left_d = 0
    #@trigger_airdash_right_d = 0
    @frames_per_turn           = 0
    # 初始化飛行道具
    @battle_bullets = []
    # 初始化小道具
    @battle_items = []
    # バトルフィールドブロックの設定
    setup_battle_field_blocks

    create_activemenu

  end

  #--------------------------------------------------------------------------
  # ● 製作暫停視窗
  #--------------------------------------------------------------------------
  def create_activemenu
    
    if $game_temp.battle_troop_id == 34
      @window_activemenu = Window_PracticeSelectMain.new(1, lambda {@phase = 1})  # 練習模式的選項窗
    else
      
      @window_activemenu = Window_PracticeSelectMain.new(0, lambda {@phase = 1})
=begin
      # 暫停視窗を作成
      case $game_config.language
      # ======== 繁中
      when "tw"
        @window_activemenu = Window_Command.new(192, ["繼續遊戲", "返回標題"])
      # ======== 英文 
      when "en"
        @window_activemenu = Window_Command.new(192, ["Resume", "Back to menu"])
      # ======== 西班牙文
      when "es"
        @window_activemenu = Window_Command.new(192, ["Seguir", "Volver al menú"])
      # ======== 其他  
      else
        @window_activemenu = Window_Command.new(192, ["繼續遊戲", "返回標題"])
      end
      @window_activemenu.x = 320 - @window_activemenu.width / 2
      @window_activemenu.y = 290
      @window_activemenu.z = 8500
      @window_activemenu.opacity = 100
      @window_activemenu.visible = false
      @window_activemenu.index = -1
    #  @window_activemenu.disable_item(1) if $game_temp.battle_can_escape == false
=end
    end
  end

  #--------------------------------------------------------------------------
  # ● フレーム更新 (アクターコマンドフェーズ)
  #--------------------------------------------------------------------------
  alias xrxs_bs1_update_phase3 update_phase3
  def update_phase3
    # アニメーションを停止
    @spriteset.stop_update_animation
    # アクティヴメニューがアクティヴの場合
    if @window_activemenu.active
      update_phase3_activemenu
      return
    end
    # 他
    xrxs_bs1_update_phase3
  end

  #--------------------------------------------------------------------------
  # ● 生成成就視窗
  #--------------------------------------------------------------------------
  def create_achievement
    # 產生成就視窗
    @achievement_plan = []  # 預約用
    @achievement_show = 0
    @achievement_window = [Sprite.new, Sprite.new, Sprite.new]
    @achievement_window[0].bitmap = RPG::Cache.windowskin("message_window")
    @achievement_window[0].zoom_x = 0.27
    @achievement_window[0].zoom_y = 0.4

    @achievement_window[1].bitmap = Bitmap.new(160,40)
    @achievement_window[1].bitmap.font.size = 16
    @achievement_window[1].bitmap.font.color = Color.new(0, 0, 0, 255)
    case $game_config.language
    # ======== 繁中
    when "tw"
      @achievement_window[1].bitmap.draw_text(0,0,160,40,"達成成就：")
    # ======== 英文 
    when "en"
      @achievement_window[1].bitmap.draw_text(0,0,160,40,"Achievement:")
    # ======== 西班牙文
    when "es"
      @achievement_window[1].bitmap.draw_text(0,0,160,40,"Logros:")
    # ======== 其他  
    else
      @achievement_window[1].bitmap.draw_text(0,0,160,40,"達成成就：")
    end
    @achievement_window[2].bitmap = Bitmap.new(150,40)
    @achievement_window[2].bitmap.font.size = 16
    @achievement_window[2].bitmap.font.color = Color.new(225, 30, 30, 255)
    @achievement_window[2].bitmap.draw_text(0,0,160,40,"")
    @achievement_window[0].x = @achievement_window[1].x = @achievement_window[2].x = 640 - 180
    @achievement_window[1].x += 15
    @achievement_window[2].x += 10
    @achievement_window[0].y = @achievement_window[1].y = @achievement_window[2].y = 20
    @achievement_window[2].y += 20
    @achievement_window[0].z = @achievement_window[1].z = @achievement_window[2].z = 9999
    @achievement_window[0].opacity = @achievement_window[1].opacity = @achievement_window[2].opacity = 0
  end  
  
  #--------------------------------------------------------------------------
  # ● 顯示成就視窗
  #--------------------------------------------------------------------------
  def achievement_appear(text)
    @achievement_plan.push(text) # 讓成就依序顯示
  end
  
  #--------------------------------------------------------------------------
  # ● 更新成就視窗
  #--------------------------------------------------------------------------
  def update_achievement_window
    # 如果有準備顯示的成就
    if !@achievement_plan.empty? and @achievement_show == 0
      @achievement_show = 121
      text = @achievement_plan.shift
      @achievement_window[2].bitmap.draw_text(0,0,160,40,text,1)
    end
    # 計時
    @achievement_show -= 1 if @achievement_show > 0
    # 過渡處理
    case @achievement_show
    when 116..121
      opacity = 45 * (121 - @achievement_show)
      @achievement_window[0].opacity = @achievement_window[1].opacity = @achievement_window[2].opacity = opacity
    when 1..10
      opacity = 22.5 * @achievement_show
      @achievement_window[0].opacity = @achievement_window[1].opacity = @achievement_window[2].opacity = opacity
    when 0
      @achievement_window[0].opacity = @achievement_window[1].opacity = @achievement_window[2].opacity = 0
      @achievement_window[2].bitmap.clear
    end
  end
  
  #--------------------------------------------------------------------------
  # ● 總體更新
  #--------------------------------------------------------------------------
  alias xrxs_bs1_update update
  def update
    # @wait_countを設定して本来の処理を行わないようにする
    @wait_count = 1    
    @wait_count_motion = 1 if @phase == 3
    
    # 更新fps
    if [1,7].include?(@phase)
      if $game_temp.fps_change == 0 and Graphics.frame_rate < $fps_set 
        for j in 0...1
          Graphics.update
        end
        Graphics.frame_rate += 1 
      else
        $game_temp.fps_change -= 1
      end
    end

    # 如果鏡頭跟隨的對象陣亡
    if @xcam_watch_battler != nil and @xcam_watch_battler.dead?
      for a in $game_party.actors
        if a.exist?
          @xcam_watch_battler = a
          break
        end
      end
    end
    
    # 更新成就視窗
    update_achievement_window

    # 呼び戻す
    xrxs_bs1_update

    if (Kboard.trigger?(KEY_MENU) || Joyall.trigger?(64, 0)) and @phase == 1
      Graphics.freeze 
        #
        # 「選單」
        #
        # 決定 SE を演奏
        $game_system.se_play($data_system.decision_se)
         if $game_temp.battle_troop_id == 34
           @window_activemenu.start_open
         else
           @window_activemenu.start_open
     #     @window_activemenu.active  = true
      #    @window_activemenu.visible = true
      #    @window_activemenu.index = 0
     #     @battle_stop_pic.visible = true 
        end
      
        # フェーズ 3 に移行
        @phase = 3
        @spriteset.stop_update_animation
        Graphics.transition(10)
        return
    end
    

    # 各階段更新
    case @phase
   
    when 1  # 戰鬥階段
   #   update_battle_events
      update_effects
      update_phase1
      update_coordinates
      update_motions
      update_battle_test
      
      # 累計過關時間
      $game_system.result_cleartime += 1
      
      # 練習模式全恢復
      if $game_temp.battle_troop_id == 34 && $game_party.actors[0].motion && !$game_party.actors[0].motion.damaging? && $game_troop.enemies[0].motion && !$game_troop.enemies[0].motion.damaging?
        $game_party.actors[0].hp = $game_party.actors[0].maxhp
        $game_party.actors[0].sp = $game_party.actors[0].maxsp
        $game_troop.enemies[0].hp = $game_troop.enemies[0].maxhp
        $game_troop.enemies[0].sp = $game_troop.enemies[0].maxsp
        $game_party.actors[0].awake_time = 1200
    #    $game_troop.enemies[0].awake_time = 1200
      end
      
    when 3  # 選單開啟階段
      update_phase3
    when 5  # 勝利階段
      update_effects
      update_phase5
      update_coordinates
      update_motions
    when 7 # 戰鬥事件階段
      update_effects
      update_phase7
      update_coordinates
      update_motions
    when 8 # 戰敗階段
      update_effects
      update_phase8
      update_coordinates
      update_motions
    end
    

    # 操作&AI更新
    if !$game_switches[STILILA::CANNOT_CTRL] and @phase != 3
      update_handling
    end
    
    if !$game_switches[STILILA::CANNOT_AI] and @phase != 3
      for battler in  $game_party.actors + $game_troop.enemies
        # 例外：　戦闘不能　　or 　操作キャラ
        next if battler.dead? or ((battler == @handle_battler) and !$game_switches[STILILA::CPU_CTRL])
        # AI操作
        battler.ai.update
      end
    end
    
    # 更新攻擊判定
    update_attack_set unless @phase == 3
    
    # 更新敵人血條可見狀態
    @window_enemystatus.visible = $game_switches[STILILA::BOSS_FLAG]
    @status_window.visible = $game_switches[STILILA::BATTLE_FLAG]
    # 更新狀態視窗
    @awaketime_window.refresh((@handle_battler.awake_time/60 + 1), 3) if @awaketime_window.visible and ![5,8].include?(@phase) 
    @window_enemystatus.update unless [5,8].include?(@phase)
    @window_enemystatus.refresh unless [5,8].include?(@phase)
    @status_window.update unless [5,8].include?(@phase)
    @status_window.refresh unless [5,8].include?(@phase)

 # 更新獸化倒數視窗可見狀態
    @awaketime_window.visible = ((@phase == 1) and !$game_switches[STILILA::FINAL_BATTLE] and @handle_battler.awaking)
    
    
    # 更新數值測試窗
  #  @test_windows[0].refresh(@handle_battler.x_pos)
#    @test_windows[0].refresh($game_troop.enemies[0].ai.dist_x)
 #   @test_windows[1].refresh($game_troop.enemies[0].ai.dist_y)
  #  @test_windows[2].refresh($game_troop.enemies[0].ai.hit_time)
  end


  
  #--------------------------------------------------------------------------
  # ● 定期檢查事件
  #--------------------------------------------------------------------------
  def update_battle_events
    

    # 敵方全滅而且還沒到最後一區
    if judge and @area < @area_max
      # 推進區域
      @area += 1
      # 讀取接下來的腳本
      @stage_script = set_stage_script(@troop_id)
      # 清空敵人數據
      $game_troop.clear
      # 再設置敵人
      $game_troop.setup(@troop_id, eval(@stage_script+"::Enemies"))

      # 再生成模組
      for enemy in  $game_troop.enemies
        enemy.battle_sprite = Sprite_Battler.new(@spriteset.viewport2, enemy)
        enemy.initialize_positioning
      end
      # 生成場內物件
      setup_battle_field_objects
      
      # 偵測公共事件
      event_id = eval(@stage_script+"::Event")
      # 有事件的情況下，執行事件
      if event_id > 0
        common_event = $data_common_events[event_id]
        $game_system.battle_interpreter.setup(common_event.list, 0)
        @phase = 7
      else
      # 沒有的情況下，回到戰鬥階段，恢復操作 
       @phase = 1
        $game_switches[STILILA::CANNOT_CTRL] = false
        $game_switches[STILILA::CANNOT_AI] = false
      end
      # BOSS戰判定消除
      $game_switches[STILILA::BOSS_FLAG] = false
      return true
    end
    return false
  end  
  
  #--------------------------------------------------------------------------
  # ● 生成場內物件
  #--------------------------------------------------------------------------
  def setup_battle_field_objects
    field_object_group = eval(@stage_script+"::Objects")
    for obj_group in field_object_group
      hidden = false
      # 攝影機
      hidden = true if obj_group[0] == 59
      obj = Game_Enemy.new(@troop_id, 999, [obj_group[1], obj_group[2]], obj_group[0], hidden, false)
      @battle_field_objects.push(obj)
       obj.initialize_positioning
      @spriteset.battle_field_object_add(obj)
    end
  end
  
  #--------------------------------------------------------------------------
  # ● 更新戰鬥特效
  #--------------------------------------------------------------------------
  def update_effects
   
    # 減少定格時間
    $game_temp.superstop_time -= 1 if $game_temp.superstop_time > 0

   # 集中線預約更新
    unless focus_plan.empty? 
       n = focus_plan.shift
       unless n.nil?
        appear_focus(n)
       end
     end 
 
    # 集中線時間
    if @focus_count > 0
     @focus_count -= 1
    else
     dispose_focus
    end  
    
    # 特寫
    if @camera_feature[0] == 0
      @camera_feature[1] = 0
      @camera_feature[2] = 0
    else
      @camera_feature[0] -= 1
    end    
  end
  
  #--------------------------------------------------------------------------
  # ● 出現集中線
  #-------------------------------------------------------------------------- 
  def appear_focus(time)
    @focus_count = time
    @focussprite = Sprite.new
    @focussprite.bitmap = RPG::Cache.picture("focus")
    @focussprite.blend_type = 1
    @focussprite.opacity = 180
    @focussprite.z = 5500

  end
  #--------------------------------------------------------------------------
  # ● 消除集中線
  #-------------------------------------------------------------------------- 
  def dispose_focus
    return if @focussprite.nil?
    @focussprite.bitmap.dispose
    @focussprite.dispose
  end
  #--------------------------------------------------------------------------
  # ● 偵測作弊鍵(測試時起動)
  #-------------------------------------------------------------------------- 
  def update_battle_test
    return unless $DEBUG  # $BTEST
    
    if Kboard.trigger?(49)  # 數字1 - 我方全恢復
      @xcam_watch_battler        = $game_party.actors[0]
      for b in  $game_party.actors
        b.hp = b.maxhp 
        b.sp = b.maxsp 
      end
    end
    if Kboard.trigger?(50)  # 數字2 - 敵方全恢復
      for e in $game_troop.enemies
        e.hp = e.maxhp 
        e.sp = e.maxsp 
      end
    end
    if Kboard.trigger?(51)  # 數字3 - 雙方全恢復
      for b in $game_party.actors + $game_troop.enemies
        b.hp = b.maxhp 
        b.sp = b.maxsp 
      end
    end
    if Kboard.trigger?(52)  # 數字4 - 雙方怒氣滿
     @handle_battler.awake_time = 1200
      $game_troop.enemies[0].awake_time = 1200
    end
    if Kboard.trigger?(48)  # 數字0 - 判定顯示
      if $crash_box
        $xcam_distance_min       = XCAM_DISTANCE_MIN_A
        $xcam_distance_max       = XCAM_DISTANCE_MAX_A
      else
        $xcam_distance_min       = XCAM_DISTANCE_MIN_B
        $xcam_distance_max       = XCAM_DISTANCE_MAX_B
      end    
      $crash_box = !$crash_box 
    end
  end
  
  #--------------------------------------------------------------------------
  # ● フレーム更新 (プレバトルフェーズ) [再定義]
  #--------------------------------------------------------------------------
  def update_phase1
    # 勝敗判定
    return if judge
    
    # 檢查戰鬥事件
    unless $game_system.battle_interpreter.running?
      unless judge
        setup_battle_event
      end
    end

    # 有戰鬥事件執行的時候，轉換成事件階段
    if $game_system.battle_interpreter.running?
      @phase = 7
    end
    
    
    # アニメーション再開
    @spriteset.start_update_animation
    # 
    #
    # フレーム更新 (バトラー操作) 
    #
  #  update_handling
    return if @phase != 1
    # 計算回合數
    @frames_per_turn += 1
     if @frames_per_turn >= FRAMES_PER_TURN
       $game_temp.battle_turn += 1
       for index in 0...$data_troops[@troop_id].pages.size
         # 獲取事件頁
         page = $data_troops[@troop_id].pages[index]
         # 這個事件頁的範圍是 [回合] 的情況下
         if page.span == 1
          # 重設執行標誌
          $game_temp.battle_event_flags[index] = false
         end
       end
      @frames_per_turn = 0
    end
  end
  
  #--------------------------------------------------------------------------
  # ●階段7 (戰鬥事件階段)
  #--------------------------------------------------------------------------
  def update_phase7
    # 勝敗判定
   return if judge
   
   unless $game_system.battle_interpreter.running?
      #檢查戰鬥事件
      unless judge
        setup_battle_event
      end
      @phase = 1
    end
    
    # 沒有戰鬥事件運行的時候
    unless $game_system.battle_interpreter.running?
      @phase = 1
    end
    
    
    # アニメーション再開
    @spriteset.start_update_animation

    if @phase != 7
      return
    end
    #
    # フレーム更新(攻撃系)
    #
  #  update_attack_set
  end


  #--------------------------------------------------------------------------
  # ● アフターバトルフェーズ開始
  #--------------------------------------------------------------------------
  alias xrxs_bs1_start_phase5 start_phase5
  def start_phase5
    # 呼び戻す
    xrxs_bs1_start_phase5
    # 
    #戰鬥結束後至勝利畫面的等待時間
    @phase5_whiteout_duration = 70
    # 禁止操作開關為on
    $game_switches[STILILA::CANNOT_CTRL] = true
    $game_switches[STILILA::CANNOT_AI] = true
    #
    if @phase5_whiteout_duration == 0
      for actor in $game_party.actors
        actor.motion.do_stand if actor.motion.directable?
      end
    end 
    # 現在のトーンを保存
    @pretone = $game_screen.tone.dup

    # ステータスウィンドウを非表示
    #
  #   @combohit_window.clear
    # 
    @phase5_voice_done = false      
  end
  
  #--------------------------------------------------------------------------
  # ● 畫面更新 (結束戰鬥回合)
  #--------------------------------------------------------------------------
  def update_phase5
    # 等待計數大於 0 的情況下
    if @phase5_wait_count > 0
      

      
      # 減少等待計數
      @phase5_wait_count -= 1
      
      
      if @phase5_wait_count == 24 
        # 色調変化
        tone = Tone.new(-40,-40,-40)
        $game_screen.start_tone_change(tone, 24)
      end
      
      # 等待計數為 0 的情況下
      if @phase5_wait_count == 10
        for actor in $game_party.actors
          if actor.level_up_flag
            actor.level_up_flag = false
            actor.animation.push([20, true, 0, 0, 1]) 
          end
        end
      end

      if @phase5_wait_count == 0
        # 顯示結果視窗
     #   @result_window.visible = true
        # 清除主回合標誌
        $game_temp.battle_main_phase = false
        # 更新狀態視窗
        @status_window.refresh
        # 成就解除：小心翼翼
        $game_config.get_achievement(1) if $game_system.result_nodamage
        
        # 設定評價情報等待時間
        @phase5_result_count = 170
        # 設定評價情報
        create_result
        
      end
      return
    end
    
    # 顯示評價情報中
    if @phase5_result_count > 0
      @phase5_result_count -= 1
      case @phase5_result_count
      when 150
        @result_windows[0].visible = true
      when 120
        @result_windows[1].visible = true
        @result_windows[2].visible = true
      when 90
        @result_windows[3].visible = true
        @result_windows[4].visible = true
      when 60
        @result_windows[5].visible = true
        @result_windows[6].visible = true
        # 成就解除：還沒還沒完呢
         $game_config.get_achievement(2) if $game_system.result_maxchain >= 20 
      when 30
        for i in 7..13
         @result_windows[i].visible = true
        end
      end

      return
    end
    
    
    # 一切結束後，等待C鍵
    if Input.trigger?(Input::C)
      $game_screen.start_tone_change(@pretone, 0)
      # 戰鬥結束
      battle_end(0)
    end
  end
  
  #--------------------------------------------------------------------------
  # ● 建立評價情報
  #--------------------------------------------------------------------------
  def create_result
    #@result_windows = []
    # 文字
    @result_windows[0] = Sprite.new
    @result_windows[0].bitmap = RPG::Cache.picture("stage_clear")
    @result_windows[0].x = 320 - @result_windows[0].bitmap.width / 2 
    @result_windows[0].y = 40
        
    
    # 最大打數
    @result_windows[1] = Sprite.new
    @result_windows[1].bitmap = RPG::Cache.picture("battle_result2")
    @result_windows[1].x = 220 - @result_windows[1].bitmap.width / 2 
    @result_windows[1].y = 160
    
    fig = $game_system.result_maxhits.to_s.size - 1
    @result_windows[2] = Window_ShowNumber.new(480 - 15*fig, @result_windows[1].y - 25)
    @result_windows[2].refresh($game_system.result_maxhits, "n")
    
    # 最大傷害
    @result_windows[3] = Sprite.new
    @result_windows[3].bitmap = RPG::Cache.picture("battle_result3")
    @result_windows[3].x = 220 - @result_windows[3].bitmap.width / 2 
    @result_windows[3].y = 200
    fig = $game_system.result_maxdamage.to_s.size - 1
    @result_windows[4] = Window_ShowNumber.new(480 - 15*fig, @result_windows[3].y - 25)
    @result_windows[4].refresh($game_system.result_maxdamage, "n")
    


    # 最大取消(連段)
    @result_windows[5] = Sprite.new
    @result_windows[5].bitmap = RPG::Cache.picture("battle_result7")
    @result_windows[5].x = 220 - @result_windows[5].bitmap.width / 2 
    @result_windows[5].y = 240
    fig = $game_system.result_maxchain.to_s.size - 1
    @result_windows[6] = Window_ShowNumber.new(480 - 15*fig, @result_windows[5].y - 25)
    @result_windows[6].refresh($game_system.result_maxchain, "n")
    
    
    # 通過時間
    @result_windows[7] = Sprite.new
    @result_windows[7].bitmap = RPG::Cache.picture("battle_result1")
    @result_windows[7].x = 220 - @result_windows[7].bitmap.width / 2 
    @result_windows[7].y = 280
    
    # 計算通關時間
    clear_hour = $game_system.result_cleartime / 216000
    clear_minute = ($game_system.result_cleartime - (216000 * clear_hour)) / 3600
    clear_second = ($game_system.result_cleartime - (216000 * clear_hour) - (3600 * clear_minute)) / 60
    
    
    # 顯示小時
    @result_windows[8] = Sprite.new
    @result_windows[8].bitmap = RPG::Cache.picture("battle_result4")
    @result_windows[8].x = 460 - @result_windows[8].bitmap.width / 2 
    @result_windows[8].y = @result_windows[7].y   
    fig = clear_hour.to_s.size - 1
    @result_windows[9] = Window_ShowNumber.new(@result_windows[8].x - 34 - 20*fig, @result_windows[8].y - 28)
    @result_windows[9].refresh(clear_hour, "n")

    # 顯示分鐘
    @result_windows[10] = Sprite.new
    @result_windows[10].bitmap = RPG::Cache.picture("battle_result5")
    @result_windows[10].x = 530 - @result_windows[10].bitmap.width / 2 
    @result_windows[10].y = @result_windows[7].y
    fig = clear_minute.to_s.size - 1
    @result_windows[11] = Window_ShowNumber.new(@result_windows[10].x - 34 - 20*fig, @result_windows[10].y - 28)
    @result_windows[11].refresh(clear_minute, "n")

    # 顯示秒
    @result_windows[12] = Sprite.new
    @result_windows[12].bitmap = RPG::Cache.picture("battle_result6")
    @result_windows[12].x = 600 - @result_windows[12].bitmap.width / 2 
    @result_windows[12].y = @result_windows[7].y
    fig = clear_second.to_s.size - 1
    @result_windows[13] = Window_ShowNumber.new(@result_windows[12].x - 34 - 20*fig, @result_windows[12].y - 28)
    @result_windows[13].refresh(clear_second, "n")
    
    for w in @result_windows
      w.z = 9999
      w.visible = false
    end
    
    
  end
  
  
  
  #--------------------------------------------------------------------------
  # ● フレーム更新 (勝利畫面)
  #--------------------------------------------------------------------------
  alias xrxs_bs1_update_phase5 update_phase5
  def update_phase5
    
    # 勝負特效，並且恢復fps
    if Graphics.frame_rate < $fps_set
    #  if Graphics.frame_rate < 35 
        if  Graphics.frame_rate == 29
         appear_focus(1)
        end
        if  Graphics.frame_rate == 13
         appear_focus(1)
        end
        if  Graphics.frame_rate == 11
         appear_focus(0)
        end
        for j in 0...1
          Graphics.update
        end
 #     end
      Graphics.frame_rate += 1
    end
    
    
    
    # ホワイトアウト
    if @phase5_whiteout_duration >= 0
      @phase5_whiteout_duration -= 1
      # 如果我方人物尚未停止動作
      for a in $game_party.actors
        if  a.motion.state != "stand" and a.exist?
          if ["walk", "guard","crouch"].include?(a.motion.state)
            a.motion.change_anime("stand")
          end
          if a.motion.state == "dash"
            a.motion.change_anime("dash_break")
          end
        end 
      end
      if @phase5_whiteout_duration == 0
       # 如果有人尚未躺平，增加準備時間
        for e in $game_troop.enemies
          if  !e.motion.downing? or e.now_x_speed > 1  or  e.now_y_speed > 1
            @phase5_whiteout_duration = 15
            return
          end 
        end
        
         # 如果連擊視窗還在，增加準備時間
        if @combohit_window.visible
          @phase5_whiteout_duration = 15
            return
        end
 
        # 如果場上還有特效
        if @spriteset.effect?
          @phase5_whiteout_duration = 15
          return
        end
        
        
        actor_list = []
        for actor in $game_party.actors
          a.motion.change_anime("stand") if a.motion.directable?
          actor_list.push(actor)
        end
        
     
        @final_battler = actor_list[rand(actor_list.size)]
=begin        
        for i in 0...actor_list.size
          actor = actor_list[i]
          case i
          when 0
            actor.x_pos = -90#-128
            actor.y_pos = 0
            actor.z_pos = 0#16
            actor.direction = -1
          when 1
            actor.x_pos = -170#-32
            actor.y_pos = 0
            actor.z_pos = 0
            actor.direction = -1
          when 2
            actor.x_pos = -10#-224
            actor.y_pos = 0
            actor.z_pos = 0
            actor.direction =  1
          else
            actor.x_pos = -50 
            actor.y_pos = 0
            actor.z_pos = 0
            actor.direction = 1
          end
        end
=end
        dispose_focus
        
        if update_battle_events
          return
        end
        
        # トランジション準備
     #   Graphics.freeze
        # カメラ
    #    $xcam_x = - 32
      #  $xcam_y =   62
    #    $xcam_z =  185#166 #
      #  @xcam_x_destination = @final_battler.x_pos
      #  @xcam_y_destination =  @final_battler.y_pos
      #  @xcam_z_destination = 185#166 (值越小鏡頭越近)
     #   @xcam_watch_battler = nil
        # 狀態視窗設為不可視
        @status_window.visible = false
        @combohit_window.visible = false
        # 色調を復旧
  #      $game_screen.start_tone_change(@pretone, 0)
        # 消除全員模組
        for actor in $game_party.actors
          actor.now_sp = actor.sp = actor.maxsp
          actor.motion.clear if actor.motion.directable?
        end
        # 清除場上所有飛道
        for bullet in @battle_bullets.dup
          bullet = nil
        end
        @battle_bullets.clear
        @spriteset.battle_bullet_allremove
        
        # 清除場上所有場內物件
        for field_object in @battle_field_objects.dup
          field_object = nil
        end
        @battle_field_objects.clear
        @spriteset.battle_field_object_allremove
        
        # 將敵人圖像設為不可視
       #  for sprite in @spriteset.enemy_sprites
       #   sprite.visible = false
     #   end
        
        # 清除場上所有小道具
        for item in @battle_items
          item.destroy
        end
        
      elsif @phase5_whiteout_duration == -1
        # トランジション実行
        # トランジション処理中フラグをセット
#        $game_temp.transition_processing = true
     #   $game_temp.transition_name = BATTLE_END_TRANSITION
      end
      return
    end
    #
    # 戦闘処理セリフ
    #

    
    unless @phase5_voice_done
      # 戦闘処理ポーズ
        for actor in $game_party.actors
          if actor == @final_battler
            @final_battler.motion.do_won_cry
          else
             actor.motion.do_won_pose
          end
        end
      @phase5_voice_done = true
    end
    # 呼び戻す
    xrxs_bs1_update_phase5
  end
  
  
  #--------------------------------------------------------------------------
  # ● 戰敗階段開始
  #--------------------------------------------------------------------------
  def start_phase8
    # 禁止操作開關為on
    $game_switches[STILILA::CANNOT_CTRL] = true
    $game_switches[STILILA::CANNOT_AI] = true
    # フェーズ 8 に移行
    @phase = 8
 ##################################################   
    # 戰鬥結束的ME存在的情況下，終止 BGM
   if $game_system.battle_end_me.name != ""
      $game_system.bgm_play(nil)
   end
  #################################################  
    # ウェイトカウントを設定
    @phase8_wait_count = 80
  end
  #--------------------------------------------------------------------------
  # ● 戰敗階段更新 
  #--------------------------------------------------------------------------
  def update_phase8
    
    # 勝負特效，並且恢復fps
    if Graphics.frame_rate < $fps_set  #40
   #   if Graphics.frame_rate < 35 
        for j in 0...1
          Graphics.update
        end
   #   end
      Graphics.frame_rate += 1
    end
    
    # ホワイトアウト
    if @phase8_wait_count >= 0
      @phase8_wait_count -= 1
      
      # 如果敵方人物上未停止動作
      for e in $game_troop.enemies
        if  e.motion.state != "stand" and e.exist?
          if ["walk", "guard","crouch"].include?(e.motion.state)
            e.motion.change_anime("stand")
          end
          if e.motion.state == "dash"
            e.motion.change_anime("dash_break")
          end
        end 
      end
      
      
      if @phase8_wait_count == 0

        # 如果有人尚未躺平，增加準備時間
        for a in $game_party.actors
          if  !a.motion.downing? or  a.now_x_speed > 1  or  a.now_y_speed > 1
            @phase8_wait_count = 15
            return
          end 
        end
        
        # 如果連擊視窗還在，增加準備時間
        if @combohit_window.visible
          @phase8_wait_count = 15
            return
        end
        
        # 如果場上還有特效
        if @spriteset.effect?
          @phase8_wait_count = 15
          return
        end
        dispose_focus
        @status_window.visible = false
        @window_enemystatus.visible = false
        # 全員模組消除
        for enemy in $game_troop.enemies
          enemy.motion.change_anime("stand") if  enemy.motion.directable?
          enemy.motion.clear if enemy.motion.directable?
        end
        # 清除場上所有飛道
        for bullet in @battle_bullets.dup
          bullet = nil
        end
        @battle_bullets.clear
        @spriteset.battle_bullet_allremove
        
        # 清除場上所有小道具
        for item in @battle_items
          item.destroy
        end
        
        # 清除場上所有場內物件
        for field_object in @battle_field_objects.dup
          field_object = nil
        end
        @battle_field_objects.clear
        @spriteset.battle_field_object_allremove
        
      elsif @phase8_wait_count == -1
          # 允許失敗的情況下
         if $game_temp.battle_can_lose
           # 血量加1
            for actor in $game_party.actors
              actor.hp += 1
              actor.damage_pop = false
              actor.motion.clear
              actor.combohit_clear
              actor.now_sp = actor.sp = actor.maxsp
            end
            # 還原為戰鬥開始前的 BGM
            $game_system.bgm_play($game_temp.map_bgm)
            # 戰鬥結束
             battle_end(2)
          else
            # 挑戰模式關卡情況
            if $game_temp.battle_troop_id >= 39
              # 淡出音樂
              $game_system.bgm_fade(5)
              # 回到標題畫面
              $scene = Scene_Title.new
              @ex_failed = true
            else
              # 以外的情況，進入Game Over
              $game_temp.gameover = true
            end
         end
      end
      return
    end
  end
  #--------------------------------------------------------------------------
  # ○ 加入小道具
  #--------------------------------------------------------------------------
  def items_add(item)
    @battle_items.push(item)
    @spriteset.battle_item_add(item)
  end
  #--------------------------------------------------------------------------
  # ○ 移除小道具
  #--------------------------------------------------------------------------
  def items_minus(item)
    @spriteset.battle_item_minus(item)
    @battle_items.delete(item)
  end
  
  
  #--------------------------------------------------------------------------
  # ○ 展示結束
  #--------------------------------------------------------------------------
  def demoplay_end
    

    
      # 消除全員模組
      for actor in $game_party.actors
        actor.now_sp = actor.sp = actor.maxsp
        actor.motion.clear if actor.motion.directable?
      end
    
      # 全員模組消除
      for enemy in $game_troop.enemies
        enemy.motion.change_anime("stand") if  enemy.motion.directable?
        enemy.motion.clear if enemy.motion.directable?
      end
      # 清除場上所有飛道
      for bullet in @battle_bullets.dup
        bullet = nil
      end
      @battle_bullets.clear
      @spriteset.battle_bullet_allremove
        
      # 清除場上所有小道具
      for item in @battle_items
        item.destroy
      end
        
      # 清除場上所有場內物件
      for field_object in @battle_field_objects.dup
        field_object = nil
      end
      @battle_field_objects.clear
      @spriteset.battle_field_object_allremove
        
    # 清除戰鬥中標誌
    $game_temp.in_battle = false
    # 清除全體同伴的行動
    $game_party.clear_actions
    # 解除戰鬥用狀態
    for actor in $game_party.actors
      actor.remove_states_battle
    end
    # 清除敵人
    # $game_troop.enemies.clear
    # 呼叫戰鬥返回呼叫
    if $game_temp.battle_proc != nil
      $game_temp.battle_proc.call(0)
      $game_temp.battle_proc = nil
    end
    
    $scene = Scene_Title.new
    
  end
  #--------------------------------------------------------------------------
  # ○ 模組的定期處理
  #--------------------------------------------------------------------------
  def update_motions
    # 清除飛行道具Flag (沒有作用)
    # bullets_changed = false
    # 處理各戰鬥者
    for battler in $game_party.actors + $game_troop.enemies + @battle_bullets.dup + @battle_field_objects
      next if battler.nil?
      # 更新戰鬥者模組
      battler.motion.update
      # 產生飛行道具
   #   bull = battler.motion.battle_bullet
     # if bb.is_a?(Game_BattleBullet)
      # 設定飛道使用者    
  #    if bull != nil
    #      bb = Game_BattleBullet.new(bull[0],bull[1],bull[2],bull[3],bull[4],bull[5],bull[6])
        # 登録
     #   @battle_bullets.push(bb)
      #  @spriteset.battle_bullet_add(bb)
  #    end
      # 飛行道具結束判定
      if  battler.is_a?(Game_BattleBullet) and battler.done
        # 登録解除
        @spriteset.battle_bullet_minus(battler)
        @battle_bullets.delete(battler)
      end
    end
    
    # 更新小道具
    for item in @battle_items
      item.update
    end
    
  end

  #--------------------------------------------------------------------------
  # ○ 生成飛道
  #      bull：飛道的資料，供飛道初始化用
  #--------------------------------------------------------------------------
  def create_battle_bullets(bull)
    # 做出飛道物件
    bb = Game_BattleBullet.new(bull[0],bull[1],bull[2],bull[3],bull[4],bull[5],bull[6],bull[7])
    # 登録到Scene_Battle(處理資料)與Spriteset_Battle(處理圖像)
    @battle_bullets.push(bb)
    @spriteset.battle_bullet_add(bb)
    return bb
  end
=begin  
  #--------------------------------------------------------------------------
  # ○ 逆向判定(按鍵方向與操作對象方向不同)
  #--------------------------------------------------------------------------
  def direction_reverse?
   return (@handle_battler.direction == 1 and Kboard.press?($game_config.battle_key["LEFT"])) || 
  (@handle_battler.direction == -1 and Kboard.press?($game_config.battle_key["RIGHT"]))
  end
=end
  
   #-------------------------------------------------------------------------------
   # ●  劇情用更換角色 (ID：要變換的角色ID)
   #-------------------------------------------------------------------------------
   def change_chara_for_scenario(id, state, frame, anime_id = 0)
     
     if $gold_finger && id <= 3
      id +=  5
     end
     
     return if id == @handle_battler.id
     # 紀錄角色資訊
     x = @handle_battler.x_pos
     y = @handle_battler.y_pos
     xs = @handle_battler.now_x_speed
     ys = @handle_battler.now_y_speed
     awake_time = @handle_battler.awake_time
  #   state = @handle_battler.motion.state
  #    frame = @handle_battler.motion.frame_number
     dir = @handle_battler.direction
     # 更換角色
     $game_party.add_actor(id)
     $game_party.remove_actor(@handle_battler.id)
     
     # 設定攝影機跟隨 / 操縱的角色
     @xcam_watch_battler = @handle_battler = $game_party.actors[0]
     # 重設位置
     @handle_battler.x_pos = x
     @handle_battler.y_pos = y
     @handle_battler.direction = dir
     @handle_battler.now_x_speed = xs
     @handle_battler.now_y_speed = ys
     # 模組、數值初始化
     @handle_battler.motion_setup($game_party.actors[0].id)
     @handle_battler.setup_actor_reflexes($game_party.actors[0].id)
      # 初始戰鬥圖
    #  @handle_battler.transgraphic_basic_form
      # 身體判定
     @handle_battler.body_rect = @handle_battler.stand_body_rect
     # 播放換人動畫
     @handle_battler.animation.push([anime_id, true, 0, 0]) if anime_id != 0
     # 轉移獸化值
     @handle_battler.awake_time = awake_time
     # 恢復先前的動作
     @handle_battler.motion.change_anime(state, frame)

   end  
   
  #--------------------------------------------------------------------------
  # ○ 獸化後續處理
  #--------------------------------------------------------------------------
  def actor_awake(x, y, xs, ys, dir, id, awake_time)
     $game_screen.start_shake(8,16,20,1)
     # 設定攝影機跟隨 / 操縱的角色
     @xcam_watch_battler = @handle_battler = $game_party.actors[0]
     # 重設位置
     @handle_battler.x_pos = x
     @handle_battler.y_pos = y
     @handle_battler.direction = dir
     @handle_battler.now_x_speed = xs
     @handle_battler.now_y_speed = ys
     # 模組、數值初始化
     @handle_battler.motion_setup($game_party.actors[0].id)
     @handle_battler.setup_actor_reflexes($game_party.actors[0].id)
      # 初始戰鬥圖
    #  @handle_battler.transgraphic_basic_form
      # 身體判定
     @handle_battler.body_rect = @handle_battler.stand_body_rect
     # 播放換人動畫
  #   @handle_battler.animation.push([19, true, 0, 0])
     # 無敵時間
     @handle_battler.motion.eva_invincible_duration = 1
     # 繼續動作
     @handle_battler.motion.change_anime("awake", 0)
     # 記憶是誰變的
     @handle_battler.before_awake_id = id
     # 設定獸化持續時間
     @handle_battler.awake_time = awake_time  #  1200 (60x20秒 )
     @awaketime_window.visible = true if !$game_switches[STILILA::FINAL_BATTLE]
     @handle_battler.awaking = true
  end
  
   
  #--------------------------------------------------------------------------
  # ○ 操縱的定期處理
  #--------------------------------------------------------------------------
  def update_handling
    
    return if $game_switches[STILILA::CPU_CTRL]
    

    @trigger_key_left -= 1  if @trigger_key_left > 0
    @trigger_key_right -= 1 if @trigger_key_right > 0
    @trigger_key_up   -= 1 if @trigger_key_up > 0
    @trigger_key_down -= 1  if @trigger_key_down > 0
    @handle_battler.awake_time = [@handle_battler.awake_time - 1, 0].max if @handle_battler.awaking and !$game_switches[STILILA::FINAL_BATTLE]
  #  @trigger_airdash_left_d -= 1
    #@trigger_airdash_right_d -= 1
    
    # 全自動判定
    return if @handle_battler.nil?
    # 生存判定
    return if @handle_battler.dead?
    
   # 解除獸化 
   if @handle_battler.awake_time == 0 and @handle_battler.motion.freemove? and (@handle_battler.id == 3 or @handle_battler.id == 8)
     x = @handle_battler.x_pos
     y = @handle_battler.y_pos
     xs = @handle_battler.now_x_speed
     ys = @handle_battler.now_y_speed
     state = @handle_battler.motion.state
     frame = @handle_battler.motion.frame_number
     dir = @handle_battler.direction
     
     # 調用換人的motion方法
     @handle_battler.motion.change_chara
     
     $game_party.add_actor(@handle_battler.before_awake_id)
     if @handle_battler.id == 8
      $game_party.remove_actor(8) 
     else
       $game_party.remove_actor(3) 
     end
     awake_time = @handle_battler.awake_time
     # 設定攝影機跟隨 / 操縱的角色
     @xcam_watch_battler = @handle_battler = $game_party.actors[0]
     # 重設位置
     @handle_battler.x_pos = x
     @handle_battler.y_pos = y
     @handle_battler.direction = dir
     @handle_battler.now_x_speed = xs
     @handle_battler.now_y_speed = ys
     # 模組、數值初始化
     @handle_battler.motion_setup($game_party.actors[0].id)
     @handle_battler.setup_actor_reflexes($game_party.actors[0].id)
      # 初始戰鬥圖
    #  @handle_battler.transgraphic_basic_form
      # 身體判定
     @handle_battler.body_rect = @handle_battler.stand_body_rect
     # 播放換人動畫
     @handle_battler.animation.push([19, true, 0, 0])
     # 恢復先前的動作
     @handle_battler.motion.change_anime(state, 0)
     @handle_battler.awake_time = awake_time
     @awaketime_window.visible = false
     @handle_battler.awaking = false
   end
    
    # 判定/實行預約指令 
    if @handle_battler.motion.command_plan != "" and !@handle_battler.motion.cannot_cancel_act?
      case @handle_battler.motion.command_plan
      when "6z"
        @handle_battler.motion.fz_action
      when "2z"
        @handle_battler.motion.dz_action
      when "8z"
        @handle_battler.motion.uz_action
      when "4z"
        @handle_battler.motion.bz_action
      when "6x"
        @handle_battler.motion.fx_action
      when "2x"
        @handle_battler.motion.dx_action
      when "8x"
        @handle_battler.motion.ux_action
      when "4x"
        @handle_battler.motion.bx_action
      when "6s"
        @handle_battler.motion.fs_action
      when "2s"
        @handle_battler.motion.ds_action
      when "8s"
        @handle_battler.motion.us_action
      when "4s"
        @handle_battler.motion.bs_action
      when "6c"
        @handle_battler.motion.fc_action
      when "4c"
        @handle_battler.motion.bc_action
      when "66"
        @handle_battler.motion.do_66
      when "44"
        @handle_battler.motion.do_44
      when "88"
        @handle_battler.motion.do_88
      when "22"
        @handle_battler.motion.do_22
      else
        
        # 執行其他預約指令
        @handle_battler.motion.do_other_plancommand
        
        
      #  if @handle_battler.motion.command_plan.include?("z")
       #   @handle_battler.motion.z_action
      #  elsif @handle_battler.motion.command_plan.include?("x")
      #    @handle_battler.motion.x_action
      #  elsif @handle_battler.motion.command_plan.include?("s") 
     #     @handle_battler.motion.s_action
      #  end
      end
      @handle_battler.motion.command_plan = "" #清除預約指令
      return
    end

     
   #-------------------------------------------------------------------------------
   # ●  按鍵偵測(一次性)
   #-------------------------------------------------------------------------------
   # 紀錄按鍵判斷
   pad_id = 0 # 只有1p
   press_4 = Kboard.press?($game_config.battle_key["LEFT"]) || Joyall.press_dir?(4, pad_id)
   trigger_4 = Kboard.trigger?($game_config.battle_key["LEFT"]) || Joyall.trigger_dir?(4, pad_id)
   press_6 = Kboard.press?($game_config.battle_key["RIGHT"]) || Joyall.press_dir?(6, pad_id)
   trigger_6 = Kboard.trigger?($game_config.battle_key["RIGHT"]) || Joyall.trigger_dir?(6, pad_id)
   
   press_8 = Kboard.press?($game_config.battle_key["UP"]) || Joyall.press_dir?(8, pad_id)
   trigger_8 = Kboard.trigger?($game_config.battle_key["UP"]) || Joyall.trigger_dir?(8, pad_id)
   press_7 = Joyall.press_dir?(7, pad_id)
   trigger_7 = Joyall.trigger_dir?(7, pad_id)
   press_9 = Joyall.press_dir?(9, pad_id)
   trigger_9 = Joyall.trigger_dir?(9, pad_id)
   
   press_2 = Kboard.press?($game_config.battle_key["DOWN"]) || Joyall.press_dir?(2, pad_id)
   trigger_2 = Kboard.trigger?($game_config.battle_key["DOWN"]) || Joyall.trigger_dir?(2, pad_id)
   press_1 = Joyall.press_dir?(1, pad_id)
   trigger_1 = Joyall.trigger_dir?(1, pad_id)
   press_3 = Joyall.press_dir?(3, pad_id)
   trigger_3 = Joyall.trigger_dir?(3, pad_id)
   
   
   trigger_change = Kboard.trigger?($game_config.battle_key["CHANGE"]) || Joyall.trigger?($game_config.battle_pad["CHANGE"], pad_id)
   trigger_change2 = Kboard.trigger?($game_config.battle_key["CHANGE2"]) || Joyall.trigger?($game_config.battle_pad["CHANGE2"], pad_id)
   trigger_change3 = Kboard.trigger?($game_config.battle_key["CHANGE3"]) || Joyall.trigger?($game_config.battle_pad["CHANGE3"], pad_id)
   
   trigger_z = Kboard.trigger?($game_config.battle_key["Z"]) || Joyall.trigger?($game_config.battle_pad["Z"], pad_id)
   press_z = Kboard.press?($game_config.battle_key["Z"]) || Joyall.press?($game_config.battle_pad["Z"], pad_id)
   trigger_x = Kboard.trigger?($game_config.battle_key["X"]) || Joyall.trigger?($game_config.battle_pad["X"], pad_id)
   press_x = Kboard.press?($game_config.battle_key["X"]) || Joyall.press?($game_config.battle_pad["X"], pad_id)
   trigger_c = Kboard.trigger?($game_config.battle_key["C"]) || Joyall.trigger?($game_config.battle_pad["C"], pad_id)
   press_c = Kboard.press?($game_config.battle_key["C"]) || Joyall.press?($game_config.battle_pad["C"], pad_id)
   
   button_used = press_4 || press_6 || press_8 || press_2 || press_1 || press_3 || press_7 || press_9 ||
                          trigger_change || trigger_change2 || trigger_change3 || 
                           trigger_z || trigger_x || press_c

   
   # 切換至 Red
   if trigger_change and 
     @handle_battler.motion.freemove? and (@handle_battler.id != 4) and !$game_switches[STILILA::NO_CHANGE] and @handle_battler.id != 1 and @handle_battler.id != 6
     x = @handle_battler.x_pos
     y = @handle_battler.y_pos
     xs = @handle_battler.now_x_speed
     ys = @handle_battler.now_y_speed
     state = @handle_battler.motion.state
     frame = @handle_battler.motion.frame_number
     dir = @handle_battler.direction
     awake_time = @handle_battler.awake_time
     # 無敵時間
     @handle_battler.motion.eva_invincible_duration = 1
     # 調用換人的motion方法
     @handle_battler.motion.change_chara
     
     case @handle_battler.id
     when 2
       $game_party.add_actor(1)
       $game_party.remove_actor(2)
     when 3
       $game_party.add_actor(1)
       $game_party.remove_actor(3)
     when 7
       $game_party.add_actor(6)
       $game_party.remove_actor(7)
     when 8
       $game_party.add_actor(6)
       $game_party.remove_actor(8)
     else
     end      
     # 設定攝影機跟隨 / 操縱的角色
     @xcam_watch_battler = @handle_battler = $game_party.actors[0]
     # 重設位置
     @handle_battler.x_pos = x
     @handle_battler.y_pos = y
     @handle_battler.direction = dir
     @handle_battler.now_x_speed = xs
     @handle_battler.now_y_speed = ys
     # 模組、數值初始化
     @handle_battler.motion_setup($game_party.actors[0].id)
     @handle_battler.setup_actor_reflexes($game_party.actors[0].id)
      # 初始戰鬥圖
    #  @handle_battler.transgraphic_basic_form
      # 身體判定
     @handle_battler.body_rect = @handle_battler.stand_body_rect
     # 播放換人動畫
     @handle_battler.animation.push([19, true, 0, 0])
     # 恢復先前的動作
     @handle_battler.motion.change_anime(state, 0)
     # 轉移獸化值
     @handle_battler.awake_time = awake_time
   end
   
   # 切換至 槍
   if trigger_change2 and 
     @handle_battler.motion.freemove? and (@handle_battler.id != 4) and !$game_switches[STILILA::NO_CHANGE] and @handle_battler.id != 2 and @handle_battler.id != 7
     x = @handle_battler.x_pos
     y = @handle_battler.y_pos
     xs = @handle_battler.now_x_speed
     ys = @handle_battler.now_y_speed
     state = @handle_battler.motion.state
     frame = @handle_battler.motion.frame_number
     dir = @handle_battler.direction
     awake_time = @handle_battler.awake_time
     # 無敵時間
     @handle_battler.motion.eva_invincible_duration = 1
     # 調用換人的motion方法
     @handle_battler.motion.change_chara
     case @handle_battler.id
     when 1
       $game_party.add_actor(2)
       $game_party.remove_actor(1)
     when 3
       $game_party.add_actor(2)
       $game_party.remove_actor(3)
     when 6
       $game_party.add_actor(7)
       $game_party.remove_actor(6)
     when 8 
       $game_party.add_actor(7)
       $game_party.remove_actor(8)
     else
     end      
     # 設定攝影機跟隨 / 操縱的角色
     @xcam_watch_battler = @handle_battler = $game_party.actors[0]
     # 重設位置
     @handle_battler.x_pos = x
     @handle_battler.y_pos = y
     @handle_battler.direction = dir
     @handle_battler.now_x_speed = xs
     @handle_battler.now_y_speed = ys
     # 模組、數值初始化
     @handle_battler.motion_setup($game_party.actors[0].id)
     @handle_battler.setup_actor_reflexes($game_party.actors[0].id)
      # 初始戰鬥圖
    #  @handle_battler.transgraphic_basic_form
      # 身體判定
     @handle_battler.body_rect = @handle_battler.stand_body_rect
     # 播放換人動畫
     @handle_battler.animation.push([19, true, 0, 0])
     # 恢復先前的動作
     @handle_battler.motion.change_anime(state, 0)
     # 轉移獸化值
     @handle_battler.awake_time = awake_time
   end
   
   
   
   # 獸化 
   if trigger_change3 and 
     @handle_battler.motion.freemove? and [1,2,6,7].include?(@handle_battler.id) and 
     $game_switches[STILILA::CAN_AWAKE]
     if (@handle_battler.id == 3 or @handle_battler.id == 8)
      #  change_chara_for_scenario(@handle_battler.before_awake_id, @handle_battler.motion.state, 0, 19)
     # # @handle_battler.motion.awake_break (原本就沒使用)
     #  @awaketime_window.visible = false
     else
       
       if @handle_battler.awake_time >= 1200 or $game_switches[STILILA::FINAL_BATTLE]
         # 無敵時間
         @handle_battler.motion.eva_invincible_duration = 1
         @handle_battler.motion.change_anime("awake", 0)
       end
    end
   end
   
   
    # 左上(搖桿用)
    if trigger_7 && @handle_battler.motion.hold_key_up == 0
      @trigger_key_right = 0
      @trigger_key_down = 0
      if @trigger_key_up > 0 
        @handle_battler.motion.do_88
        @trigger_key_up = 0
      else
        @handle_battler.motion.up_action(-1)
        @trigger_key_up = DOUBLE_TRIGGER_DURATION
      end
    end
    
    # 右上(搖桿用)
    if trigger_9 && @handle_battler.motion.hold_key_up == 0
      @trigger_key_left = 0
      @trigger_key_down = 0
      if @trigger_key_up > 0 
        @handle_battler.motion.do_88
        @trigger_key_up = 0
      else
        @handle_battler.motion.up_action(1)
        @trigger_key_up = DOUBLE_TRIGGER_DURATION
      end
    end
   
    # 上
    if trigger_8 && @handle_battler.motion.hold_key_up == 0
      @trigger_key_left = 0
      @trigger_key_right = 0
      @trigger_key_down = 0
      dir = 0
      dir = 1 if press_6
      dir = -1 if press_4
      if @trigger_key_up > 0 
        @handle_battler.motion.do_88
        @trigger_key_up = 0
      else
        @handle_battler.motion.up_action(dir)
        @trigger_key_up = DOUBLE_TRIGGER_DURATION
      end
    end
    

    
    # 下
    if trigger_2
      @trigger_key_left = 0
      @trigger_key_right = 0
      @trigger_key_up = 0
      if @trigger_key_down > 0
        @handle_battler.motion.do_22
        @trigger_key_down = 0
      else
        @handle_battler.motion.down_action
        @trigger_key_down = DOUBLE_TRIGGER_DURATION
      end
    end
    # 右
    if trigger_6
      @trigger_key_left = 0
      @trigger_key_down = 0
      @trigger_key_up = 0
      if @trigger_key_right > 0
        (@handle_battler.direction == 1) ? @handle_battler.motion.do_66 : @handle_battler.motion.do_44
        @trigger_key_right = 0
      else
        @handle_battler.motion.front_action
        @trigger_key_right = DOUBLE_TRIGGER_DURATION
      end
    end
    # 左
    if trigger_4
      @trigger_key_right = 0
      @trigger_key_down = 0
      @trigger_key_up = 0
      if @trigger_key_left > 0
        (@handle_battler.direction == 1) ? @handle_battler.motion.do_44 : @handle_battler.motion.do_66
        @trigger_key_left = 0
      else
        @handle_battler.motion.back_action
        @trigger_key_left = DOUBLE_TRIGGER_DURATION
      end
    end
    # 普攻
    if trigger_z and !press_c
      if (@handle_battler.direction == 1 and (press_6 || press_9)) or 
            (@handle_battler.direction == -1 and (press_4 || press_7))
          # 「6Z」
          @handle_battler.motion.fz_action
      elsif press_8
          # 「8Z」
          @handle_battler.motion.uz_action
      elsif press_2
          # 「2Z」
          @handle_battler.motion.dz_action
      elsif (@handle_battler.direction == -1 and (press_6 || press_3)) or 
              (@handle_battler.direction == 1 and (press_4 || press_1))
            # 「4Z」
           @handle_battler.motion.bz_action
      else
          # 「Z」
          @handle_battler.motion.z_action
      end
    end
    # 必殺
    if trigger_x and !press_c
      if (@handle_battler.direction == 1 and (press_6 || press_9)) or 
          (@handle_battler.direction == -1 and (press_4 || press_7))
        # 「6X」
        @handle_battler.motion.fx_action
      elsif press_8
        # 「8X」
        @handle_battler.motion.ux_action
      elsif press_2
        # 「2X」
        @handle_battler.motion.dx_action
      elsif (@handle_battler.direction == -1 and (press_6 || press_3)) or 
            (@handle_battler.direction == 1 and (press_4 || press_1))
          # 「4X」
        @handle_battler.motion.bx_action
      else
        # 「X」
        @handle_battler.motion.x_action
      end
    end
=begin
    # 超必殺
    if Kboard.trigger?($game_config.battle_key["S"]) and !Kboard.press?($game_config.battle_key["C"]) 
      if (@handle_battler.direction == 1 and Kboard.press?($game_config.battle_key["RIGHT"])) or 
            (@handle_battler.direction == -1 and Kboard.press?($game_config.battle_key["LEFT"]))
        # 「前必殺」
        @handle_battler.motion.fs_action
      elsif Kboard.press?($game_config.battle_key["UP"])
        # 「上必殺」
        @handle_battler.motion.us_action
      elsif Kboard.press?($game_config.battle_key["DOWN"])
        # 「下必殺」
        @handle_battler.motion.ds_action
      elsif (@handle_battler.direction == -1 and Kboard.press?($game_config.battle_key["RIGHT"])) or 
            (@handle_battler.direction == 1 and Kboard.press?($game_config.battle_key["LEFT"]))
        # 「後必殺」
        @handle_battler.motion.bs_action
      else
        # 「必殺」
        @handle_battler.motion.s_action
      end
    end
=end    
    
    # 防禦
    if trigger_c
      @handle_battler.motion.c_action
    end
    
    #-------------------------------------------------------------------------------
    # ●   按鍵偵測(持續)
    #-------------------------------------------------------------------------------

    # 防禦
    if press_c
      @handle_battler.motion.hold_key_c += 1
      if (@handle_battler.direction == 1 and (press_6 || press_3 || press_9)) or 
            (@handle_battler.direction == -1 and (press_4 || press_1 || press_7))
        # 「6C」
        @handle_battler.motion.fc_action
     elsif press_8
        # 「8C」
        @handle_battler.motion.uc_action
        # 「2C」
      elsif press_2
        @handle_battler.motion.dc_action
        # 「4C」
      elsif (@handle_battler.direction ==-1 and (press_6 || press_3 || press_9)) or 
            (@handle_battler.direction == 1 and (press_4 || press_1 || press_7))
        @handle_battler.motion.bc_action
  #    else
    #    @handle_battler.motion.hold_c
      end
      @handle_battler.motion.hold_c
    else
#     @handle_battler.motion.cancel_hold_c
      @handle_battler.motion.hold_key_c = 0
    end
    
    
    # 上
    if press_8 || press_7 || press_9
      dir = 0
      dir = 1 if press_6 || press_9
      dir = -1 if press_4 || press_7
      @handle_battler.motion.hold_key_up += 1
      @handle_battler.motion.hold_up(dir)
    else
      @handle_battler.motion.hold_key_up = 0
    end
    # 下
    if press_2 || press_1 || press_3
      @handle_battler.motion.hold_key_down += 1
      @handle_battler.motion.hold_down
    else
      @handle_battler.motion.hold_key_down = 0
    end
    # 右
    if press_6
      @handle_battler.motion.hold_key_right += 1
      @handle_battler.motion.hold_right
    else
      @handle_battler.motion.hold_key_right = 0
    end
    # 左
    if press_4
      @handle_battler.motion.hold_key_left += 1
      @handle_battler.motion.hold_left
    else
      @handle_battler.motion.hold_key_left = 0
    end
    # 普攻
    if press_z
      @handle_battler.motion.hold_key_z += 1
      @handle_battler.motion.hold_z
    else
      @handle_battler.motion.hold_key_z = 0
    end
    # 必殺
    if press_x
      @handle_battler.motion.hold_key_x += 1
      @handle_battler.motion.hold_x
    else
      @handle_battler.motion.hold_key_x = 0
    end
=begin
    # 超必殺
    if Kboard.press?($game_config.battle_key["S"])
      @handle_battler.motion.hold_key_s += 1
      @handle_battler.motion.hold_s
    else
      @handle_battler.motion.hold_key_s = 0
    end
=end    
    

    

    # 沒按鍵的情形
=begin
    if !Kboard.press?($game_config.battle_key["UP"]) and
        !Kboard.press?($game_config.battle_key["DOWN"]) and
        !Kboard.press?($game_config.battle_key["RIGHT"]) and 
        !Kboard.press?($game_config.battle_key["LEFT"]) and 
        !Kboard.press?($game_config.battle_key["Z"]) and 
        !Kboard.press?($game_config.battle_key["X"]) and
#        !Kboard.press?($game_config.battle_key["S"]) and
        !Kboard.press?($game_config.battle_key["C"]) and
        !Kboard.press?($game_config.battle_key["CHANGE"]) and
        !Kboard.press?($game_config.battle_key["CHANGE2"])
=end
    if !button_used
      @handle_battler.motion.no_press_action
    end

    
    return
    
    
    
    
=begin
    
    #
    # 「受身」
    #
    if (@handle_battler.motion.blowning? &&  @handle_battler.motion.knock_back_duration <= 0) and 
      (Kboard.trigger?($game_system.battle_key["UP"]) or Kboard.trigger?($game_system.battle_key["C"]))
      #@handle_battler.motion.ukemi_duration = 18 
      @handle_battler.motion.do_ukemi
    end
=end
    
  end # def end

  #--------------------------------------------------------------------------
  # ○ 更新座標
  #--------------------------------------------------------------------------
  def update_coordinates
    # カメラ用数値・初期化(高い値から徐々に下げる)
    battlers_x_min =  512
    battlers_x_max = -512
    battlers_y_min = 1024
    battlers_y_max = -512

    # 更新戰鬥者位置
    for battler in $game_party.actors + $game_troop.enemies + @battle_bullets #+ @battle_field_objects
      if (battler.is_a?(Game_Actor) or battler.is_a?(Game_Enemy)) and battler != nil and battler.motion != nil 
        battler.motion.voice_cold -= 1   if battler.motion.voice_cold > 0 
      end
      next if battler.nil?
      next if battler.motion.nil?
      next if battler.motion.catched
     # next if @battle_field_objects.include?(battler)
            
      if battler.is_a?(Game_BattleBullet)
        # 飛行道具的身體判定
        battler_rect    = Rect.new(0,-9999,1,1)
        battler_rect.x  += battler.x_pos
        battler_rect.y -= battler.y_pos
      else
        # 計算戰鬥者身體判定
        
      #  p battler.body_rect if battler.is_a?(Game_Enemy)
        battler_rect    = battler.stand_body_rect.dup
        # 逆向(面左)時
        if battler.direction == -1
          battler_rect.x = -1 * battler_rect.x - battler_rect.width
        end
        battler_rect.x += battler.x_pos
        battler_rect.y -= battler.y_pos
      end
   
      # 不被定住的情況
      unless battler.motion.static? or battler.motion.hit_stop_duration > 0 #or battler.is_a?(Game_BattleBullet)
      #
      # --- X --- #  and battler.motion.unfrictbreak_duration <= 0
        unless ["parallel_f_blow", "parallel_b_blow"].include?(battler.motion.state)
        # 如果戰鬥者在地上  
          if !battler.motion.on_air? 
            if battler.motion.physical
               if battler.now_x_speed > 0
                 battler.now_x_speed = [battler.now_x_speed - battler.frict_x_break, 0].max
               elsif battler.now_x_speed < 0
                battler.now_x_speed = [battler.now_x_speed + battler.frict_x_break, 0].min
              end
            end
            if battler.hit_slide > 0
              battler.now_x_speed = battler.hit_slide * -battler.direction
              battler.hit_slide = 0
            end
       # 在空中
       elsif battler.motion.on_air?  and battler.motion.controllable? and !["f_jump", "b_jump", "hf_jump", "hb_jump","f_jump_fall", "b_jump_fall", "hf_jump_fall", "hb_jump_fall"].include?(battler.motion.state)
         if battler.motion.physical
           if battler.now_x_speed > 0
             battler.now_x_speed = [battler.now_x_speed - battler.air_x_resistance, 0].max
           elsif battler.now_x_speed < 0
             battler.now_x_speed = [battler.now_x_speed + battler.air_x_resistance, 0].min
           end
         end
       end
     end  
     
   #  if battler.hit_slide != 0
     #    battler.hit_slide = battler.hit_slide.abs
  #       battler.hit_slide = [battler.hit_slide - battler.frict_x_break, 0].max
  #       battler.hit_slide *= battler.direction
 #    end
     
       # 計算移動量 : 相対 X 目的位置 + 現在移動速度
       variation =  (battler.relative_x_destination + battler.now_x_speed).round
      # variation =  battler.relative_x_destination + battler.now_x_speed.round - battler.hit_slide

   #   next if battler.is_a?(Game_Enemy) and (STILILA::NO_MOVE_ENEMY).include?(battler.id)

      
      now_xpos1 = battler.x_pos
      
        # 計算 X 軸的可能移動範圍
       side = $game_temp.battle_field_w  # 取得場地寬
     #  x_max = side - ((battler.direction*side > 0) ? battler.edge_spacing : 0) # 取得往右的最大移動距離
     #  x_min =  -1 * (side - ((battler.direction*side < 0) ? battler.edge_spacing : 0)) # 取得往左的最大移動距離
       x_max = side - battler.edge_spacing # 取得往右的最大移動距離
       x_min =  0 + battler.edge_spacing # 取得往左的最大移動距離
      
       # 地板判定
       for block in @field_blocks.dup
         
        # 角色在兩X軸內
        if rects_over_y?(battler_rect, block) 
          
          
       #   block_now_x = battler.x_pos - block.x
       #   block_now_height = block.get_slope_height(block_now_x)
          
          
          # 算出中心點
          block_ox = block.x + block.width/2
          block_oy = -block.y - block.height/2
          block_left = block.x
          block_right = block.x + block.width
          block_bot = -block.y - block.height
          block_top = -block.y

          # 角色在障礙物左邊
          if battler.x_pos + battler_rect.width/2 <= block_left and (x_max > block_left - battler_rect.width/2)
       
            
            x_max = block_left - battler_rect.width/2 - 1 #- ((battler.direction*block_left > 0) ? battler.edge_spacing : 0)   
          elsif battler.x_pos - battler_rect.width/2 >= block_right and  (x_min < block_right + battler_rect.width/2)
            x_min = block_right + battler_rect.width/2 + 1# - ((battler.direction*block_right < 0) ? battler.edge_spacing : 0)
          else
            
    #        p battler.y_pos, battler.y_pos - battler.body_rect.height
            
            if rects_over_x?(battler_rect, block)  #!(battler.y_pos - battler.body_rect.height < block_bot) and rects_over_x?(battler_rect, block) 
              # 掉進障礙物裡面的情況，角色偏左
              if battler.x_pos + battler_rect.width/2 <= block_ox 
                battler.x_pos = block_left - battler_rect.width/2 - 2
               # 掉進障礙物裡面的情況，角色偏右
              elsif battler.x_pos - battler_rect.width/2 >= block_ox 
                battler.x_pos = block_right + battler_rect.width/2 + 2
              end
            end
          end # if battler.x_pos <= block_left
          # 保留可移動距離
          battler.x_max = x_max - battler.edge_spacing
          battler.x_min = x_min + battler.edge_spacing
        end # if rects_over_x?(battler_rect, block)  #角色在兩X軸內
      end # for block in @field_blocks.dup
      
      
       # 保留可移動距離(如果沒上面的判定)
       battler.x_max = x_max - battler.edge_spacing
       battler.x_min = x_min + battler.edge_spacing
       
       
      final_block_target = nil 
      push_max = 0
      field_x_max = x_max
      field_x_min = x_min

      
   #   @test_windows[0].refresh(x_max) if battler == $game_party.actors[0]
=begin   
      # =============  敵我方阻擋判定
      for target in $game_troop.enemies + @battle_field_objects + $game_party.actors
     #   next if x_max == nil
      #  next if x_min == nil
        # 自分は除外
        next if target == battler
        next if battler.class == target.class
        
      #  next if target.motion.can_push?
        
     #   next if battler.is_a?(Game_Enemy)
        next if battler.motion.penetrate
        next if target.motion.penetrate
        # 戦闘不能なターゲットは除外
        next if target.dead?
    #    next if battler.motion.downing?
   #     next if target.motion.downing?

        # Z座標の差が8以上あるときは除外
        #next if (battler.z_pos - target.z_pos).abs >= 8
        # 被抓中除外
        next if battler.motion.catched 
        next if target.motion.catched 
        # 無敵中除外
     #   next if battler.motion.eva_invincible_duration > 0
   #     next if target.motion.eva_invincible_duration > 0 
        next if battler.is_a?(Game_Enemy) and (STILILA::NO_MOVE_ENEMY).include?(battler.id)
        next if !battler.exist? or !target.exist?
        # 重疊判定
        target_rect     = target.stand_body_rect.dup
        target_rect.x  += target.x_pos
        target_rect.y  -= target.y_pos
        
      #  if rects_over?(battler_rect, target_rect)
        if rects_over_y?(battler_rect, target_rect)
          target_x_max = (target.x_pos - target_rect.width/2 - battler.stand_body_rect.width/2 - 1)
          target_x_min = (target.x_pos + target_rect.width/2 + battler.stand_body_rect.width/2 + 1)
          
          # 障礙物敵人
          if target.is_a?(Game_Enemy) and (STILILA::NO_MOVE_ENEMY).include?(target.id)
            # 目標在右
            if battler.x_pos < target.x_pos
              x_max = target_x_max if x_max > target_x_max
              battler.x_max = x_max - battler.edge_spacing
            else
              x_min = target_x_min if x_min < target_x_min
              battler.x_min = x_min + battler.edge_spacing
            end
          # 可以推的情況就推
          elsif target.motion.can_push? and target.x_pos < field_x_max and target.x_pos > field_x_min
          # 不能推的情況(對像已經到邊界了、移動中不能推)  
          else
            # 推擠放寬
            if $game_switches[STILILA::BATTLER_PUSHED_LIGHTEN]
              if rects_over?(battler_rect, target_rect)  # 追加重疊才判定
              # 邊界
                if target.x_pos > field_x_max
                  target.x_pos = field_x_max
                  battler.x_pos = target.x_pos - battler_rect.width/2 - target_rect.width/2
                  push_max = battler_rect.width/2 + target_rect.width/2
                  puseed = true
                elsif target.x_pos < field_x_min
                  target.x_pos = field_x_min
                  battler.x_pos = target.x_pos + battler_rect.width/2 + target_rect.width/2
                  push_max = battler_rect.width/2 + target_rect.width/2
                  puseed = true
                end
              end 
            else
              # 邊界
              if target.x_pos > field_x_max
                target.x_pos = field_x_max
                battler.x_pos = target.x_pos - battler_rect.width/2 - target_rect.width/2
                push_max = battler_rect.width/2 + target_rect.width/2
                puseed = true
              elsif target.x_pos < field_x_min
                target.x_pos = field_x_min
                battler.x_pos = target.x_pos + battler_rect.width/2 + target_rect.width/2
                push_max = battler_rect.width/2 + target_rect.width/2
                puseed = true
              end
            end # if $game_switches[STILILA::BATTLER_PUSHED_LIGHTEN]
            
            # 沒被目標推回來的情況(目標還沒到邊界)
            unless puseed
              # 目標在右
              if battler.x_pos < target.x_pos
                x_max = target_x_max if x_max > target_x_max
                battler.x_max = x_max - battler.edge_spacing
              else
                x_min = target_x_min if x_min < target_x_min
                battler.x_min = x_min + battler.edge_spacing
              end
            end
          end
          
        end # if rects_over_y?(battler_rect.dup, target_rect.dup)
        
      end
=end
       # =============  敵我方阻擋判定結束

      # =============  敵我方阻擋判定 ver. 2 
      for target in $game_party.actors + $game_troop.enemies + @battle_field_objects
     #   next if x_max == nil
      #  next if x_min == nil
        # 自分は除外
        next if target == battler
        next if battler.class == target.class
    #    next if target.motion.downing? or battler.motion.downing?
        next if battler.motion.penetrate
        next if target.motion.penetrate
        # 戦闘不能なターゲットは除外
      #  next if target.dead?
     #   next if battler.motion.downing?
      #  next if target.motion.downing?

        # Z座標の差が8以上あるときは除外
        #next if (battler.z_pos - target.z_pos).abs >= 8
        # 被抓中除外
        next if battler.motion.catched 
        next if target.motion.catched 
        # 無敵中除外
     #   next if battler.motion.eva_invincible_duration > 0
   #     next if target.motion.eva_invincible_duration > 0 
        next if battler.is_a?(Game_Enemy) and (STILILA::NO_MOVE_ENEMY).include?(battler.id)
        next if !battler.motion.push_flag
        next if !battler.exist? or !target.exist?
        # 重疊判定
        target_rect     = target.stand_body_rect.dup
        target_rect.x  += target.x_pos
        target_rect.y  -= target.y_pos

        # 障礙物敵人
        if target.is_a?(Game_Enemy) and (STILILA::NO_MOVE_ENEMY).include?(target.id) or !target.motion.push_flag
          if rects_over_y?(battler_rect, target_rect)
            target_x_max = (target.x_pos - target_rect.width/2 - battler.stand_body_rect.width/2 - 1)
            target_x_min = (target.x_pos + target_rect.width/2 + battler.stand_body_rect.width/2 + 1)
            # 目標在右
            if battler.x_pos < target.x_pos
              x_max = target_x_max if x_max > target_x_max
              battler.x_max = x_max - battler.edge_spacing
            else
              x_min = target_x_min if x_min < target_x_min
              battler.x_min = x_min + battler.edge_spacing
            end
          end
          
        # 貼在板邊  
        elsif target.x_pos > x_max or target.x_pos < x_min

          if rects_over_y?(battler_rect, target_rect)
            target_x_max = (target.x_pos - target_rect.width/2 - battler.stand_body_rect.width/2 - 1)
            target_x_min = (target.x_pos + target_rect.width/2 + battler.stand_body_rect.width/2 + 1)
            # 目標在右
            if battler.x_pos < target.x_pos
              x_max = target_x_max if x_max > target_x_max
              battler.x_max = x_max - battler.edge_spacing
            else
              x_min = target_x_min if x_min < target_x_min
              battler.x_min = x_min + battler.edge_spacing
            end
          end
          
        else

          if rects_over?(battler_rect, target_rect)
            #  滑開
            if battler.x_pos > target.x_pos  # 戰鬥者在目標右邊 
              unless target.x_pos == battler.x_min + 1# 

                target.x_pos = [target.x_pos - battler.now_x_speed.abs/2, battler.x_min + 1].max 
                target.motion.catching_target.x_pos = [target.motion.catching_target.x_pos - battler.now_x_speed.abs/2, battler.x_min + 1].max if target.motion.catching_target != nil
                battler.x_pos = [battler.x_pos + battler.now_x_speed.abs/2, battler.x_max - 1].min
                battler.motion.catching_target.x_pos = [battler.motion.catching_target.x_pos + battler.now_x_speed.abs/2, battler.x_max - 1].min if battler.motion.catching_target != nil 
              else
              #  battler.x_pos += battler.now_x_speed.abs * 2
                battler.x_pos = battler.x_min + 1 + battler.stand_body_rect.width/2 + target_rect.width/2
                battler.motion.catching_target.x_pos += battler.now_x_speed.abs  if battler.motion.catching_target != nil 
              end
            elsif battler.x_pos < target.x_pos  # 戰鬥者在目標左邊
              unless target.x_pos == battler.x_max 
                target.x_pos = [target.x_pos + battler.now_x_speed.abs/2, battler.x_max - 1].min 
                target.motion.catching_target.x_pos = [target.motion.catching_target.x_pos + battler.now_x_speed.abs/2, battler.x_max - 1].min if target.motion.catching_target != nil
                battler.x_pos = [battler.x_pos - battler.now_x_speed.abs, battler.x_min + 1].max 
                battler.motion.catching_target.x_pos = [battler.motion.catching_target.x_pos - battler.now_x_speed.abs/2, battler.x_min + 1].max if battler.motion.catching_target != nil
              else
                battler.x_pos -= battler.now_x_speed.abs * 2
                battler.motion.catching_target.x_pos -= battler.now_x_speed.abs if battler.motion.catching_target != nil
              end
            else # 戰鬥者與目標重疊
              if target.x_pos <= battler.x_min + 10    
                battler.x_pos += battler.now_x_speed.abs #
                battler.motion.catching_target.x_pos += battler.now_x_speed.abs/2 if battler.motion.catching_target != nil 
              elsif target.x_pos >= battler.x_max - 10    
                battler.x_pos -= battler.now_x_speed.abs
                battler.motion.catching_target.x_pos -= battler.now_x_speed.abs/2 if battler.motion.catching_target != nil
              else
           #     p
              end
            end

          end # if rects_over?(battler_rect.dup, target_rect.dup)
        end #   if target.is_a?(Game_Enemy) and (STILILA::NO_MOVE_ENEMY).include?(target.id)
        
        
#        @test_windows[1].refresh(x_max) if battler == $game_party.actors[0]
    #    @test_windows[2].refresh(battler.x_max) if battler == $game_party.actors[0]
        
        
      end # for target in $game_party.actors + $game_troop.enemies + @battle_field_objects
    # =============  敵我方阻擋判定 ver. 2  結束
       
    
     # 確定移動
      if battler.is_a?(Game_BattleBullet)
        battler.x_pos += variation
      else
        battler.x_pos = [[battler.x_pos+variation, x_min + push_max+1].max, x_max - push_max-1].min
      end


  
  
      # 飛行道具不受牆壁阻擋
      if !battler.is_a?(Game_BattleBullet) 
        if battler.x_pos < x_min
          battler.x_pos = x_min 
        elsif battler.x_pos >= x_max  
          battler.x_pos = x_max 
        end
      end #unless battler.is_a?(Game_BattleBullet)

      now_xpos2 = battler.x_pos
      
      # 抓住的對象位移
      if battler.motion.catching_target != nil
        battler.motion.catching_target.x_pos += (now_xpos2 - now_xpos1)
      end
      
      #
      # --- Y ---
      #
      # 計算 Y 軸的可能移動範圍
      # 這裡的Y是數值越大越高
      y_max = $game_temp.battle_field_h + 256#+ (METEOR_SMASH_ENABLE ? 256 : 0)
      y_min = $game_temp.battle_field_b
      
  #    min = battler.y_min
      
      # 地板判定
      for block in @field_blocks.dup
        # 角色在兩 Y 軸內
      #  if rects_over_x?(battler_rect.dup, block)  
        if point_in_rect_x?(battler.x_pos, block)  
          
          block_now_x = battler.x_pos - block.x
          block_now_height = block.get_slope_height(block_now_x)
         # p block_now_height if battler.is_a?(Game_Actor)
          battler.y_min_slope_plus = block_now_height
          # 算出中心點、頂和底
          block_ox = block.x + block.width/2
          block_oy = -block.y - block.height/2
          block_bot = -block.y - block.height
          block_top = -block.y
          
          in_slope = true if block_now_height != 0
          
          
          # 角色在頂部上方
          if battler.y_pos >= block_top and block_top >= y_min 
              y_min = block_top - block_now_height
          elsif battler.y_pos - battler_rect.height < block_bot and block_bot < y_max
            # 斜坡→一般平台錯位補救  
            if ((battler.y_pos - battler_rect.height) - block_bot).abs <= 5
              slopebug = true
              y_min = block_top - block_now_height
            else 
              y_max = block_bot
            end    
              if rects_over_y?(battler_rect, block) 
                battler.now_y_speed = 0
              end
          else    
           if point_in_rect_y?(battler.y_pos, block) 
              if battler.y_pos + battler_rect.height < block_bot
                y_max = block_bot
              else
                # 頭進去障礙物裡
                if battler.y_pos < block_bot
                  battler.y_pos = block_bot - battler_rect.height
                  battler.now_y_speed = 0
                  y_max = block_bot
                else
                 y_min = block_bot
               end
             end
           end
          end
          
         # y = -(block.y + block.height)
        #  if battler.y_pos < y and y < max
        #    max = y
        #  end
        end #  if rects_over_x?(battler_rect.dup, block) # 進入範圍
    
      end #  for block in @field_blocks
      
      # 跳台判定
      if battler.motion.boardthrough_duration <= 0
        for board in @field_boards
          # 判定
          if rects_over_x?(battler_rect, board)
            if battler.y_pos >= -board.y and -board.y > y_min
               y_min = -board.y
            end
          end
        end
      end
      y_max -= battler_rect.height
      # 出現不能踩到地面的情況
      if battler.y_pos != y_min  and battler.motion.physical#  and !slopebug and (battler.y_pos - y_min).abs > 10
        # 落下時已跳躍次數設為1
        if battler.motion.now_jumps == 0 #and !in_slope
          battler.motion.now_jumps = 1
        end
        # 擊中硬直中
        next if battler.motion.hit_stop_duration > 0
        next if battler.is_a?(Game_Enemy) and (STILILA::NO_MOVE_ENEMY).include?(battler.id)
        next if !battler.motion.push_flag
        # 落下Y加速度による更新
        if battler.now_y_speed >= -battler.air_y_maximum
          # 落下Y
          battler.now_y_speed = [battler.now_y_speed - battler.air_y_velocity, -battler.air_y_maximum].max
          battler.now_y_speed = 0 if battler.motion.y_fixed
        end
      end # if battler.y_pos != min
      
      
      
      # 増減値の算出 : 相対 Y 目的位置 + 現在移動
      variation = battler.relative_y_destination + battler.now_y_speed.round   #.floor
      now_ypos1 = battler.y_pos
      
      
      
      # Yを加算して範囲指定
      battler.y_pos = [[battler.y_pos + variation, y_min].max, y_max].min
      now_ypos2 = battler.y_pos
      
      
      
      
      # 保存下限
      battler.y_min = y_min
      
      
      # 抓住的對象位移
      if battler.motion.catching_target != nil
        battler.motion.catching_target.y_pos +=  (now_ypos2 - now_ypos1)
        battler.motion.catching_target.y_min = y_min
      end
      
      
      # 落下速度リセット
     # if battler.y_pos == min
    #     battler.now_y_speed = 0
    #  end
      # 落下によるジャンプ値 1 化
    #  if battler.motion.now_jumps == 0 and battler.y_pos != y_min
      #  battler.motion.now_jumps = 1
   #   end
      
      # 飛び道具はここまで
     # next if battler.is_a?(Game_BattleBullet)

      # 限界地点
      if battler.y_pos == y_min and battler.motion.now_jumps > 0 and !battler.motion.y_fixed
        if battler.motion.blowning?  or  battler.motion.down_type != "N" 
           # 倒地
            battler.motion.do_down
        else
          # 着地隙モーションへ移行
          battler.motion.do_landing_step
        end
      # 撞到天花板    
      elsif battler.y_pos == y_max and battler.now_y_speed > battler.now_x_speed.abs and y_max == $game_temp.battle_field_h + 256
     #  if battler.motion.blowning
           # シェイクを開始
            do_crashing_shake(1) 
            battler.motion.do_collision_blow  ####
            battler.now_y_speed *= -1/2
            battler.hp -= battler.maxhp /  6 ##
            battler.damage = 0
            battler.damage_pop = true
            battler.motion.knock_back_duration += 35
            battler.combohit_count
           @combohit_window.refresh(battler.combohit, battler.motion.knock_back_duration, battler)
            
          # 定格特效  
          @all_stop_time = 5
     #   else
          # 頭ぶつけ
     #     battler.now_y_speed = 0
     #   end
       end

      
      end #unless  battler.motion.static?
      
      
      
      # 保存(ボード着地に使用)
    #  battler.previous_x_pos = battler.x_pos
   #   battler.previous_y_pos = battler.y_pos
      
      
      
      # 戦闘終了/逃走ダッシュではここまで
      next if @phase == 5 or @phase == 6
        
      # メテオスマッシュ判定
      if METEOR_SMASH_ENABLE and battler.y_pos <= $game_temp.battle_field_b
        # メテオスマッシュによるダメージ
        battler.hp -= battler.maxhp / 8
        # メテオ
        battler.motion.do_meteor
      end
      
      # 偵測事件區域
      if battler.is_a?(Game_Actor) and @phase != 7
        for ev_board in @field_events
          # 判定
          if rects_over?(battler_rect, ev_board)
            if ev_board.common_event_id == 0
              p "事件用碰撞塊公共事件ID不能為0"
            end
            
            
            common_event = $data_common_events[ev_board.common_event_id]
            $game_system.battle_interpreter.setup(common_event.list, 0)
            @phase = 7
          end
        end
      end
      
      #
      # --- 滑開 ( X座標 )---
      #
=begin
      # 戦闘不能なターゲットは除外
      next if battler.dead? or battler.is_a?(Game_BattleBullet)
      # 攻撃側の範囲を設定
      battler_rect    = battler.stand_body_rect.dup
      battler_rect.x += battler.x_pos
      battler_rect.y -= battler.y_pos
      for target in $game_party.actors + $game_troop.enemies + @battle_field_objects
     #   next if x_max == nil
      #  next if x_min == nil
        # 自分は除外
        next if target == battler
        next if battler.class == target.class
        next if battler.motion.penetrate
        next if target.motion.penetrate
        # 戦闘不能なターゲットは除外
        next if target.dead?
        next if battler.motion.downing?
        next if target.motion.downing?

        # Z座標の差が8以上あるときは除外
        #next if (battler.z_pos - target.z_pos).abs >= 8
        # 被抓中除外
        next if battler.motion.catched 
        next if target.motion.catched 
        # 無敵中除外
     #   next if battler.motion.eva_invincible_duration > 0
   #     next if target.motion.eva_invincible_duration > 0 
        next if battler.is_a?(Game_Enemy) and (STILILA::NO_MOVE_ENEMY).include?(battler.id)
        next if !battler.exist? or !target.exist?
        # 重疊判定
        target_rect     = target.stand_body_rect.dup
        target_rect.x  += target.x_pos
        target_rect.y  -= target.y_pos
      #  if rects_over?(battler_rect, target_rect)
        if rects_over?(battler_rect, target_rect)
            #  滑開
            if battler.x_pos > target.x_pos  # 戰鬥者在目標右邊
              unless target.x_pos == battler.x_min #-$game_temp.battle_field_w
                if target.is_a?(Game_Enemy) and (STILILA::NO_MOVE_ENEMY).include?(target.id)
                  battler.x_pos -= battler.now_x_speed if battler.x_pos < battler.x_max - 8 #$game_temp.battle_field_w - 4
                  battler.motion.catching_target.x_pos += 4 if battler.motion.catching_target != nil 
                else
                   target.x_pos -= 4 if target.x_pos > battler.x_min + 4 #$game_temp.battle_field_w + 4
                   target.motion.catching_target.x_pos -= 4 if target.motion.catching_target != nil
                 end
                battler.x_pos += 4 if battler.x_pos < battler.x_max - 4 #$game_temp.battle_field_w - 4
                battler.motion.catching_target.x_pos += 4 if battler.motion.catching_target != nil 
              else
                battler.x_pos += 8 #if battler.x_pos < $game_temp.battle_field_w - 4
                battler.motion.catching_target.x_pos += 8 if battler.motion.catching_target != nil 
              end
            elsif battler.x_pos < target.x_pos  # 戰鬥者在目標左邊
              unless target.x_pos == battler.x_max #$game_temp.battle_field_w
                if target.is_a?(Game_Enemy) and (STILILA::NO_MOVE_ENEMY).include?(target.id)
                  battler.x_pos -= battler.now_x_speed if battler.x_pos > battler.x_min + 8 #-$game_temp.battle_field_w + 4
                  battler.motion.catching_target.x_pos -= 4 if battler.motion.catching_target != nil
                else  
                  target.x_pos += 4 if target.x_pos < battler.x_max - 4  #$game_temp.battle_field_w - 4
                  target.motion.catching_target.x_pos += 4 if target.motion.catching_target != nil
                 end
                battler.x_pos -= 4 if battler.x_pos > battler.x_min + 4 #-$game_temp.battle_field_w + 4
                battler.motion.catching_target.x_pos -= 4 if battler.motion.catching_target != nil
              else
                battler.x_pos -= 8# if battler.x_pos > -$game_temp.battle_field_w + 4
                battler.motion.catching_target.x_pos -= 8 if battler.motion.catching_target != nil
              end
            else # 戰鬥者與目標重疊
              if target.x_pos <= battler.x_min + 10     #-$game_temp.battle_field_w + 10
                battler.x_pos += 8 #if battler.x_pos < $game_temp.battle_field_w - 4
                battler.motion.catching_target.x_pos += 8 if battler.motion.catching_target != nil 
              else target.x_pos >= battler.x_max - 10    # $game_temp.battle_field_w - 10
                battler.x_pos -= 8# if battler.x_pos > -$game_temp.battle_field_w + 4
                battler.motion.catching_target.x_pos -= 8 if battler.motion.catching_target != nil
              end
            end
            
            battler_rect    = battler.stand_body_rect.dup
            battler_rect.x += battler.x_pos
            battler_rect.y -= battler.y_pos
            target_rect     = target.stand_body_rect.dup
            target_rect.x  += target.x_pos
            target_rect.y  -= target.y_pos
            
          end # if rects_over?(battler_rect.dup, target_rect.dup)
        end
=end        
        
        
      # 吃到道具
      for item in @battle_items
        item_rect = item.body_rect.dup
        item_rect.x += item.x_pos
        item_rect.y -= item.y_pos   
        if rects_over?(battler_rect, item_rect) and battler.is_a?(Game_Actor)
          item.eaten(battler)
        end
      end
        
    end # for battler in $game_party.actors + $game_troop.enemies + @battle_bullets
    
    # 小道具的判定
   for item in @battle_items
      item_rect = item.body_rect.dup
      item_rect.x += item.x_pos
      item_rect.y -= item.y_pos   

      y_max = $game_temp.battle_field_h + 256
      y_min = $game_temp.battle_field_b
      # 地板判定
      for block in @field_blocks.dup
        # 角色在兩 Y 軸內 
        if point_in_rect_x?(item.x_pos, block) 
          # 算出中心點、頂和底
          block_ox = block.x + block.width/2
          block_oy = -block.y - block.height/2
          block_bot = -block.y - block.height
          block_top = -block.y
          
          # 角色在頂部上方
          if item.y_pos >= block_top and block_top >= y_min 
              y_min = block_top 
          elsif item.y_pos - item_rect.height < block_bot and block_bot < y_max
              y_max = block_bot
          else    
           if point_in_rect_y?(item.y_pos, block) 
              if item.y_pos + item_rect.height < block_bot
                y_max = block_bot
              else
                # 頭進去障礙物裡
                if item.y_pos < block_bot
                  item.y_pos = block_bot - battler_rect.height
                  y_max = block_bot
                else
                 y_min = block_bot
               end
             end
           end
          end
        end #  if rects_over_x?(battler_rect.dup, block) # 進入範圍
    
      end #  for block in @field_blocks
      if item.y_pos > item.y_min
        item.y_pos -= 5
      end
      item.y_pos = y_min if item.y_pos < y_min
    end
  
  
    # 戦闘終了/逃走ダッシュではここまで
    return if @phase == 5 or @phase == 8
    #
    # --- 鏡頭捲動 ---
    #
  #  @xcam_x_destination = (battlers_x_max + battlers_x_min)/2
  #  @xcam_y_destination = (battlers_y_max/2 + battlers_y_min)/2
    #max_distance = [(battlers_x_min - battlers_x_max).abs,(battlers_y_min - battlers_y_max).abs].max
 #   @xcam_z_destination =  [[(max_distance * 185.0 / 480).floor, XCAM_DISTANCE_MIN].max, XCAM_DISTANCE_MAX].min
    @xcam_z_destination =  $xcam_distance_max if @wait_count_xcam <= 0

    
  end
  #--------------------------------------------------------------------------
  # ○ フレーム更新 (攻撃系更新) 
  #--------------------------------------------------------------------------
  def update_attack_set

    temp_array = $game_party.actors + $game_troop.enemies + @battle_bullets + @battle_field_objects
    all_attacker = []
    loop do 
      random = rand(temp_array)
      all_attacker.push(random)
      temp_array.delete(random)
      break if temp_array.empty?
    end

   
     # all_attacker = $game_party.actors + $game_troop.enemies + @battle_bullets + @battle_field_objects
    
     @target_battlers = []
    # 攻撃判定
  #  for attacker in $game_party.actors + $game_troop.enemies + @battle_bullets
    for attacker in all_attacker
      next if attacker.nil?
      next if attacker.motion.attack_rect.empty?
      #
      # -攻撃側の範囲を設定-
      #
      attacker_rect   = attacker.motion.attack_rect.dup
      #
      # 「攻撃範囲と対象」
      #
      # 取得攻擊者是我方還是敵方
      if attacker.is_a?(Game_Actor) or 
        (attacker.is_a?(Game_BattleBullet) and attacker.root.is_a?(Game_Actor))
        is_actor = true
      else
        is_actor = false
      end
      
      #
      #
      #
      # 獲取目標的範圍
      scope = attacker.motion.get_skill_scope
     
      targets = []
      case scope
      when 1 # 敵単体
        if is_actor
          targets = $game_troop.enemies
        else
          targets = $game_party.actors
        end
      when 2 # 敵全体
        if is_actor
          targets = $game_party.actors
        else
          targets = $game_troop.enemies
        end
      when 3 # 使用者以外全體
        @target_battlers = $game_party.actors + $game_troop.enemies + @battle_bullets
         if attacker.is_a?(Game_BattleBullet)
          @target_battlers.delete_at(attacker.root)
         else
          @target_battlers.delete_at(attacker)
         end
       end
       
       
      # 計算每個目標是否與攻擊判定重疊 
      for target in targets 
        ##################### 計算目標身體判定 ######################### 
        target_rect    = target.body_rect.dup
        # 逆向(面左)時
        if target.direction == -1
          target_rect.x = -1 * target_rect.x - target_rect.width
        end
        target_rect.x += target.x_pos
        target_rect.y -= target.y_pos
        ############################################################### 
        # 計算每個攻擊判定
        for at_rect in attacker_rect
          
          at_rect_part = at_rect.dup
          
          # 目標沙包值到達極限的話除外
          next if target.motion.now_full_count >= target.motion.full_limit
          # 目標在隱藏中除外
          next if target.hidden
          # 目標死亡除外
          next if target.dead?
          # blow lv為0的打不到擊飛狀態的目標
  #        next if (action_attack_effect.blow_lv == 0) and ((231..250) === target.motion.frame_number)
          # 目標已經命中的話除外

          next if attacker.motion.attack_hit_targets.include?(target)
          next if @target_battlers.include?(target)
          # 目標為完全迴避狀態除外
          next if target.motion.eva_invincible_duration > 0
          # 只有抓人的人才能攻擊被抓的對象
          if attacker.is_a?(Game_BattleBullet)
            next if (target.motion.catched and attacker.root.motion.catching_target != target)
          else  
            next if (target.motion.catched and attacker.motion.catching_target != target)
          end
          # 畫出攻擊判定
          if attacker.direction == -1
            at_rect_part.x = -1 * at_rect_part.x - at_rect_part.width
          end
          at_rect_part.x += attacker.x_pos
          at_rect_part.y -= attacker.y_pos# - attacker.body_rect.height #+ attacker_rect.y
          #
          # 攻擊命中!!(攻擊判定與身體判定重疊)
          #
          if rects_over?(at_rect_part, target_rect)
          #  target.animation.push([Game_Motion::LAND_ANIMATION_ID + rand(3), true,0,0]) if target.motion.now_jumps == 0
            # 套用攻擊結果
          #   make_skill_action_result(attacker, target)
           
            skill = attacker.motion.skill_effect(attacker.motion.state, target)
            
            # 計算火花位置
           # target.motion.spark_rect = make_spark_position(attacker, at_rect_part,target, target_rect)
          

            # 對象存入已攻擊數組
            @target_battlers.push([attacker, target, skill])
            attacker.motion.attack_hit_targets.push(target)
            
          end # if rects_over?(at_rect_part, target_rect)
        end  # for at_rect_part in attacker_rect
      end # for target in targets 
      # 如果捕捉對象在攻擊範圍外，重新算進去
      if attacker.motion.catching_target != nil and !attacker.motion.attack_hit_targets.include?(attacker.motion.catching_target)
        skill = attacker.motion.skill_effect(attacker.motion.state, attacker.motion.catching_target) # skill = attacker.motion.skill_effect(attacker.motion.state, attacker.motion.target)
        @target_battlers.push([attacker, attacker.motion.catching_target, skill])
        attacker.motion.attack_hit_targets.push(attacker.motion.catching_target)
        # 計算火花位置
#        target.motion.spark_rect = target.body_rect.dup
        # 套用攻擊結果
     #   make_skill_action_result(attacker, attacker.motion.catching_target)
      end

        
        # 攻撃対象を保存
        @target_battlers_force  = @target_battlers     
        # 勝利時のためにバトラーを保存
        @final_battler = @active_battler
        
      
      
      
  #    end # unless @target_battlers.empty?
    end  #   for attacker in $game_party.actors + $game_troop.enemies + @battle_bullets
    
=begin  
    unless @target_battlers.empty?
      for a in 0...@target_battlers.size  # 新加
        # 攻撃者の設定
        if attacker.is_a?(Game_BattleBullet)
          @active_battler = attacker.root
          # ついでにここでdone設定
          unless attacker.piercing
            attacker.done = true
          end
        else
          @active_battler = attacker
        end
      end
=end    
    #
    # 「攻撃実行」
    #
    count = 0
    hitstopflag = false
    unless @target_battlers.empty?
      for a in @target_battlers  # 新加
        count += 1
        hitstopflag = true if count == @target_battlers.size
        make_skill_action_result(a[0], a[1], a[2], hitstopflag)
        # 攻撃者の設定
        if a[0].is_a?(Game_BattleBullet)
          @active_battler = a[0].root
          # ついでにここでdone設定
          unless a[0].piercing
            a[0].done = true
          end
        else
          @active_battler = a[0]
        end # if a[0].is_a?(Game_BattleBullet)
      end # for a in 0...@target_battlers.size
    end # unless @target_battlers.empty?
    
    
  end # def end 
  #--------------------------------------------------------------------------
  # ● スキルまたはアイテムの対象側バトラー設定 [再定義]
  #--------------------------------------------------------------------------
  def set_target_battlers(scope)
    # 保存したものから復旧
    @target_battlers = @target_battlers_force
  end

  
  #--------------------------------------------------------------------------
  # ● 產生攻擊行動結果 (重新定義)
  #--------------------------------------------------------------------------
  def make_skill_action_result(attacker, target, skill, hitstopflag)
    
  #  p skill, attacker.class
    
    # 獲取攻擊效果
    @skill = skill
    # 設定動畫 ID
    @animation1_id = 0
      # 設定損傷標誌
      target.damage_pop = true
    
    
    # 設定公共事件
    if @skill["common_event"] > 0
      common_event = $data_common_events[@skill["common_event"]]
      $game_system.battle_interpreter.setup(common_event.list, 0)
    end
    
    result = target.skill_effect(attacker, @skill, hitstopflag)

    
  #  p result if attacker.name == "Red_Hunter"
    
    # 技能確實命中 
    if result
      @combohit_window.counter_appear = 60 if target.motion.counter_flag and target.is_a?(Game_Enemy)
      # 處理位移
      target.move_effect(attacker, @skill) if result[1]
      # 設定損傷標誌
     # target.damage_pop = true
      # 未完成，決定戰鬥動畫要在攻擊者還是目標出現
      target.animation.push([@skill["anime"], true, 0, 0])
      
      # 增加怒氣
      if attacker.is_a?(Game_BattleBullet)
        attacker.root.awake_time = [attacker.root.awake_time + 20, 1200].min if !attacker.root.awaking or $game_switches[STILILA::FINAL_BATTLE]
      else
        attacker.awake_time = [attacker.awake_time + 20, 1200].min if !attacker.awaking or $game_switches[STILILA::FINAL_BATTLE]
      end
      target.awake_time = [target.awake_time + 30, 1200].min if (!target.awaking or $game_switches[STILILA::FINAL_BATTLE])
      
      
      if attacker.y_pos + @skill["spark"][2] < target.y_pos
        anime_y = target.y_pos + @skill["spark"][2]
      else
        anime_y  = attacker.y_pos+@skill["spark"][2]
      end
      target.battle_sprite.damage(target.damage, false, target.x_pos+@skill["spark"][1]*target.direction, anime_y, @skill["spark"][0])
      target.damage = nil
      target.critical = false
      
      # 碰撞確定後調用這兩個方法
      attacker.motion.collision_action(attacker.motion.state, target) 
      attacker.motion.collision_varset(attacker.motion.state, target)
      
      # 畫面特效
      if target == $game_party.actors[0] and !$crash_box#@handle_battler
        @wait_count_xcam = @skill["d_zoom"][0]
      #  $xcam_y = [$xcam_y - @skill["d_zoom"][1], -20].max
     #   $xcam_z = [$xcam_z - @skill["d_zoom"][2], 80].max
      end
      $game_screen.start_shake(@skill["d_shake"][0],@skill["d_shake"][1],@skill["d_shake"][2],@skill["d_shake"][3])
      if attacker == $game_party.actors[0] and !$crash_box
        @wait_count_xcam = @skill["h_zoom"][0]
 #       $xcam_y = [$xcam_y - @skill["h_zoom"][1], -20].max
       # $xcam_z = [$xcam_z - @skill["h_zoom"][2], 80].max
        $game_screen.start_shake(@skill["h_shake"][0],@skill["h_shake"][1],@skill["h_shake"][2],@skill["h_shake"][3])
      end

    end
    
    # 只要判定相交就觸發
    attacker.motion.collision_process(attacker.motion.state, target) 
    
    
    if target.combohit > $game_temp.combo_max
      $game_temp.combo_max = target.combohit
      @combohit_window.refresh($game_temp.combo_max, target.combohit_duration, target)
    end
    
    
    # 更新評價的最大連擊
    if target.combohit > $game_system.result_maxhits
      $game_system.result_maxhits = target.combohit
    end

    target.motion.counter_flag = false

  end
  
  #--------------------------------------------------------------------------
  # ○ 計算火花位置
  #--------------------------------------------------------------------------
  def make_spark_position(atker,atk_rect,target,target_rect)
    atk_part = atk_rect.dup
    target_rect2   = target_rect.dup
    rects_overlap(atk_part, target_rect2)
  end
  
  #--------------------------------------------------------------------------
  # ○ 二つの rect の重なりがあるかを判別
  #--------------------------------------------------------------------------
  def rects_over?(rect1, rect2)
    # Xの重なりを検出
    x_bool = rects_over_x?(rect1, rect2)
    # Yの重なりを検出
    y_bool = rects_over_y?(rect1, rect2)
    # 返す
    return (x_bool and y_bool)
  end
  #--------------------------------------------------------------------------
  # ○ 二つの rect の X 座標的な重なりがあるかを判別
  #--------------------------------------------------------------------------
  def rects_over_x?(rect1, rect2)
    if (rect1.x < rect2.x and rect2.x < rect1.x + rect1.width) or
       (rect2.x < rect1.x and rect1.x < rect2.x + rect2.width) or
       (rect1.x < rect2.x + rect2.width and rect2.x + rect2.width < rect1.x + rect1.width) or
       (rect2.x < rect1.x + rect1.width and rect1.x + rect1.width < rect2.x + rect2.width)
=begin
    if (rect1.x <= rect2.x and rect2.x <= rect1.x + rect1.width) or
       (rect2.x <= rect1.x and rect1.x <= rect2.x + rect2.width) or
       (rect1.x <= rect2.x + rect2.width and rect2.x + rect2.width <= rect1.x + rect1.width) or
       (rect2.x <= rect1.x + rect1.width and rect1.x + rect1.width <= rect2.x + rect2.width)
=end
      return true
    end
    return false
  end
  #--------------------------------------------------------------------------
  # ○ 二つの rect の Y 座標的な重なりがあるかを判別
  #--------------------------------------------------------------------------
  def rects_over_y?(rect1, rect2)
    if (rect1.y <= rect2.y and rect2.y <= rect1.y + rect1.height) or
       (rect2.y <= rect1.y and rect1.y <= rect2.y + rect2.height) or
       (rect1.y <= rect2.y + rect2.height and rect2.y + rect2.height <= rect1.y + rect1.height) or
       (rect2.y <= rect1.y + rect1.height and rect1.y + rect1.height <= rect2.y + rect2.height)
      return true
    end
    return false
  end
  
  #--------------------------------------------------------------------------
  # ○ 點進入矩形的兩Y軸內
  #--------------------------------------------------------------------------
  def point_in_rect_x?(point, rect)
    if point > rect.x and point < rect.x + rect.width
      return true
    else
      return false
    end
  end
  
  #--------------------------------------------------------------------------
  # ○ 點進入矩形的兩X軸內
  #--------------------------------------------------------------------------
  def point_in_rect_y?(point, rect)
    if point > rect.y and point < rect.y + rect.height
      return true
    else
      return false
    end
  end
  
  #--------------------------------------------------------------------------
  # ○ 兩個矩形的重疊範圍(未使用)
  #      rect1：被攻擊方、rect2：攻擊方
  #--------------------------------------------------------------------------
  def rects_overlap(rect1, rect2)
    rect_x =  [rect1.x,rect2.x].max
    rect_y =  [rect1.y,rect2.y].max
    if rect2.x >= rect1.x
      rect_w = ((rect1.x + rect1.width) -  rect2.x).abs
    else
      rect_w = ((rect2.x + rect2.width) -  rect1.x).abs
    end
    
    rect_w = [rect_w, [rect1.width, rect2.width].min].min
    
     if rect1.y >= rect2.y
       rect_h =  (rect2.y + rect2.height - rect1.y).abs
     else
       rect_h = (rect1.y + rect1.height - rect2.y).abs
     end
     
     rect_h = [rect_h, [rect1.height, rect2.height].min].min
    return Rect.new(rect_x, -rect_y-rect_h, rect_w+1, rect_h+1)
  end
end
