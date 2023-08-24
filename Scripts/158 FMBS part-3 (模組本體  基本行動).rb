# ▽△▽ XRXS_BS 1. Full-Move BattleSystem 新クラス ▽△▽ built 033011
# by 桜雅 在土


#------------------------------------------------------------------------------
#
#
# ▽ 生成模組
#
#
#==============================================================================
# ■ Game_Enemy
#------------------------------------------------------------------------------
#      敵人
#==============================================================================
class Game_Enemy < Game_Battler
  #--------------------------------------------------------------------------
  # ● 變身
  #     enemy_id : 變身為的敵人 ID
  #     anime：變身後的動畫
  #--------------------------------------------------------------------------
  def transform(enemy_id, anime = nil)
    # 變更敵人 ID
    @enemy_id = enemy_id
    # 變更戰鬥圖形
    @battler_name = $data_enemies[@enemy_id].battler_name
    @battler_name_basic_form = @battler_name
    @battler_hue = $data_enemies[@enemy_id].battler_hue
    
    self.motion.dispose
    
    dir = self.direction
    
    # 設定能力
    self.initialize_positioning
    setup_enemy_reflexes(enemy_id)
    
    self.direction = dir
    
    # motion 變更
  #  self.motion.change_anime(anime) if anime != nil
    # 再產生行動
    make_action
  end
end

#==============================================================================
# ■ Game_Actor
#------------------------------------------------------------------------------
#      角色
#==============================================================================
class Game_Actor < Game_Battler
  #--------------------------------------------------------------------------
  # ● 變身 (還沒做完)
  #     actor_id : 變身為的角色 ID
  #--------------------------------------------------------------------------
  def transform(actor_id)
    # 變更 ID
    @actor_id = actor_id
    # 變更戰鬥圖形
    @battler_name = $data_actors[@actor_id].battler_name
    @battler_hue = $data_actors[@actor_id].battler_hue
    @battler_name_basic_form = @battler_name
    # 設定能力
    self.initialize_positioning
    setup_actor_reflexes(actor_id)
    
  end
end

#==============================================================================
# ■ Game_BattleBullet
#------------------------------------------------------------------------------
#      飛行道具
#==============================================================================
class Game_BattleBullet < Game_Battler
  #--------------------------------------------------------------------------
  # ○ 公開インスタンス変数
  #--------------------------------------------------------------------------  
  attr_reader   :name                     # 名稱
  attr_accessor :user                     # 飛び道具の使用者
  attr_accessor :remain_time          # 寿命
  attr_accessor :done                     # 終了判定
  attr_reader   :gravity_affect           # 重量影響
  attr_reader   :piercing                 # 貫通性能
#  attr_accessor :bullet_sprite           # 飛行道具的Sprite(消除時會用到)
  attr_accessor   :other_vars              # 其他參數(可以是數字、數組、字串等等物件)
  
  attr_reader   :root                        # 根使用者(必定是Game_Battler)
  
  #--------------------------------------------------------------------------
  # ○ 物件初始化
  # 使用者、動畫、動畫影格、X、Y
  #--------------------------------------------------------------------------
  def initialize(user, anime, frame_id, x, y, gravity_affect, piercing, other_vars=nil)
    # 調用父類
    super()
    # 設定
    @maxhp     = 1
    @maxsp     = 1
    @hp        = 1
    @sp     = 1
    @x_pos     = user.x_pos + (x * user.direction)
    @y_pos     = user.y_pos + y
    @z_pos     = 0
    @zoom      = user.zoom
    @direction = user.direction
    
    # 記憶使用者
    @user      = user
    
    # 記憶根使用者
    if user.is_a?(Game_BattleBullet)
      @root = user.root
    else
      @root = user
    end
      
    if @root.is_a?(Game_BattleBullet)
      p "記憶的根使用者是 BattleBullet \n記憶對象 #{user.name} ，目標動畫 #{anime} 、影格 #{frame_id}\n請除錯。"
      exit
    end
      
    @done = false
    @gravity_affect = gravity_affect
    @piercing = piercing
    @battle_shadow_id = 0
    @other_vars = other_vars
    
    set_motion(user, frame_id, anime)
  end
  #--------------------------------------------------------------------------
  # ○ 基本最大HP
  #--------------------------------------------------------------------------
  def base_maxhp
    return 1
  end
  #--------------------------------------------------------------------------
  # ○ 模組初始化
  #--------------------------------------------------------------------------
  def set_motion(user, frame_id, anime)
    @name = user.name  # 設定飛道名稱
    case user.name
    when "Red_Sickle"
      @name = "RedS"  # 重新更名
      @battler_hue = user.battler_hue
      @motion = Red_Sickle.new(self, frame_id, anime)
    when "Red_Hunter"
      @name = "RedH" # 重新更名
      @battler_hue = user.battler_hue
      @motion = Red_Hunter.new(self, frame_id, anime)
    when "Red_Beast"
      @name = "RedB" # 重新更名  
      @battler_hue = user.battler_hue
      @motion = Red_Beast.new(self, frame_id, anime)
    when "Grass"
      @battler_hue = user.battler_hue
      @motion = Grass.new(self, frame_id, anime)
    when "Bee"
      @battler_hue = user.battler_hue
      @motion = Bee.new(self, frame_id, anime)
    when "Bat"
      @battler_hue = user.battler_hue
      @motion = Bat.new(self, frame_id, anime)
    when "Leather"
      @battler_hue = user.battler_hue
      @motion = LeatherB.new(self, frame_id, anime)
    when "DarkRedS"
      @battler_hue = user.battler_hue
      @motion = Red_Sickle.new(self, frame_id, anime)
    when "DarkRedH"
      @battler_hue = user.battler_hue
      @motion = Red_Hunter.new(self, frame_id, anime)
    when "DarkRedB"
      @battler_hue = user.battler_hue
      @motion = Red_Beast.new(self, frame_id, anime)
    when "Mushrooms"
      @battler_hue = user.battler_hue
      @motion = Mushrooms.new(self, frame_id, anime)
    when "Spider"
      @battler_hue = user.battler_hue
      @motion = Spider.new(self, frame_id, anime)
    when "Corals" 
      @battler_hue = user.battler_hue
      @motion = Corals.new(self, frame_id, anime)
    when "CoralsFinal" 
      @battler_hue = user.battler_hue
      @motion = CoralsFinal.new(self, frame_id, anime)
      
      
    when "EX_Leather"
      @battler_hue = user.battler_hue
      @motion = LeatherEX.new(self, frame_id, anime)
    when "EX_DarkRedS", "Red_SickleEX"
      @battler_hue = user.battler_hue
      @motion = Red_SickleEX.new(self, frame_id, anime)
    when "EX_DarkRedH", "Red_HunterEX"
      @battler_hue = user.battler_hue
      @motion = Red_HunterEX.new(self, frame_id, anime)
    when "EX_DarkRedB", "Red_BeastEX"
      @battler_hue = user.battler_hue
      @motion = Red_BeastEX.new(self, frame_id, anime)
    when "EX_Corals" 
      @battler_hue = user.battler_hue
      @motion = CoralsEX.new(self, frame_id, anime)
    when "EX_CoralsFinal" 
      @battler_hue = user.battler_hue
      @motion = CoralsFinalEX.new(self, frame_id, anime)
      
    else
      p "#{user.name}的飛道宣告設定錯誤囉，到 Game_BattleBullet 的 set_motion 檢查"
      exit
    end
  end
  
  
  #--------------------------------------------------------------------------
  # ○ 使用者をセット
  #--------------------------------------------------------------------------
  def set_user(user)
    # バトラーから値を取得
    @maxhp     = 1
    @maxsp     = 1
    @hp        = 1
    @sp     = 1
    @user      = user
    @x_pos     = user.x_pos + (@x_pos * user.direction)
    @y_pos     = user.y_pos + @y_pos
    @z_pos     = 50
    @zoom      = user.zoom
    @direction = user.direction
    @battler_hue = user.battler_hue
  end
