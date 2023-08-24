#==============================================================================
# ■ Scene_BattlerOffestEdit
#------------------------------------------------------------------------------
# 　角色戰鬥圖原點編輯界面。
#==============================================================================

class Scene_BattlerOffestEdit
  
 # ==== 方便用的自定義設置↓
 
  # 戰鬥圖最大數目
  PICTURE_LIMIT = Game_Motion::PICTURE_LIMIT     #999
  # 輸出目錄(要在專案根目錄下用空字符："" )
  FILE = "Offset_Output/"
  # 輸出內容每行開頭要留多少空白
  BLANK = "   "
  # 開啟遊戲直接進入編輯畫面
  FROM_TITLE = false # false    true
  # 輸出的數組形式
  # 1：多行式，只輸出設定過的(不輸出nil和預設值)
  # 2：一行式，把整串數組輸出
  OUTPUT_TYPE = 1 
  
  

  
  
  #--------------------------------------------------------------------------
  # ● 設定輸出時的數組名稱
  #--------------------------------------------------------------------------
  def load_output_array_name(battler)
    case battler.id
    when 1
      array_start = "REDS_ORIGIN"
    when 2
      array_start = "REDH_ORIGIN"
    when 3
      array_start = "REDB_ORIGIN"
    when 10
      array_start = "CoralsFinal_ORIGIN"
    end
    return array_start
  end
  #--------------------------------------------------------------------------
  # ● 載入模組
  #--------------------------------------------------------------------------
  def load_battler_motion(battler)
    case battler.name
    when "Red_Sickle"
      @battler.motion_setup(1)
    when "Red_Hunter"
      @battler.motion_setup(2)
    when "Red_Beast"
      @battler.motion_setup(3)
    when "CoralsFinal"
      @battler.motion_setup(10)
    else
      p "設定怪怪的，怎麼會選到不存在的人，程序終止囉"
      exit
    end
  end
  
  # ==== 方便用的自定義設置↑
  
  #--------------------------------------------------------------------------
  # ● 變量公開
  #--------------------------------------------------------------------------
  attr_reader :offset_edit_result_temp
  #--------------------------------------------------------------------------
  # ● 主處理
  #--------------------------------------------------------------------------
  def main
    
    # 沒有設好資料夾的情況，避免做老半天結果因為這樣被洗掉
    unless FileTest.exist?(FILE)
      p "未建立保存資料夾 #{FILE}，回到標題畫面"
      $scene = Scene_Title.new
      return
    end
    
   if FROM_TITLE 
    # 載入資料庫
      $data_actors        = load_data("Data/Actors.rxdata")
      $data_classes       = load_data("Data/Classes.rxdata")
      $data_skills        = load_data("Data/Skills.rxdata")
      $data_items         = load_data("Data/Items.rxdata")
      $data_weapons       = load_data("Data/Weapons.rxdata")
      $data_armors        = load_data("Data/Armors.rxdata")
      $data_enemies       = load_data("Data/Enemies.rxdata")
      $data_troops        = load_data("Data/Troops.rxdata")
      $data_states        = load_data("Data/States.rxdata")
      $data_animations    = load_data("Data/Animations.rxdata")
      $data_tilesets      = load_data("Data/Tilesets.rxdata")
      $data_common_events = CommonEventsManager.new #load_data("Data/CommonEvents.rxdata")
      $data_system        = load_data("Data/System.rxdata")

    # 產生系統物件
      $game_system = Game_System.new
      $game_temp          = Game_Temp.new
      $game_switches      = Game_Switches.new
      $game_variables     = Game_Variables.new
      $game_actors        = Game_Actors.new
      $game_party         = Game_Party.new
      # 設定初期同伴
      $game_party.setup_starting_members
    end
    
    # 狀態
    @scene_state = 0  
    # 編輯中角色
    @battler = nil
    @now_form_id = 0
    # 運行動畫時需要的變數
    @frame_duration = 0
    @next_frame = 0
    @pre_frame = 0
    @frame_number = 0
    @anime = nil
    @state = nil
    # 動畫延遲
    @anime_delay = 0
    # 動畫暫停
    @anime_pause = false
    
    # 記憶設定過的原點(原點暫存變數)
    @offset_edit_result_temp = []
    # 角色原點編輯區塊
    @offset_edit_viewport = Viewport.new(20, 20, 320, 480)
    @battler_offset_editor = Sprite.new(@offset_edit_viewport)
    # 原點編輯游標生成
    @edit_cursor = Sprite.new(@offset_edit_viewport)
    @edit_cursor.bitmap = RPG::Cache.windowskin("offset_edit_cursor") 
    @edit_cursor.ox = @edit_cursor.bitmap.width/2 + 1
    @edit_cursor.oy = @edit_cursor.bitmap.height
    

    # 角色動畫預覽區塊
    @anime_viewport = Viewport.new(0, 240, 640, 240)
    @battler_anime = Sprite_Battler.new(@anime_viewport)
    @anime_hash = []
    # 指示動畫原點的游標
    @anime_cursor = Sprite.new(@anime_viewport)
    @anime_cursor.bitmap = RPG::Cache.windowskin("offset_edit_cursor") 
    @anime_cursor.ox = @anime_cursor.bitmap.width/2 + 1
    @anime_cursor.oy = @anime_cursor.bitmap.height
    @anime_cursor.z = 50
    
  

    
    # 選擇角色指令視窗
    select_actor = []
    for a in 0...$game_party.actors.size
      select_actor.push($game_party.actors[a].name)
    end
    @command_select_battler = Window_Command.new(80, select_actor)
    @command_select_battler.x = 560
    @command_select_battler.active = true

    
  # 預覽目前在編輯區上的座標視窗
    @window_offset_view = Window_Base.new(461,0,96,64)
    @window_offset_view.contents = Bitmap.new(@window_offset_view.width - 32, @window_offset_view.height - 32)
    
    # 動畫延遲數值視窗
    @anime_delay_view = Window_Base.new(540, 65,100,64)
    @anime_delay_view.contents = Bitmap.new(@anime_delay_view.width - 32, @anime_delay_view.height - 32)
    
    # 選擇角色圖像指令視窗
    @battler_sprite_temp = []
    @command_select_battler_sprite = Window_OffsetEdit_ChooseBattlerSprite.new
    @command_select_battler_sprite.x = 461
    @command_select_battler_sprite.y = 65

    
    # 預覽動畫目前用圖視窗
    @anime_sprite_id_view = Window_Base.new(411,240,64,64)
    @anime_sprite_id_view.contents = Bitmap.new(@anime_sprite_id_view.width - 32, @anime_sprite_id_view.height - 32)
    # 選擇預覽動畫指令視窗
    @command_select_anime = Window_OffsetEdit_ChoosePreAnime.new
    @command_select_anime.x = 480
    @command_select_anime.y = 240


    
    # 執行漸變
    Graphics.transition(20)
    # 主循環
    loop do
      # 更新遊戲畫面
      Graphics.update
      # 更新輸入訊息
      Input.update
      # 更新畫面情報
      update
      # 如果畫面被切換的話就中斷循環
      if $scene != self
        break
      end
    end
    # 準備過渡
    Graphics.freeze
    
    # 釋放
    @command_select_anime.dispose
    @command_select_battler_sprite.dispose
    @command_select_battler.dispose
    
    @battler_anime.dispose
    @battler_offset_editor.dispose
    @offset_edit_viewport.dispose
    @anime_viewport.dispose
    @edit_cursor.bitmap.dispose
    @edit_cursor.dispose
    @anime_cursor.bitmap.dispose
    @anime_cursor.dispose
    @window_offset_view.dispose
    @anime_sprite_id_view.dispose
    @anime_delay_view.dispose
    RPG::Cache.clear 
    
    
  end
  
  #--------------------------------------------------------------------------
  # ● 更新畫面
  #--------------------------------------------------------------------------
  def update
    case @scene_state
    when 0
       update_command_select_battler
    when 1
       update_command_battler_offset_edit
    when 2
       update_command_select_anime
     end
     
     if @command_select_battler.active
       @command_select_battler.opacity = 255
     else
       @command_select_battler.opacity = 80
     end
     
     if @command_select_battler_sprite.active
       @command_select_battler_sprite.opacity = 255
     else
       @command_select_battler_sprite.opacity = 80
     end
     
     if @command_select_anime.active
       @command_select_anime.opacity = 255
     else
       @command_select_anime.opacity = 80
     end
  end
  
  #--------------------------------------------------------------------------
  # ● 更新選擇角色指令窗
  #--------------------------------------------------------------------------
  def update_command_select_battler
    # 更新選擇角色指令窗
    @command_select_battler.update
    # 按下確定的情況
    if Input.trigger?(Input::C)
      # 演奏讀檔 SE
      $game_system.se_play($data_system.load_se)
      # 依選項位置獲取角色
      @battler = $game_party.actors[@command_select_battler.index]
      get_battler_information(@battler, @command_select_battler.index)
      
      # 切換至選擇動畫狀態
      @scene_state = 2
      @command_select_battler_sprite.active = false
      @command_select_anime.active = true

      # 場景切換為編輯原點狀態
     # @command_select_battler.active = false
    #  @command_select_battler_sprite.active = true
    #  @scene_state = 1
      # 刷新座標資訊
      refresh_offset_view
      # 刷新動畫延遲資訊
      refresh_anime_delay_view
    end

  end
  #--------------------------------------------------------------------------
  # ● 刷新座標視窗
  #--------------------------------------------------------------------------
  def refresh_offset_view(set = false)
    @window_offset_view.contents.clear
    @window_offset_view.contents.draw_text(0, 0, 64, 32, @edit_cursor.x.to_s + "," + @edit_cursor.y.to_s, 1)
    # 設定新原點
    if set 
     @offset_edit_result_temp[@now_form_id] = [@edit_cursor.x, @edit_cursor.y]
    end
  end
  #--------------------------------------------------------------------------
  # ● 刷新動畫用圖視窗
  #--------------------------------------------------------------------------
  def refresh_anime_sprite_id_view
    @anime_sprite_id_view.contents.clear
    @anime_sprite_id_view.contents.draw_text(0, 0, 32, 32, @battler.now_form_id.to_s, 1)
  end
  #--------------------------------------------------------------------------
  # ● 刷新動畫延遲視窗
  #--------------------------------------------------------------------------
  def refresh_anime_delay_view
    @anime_delay_view.contents.clear
    @anime_delay_view.contents.draw_text(0, 0, 68, 32, "Delay："+@anime_delay.to_s, 0)
  end
  #--------------------------------------------------------------------------
  # ● 取得角色資訊
  #      模組檔、圖像、圖像原點
  #--------------------------------------------------------------------------
  def get_battler_information(battler, index)
    # 載入模組
    load_battler_motion(battler)
    # 畫面凍結
    Graphics.freeze
    # 載入圖檔
    for pic_number in 1..PICTURE_LIMIT
      @battler.transgraphic(pic_number)
      # 如果圖檔存在，將目前的原點設定存入暫時變量
      if @battler.battler_graphic_exist?(pic_number) 
        bitmap = RPG::Cache.battler(@battler.battler_name, @battler.battler_hue)
        ori_width = bitmap.width
        ori_height = bitmap.height
        ox = @battler_anime.get_ox(@battler, @battler.now_form_id, ori_width)
        oy = @battler_anime.get_oy(@battler, @battler.now_form_id, ori_height)
        @offset_edit_result_temp[pic_number] = [ox,oy] 
        @battler_sprite_temp[pic_number] = pic_number
      end
    end
    
    # 預覽動畫部分
    @anime = @battler.motion.anime
    @state = @battler.motion.state
    @frame_duration = @battler.motion.frame_duration
    @next_frame = @battler.motion.next_frame
    @frame_number = @battler.motion.frame_number
    @battler_anime.battler = @battler
    @battler.x_pos = -200
    @battler.y_pos = 64
    # 預覽動畫部分－指令相關
    @anime_hash = @anime.keys
    @command_select_anime.refresh(@anime_hash)
    @command_select_anime.update
    
    # 進入編輯原點狀態
    $game_temp.offset_editing = true
    
    # 編輯區部分
    change_sprite(1)
   # edit_first = @battler.name+"_battler/"+@battler.name+"_001"
  #  @battler_offset_editor.bitmap = RPG::Cache.battler(edit_first, @battler.battler_hue)
    
    @command_select_battler_sprite.refresh(@now_form_id)
    
    # 游標位置設定
    @edit_cursor.x = @offset_edit_result_temp[@now_form_id][0]
    @edit_cursor.y = @offset_edit_result_temp[@now_form_id][1]
    # 畫面漸變
    Graphics.transition(10)
    
  end
  
  
  
  #--------------------------------------------------------------------------
  # ● 更新編輯狀態
  #--------------------------------------------------------------------------
  def update_command_battler_offset_edit
    
    @command_select_battler_sprite.update
    @battler_offset_editor.update
    # 動畫運作
    unless @anime_pause
      (@frame_duration == 0) ? update_anime(@next_frame) : @frame_duration -= 1
    end
    
    # 更新動畫預覽區
    @battler_anime.update

    
    
    # 移動游標
    case Input.dir8
    when 1
      @edit_cursor.x = [@edit_cursor.x-1, 0].max
      h_max = @battler_offset_editor.bitmap.height
      @edit_cursor.y = [@edit_cursor.y+1, h_max].min
      refresh_offset_view(true)
    when 2
      h_max = @battler_offset_editor.bitmap.height
      @edit_cursor.y = [@edit_cursor.y+1, h_max].min
      refresh_offset_view(true)
    when 3
      w_max = @battler_offset_editor.bitmap.width
      @edit_cursor.x = [@edit_cursor.x+1, w_max].min
      h_max = @battler_offset_editor.bitmap.height
      @edit_cursor.y = [@edit_cursor.y+1, h_max].min
      refresh_offset_view(true)
    when 4
      @edit_cursor.x = [@edit_cursor.x-1, 0].max
      refresh_offset_view(true)
    when 6
      w_max = @battler_offset_editor.bitmap.width
      @edit_cursor.x = [@edit_cursor.x+1, w_max].min
      refresh_offset_view(true)
    when 7
      @edit_cursor.x = [@edit_cursor.x-1, 0].max
      @edit_cursor.y = [@edit_cursor.y-1, 0].max
      refresh_offset_view(true)
    when 8
      @edit_cursor.y = [@edit_cursor.y-1, 0].max
      refresh_offset_view(true)
    when 9
      w_max = @battler_offset_editor.bitmap.width
      @edit_cursor.x = [@edit_cursor.x+1, w_max].min
      @edit_cursor.y = [@edit_cursor.y-1, 0].max
      refresh_offset_view(true)
    end
  
    # 上微調：K鍵被按下
    if Kboard.trigger?(75)
      @edit_cursor.y = [@edit_cursor.y-1, 0].max
      refresh_offset_view(true)
    end
    
    # 下微調：逗點鍵被按下
    if Kboard.trigger?(188)
      h_max = @battler_offset_editor.bitmap.height
      @edit_cursor.y = [@edit_cursor.y+1, h_max].min
      refresh_offset_view(true)
    end
    
    # 左微調：M鍵被按下
    if Kboard.trigger?(77)
      @edit_cursor.x = [@edit_cursor.x-1, 0].max
      refresh_offset_view(true)
    end
    
    # 右微調：句點鍵被按下
    if Kboard.trigger?(190)
      w_max = @battler_offset_editor.bitmap.width
      @edit_cursor.x = [@edit_cursor.x+1, w_max].min
      refresh_offset_view(true)
    end
    
    
 #   if Graphics.frame_count % 5 == 0  # 每過5畫格才進行一次避免換太快
    # Q鍵被按下
    if Kboard.repeat?(81) 
      # 播放游標音效
      $game_system.se_play($data_system.cursor_se)
      # 搜尋上一張可編輯的圖
      unless @now_form_id <= 1
        loop do
          @now_form_id -= 1
          if @battler_sprite_temp[@now_form_id] != nil
            break
          end
        end
        # 改變圖像
        change_sprite(@now_form_id)
        # 刷新圖像指令框
        @command_select_battler_sprite.refresh(@now_form_id)
        # 游標位置設定
       @edit_cursor.x = @offset_edit_result_temp[@now_form_id][0]
       @edit_cursor.y = @offset_edit_result_temp[@now_form_id][1]
       # 刷新座標預覽
       refresh_offset_view
      end
    end
    
    # W鍵被按下
    if Kboard.repeat?(87)   
      # 播放游標音效
      $game_system.se_play($data_system.cursor_se)
      # 搜尋下一張可編輯的圖
      unless @now_form_id >= @battler_sprite_temp.size - 1
        loop do
          @now_form_id += 1
          if @battler_sprite_temp[@now_form_id] != nil
            break
          end
        end
        # 改變圖像
        change_sprite(@now_form_id)
        # 刷新圖像指令框
        @command_select_battler_sprite.refresh(@now_form_id)
        # 游標位置設定
       @edit_cursor.x = @offset_edit_result_temp[@now_form_id][0]
       @edit_cursor.y = @offset_edit_result_temp[@now_form_id][1]
       # 刷新座標預覽
       refresh_offset_view
      end
    end
 #   end # if Graphics.frame_count % 5 == 0
    
    # 數字 3 被按下
    if Kboard.trigger?(51)
      # 演奏讀檔 SE
      $game_system.se_play($data_system.load_se)
      # 切換至選擇動畫狀態
      @scene_state = 2
      @command_select_battler_sprite.active = false
      @command_select_anime.active = true
    end
    
    
    # 數字 8 被按下
    if Kboard.trigger?(56)
      # 播放游標音效
      $game_system.se_play($data_system.cursor_se)
      # 動畫延遲減 1
      @anime_delay -= 1
      refresh_anime_delay_view
    end
    # 數字 9 被按下
    if Kboard.trigger?(57)
      # 播放游標音效
      $game_system.se_play($data_system.cursor_se)
      # 動畫延遲加 1
      @anime_delay += 1
      refresh_anime_delay_view
    end
    
    # P 鍵被按下
    if Kboard.trigger?(80)
      # 演奏讀檔 SE
      $game_system.se_play($data_system.load_se)
      # 切換動畫暫停
      @anime_pause = !@anime_pause
    end
    
    # ] 鍵被按下
    if Kboard.trigger?(221)
      # 播放游標音效
      $game_system.se_play($data_system.cursor_se)
      # 快進一格
      update_anime(@next_frame)
    end
    # [ 鍵被按下
    if Kboard.trigger?(219)
      # 播放游標音效
      $game_system.se_play($data_system.cursor_se)
      # 倒帶一格
      update_anime(@pre_frame)
    end
    
    
    # 確定被按下
  #  if Input.trigger?(Input::C)
      # 設定新原點
    #  @offset_edit_result_temp[@now_form_id] = [@edit_cursor.x, @edit_cursor.y]
   # end

    # 取消被按下
    if Input.trigger?(Input::B)
      # 演奏存檔 SE
      $game_system.se_play($data_system.save_se)
      # 輸出編輯資訊
      offset_data_output(@battler)
      @command_select_battler.active = true
      @command_select_battler_sprite.active = false
      p "新設定已輸出，請至專案主目錄查看"
     # 清空暫存資料 
     @offset_edit_result_temp.clear
     @battler_sprite_temp.clear
      # 清空快取
      RPG::Cache.clear 
      # 場景切換至選擇角色狀態
      @scene_state = 0
      
    end
    
  end
  
  
  #--------------------------------------------------------------------------
  # ● 更新選擇動畫狀態
  #--------------------------------------------------------------------------
  def update_command_select_anime
    @command_select_anime.update
    
    # 動畫運作
    unless @anime_pause
      (@frame_duration == 0) ? update_anime(@next_frame) : @frame_duration -= 1
    end
    
    # 更新動畫預覽區
    @battler_anime.update
    
    if Input.trigger?(Input::C)
      # 演奏確定 SE
      $game_system.se_play($data_system.decision_se)
      change_anime(@command_select_anime.animes[@command_select_anime.index])
    end
    
    # 按下取消或數字2
    if Input.trigger?(Input::B) or Kboard.trigger?(50)
      # 演奏取消 SE
      $game_system.se_play($data_system.cancel_se)
      @command_select_battler_sprite.active = true
      @command_select_anime.active = false
      # 場景切換至編輯原點狀態
      @scene_state = 1
    end
    
    # 數字 8 被按下
    if Kboard.trigger?(56)
      # 播放游標音效
      $game_system.se_play($data_system.cursor_se)
      # 動畫延遲減 1
      @anime_delay -= 1
      refresh_anime_delay_view
    end
    
    # 數字 9 被按下
    if Kboard.trigger?(57)
      # 播放游標音效
      $game_system.se_play($data_system.cursor_se)
      # 動畫延遲加 1
      @anime_delay += 1
      refresh_anime_delay_view
    end
    
    # P 鍵被按下
    if Kboard.trigger?(80)
      # 演奏讀檔 SE
      $game_system.se_play($data_system.load_se)
      # 切換動畫暫停
      @anime_pause = !@anime_pause
    end
    
    # ] 鍵被按下
    if Kboard.trigger?(221)
      # 播放游標音效
      $game_system.se_play($data_system.cursor_se)
      # 快進一格
      update_anime(@next_frame)
    end
    # [ 鍵被按下
    if Kboard.trigger?(219)
      # 播放游標音效
      $game_system.se_play($data_system.cursor_se)
      # 倒帶一格
      update_anime(@pre_frame)
    end
    
  end

  
  #--------------------------------------------------------------------------
  # ○ 切換動畫
  #      name ：  動畫名稱
  #--------------------------------------------------------------------------
  def change_anime(name)
    @state = name
    @next_frame = 0
    update_anime(@next_frame)
  end
  
  #--------------------------------------------------------------------------
  # ● 更新角色動畫
  #--------------------------------------------------------------------------
  def update_anime(frame)
    
    # 如果@next_frame是數組
    if frame.is_a?(Array)
      # 改變動畫
      @next_frame = 0
      return
    # 如果@next_frame是字串
    elsif frame.is_a?(String)
      # 執行與字串同名的方法
      @next_frame = 0
      return
    end
    
    # 設定圖片
   # @battler.transgraphic(@anime[@state][frame]["pic"])  if @anime[@state][frame]["pic"] != PICTURE_LIMIT
   
    transgraphic(@anime[@state][frame]["pic"])  if @anime[@state][frame]["pic"] != PICTURE_LIMIT
    # 設定換至下個影格的等待值
    @frame_duration = @anime[@state][frame]["wait"] + @anime_delay
    # 如果等待值是-1的話，強制指定為20
    @frame_duration = [20 + @anime_delay, 1].max if @frame_duration < 0
    
    # 設定下個影格
    @next_frame = @anime[@state][frame]["next"] 
    # 取得目前影格
    @frame_number = frame 
    # 取得上個影格
    @pre_frame = @frame_number - 1
    @pre_frame = @anime[@state].size - 1 if @pre_frame < 0
    
    
    @anime_cursor.x = @battler.screen_x #@offset_edit_result_temp[@battler.now_form_id][0] + @battler.screen_x
    @anime_cursor.y = @battler.screen_y#@offset_edit_result_temp[@battler.now_form_id][1] + @battler.screen_y
    
    refresh_anime_sprite_id_view
  end
  


  
  #--------------------------------------------------------------------------
  # ○ 變更戰鬥圖
  #      form_id : 新的圖像 ID
  #--------------------------------------------------------------------------
  def transgraphic(form_id)
    # 記憶目前的圖像 ID
    ori_form = @battler.now_form_id
    # 更新目前的圖像 ID
    @battler.now_form_id = form_id
    if form_id == 0
      # form_id是 0 的話，消除圖像
      @battler.battler_name = ""
      return
    else
      # 檢查圖檔是否存在
      if @battler.battler_graphic_exist?(form_id)
        # 存在的話，設定好要變換的圖像
        @battler.battler_name = @battler.form_id_to_name(form_id)
      else
        # 不存在的話，ID改回原本的
        @battler.now_form_id = ori_form
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # ○ 變更戰鬥圖(編輯區用)
  # 　 form_id : 新的圖像 ID
  #--------------------------------------------------------------------------
  def change_sprite(form_id)
    # 記憶目前的圖像編號
    ori_form = @now_form_id
    
    # 更新目前的圖像 ID
    @now_form_id = form_id
    if form_id == 0
      # form_id是 0 的話，消除圖像
      bitmap = ""
      return
    else
      # 檢查圖檔是否存在
      if @battler.battler_graphic_exist?(form_id)
        # 存在的話，設定好要變換的圖像
        bitmap = @battler.form_id_to_name(form_id)
      else
        # 不存在的話，ID改回原本的
        @now_form_id = ori_form
      end
    end
    # 叫出圖檔
    @battler_offset_editor.bitmap = RPG::Cache.battler(bitmap, @battler.battler_hue)
  end
  
  #--------------------------------------------------------------------------
  # ● 將編輯內容輸出成文字檔
  #--------------------------------------------------------------------------
  def offset_data_output(battler)
    
    
    
    # 設定數組名稱
    array_start = load_output_array_name(battler)
    
    # 照設定模式輸出(1：多行輸出、2：單行輸出)
    case OUTPUT_TYPE
    when 1  
      # 宣告一開始的輸出文字
      data = BLANK + array_start + " = []\n"
      for i in 0...@offset_edit_result_temp.size
        # 如果數組內容為空，跳過
        if @offset_edit_result_temp[i] == nil
          next
        end
        # 如果是用預設的"取圖片寬/2, 圖片高"當原點，跳過
        bitmap_name = @battler.form_id_to_name(i)
        bitmap = RPG::Cache.battler(bitmap_name, @battler.battler_hue)
        if (bitmap.width/2 == @offset_edit_result_temp[i][0]) and (bitmap.height == @offset_edit_result_temp[i][1])
          next
        end
        # 寫入資料
        data += BLANK + array_start + "["+ i.to_s + "]" + " " + "=" + " "+ 
        "[" + @offset_edit_result_temp[i][0].to_s + "," + " " + @offset_edit_result_temp[i][1].to_s + "]"+"\n"
      end
    when 2  
      # 宣告一開始的輸出文字
      array = ""
      for i in 0...@offset_edit_result_temp.size
        if i != (@offset_edit_result_temp.size - 1)
         blank = ", "
       else
         blank = ""
       end
       if  @offset_edit_result_temp[i] == nil
         array += "nil" + blank
       else
         array += "["+@offset_edit_result_temp[i][0].to_s+", "+@offset_edit_result_temp[i][1].to_s+"]" + blank
       end
      end
      data = BLANK + array_start + " = [" + array + "]"
    end
    
    

    
    
    
    