end

#------------------------------------------------------------------------------
#
#
# ▽ 新規
#
#
#==============================================================================
# □ Game_Motion
#------------------------------------------------------------------------------
# 負責處理角色模組的Class，在Game_Battler裡使用。
#==============================================================================
class Game_Motion
  
  #--------------------------------------------------------------------------
  # ○ 設置常量
  #--------------------------------------------------------------------------  
  # メテオされたときの消滅時間[単位:F]
  DISAPPEAR_DURATION = 2
  # メテオされたときのアニメーションID
  METEOR_ANIMATION_ID = 0
  # 復帰時のアニメーションID
  RETURN_ANIMATION_ID = 0
  # 倒地時動畫 ID
  DOWN_ANIMATION_ID = 10
  # 著地時動畫 ID
   LAND_ANIMATION_ID = 11
   
   
   TIMELY_GUARD_TIME = 8
   
  # 著地聲
  CROUCH_SE = "bosu37"
   
   
   # 最大圖片數
   PICTURE_LIMIT = 999
  #--------------------------------------------------------------------------
  # ○ 公開變數
  #--------------------------------------------------------------------------  
  attr_accessor  :attack_rect                            # 攻撃判定
  attr_reader     :state_time                            # 狀態經過時間(不受定格影響，給AI立回判定用)
  attr_reader     :anime_time                         # 動畫經過時間(會受定格影響)
  attr_reader     :frame_number                      # 影格編號
  attr_reader     :frame_loop                          # 循環影格/結束後移至的影格 
  attr_accessor  :blur_effect                           # 殘影判定
  attr_accessor  :spark_rect                            # 爆花效果判定
  
  
  attr_reader     :penetrate                              # 自身穿透性
  attr_reader     :full_limit                               # 擊飛狀態中最大承受的攻擊量(在個別資料內宣告)
  attr_accessor   :state                                   # 目前行動
  attr_reader     :blow_type
  attr_reader     :down_type
  attr_accessor :knock_back_duration         # 傷害硬直時間
  attr_accessor :hit_stop_duration                # 命中停頓時間
  attr_accessor :attack_hit_targets               # 中招者清單(防止連打)
  attr_accessor :battle_bullet                        # 飛行道具
  attr_accessor :battle_bullet_plan                # 飛行道具預約
  attr_accessor :boardthrough_duration        # 可穿透平台的時間(用於從平台上落下)
  attr_accessor :hit_invincible_duration        # 無敵時間(有判定)
  attr_accessor :eva_invincible_duration      # 無敵時間(無判定)
  attr_accessor :now_jumps                          # 現在跳躍次數
  attr_accessor :super_armor                        #霸體
  attr_accessor :voice_cold                         # 語音cd時間
  attr_accessor :catching_target                 # 捉住的人
  attr_accessor :command_plan                     # 指令輸入預約
  attr_accessor :command_plan_count          # 預約指令維持時間
  attr_accessor :catched                                # 被捉判定
  attr_accessor :catching_target_action        # 強制指定目標動作
  attr_accessor :catching_attacker                # 被誰捉(被捉的人用)
  attr_accessor :supermove_time                # 定格中可以行動的時間
  attr_accessor :uncancel_flag                   # 硬直標誌
  attr_accessor :absolute_uncancel_time    # 絕對硬直時間
  attr_accessor :y_fixed                             # Y軸固定標誌
  attr_accessor :fall_damage                           # 碰撞時的傷害值 
  attr_accessor :timely_guard_time            # 瞬間防禦　
  attr_accessor :counter_flag                   # 反擊標誌
  attr_accessor :now_full_count             # 擊飛狀態中承受的攻擊量
  attr_reader    :pre_state                       # 前一個動作
  attr_reader    :down_count                   # 倒地時間
  attr_accessor    :physical                     # 物理運算有無(重力加速度、阻力等...常時true)
  
  attr_reader    :frame_time                   # 畫格經過時間
  attr_accessor    :frame_duration         # 畫格倒數
  # 偵測按住
  attr_accessor :hold_key_left
  attr_accessor :hold_key_right
  attr_accessor :hold_key_up
  attr_accessor :hold_key_down
  attr_accessor :hold_key_z
  attr_accessor :hold_key_x
  attr_accessor :hold_key_s
  attr_accessor :hold_key_c
  
  # 可以被推走
  attr_accessor :push_flag
  #--------------------------------------------------------------------------
  # ○ オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize(me,frame=0,anime="stand")
    @me = me
    @state = anime
    @frame_time = 0
    @frame_number = 0
    @frame_duration = 0
    @next_frame = frame
    @hold_key_left = 0
    @hold_key_right = 0
    @hold_key_up = 0
    @hold_key_down = 0
    @hold_key_z = 0
    @hold_key_x = 0
    @hold_key_s = 0
    @hold_key_c = 0
    @me.damage_correction = 100
    @down_count = 0
    @pre_state = "anime"
    full_clear(frame,anime)
  end
  #--------------------------------------------------------------------------
  # ○ 完全クリア
  #--------------------------------------------------------------------------
  def full_clear(frame=0,anime="stand")
    @attack_rect        = []
    @attack_hit_targets = []
    @frame_loop = [0,0]
    @voice_cold = 0
    @appeared_dead_voice = false
    @me.now_x_speed = 0
    @me.now_y_speed = 0
    # 通常クリアされない値の初期化
    @hit_stop_duration   = 0
    @knock_back_duration = 0
    @now_jumps           = 0
     #空中衝刺次數
    @airdash_times = 0
    #大跳過與否判定
    @high_jump = false
    # 定格中允許行動時間
    @supermove_time = 0
    # 被捉住
    @catched = false    
    # 被捉住的人
    @catching_target = nil 
    # 被誰捉
    @catching_attacker = nil
    @timely_guard_time = 0
    @counter_flag = false
    @now_full_count = 0
    @spark_rect = nil
    # 通常クリア
    clear
  end
  #--------------------------------------------------------------------------
  # ○ クリア
  #--------------------------------------------------------------------------
  def clear
    @push_flag = true
    @physical = true
    @blow_type = "N"
    @down_type = "N"
    @attack_rect.clear
    @attack_hit_targets = []
    @boardthrough_duration = 0
    @hit_invincible_duration = 0
    @eva_invincible_duration = 0
    @battle_bullet       = nil
    @super_armor    = 0 #霸體值
    @blur_effect = false # 殘影效果
    @command_plan = "" # 指令預約
    @command_plan_count = 0 # 預約指令維持時間
    @uncancel_flag = false # 硬直標誌
    @absolute_uncancel_time = 0 # 絕對硬直時間
    @y_fixed = false # Y軸固定標記
    @fall_damage = 0  # 落地傷害值

    @penetrate = false
    @frame_loop[0] = 0
    @frame_loop[1] = 0
    @me.edge_spacing = 0
    @valuereset_flag = false  # 變量重置flag
    @blow_lv = 0 # 擊飛等級
    @hit_silde = 0  # 板邊命中對方時往後滑開的速度
    @me.z_pos = 0  # 圖像優先度
    @state_time = 0  # 動作經過時間
    @anime_time = 0
    
    # 重置取消數
    if @me.chain_count > $game_system.result_maxchain
      $game_system.result_maxchain = @me.chain_count 
    end
    @me.chain_count = 0
    
  end

  #--------------------------------------------------------------------------
  # ○ 切換動畫
  #      name ：  動畫名稱、frame：畫格
  #--------------------------------------------------------------------------
  def change_anime(name, frame = 0)
    @pre_state = @state  # 紀錄上一個動作
    @state = name

    frame = 0 if frame == nil
    @state_time = 0
    @anime_time = 0
    @frame_time = 0
    @penetrate = false
    # 清除攻擊判定
    @attack_rect.clear
    @attack_hit_targets.clear
    update_anime(frame)
  end
  
  #--------------------------------------------------------------------------
  # ○ 檢查動畫(除錯用)
  #--------------------------------------------------------------------------
  def check_anime_exist(name, frame)
    return "no_a" if @anime[name] == nil
    return "no_f" if @anime[name][frame] == nil
  end
  
  #--------------------------------------------------------------------------
  # ○ 進行影格
  #      run_frame
  #--------------------------------------------------------------------------
  def update_anime(frame)
    begin
      
    if frame.is_a?(Array)
      change_anime(frame[0], frame[1])
      return
    end
    
    # 設定圖片
    @me.transgraphic(@anime[@state][frame]["pic"])  if @anime[@state][frame]["pic"] != 999 # 設定圖片 
    # 設定換至下個影格的等待值
    @frame_duration = @anime[@state][frame]["wait"] 
    # 設定下個影格
    @next_frame = @anime[@state][frame]["next"] 
    # 取得目前影格
    @frame_number = frame 
    # 畫格時間重置
    @frame_time = 0
    # 無法取消值
    @absolute_uncancel_time = @anime[@state][frame]["ab_uncancel"] unless @anime[@state][frame]["ab_uncancel"].nil? 
    # 硬直標記
    @uncancel_flag = @anime[@state][frame]["uncancel"]  unless @anime[@state][frame]["uncancel"].nil? 
     # 設定鏡頭
     $scene.camera_feature = @anime[@state][frame]["camera"].dup if @anime[@state][frame]["camera"] != nil
     # 設定 fps
     if @anime[@state][frame]["fps"] != nil
       if @me == $scene.xcam_watch_battler or (@me != $scene.xcam_watch_battler and ($scene.xcam_watch_battler.x_pos - @me.x_pos).abs < 100)
         $game_temp.fps_change = @anime[@state][frame]["fps"][0]
         Graphics.frame_rate = @anime[@state][frame]["fps"][1]
       end
      end
     # 設定轉暗 
     $game_temp.black_time = @anime[@state][frame]["black"].dup if @anime[@state][frame]["black"] != nil
     
    # 轉向
    @me.direction *= -1 if @anime[@state][frame]["turn_back"] != nil
     
     
     
     # X 強制移動
     if @anime[@state][frame]["x_move"] != nil
       if @anime[@state][frame]["x_move"] == 0
        @me.now_x_speed = 0
       else
        @me.relative_x_destination = @anime[@state][frame]["x_move"] * @me.direction
       end
     end
     
     # X 速度設定
     if @anime[@state][frame]["x_speed"] != nil
       if @anime[@state][frame]["x_speed"] == 0
         @me.now_x_speed = 0
       else
         @me.now_x_speed = @anime[@state][frame]["x_speed"] * @me.direction
       end
     end

     p @anime_time if @anime[@state][frame]["p"]
     
     
     # Y軸固定標誌
     @y_fixed = @anime[@state][frame]["y_fixed"] unless @anime[@state][frame]["y_fixed"].nil?
     
      # Y 強制移動
     if @anime[@state][frame]["y_move"] != nil
      @me.relative_y_destination = @anime[@state][frame]["y_move"]
      @me.now_y_speed = 0
     end
     
     
     # Y 速度設定
     if @anime[@state][frame]["y_speed"] != nil
       if @anime[@state][frame]["y_speed"] == 0
         @me.now_y_speed = 0
       else
         @me.now_y_speed = @anime[@state][frame]["y_speed"]
       end
     end
 
     
    # 強制指定目標動作
    if @anime[@state][frame]["catch_target_act"] != nil  and @catching_target != nil 
      @catching_target.x_pos = @me.x_pos + (@anime[@state][frame]["catch_target_act"][0] * @me.direction)  if @anime[@state][frame]["catch_target_act"][0] != nil
      @catching_target.y_pos = @me.y_pos + @anime[@state][frame]["catch_target_act"][1]  if @anime[@state][frame]["catch_target_act"][1] != nil
      @catching_target.motion.change_anime(@anime[@state][frame]["catch_target_act"][2][0], @anime[@state][frame]["catch_target_act"][2][1])  if @anime[@state][frame]["catch_target_act"][2] != nil
      @catching_target.direction *= -1  if @anime[@state][frame]["catch_target_act"][3] != nil
    end
    
    # 強制指定與板邊的距離
    @me.edge_spacing = @anime[@state][frame]["edge_spacing"] if @anime[@state][frame]["edge_spacing"] != nil
    
    
    # 清除攻擊過的目標
    if @anime[@state][frame]["hit_reset"]
      @attack_hit_targets.clear 
      if !@me.is_a?(Game_BattleBullet)
        @me.ai.guard_time = 0
        @me.ai.contact_time = 0 
        @me.ai.hit_time = 0
       end
    end

    # 設定攻擊判定
    if @anime[@state][frame]["atk"] != nil
      if @anime[@state][frame]["atk"] == 0
        @attack_rect.clear # 範圍
      else
        @attack_rect  = @anime[@state][frame]["atk"].dup # 範圍
      end
      # 清除攻擊過的目標
  #    @attack_hit_targets.clear unless @anime[@state][frame]["keep_atk_rect"]
    end
    


    
    # 改變影子圖
    @me.battle_shadow_id = @anime[@state][frame]["shadow_id"]  unless @anime[@state][frame]["shadow_id"].nil?
    # 設定身體判定
    @me.body_rect = @anime[@state][frame]["body"]  unless @anime[@state][frame]["body"].nil?
    
    
    # 放出飛行道具
   # @battle_bullet = @anime[@state][frame]["bullet"] unless @anime[@state][frame]["bullet"].nil?
    $scene.create_battle_bullets(@anime[@state][frame]["bullet"]) if @anime[@state][frame]["bullet"] != nil

    
    # 播放音效
    Audio.se_play("Audio/SE/" + @anime[@state][frame]["se"][0], @anime[@state][frame]["se"][1] * $game_config.se_rate / 10, @anime[@state][frame]["se"][2]) unless @anime[@state][frame]["se"].nil?
    # 設定完全迴避
    @eva_invincible_duration = @anime[@state][frame]["eva"] unless @anime[@state][frame]["eva"].nil?
    # 設定無敵
    @hit_invincible_duration = @anime[@state][frame]["invincible"] unless @anime[@state][frame]["invincible"].nil?
    # 設定霸體
    @super_armor = @anime[@state][frame]["super_armor"] unless @anime[@state][frame]["super_armor"].nil?
    # 設定殘影
    @blur_effect = @anime[@state][frame]["blur"] unless @anime[@state][frame]["blur"].nil?
    # 設定動畫
    @me.animation.push([@anime[@state][frame]["anime"][0], true, @anime[@state][frame]["anime"][1], @anime[@state][frame]["anime"][2]]) unless @anime[@state][frame]["anime"].nil?
    # 設定定格
    $game_temp.superstop_time = @anime[@state][frame]["superstop"] if @anime[@state][frame]["superstop"] != nil
    # 設定定格中行動時間
    @supermove_time = @anime[@state][frame]["supermove"] if @anime[@state][frame]["supermove"] != nil
    # 圖像優先度
    @me.z_pos = @anime[@state][frame]["z_pos"] if @anime[@state][frame]["z_pos"] != nil
    # 穿透性
    @penetrate = @anime[@state][frame]["penetrate"] if @anime[@state][frame]["penetrate"] != nil
    # 影格循環
    @frame_loop = @anime[@state][frame]["loop"]  if @anime[@state][frame]["loop"] != nil
    # 物理運算
    @physical = @anime[@state][frame]["physical"]  if @anime[@state][frame]["physical"] != nil
    # 變量重置flag
    @varreset_flag = @anime[@state][frame]["var_reset"]  if@anime[@state][frame]["var_reset"] != nil
    
  rescue
    
     # 整理錯誤訊息
     $!.backtrace[0][/(\d+):(\d+)/]
     section = $1.to_i
     line = $2
     script = load_data("Data/Scripts.rxdata")

    case check_anime_exist(@state, frame)
    when "no_a"
      p "#{@me.name}的動畫清單中沒有#{@state}，請檢查"
    when "no_f"
      p "#{@me.name}的動畫清單中的#{@state}沒有第#{frame}格，請檢查"
    else
      print ("Game_Motion 類的 update_anime 處理過程發生其他錯誤，請檢查。\n\n",
"＜錯誤位置＞\n腳本「" + script[section][1] + "」第 " + line + " 行\n\n",
"＜錯誤內容＞\n【" + $!.class.to_s + "】\n" + $!.message)
      exit
    end
  end  #begin end
  
  end  # def end
  
   
   

  #--------------------------------------------------------------------------
  # ○ フレーム更新
  #--------------------------------------------------------------------------
  def update

    @battle_bullet = nil
    @me.relative_y_destination = 0
    @me.relative_x_destination = 0

    @timely_guard_time -= 1 if @timely_guard_time > 0
    @supermove_time -= 1 if @supermove_time > 0
    
    @state_time += 1
    
    
    # 常時監視A (無視暫停效果)
    respective_updateA
    
    # 定格中
    return if static?
    
   # Hit Stop減少  
   if @hit_stop_duration > 0
      @hit_stop_duration -= 1
      return
    end

    # 各種數值減少
    @down_count -= 1 if @down_count > 0# and !@me.dead?
    @eva_invincible_duration -= 1 if @eva_invincible_duration > 0
    @hit_invincible_duration -= 1 if @hit_invincible_duration > 0
    @boardthrough_duration   -= 1 if @boardthrough_duration > 0
    @absolute_uncancel_time   -= 1 if @absolute_uncancel_time > 0
    @super_armor -= 1 if @super_armor > 0
    # 暈眩減少
    @knock_back_duration   -= 1 if @knock_back_duration > 0
    # 動畫時間增加
    @anime_time += 1
   # 等待值減少
   @frame_duration -= 1 if @frame_duration > 0
   # 畫格時間增加
   @frame_time += 1
   # 常時監視B
   respective_updateB
   
    # 如果該狀態有額外設定專用方法，就執行他 
    #  (只是為了美觀，全寫在respective_update會很擠...)
    if respond_to?(@state)
      eval(@state)
    end

    # 維持預約指令的時間減少
    if @command_plan_count > 0
      @command_plan_count -= 1
    else
      @command_plan = ""
    end
    
    # 循環影格處理
    if @frame_loop[0] > 0
     @frame_loop[0] -= 1
    else
       if @frame_loop[1] != 0
         change_anime(@frame_loop[1][0], @frame_loop[1][1]) 
        @frame_loop[0] = 0
        @frame_loop[1] = 0
        return
       end
    end
    
   # 動畫等待值為0的時候，改變動畫
   if @frame_duration == 0
     if @varreset_flag
       var_reset if [["stand"], ["jump_fall"]].include?(@next_frame)
       @varreset_flag = false
     end
     if @next_frame == ["dispose"]
       do_dispose
       return
     end
     if @next_frame.is_a?(String)
       eval(@next_frame)
       return
     end
     update_anime(@next_frame)
   end
   
   
   
   
  return  # 以下內容廢除


    
    # ボイス再生予約の更新
    if @voice_playing_plan.size > 0
      n = @voice_playing_plan.shift
      unless n.nil?
        if n[0].include?("damage")  and @voice_cold > 0
        else
          if n[2].nil?
            n[2] = 100
          end
          Audio.se_play("Audio/SE/" + n[0], n[1] * $game_config.se_rate / 10, n[2]) 
          @voice_cold = 16
        end
      end
    end
    
  end
  
  #--------------------------------------------------------------------------
  # ○ 解放
  #--------------------------------------------------------------------------
  def dispose
  end
  
  