=begin
    # MP3 ループ対応 データスクリプト Ver XP_1.00\n" +
    "# 配布元・サポートURL\n" +
    "# http://members.jcom.home.ne.jp/cogwheel/\n" +
    "\n" +
    "#==============================================================================\n" +
    "# ■ Game_System\n" +
    "#------------------------------------------------------------------------------\n" +
    "# 　システム周りのデータを扱うクラスです。BGM などの管理も行います。このクラス\n" +
    "# のインスタンスは $game_system で参照されます。\n" +
    "#==============================================================================\n" +
    "\n" +
    "class Game_System\n" +
    "  #--------------------------------------------------------------------------\n" +
    "  # ● BGM の演奏\n" +
    "  #--------------------------------------------------------------------------\n" +
    "  def bgm_play(bgm)\n" +
    "    # 初期状態の設定\n" +
    "    name = \"Audio/BGM/\"\n" +
    "    vol = 1000\n" +
    "    start = 0\n" +
    "    loop = 0\n" +
    "    step = [0, 0]\n" +
    "    fin = 0\n" +
    "    # BGM 毎の設定\n" +
    "    if bgm != nil\n" +
    "      case bgm.name\n"
    
    # リストループ
    for name in @list
      if @type[name] > 0
        audio = name.sub(/(.+)\..*/) { $1 }
        data += "      when \"" + audio + "\"\n"
        data += "        type = \"" + @typs[@type[name]]+ "\"\n"
        data += "        start = " + @start[name].to_s + "\n"
        data += "        loop = " + @loop[name].to_s + "\n"
        data += "        fin = " + @fin[name].to_s + "\n"
      end
    end
    
    data += "      else\n" +
    "        name = name + bgm.name\n" +
    "        type = \"Normal\"\n" +
    "        vol = bgm.volume\n" +
    "      end\n" +
    "      # ネーム、ボリュームの再設定\n" +
    "      if type != \"Normal\"\n" +
    "        name = $game_audio.name?(name + bgm.name)\n" +
    "        vol = vol * bgm.volume / 100\n" +
    "      end\n" +
    "      $game_audio.bgm_play(name, type, vol, start, loop, step, fin)\n" +
    "    else\n" +
    "      # 現在の BGM の停止\n" +
    "      bgm_stop\n" +
    "    end\n" +
    "    @playing_bgm = bgm\n" +
    "  end\n" +
    "end\n"
=end
    #file = File.open(sprintf("CharaOffset_data%02d.txt", battler.id),'w')
    file = File.open(FILE+ battler.name + "_offset.txt",'w')
    file.puts data
    file.close

  end

  
  
  
end








#==============================================================================
# ■ Window_OffsetEdit_ChoosePreAnime
#------------------------------------------------------------------------------
# 　原點編輯畫面中，選擇預覽動畫的指令窗。
#==============================================================================

class Window_OffsetEdit_ChoosePreAnime < Window_Selectable
  #--------------------------------------------------------------------------
  # ● 公開變量
  #--------------------------------------------------------------------------
  attr_reader :animes
  #--------------------------------------------------------------------------
  # ● 初始化物件
  #     width    : 視窗的寬度
  #     animes : 動畫(Game_Motion的@anime)
  #--------------------------------------------------------------------------
  def initialize#(width, animes)
    # 由命令的個數計算出視窗的高度
    super(0, 0, 160, 5 * 32 + 32)
    @item_max = 1
    @column_max = 1
    @animes = []
    self.contents = Bitmap.new(width - 32, 5 * 32)
 #   refresh
    self.index = 0
    self.active = false
  #  self.visible = false
  end
  #--------------------------------------------------------------------------
  # ● 更新
  #      animes : 動畫(Game_Motion的@anime)
  #--------------------------------------------------------------------------
  def refresh(animes)
    self.contents.clear
    @animes = animes.sort
    
    @item_max = animes.size
    self.contents = Bitmap.new(width - 32, @item_max * 32)

    for i in 0...@item_max
      draw_item(i, normal_color)
    end
    @index = @animes.index("stand")
  end
  #--------------------------------------------------------------------------
  # ● 描繪項目
  #     index : 項目編號
  #     color : 文字色彩
  #--------------------------------------------------------------------------
  def draw_item(index, color)
    self.contents.font.color = color
    rect = Rect.new(4, 32 * index, self.contents.width - 8, 32)
    self.contents.fill_rect(rect, Color.new(0, 0, 0, 0))
    self.contents.draw_text(rect, @animes[index])
  end