#==============================================================================
# □ 判定部分
#==============================================================================
  
  #--------------------------------------------------------------------------
  # ◇ 指示可能？(戦闘終了時などに使用)
  #--------------------------------------------------------------------------
  def directable?
    return (not @me.dead?)
  end
  #--------------------------------------------------------------------------
  # ◇ 擊飛判定
  #--------------------------------------------------------------------------
  def blowning?
    return ["f_blow","b_blow","hf_blow", "hb_blow", "vertical_blow", "vertical_blow_fall", "parallel_f_blow", "parallel_b_blow", "bounce_f_down", "bounce_b_down", "pressure_f_down", "pressure_b_down"].include?(@state)
  end
  #--------------------------------------------------------------------------
  # ◇ 完全倒地判定
  #--------------------------------------------------------------------------
  def downing?
    return (["f_down", "b_down"].include?(@state) or (@state == "dead" and @me.dead_disappear))
  end
  
  #--------------------------------------------------------------------------
  # ◇ 受傷中
  #--------------------------------------------------------------------------
  def damaging?
    return ((@knock_back_duration > 0) or 
    (["damage_up", "damage_down", "damage_mid", "damage_crouch", "damage_air", "damage1", "damage2",
    "damage_up_recover", "damage_mid_recover", "damage_down_recover", "damage_crouch_recover", "damage_air_recover", "catched", "binding", "binding2", "binding3"].include?(@state)) or 
    blowning?)
  end
  
  #--------------------------------------------------------------------------
  # ◇ 操作可能？
  #--------------------------------------------------------------------------
  def controllable?
    return (!blowning? and !downing? and @knock_back_duration <= 0 and !static? and !@catched and @state != "dead" and @state != "catched" and @state != "binding" and @state != "binding2" and @state != "binding3") 
  end
  #--------------------------------------------------------------------------
  # ◇ 技無法取消
  #--------------------------------------------------------------------------
  def cannot_cancel_act?
    return (@uncancel_flag  or @absolute_uncancel_time > 0)
  end       
  #--------------------------------------------------------------------------
  # ◇ 防禦可能？
  #--------------------------------------------------------------------------
  def guardable?
    return (!blowning? and !downing? and !cannot_cancel_act? and @knock_back_duration <= 0 and freemove?)
  end
  #--------------------------------------------------------------------------
  # ◇ 防禦中？
  #--------------------------------------------------------------------------
  def guarding?
    return  ["guard","guard_shock"].include?(@state) 
  end
  #--------------------------------------------------------------------------
  # ◇ 空中？
  #--------------------------------------------------------------------------
  def on_air?
    return  (@now_jumps > 0)  #and  @me.y_pos > 0 )
  end
  #--------------------------------------------------------------------------
  # ◇ 定格中？
  #--------------------------------------------------------------------------
  def static?
    return ($game_temp.superstop_time > 0 and @supermove_time < 1)
  end
  #--------------------------------------------------------------------------
  # ◇ 放開捉住的對象
  #--------------------------------------------------------------------------
  def release_catching_target
    return if @catching_target.nil?
    @catching_target.motion.do_damage(1, 2, "N", "N", @catching_target.motion.catching_attacker, nil)
    @catching_target.motion.hit_stop_duration += 3
    @catching_target.motion.knock_back_duration += 10
    @catching_target.now_x_speed += -3 * @catching_target.direction 
    @catching_target.now_y_speed += 4
    @catching_target.motion.catched = false
    @catching_target = nil
  end
  #--------------------------------------------------------------------------
  # ◇ 捉住對像
  #--------------------------------------------------------------------------
  def do_catch(target)
    @catching_target = target
    @catching_target.motion.catched = true
    target.motion.catching_attacker = @me
  end
  #--------------------------------------------------------------------------
  # ◇ 判斷板邊距離(前面)
  #--------------------------------------------------------------------------
  def frontedge_dist
    if @me.direction == 1
      return ($game_temp.battle_field_w - @me.x_pos)
    else
     return @me.x_pos 
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 判斷板邊距離(後面)
  #--------------------------------------------------------------------------
  def backedge_dist
    if @me.direction == 1
      return @me.x_pos 
    else
      return $game_temp.battle_field_w - @me.x_pos
    end
  end
  #--------------------------------------------------------------------------
  # ○ 可自由活動的狀態
  #--------------------------------------------------------------------------
  def freemove?
    return (["stand", "stand_idle", "walk", "dash", "landing", "crouch", "jump_fall",
    "jump_fall", "f_jump_fall", "b_jump_fall", "double_jump_fall",
    "h_jump_fall", "hf_jump_fall", "hb_jump_fall", "guard"].include?(@state) and @absolute_uncancel_time <= 0)
  end
  #--------------------------------------------------------------------------
  # ○ 可以被推擠
  #--------------------------------------------------------------------------
  def can_push?
    return @me.now_x_speed == 0  #["stand","stand_idle"].include?(@state)
  end
  #--------------------------------------------------------------------------
  # ○ 取得動畫剩餘禎數
  #--------------------------------------------------------------------------
  def anime_remain
    count = 0
    for f in 0...@anime[@state].size
      next if (f <= @frame_number)
      count += @anime[@state][f]["wait"]
    end  
      count += @frame_duration
      return count
  end
  #--------------------------------------------------------------------------
  # ○ 取得動畫總禎數
  #--------------------------------------------------------------------------
  def total_anime_time
    count = 0
    for f in 0...@anime[@state].size
      count += @anime[@state][f]["wait"]
    end  
    return count
  end
  