end  
#==============================================================================
# ■ Window_OffsetEdit_ChooseBattlerSprite
#------------------------------------------------------------------------------
# 　原點編輯畫面中，選擇角色圖像的指令窗。
#==============================================================================

class Window_OffsetEdit_ChooseBattlerSprite < Window_Base
  #--------------------------------------------------------------------------
  # ● 初始化物件
  #     width    : 視窗的寬度
  #     sprites : 角色圖像數量
  #--------------------------------------------------------------------------
  def initialize#(width, sprites)
    # 由命令的個數計算出視窗的高度
    super(0, 0, 80,  64)
    @item_max = 1
    @column_max = 1
    self.contents = Bitmap.new(width - 32, height - 32)
   # refresh
    self.index = 0
    self.active = false
  end
  #--------------------------------------------------------------------------
  # ● 更新
  #      sprite_number: 角色圖像編號
  #--------------------------------------------------------------------------
  def refresh(sprite_number)
    self.contents.clear
    self.contents.draw_text(0,0,32,32, sprite_number.to_s, 1)
  end
  #--------------------------------------------------------------------------
  # ● 設置游標的位置
  #     index : 新的游標位置
  #--------------------------------------------------------------------------
  def index=(index)
    @index = index
    # 更新游標矩形
    update_cursor_rect
  end
  #--------------------------------------------------------------------------
  # ● 更新游標行
  #--------------------------------------------------------------------------
  def update_cursor_rect
    # 游標位置不滿 0 的情況下
    if @index < 0
      self.cursor_rect.empty
      return
    end
    # 計算游標的寬度
    cursor_width = self.width / @column_max - 32
    # 計算游標座標
    x = @index % @column_max * (cursor_width + 32)
    y = @index / @column_max * 32 - self.oy
    # 更新游標矩形
    self.cursor_rect.set(x, y, cursor_width, 32)
  end

  #--------------------------------------------------------------------------
  # ● 更新畫面(再定義)
  #--------------------------------------------------------------------------
  def update
    super
    # 更新游標矩形
    update_cursor_rect
  end
  
end










#==============================================================================
# ■ 補充的變量公開
#==============================================================================

class Game_Motion
  #--------------------------------------------------------------------------
  # ● 變量公開
  #--------------------------------------------------------------------------
    attr_reader :anime
    attr_reader :frame_duration
    attr_reader :next_frame
end


class Game_Temp
  #--------------------------------------------------------------------------
  # ● 變量公開
  #--------------------------------------------------------------------------
  attr_accessor :offset_editing          # 戰鬥圖原點編輯中
  #--------------------------------------------------------------------------
  # ● 初始化物件(一次性)
  #--------------------------------------------------------------------------
  alias offseteditor_initialize initialize
  def initialize
    offseteditor_initialize
    @offset_editing = false
  end
end

class Game_Battler
  #--------------------------------------------------------------------------
  # ● 定義實例變數
  #--------------------------------------------------------------------------
  attr_accessor   :battler_name             # 戰鬥者 檔案名稱
end




class Sprite_Battler < RPG::Sprite
  #--------------------------------------------------------------------------
  # ● 取得中心點
  #--------------------------------------------------------------------------
  alias offset_editor_get_ox get_ox
  def get_ox(battler, number, ori_width)
    
    # 編輯原點中
    if $game_temp.offset_editing and !$scene.offset_edit_result_temp[number].nil?
      # 圖片有左右翻轉
      if self.mirror
        return ori_width - $scene.offset_edit_result_temp[number][0]
      else 
        return $scene.offset_edit_result_temp[number][0]
      end
    end
    # 調用原方法
    offset_editor_get_ox(battler, number, ori_width)
  end
  #--------------------------------------------------------------------------
  # ● 取得立足點
  #--------------------------------------------------------------------------
  alias offset_editor_get_oy get_oy
  def get_oy(battler, number, ori_height)
    
    # 編輯原點中
    if $game_temp.offset_editing and !$scene.offset_edit_result_temp[number].nil?
      return $scene.offset_edit_result_temp[number][1]
    end
    # 調用原方法
    offset_editor_get_oy(battler, number, ori_height)
  end
end



class Scene_Title
  alias offset_editor_main main
  def main
    if Scene_BattlerOffestEdit::FROM_TITLE 
      $scene = Scene_BattlerOffestEdit.new
      return
    end
    offset_editor_main
  end
end