#==============================================================================
# □ 基本指令部分
#==============================================================================  

  #--------------------------------------------------------------------------
  # ◇ 掉落地洞的處理
  #--------------------------------------------------------------------------
  def do_meteor
    release_catching_target
    # 完全クリア
    full_clear
    # メテオスマッシュによる一定時間消滅
    do_down
    # 行動設定
    @frame_duration = DISAPPEAR_DURATION
    # アニメーションを表示
    @me.animation.push([METEOR_ANIMATION_ID, true,0,0])
    # 拉回地面
    @me.x_pos = 0
    @me.y_pos = 480
  end

  #--------------------------------------------------------------------------
  # ◇ 復帰
  #--------------------------------------------------------------------------
  def do_return
    # 位置を中央にして
    @me.x_pos = 0
    @me.y_pos = 160
    @me.now_y_speed = -14
    @absolute_uncancel_time = 28
    # 受け身不可能で
    @ukemi_duration = 0
    # 倒れる
    do_down
    # 一定時間当たりあり無敵
    @hit_invincible_duration = 120
    # 行動設定
    @frame_duration   = 28 
    # 記憶位置
    @me.previous_x_pos = @me.x_pos
    @me.previous_y_pos = @me.y_pos
    # アニメ設定
    @me.animation.push([RETURN_ANIMATION_ID, true,0,0])
  end

  #-------------------------------------------------------------------------------
  # ○ 消失
  #-------------------------------------------------------------------------------
  def do_dispose
    @me.done = true
    @me.transgraphic(0)
  end
  #--------------------------------------------------------------------------
  # ◇ 姿勢恢復
  #--------------------------------------------------------------------------
  def var_reset
    
    if @me.chain_count > $game_system.result_maxchain
      $game_system.result_maxchain = @me.chain_count 
    end

    @me.chain_count = 0

    if @me.dead?
      @me.combohit_clear # 連段數歸零
       return
     end

    #@absolute_uncancel_time = 1
    @uncancel_flag = false # 解除動作硬直
    @blur_effect = false  # 消除殘影
    @attack_rect.clear    # 攻擊判定消除
    @me.combohit_clear # 連段數歸零
    @battle_bullet = nil

    @counter_flag = false
    @now_full_count = 0
    @frame_loop[0] = 0
    @frame_loop[1] = 0
    @me.edge_spacing = 0
    if @me.is_a?(Game_BattleBullet)
      @me.done = true
    else
      @me.ai.determine_set
    end
  end

  
  #--------------------------------------------------------------------------
  # ◇ 執行其他預約指令
  #      處理5ZZ、5XX這種角色間不一定有的指令
  #--------------------------------------------------------------------------
  def do_other_plancommand
    
    p "這角色是敵人" if @me.is_a?(Game_Enemy)
    
    case @command_plan
    when 999999
      return
    end
    
    p "#{@command_plan} 沒設定到 do_other_plancommand"
    
  end
  
  #--------------------------------------------------------------------------
  # ◇ 走路
  #--------------------------------------------------------------------------
  def do_walk(direction)
    return if cannot_cancel_act?
    if on_air?
      do_airwalk(direction)
      return
    end
    @me.direction = direction
    # 步行中
    @me.now_x_speed = direction * @me.walk_x_speed
    if @state != "walk"
      change_anime("walk")
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 跑步
  #--------------------------------------------------------------------------
  def do_dash(direction)
    return if cannot_cancel_act?
    @me.direction = direction
    # 奔跑中
    @me.now_x_speed = direction * @me.dash_x_speed
    if @state != "dash"
      change_anime("dash")
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 衝刺中斷/剎車
  #--------------------------------------------------------------------------
  def do_dashbreak
    @me.now_x_speed = (@me.dash_x_speed/1.5) * @me.direction
     change_anime("dash_break")
  end

   #--------------------------------------------------------------------------
  # ◇大跳躍
  #--------------------------------------------------------------------------
  def do_high_jump
    if @me == $game_party.actors[0]
        $game_temp.superstop_time += 20
        @supermove_time += 20
        $scene.camera_feature = [20,15,15]
        $game_temp.black_time = [20,50] if (20 > $game_temp.black_time[0])
     end
    @me.animation.push([LAND_ANIMATION_ID, true,0,0])  if !on_air?
    @high_jump = true
    @now_jumps += 1
    change_anime("h_jump")
  end
  
  #--------------------------------------------------------------------------
  # ◇ 空中横移動(封印)
  #--------------------------------------------------------------------------
  def do_airwalk(direction)
    return if @absolute_uncancel_time > 0 
  #  return unless @state == 5
  #  return
    if direction == 1
      if @me.now_x_speed <= @me.air_x_maximum
        @me.now_x_speed += @me.air_x_velocity
        @me.now_x_speed  = [@me.now_x_speed, @me.air_x_maximum].min
      end
    else
      if @me.now_x_speed >= -@me.air_x_maximum
        @me.now_x_speed -= @me.air_x_velocity
        @me.now_x_speed  = [@me.now_x_speed, -@me.air_x_maximum].max
      end
    end
 #   @me.direction = direction
  end
  

  

  
  
  #--------------------------------------------------------------------------
  # ◇ 從平台落下
  #--------------------------------------------------------------------------
  def do_boardthrough
     return if !controllable?
    @boardthrough_duration = 3
  end
  #--------------------------------------------------------------------------
  # ◇ 著地
  #--------------------------------------------------------------------------
  #--------------------------------------------------------------------------
  # ◇防禦
  #--------------------------------------------------------------------------


  #--------------------------------------------------------------------------
  # ◇ 防禦硬直
  #--------------------------------------------------------------------------
  def do_guard_shock
    @knock_back_duration = [((@knock_back_duration * 2) / 5.0).round, 6].min
    change_anime("guard_shock")
    appear_guard_voice(@me)
  end
  
  #--------------------------------------------------------------------------
  # ◇ 受傷額外處理
  #--------------------------------------------------------------------------
  def extra_damage_process
    
  end
  
  #--------------------------------------------------------------------------
  # ◇ 受傷
  #      attacker：攻擊者(有可能是nil)
  #      dir：判定方向 
  #      scope：從攻擊等級變過來，沒作用 
  #      blow_type：擊飛類型("N"：一般、"H"：重擊、"P"：平行、"V"：垂直、"None"：不擊飛)
  #      down_type：擊倒類型
  #      force_state：強制切換狀態
  #--------------------------------------------------------------------------
  def do_damage(dir, scope, blow_type, down_type, attacker = nil, force_state = nil)
    clear # まずはクリア
    release_catching_target 
    @me.z_pos = 1
    @blur_effect = false
    # AI 重新整理
    @me.ai.clear
    @me.ai.do_next
    
    # 不會被擊飛的敵人
    if @me.is_a?(Game_Enemy) and STILILA::NO_BLOW_ENEMY.include?(@me.id)                   #@me.name == "Leather"
      blow_type = "None"
    end  
    
   # can_lock = true
   # can_catch = true
   # can_lock = false if (target.is_a?(Game_Enemy) && STILILA::NO_LOCK_ENEMY.include?(target.id))
  #  can_catch = false if (target.is_a?(Game_Enemy) && STILILA::NO_CATCH_ENEMY.include?(target.id))
    
    if force_state != nil #and can_lock and can_catch # 強制切換狀態
      change_anime(force_state[0],force_state[1])
    elsif blow_type != "None"  # 判定為可擊飛時
      case blow_type
      when "N"
         dir == 1 ? change_anime("f_blow") : change_anime("b_blow")
      when "H"
        @blur_effect = true
        appear_blow_voice(@me)
        dir == 1 ? change_anime("hf_blow") : change_anime("hb_blow")
      when "P"
        dir == 1 ? change_anime("parallel_f_blow") : change_anime("parallel_b_blow")
      when "V"
        change_anime("vertical_blow")
      end
    else  # 除外的情況切換到受傷
      appear_damage_voice(@me)
     # rand(2) == 1 ? change_anime("damage1") : change_anime("damage2")
      change_anime("damage1")
      @me.body_rect = @me.stand_body_rect
    end
    @down_type = down_type  # 記錄倒地方式
  end
  #--------------------------------------------------------------------------
  # ◇ 倒地(？
  #      ("N"：一般、"H"：重擊(摩擦地面)、"P"：壓制、"B"：反彈)
  #--------------------------------------------------------------------------
  def do_down
    Audio.se_play("Audio/SE/" + Scene_Battle::DOWN_SE, 87 * $game_config.se_rate / 10, 100)  unless @me.hidden
    @now_jumps = 0
    @me.z_pos = 1
    @blur_effect = false
  #  @me.body_rect = @me.down_body_rect
    if @me.dead?
      @me.z_pos = -1
    end  
    # 方向
    if  ["f_blow", "hf_blow", "bounce_f_down", "pressure_f_down"].include?(@state)
      dir = 1
    elsif  ["b_blow", "hb_blow", "bounce_b_down", "pressure_b_down"].include?(@state)
      dir = -1
    else
      dir = 0
    end
    case @down_type
    when "N"
       if @me.now_y_speed.abs >= 13.9 # 彈起
        @me.y_pos += (@me.now_y_speed *= -2/5.0).round
        @me.x_pos += (@me.now_x_speed *= 3/5.0).round
        @knock_back_duration += 5
         (dir == 1) ? change_anime("bounce_f_down") : change_anime("bounce_b_down")
       else  # 倒地
         @me.now_x_speed /= 2
         @me.now_y_speed = 0 
         (dir == 1) ? change_anime("f_down") : change_anime("b_down")
          # 補正少50%
         @me.damage_correction = [@me.damage_correction - 50, 1].max
         @absolute_uncancel_time = 20
         @down_count = 20
      end
    when "H"
       dir == 1 ? change_anime("hf_down") : change_anime("hb_down")
       @down_count = 50
    when "P"
      @me.y_pos += (@me.now_y_speed *= -3/5.0).round
       (dir == 1) ? change_anime("pressure_f_down") : change_anime("pressure_b_down")
    when "B"
      (dir == 1) ? change_anime("bounce_f_down") : change_anime("bounce_b_down")
    end
    # 著地特效
    @me.animation.push([DOWN_ANIMATION_ID, true,0,0])
    @me.animation.push([LAND_ANIMATION_ID, true,0,0])
    @down_type = "N"
   # clear
  end
  
  #--------------------------------------------------------------------------
  # ◇ 倒地被打
  #--------------------------------------------------------------------------
  def do_down_damage(blow,dir,type = "N")
    clear # まずはクリア
    # AIをリセット
    @me.ai.clear
    @me.ai.do_next
    if blow == 2
       do_light_blow(dir, type)
    elsif blow >= 3
       do_hard_blow(dir, type)
    else
      appear_damage_voice(@me)
      do_down
    end
  end
  
  #--------------------------------------------------------------------------
  # ◇ 倒地被打
  #--------------------------------------------------------------------------
  def do_down_damage2
    clear # まずはクリア
    # AIをリセット
    @me.ai.clear
    @me.ai.do_next
     run_frame(@blow_d)
   end
   
   
  #--------------------------------------------------------------------------
  # ◇ 判定相交的處理
  # action：自身的行動
  # target：目標
  #--------------------------------------------------------------------------  
  def collision_process(action, target)
  end
  
  #--------------------------------------------------------------------------
  # ◇ 著地反彈
  #--------------------------------------------------------------------------
  def do_down_rebound
    case @action_name
    when "front_down"
      run_frame(@rebound_front)
    when "front_blow"
      run_frame(@rebound_front)
    when "back_down"
      run_frame(@rebound_back)
    when "back_blow"
      run_frame(@rebound_back)
    else
      run_frame(@rebound_front)
    end
    @me.body_rect = @me.down_body_rect
  end
  
  #--------------------------------------------------------------------------
  # ◇ 倒地起身(沒作用)
  #--------------------------------------------------------------------------
  def do_stand_up
    
     if @me.dead?
       @me.combohit_clear
       return
     end

    @blur_effect = false
    @me.combohit_clear #連段數歸0
    @absolute_uncancel_time = 8
    
    
    if @me.is_a?(Game_Actor)
      @eva_invincible_duration = 80 #無敵時間
    else
      @eva_invincible_duration = 9 #無敵時間
    end
    
   
    @me.body_rect = @me.stand_body_rect
    @super_armor = 10
    appear_standup_voice(@me)
    @counter_flag = false
    @now_full_count = 0
    case @action_name
    when "front_down"
      run_frame(@stand_front)
    when "back_down"
      run_frame(@stand_back)
    end
  end
  
  

  
  #--------------------------------------------------------------------------
  # ◇ 撞牆
  #--------------------------------------------------------------------------
  def do_collision_blow
    clear # まずはクリア
    # AIをリセット
    @me.ai.clear
    @me.ai.do_next
    @blur_effect = true

    #撞到會掛掉的話
    if (@me.hp - @me.maxhp * Scene_Battle::METEOR_SMASH_DAMAGE / 100) <= 0
       appear_dead_voice(@me)
     else #除外的情況
       appear_blow_voice(@me)
     end 
     @me.hp -= @me.maxhp * Scene_Battle::METEOR_SMASH_DAMAGE / 100 ##
     @me.damage = 0
     @me.damage_pop = true
     @knock_back_duration += 15
     $game_temp.superstop_time += 5
    # @hit_stop_duration = 10
    
     if ["parallel_f_blow", "parallel_b_blow"].include?(@state)
       @me.now_y_speed += 5.7
       @me.now_x_speed /= 3.0
     end
     if ["hf_blow", "hb_blow"].include?(@state)
       (@state == "hf_blow") ? change_anime("hb_blow") : change_anime("hf_blow")
     else
       dir = (["parallel_f_blow", "f_blow"].include?(@state) ? 1 : -1)
       (dir == 1) ? change_anime("b_blow") : change_anime("f_blow")
     end
     
     #(231..250) === @frame_number  ?   run_frame(@blow_h_b) : run_frame(@blow_n_b)
  end
  
  
  #--------------------------------------------------------------------------
  # ◇ 受身
  #--------------------------------------------------------------------------
  def do_ukemi

 #   clear # まずはクリア
    @me.body_rect = @me.stand_body_rect
    @me.combohit_clear  #連段數歸0
    @eva_invincible_duration = 12 #無敵時間
    @absolute_uncancel_time = 12
    @me.now_x_speed = 0
    @me.now_y_speed = 10
    @now_jumps   = @me.max_jumps
    @me.animation.push([9, true,0,0])
    appear_ukemi_voice(@me)
    @counter_flag = false
    @now_full_count = 0
    change_anime("ukemi")

  end
  
  #--------------------------------------------------------------------------
  # ◇ 受傷聲(戰鬥者，隨機值1~3)
  #  命名格式：戰鬥者名_damage隨機數1~3
  #  ex ： Slide_damage2
  #--------------------------------------------------------------------------
  def  appear_damage_voice(battler)
    rand = rand(3)+1
    battler_name = battler.battler_name_basic_form.to_s
    damage = "_damage" + ".wav"#+ rand.to_s + ".wav"
    if FileTest.exist?("Audio/SE/" + battler_name + damage) and @voice_cold <= 0
      
      Audio.se_play("Audio/SE/" + battler_name + damage, 100 * $game_config.se_rate / 10, 100) 
      @voice_cold = 16
      
     # @voice_playing_plan[1] = [battler_name + damage, 85, 100]
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 重度彈飛聲(戰鬥者，隨機值1~3)
  #  命名格式：戰鬥者名_blow隨機數1~3
  #  ex ： Slide_blow2
  #--------------------------------------------------------------------------
  def  appear_blow_voice(battler)
 #   battler_id = @me.id
  #  if @me.is_a?(Game_Enemy) 
   #   battler_id += 100
   # end
   appear_damage_voice(battler)
   return
   
   
    rand = rand(3)+1
    battler_name = battler.battler_name_basic_form.to_s
    blow = "_blow" + rand.to_s + ".wav"
    if FileTest.exist?("Audio/SE/" + battler_name + blow)
      @voice_playing_plan[1] = [battler_name + blow, 85, 100]
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 受身聲
  #  命名格式：戰鬥者名_ukemi隨機數1~2
  #  ex ： Slide_ukemi2
  #--------------------------------------------------------------------------
  def  appear_ukemi_voice(battler)
    rand = rand(2)+1
    battler_name = battler.battler_name_basic_form.to_s
    ukemi = "_ukemi" + rand.to_s + ".wav"
    if FileTest.exist?("Audio/SE/" + battler_name + ukemi)
      @voice_playing_plan[1] = [battler_name + ukemi, 85, 100]
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 起身聲
  #  命名格式：戰鬥者名_standup隨機數1~2
  #  ex ： Slide_standup2
  #--------------------------------------------------------------------------
  def  appear_standup_voice(battler)
    rand = rand(2)+1
    battler_name = battler.battler_name_basic_form.to_s
    standup = "_standup" + rand.to_s + ".wav"
    if FileTest.exist?("Audio/SE/" + battler_name + standup)
      @voice_playing_plan[1] = [battler_name + standup, 85, 100]
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 防禦被打聲
  #  命名格式：戰鬥者名_guard隨機數1~2
  #  ex ： Slide_guard2
  #--------------------------------------------------------------------------
  def  appear_guard_voice(battler)
    rand = rand(2)+1
    battler_name = battler.battler_name_basic_form.to_s
    guard = "_guard" + rand.to_s + ".wav"
    if FileTest.exist?("Audio/SE/" + battler_name + guard)
      @voice_playing_plan[1] = [battler_name + guard, 85, 100]
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 勝利語音
  #  命名格式：戰鬥者名_win隨機數1~3
  #  ex ： Slide_win2
  #--------------------------------------------------------------------------
  def  appear_win_voice(battler)
    rand = rand(3)+1
    battler_name = battler.battler_name_basic_form.to_s
    win = "_win" + rand.to_s + ".wav"
    if FileTest.exist?("Audio/SE/" + battler_name + win)
      @voice_playing_plan[1] = [battler_name + win, 85, 100]
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 快掛了的勝利語音
  #  命名格式：戰鬥者名_win_pinch隨機數1~2
  #  ex ： Slide_win_pinch2
  #--------------------------------------------------------------------------
  def  appear_winpinch_voice(battler)
    rand = rand(2)+1
    battler_name = battler.battler_name_basic_form.to_s
    winpinch = "_win_pinch" + rand.to_s + ".wav"
    if FileTest.exist?("Audio/SE/" + battler_name + winpinch)
      @voice_playing_plan[1] = [battler_name + winpinch, 85, 100]
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 陣亡語音
  #  命名格式：戰鬥者名_dead隨機數1~2
  #  ex ： Slide_dead2
  #--------------------------------------------------------------------------
  def  appear_dead_voice(battler)
    rand = rand(2)+1
    @voice_cold = 10
    battler_name = battler.battler_name_basic_form.to_s
    dead = "_dead" + ".wav"#+ rand.to_s + ".wav"
    if FileTest.exist?("Audio/SE/" + battler_name + dead) and not @appeared_dead_voice
      Audio.se_play("Audio/SE/" + battler_name + dead, 85 * $game_config.se_rate / 10, 100)
      @appeared_dead_voice = true
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 迴避語音
  #  命名格式：戰鬥者名_flee隨機數1~2
  #  ex ： Slide_flee2
  #--------------------------------------------------------------------------
  def  appear_flee_voice(battler)
    rand = rand(2)+1
    battler_name = battler.battler_name_basic_form.to_s
    flee = "_flee" + rand.to_s + ".wav"
    if FileTest.exist?("Audio/SE/" + battler_name + flee)
      @voice_playing_plan[1] = [battler_name + flee, 85, 100]
    end
  end
  

  #--------------------------------------------------------------------------
  # ◇ アイテム使用硬直
  #--------------------------------------------------------------------------
  def do_use_item
    @frame_duration    = 36
    @selfanimation_plan[ 1] = 25
    #@attack_motion_plan = [341,nil,342,nil,343,nil,344,nil,345,nil,346,nil,347,nil,348,nil,349,nil,350,nil,351,nil,352,nil,353,nil,354,nil,355,nil,356]
  end
  #--------------------------------------------------------------------------
  # ◇ 勝利動作(主要)
  #--------------------------------------------------------------------------
  def do_won_cry
    if @me.hp * 3 < @me.maxhp
      #@attack_motion_plan = [981,982,983,984,985]
      appear_winpinch_voice(@me)
    else
    #  @attack_motion_plan = [991,992,993,994,995]
      appear_win_voice(@me)
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 勝利動作(其他)
  #--------------------------------------------------------------------------
  def do_won_pose
    if @me.hp * 3 < @me.maxhp
    #  @attack_motion_plan = [981,982,983,984,985]
    else
   #   @attack_motion_plan = [991,992,993,994,995]
    end
  end
  
  
  
  
  #--------------------------------------------------------------------------
  # ◇ 實行動作
  #       action：出招
  #       command：指令(預約紀錄用)
  #       type：Z普攻、X超必殺、C迴避、chase追擊
  #       derive：派生動作
  #       force_cost：強制消耗30sp
  #       sp_cost：消耗sp
  #--------------------------------------------------------------------------
  def do_act(action, command, type, derive = false, force_cost = false, sp_cost = 0)

    # 定格中終止
    return false if static?

    # 用同一招終止
    return false if (action == @state)
    return false if @hit_invincible_duration > 0
    # 還在不能取消硬直的情況
    
    
    # 情況1(防禦時)
    if guarding? and @knock_back_duration > 0
      # 預約指令
      @command_plan = command
      @command_plan_count = 3
      return false
    end
    
    
    # 不能操作時終止
    return false unless controllable?
    
    # 情況2
    if @uncancel_flag
      unless action.include?("chase")
         # 預約指令
        @command_plan = command
        @command_plan_count = 3
      end
      return false
    end
    
    # 情況3(只有往後迴避可無視該硬直)
    if @absolute_uncancel_time > 0  and  action != "b_chase"
     return false if @absolute_uncancel_time > 5
      # 預約指令
     @command_plan = command
     @command_plan_count = 4
      return false
    end

    
    # 疾速效果
    no_cost = true if (@me.ability.include?(6) and rand(10) > 2)
    # 攻擊中
    if (x_skill? and !derive) or force_cost# 超必殺技的情況  
      if  (@me.sp < (sp_cost + 10) and !no_cost)
        return false
      else
        $game_temp.black_time = [50,50]  if (20 > $game_temp.black_time[0])
        # 設定集中線
        $scene.focus_plan[0] = 3
        $scene.focus_plan[4] = 3
        @me.sp -= 10 if (@me.maxsp <= 300 and !no_cost)
        Audio.se_play("Audio/SE/swing", 93 * $game_config.se_rate / 10, 116) 
        @blur_effect = true
        # 設定鏡頭
        $scene.camera_feature = [45,40,40]
      end
    end
    # 追擊動作中  
    if action.include?("chase")
      $game_temp.superstop_time += 5
      @supermove_time += 5
      $game_temp.black_time = [20,50]  if (20 >  $game_temp.black_time[0])
      release_catching_target
    end  
    
    # 檢查sp是否可使用技能
    return false if @me.sp < sp_cost
    #
    #
    # 確定可實行後，初始指定變數
    #
    #

    @eva_invincible_duration = 0
    @attack_rect  = [] # 範圍
    @me.now_x_speed /= 10 unless on_air?  # 地面時，x速度減少
    @me.sp -=  sp_cost if @me.maxsp <= 300# 減少sp
    @penetrate = false
    @me.edge_spacing = 0
    
    @me.direction *= -1 if ["4z", "4x"].include?(command)
    
    @physical = true
    @y_fixed = false
    
     change_anime(action) # 實行動作
     
     case @state
     when z_skill?
       @me.ai.combohold_count += 1
     when x_skill?
       @me.ai.combohold_count += 3
     end
     
     if !@me.is_a?(Game_BattleBullet)
      @me.ai.guard_time = 0
      @me.ai.contact_time = 0 
      @me.ai.hit_time = 0
     end
     
    
     
     # 累計取消數
     if @me.is_a?(Game_Actor) and attacking?
       @me.chain_count += 1
     end
     
     
     
     @me.ai.combo_list.push(action)
    # @action_name = action_name
     # 成功實行
     return true  
     
  #  if @me.is_a?(Game_Actor) or @me.is_a?(Game_Enemy)
  #    @me.ai.do_next
   # end
    

 end
 
 
 
  #--------------------------------------------------------------------------
  # ◇ 攻擊效果設定
  #      power：威力    
  #      correction：追加補正
  #      limit：最低傷害
  #      scope：有效範圍("Landing"：地面有效、"Air"：空中有效、"Blow"：擊飛狀態有效、"Down"：倒地有效，預設前三者)
  #      u_hitstop：命中時自己的作用力
  #      t_hitstop：命中時對方的作用力
  #      t_knockback：對方的傷害硬直
  #      x_speed、y_speed ： 對方位移
  #      blow_type：擊飛類型 ("N"：一般、"H"：重擊、"P"：平行、"V"：垂直、"D"：倒地壓制、"None"：不擊飛)
  #      down_type：倒地類型 ("N"：一般、"H"：重擊(摩擦地面)、"P"：壓制、"B"：反彈)
  #      d_se、g_se、ko_se：傷害、防禦、擊殺時的效果音 ["路徑名", 音量, 音調]
  #      anime：動畫ID
  #      hp_recover / sp_recover：命中時HP/SP恢復量
  #      h_zoom / d_zoom：打人 / 被打時畫面縮放    [時間, 鏡頭位置y, 鏡頭位置z]
  #      h_shake / d_shake：打人 / 被打時畫面震動     [力量, 速度, 時間, 類型]    
  #      catch_release：放掉被捉的人
  #      spark：打人時的火花 (0：撞擊、1：砍擊、-1：沒火花)
  #      element：攻擊屬性(未實裝)
  #      add_state：追加狀態 (著火、結冰、暈眩、時停)       (未實裝)
  #      common_event：觸發公用事件(未實裝)
  #      full_count：強制擊倒值(未實裝)
  #      hit_slide：板邊判定發生時後退速度
  #      t_state：強制指定對方狀態(動作)
  
  #      no_atk：攻擊無效(純偵測碰撞用)
  #      no_kill：不擊殺(HP鎖在1)
  #      no_guard：無法防禦
  
  #      skill_data：[state, 影格]，除錯用

  
  #    2013/12/19 ： 攻擊等級(level)移除、blow_type判定追加"None(不擊飛)" 
  #--------------------------------------------------------------------------  
  def skill_effect(skill, target)
    result = {"power" => 0, "limit" => 0, "scope" => ["Landing", "Air", "Blow"], "hit_slide" => 5, "correction" => 3,
                 "u_hitstop" => 0, "t_hitstop" => 0, "t_knockback" => 0,
                 "x_speed" => 0, "y_speed" => 0,  "blow_type" => "N", "down_type" => "N",
                 "d_se" => [], "g_se" => ["Audio/SE/guard_se", 80, 110], "ko_se" => [], "anime" => 3, "spark" => [0, 5*rand(10), 9*(rand(6)+1)+30], "hp_recover" => 1, "sp_recover" => 0,
                 "h_zoom" => [0,0,0], "d_zoom" => [0,0,0], "h_shake" => [0,0,0,0], "d_shake" => [0,0,0,0],
                 "catch_release" => true, 
                 "element" => [1], "add_state" => 0, "common_event" => 0, "full_count" => 1, "t_state" => nil, "skill_data" => [skill, @frame_number], "no_atk" => false, "no_kill" => false, "no_guard" => false}
    return result
  end
end
