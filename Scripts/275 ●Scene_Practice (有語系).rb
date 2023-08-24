#==============================================================================
# ■ Scene_Practice
#------------------------------------------------------------------------------
# 　練習模式選人的場景。
#==============================================================================

class Scene_Practice
    #--------------------------------------------------------------------------
  # ● 主處理
  #--------------------------------------------------------------------------
  def main
     # 選擇索引
    @list_index = 0
    
    # 可選對象清單
    @battlers_list = [1,4,5,6,14,11,12,13]
    
    # 追加
    if $game_config.cleared >= 1
      @battlers_list.push(30)
      @battlers_list.push(31)
    end
    @battlers_list.push(40) if $game_config.cleared >= 2
    @battlers_list.push(41) if $game_config.cleared >= 3
    @battlers_list.push(42) if $game_config.cleared >= 4

    # 說明
    @help = Window_Base.new(0,20,640,96)
    @help.opacity = 0
    @help.contents = Bitmap.new(@help.width - 32, @help.height - 32)
    @help.contents.font.color.set(255,255,0)
    @help.contents.font.size = 28
    case $game_config.language
    # ======== 繁中 
    when "tw"
       @help.contents.draw_text(0,0,640-32,64, "選擇要練習的對象：", 1)
    # ======== 英文 
    when "en"
     @help.contents.draw_text(0,0,640-32,64, "Please choose an enemy you want to practice with：", 1)
    # ======== 西班牙文
    when "es"
      @help.contents.draw_text(0,0,640-32,64, "Elige un enemigo con el que practicar：", 1)
    # ======== 其他  
    else
      @help.contents.draw_text(0,0,640-32,64, "選擇要練習的對象：", 1)
    end
   
    
    
    # 顯示左右箭頭
    @battler_window = Window_Base.new(0,0,640,400)
    @battler_window.opacity = 0
    @battler_window.contents = Bitmap.new(@battler_window.width, @battler_window.height - 32)
 #   @battler_window.contents.draw_text(-500,0,600,64, " ", 0)
    @battler_window.ox += 20
    
    # 取得戰鬥者資料
    @battler = $data_enemies[@battlers_list[@list_index]]
    

    
    
    # 顯示戰鬥圖
    @battler_sprite = Sprite.new
    @battler_sprite.bitmap = RPG::Cache.battler(@battler.battler_name, @battler.battler_hue)
    @battler_sprite.x = 320
    @battler_sprite.y = 460
    @battler_sprite.ox = @battler_sprite.bitmap.width / 2
    @battler_sprite.oy = @battler_sprite.bitmap.height 

    # 顯示名稱
    @name_window = Window_Base.new(640-180,360,320,120)
    @name_window.opacity = 0
    @name_window.contents = Bitmap.new(@name_window.width - 32, @name_window.height - 32)
    @name_window.contents.font.color.set(255,255,0)
    @name_window.contents.font.size = 22
    @name_window.contents.draw_text(0,0,320-32,64, "#{@battler.name}", 0)

    # 執行漸變
    Graphics.transition
    
    # 主循環
    loop do
      # 更新遊戲畫面
      Graphics.update
      # 更新輸入訊息
      Input.update
      # 更新畫面
      update
      # 如果畫面切換的話就中斷循環
      if $scene != self
        break
      end
    end
    # 準備過渡
    Graphics.freeze
    
   @help.dispose
   @battler_window.dispose
   @battler_sprite.dispose
   @name_window.dispose
    
  end
  


  
  #--------------------------------------------------------------------------
  # ● 更新畫面
  #--------------------------------------------------------------------------
  def update

    # 左選
    if Input.trigger?(Input::LEFT)
      $game_system.se_play($data_system.cursor_se)
      if @list_index == 0
        @list_index = @battlers_list.size - 1
      else
        @list_index -= 1
      end
      refresh(@list_index)
    end
      
    # 右選
    if Input.trigger?(Input::RIGHT)
      $game_system.se_play($data_system.cursor_se)
      if @list_index == @battlers_list.size - 1
        @list_index = 0
      else
        @list_index += 1
      end
      refresh(@list_index)
    end  
      
    
    # 決定
    if  Input.trigger?(Input::C)  
      $game_temp.practice_battler = @battlers_list[@list_index]
      $game_system.se_play($data_system.decision_se)
      $scene = Scene_Map.new
    end

    # 按下 B 鍵的情況下
    if Input.trigger?(Input::B)
      $game_temp.practice_battler = 0
      $game_system.se_play($data_system.cancel_se)
      $scene = Scene_Map.new
    end
    
  end
  
  #--------------------------------------------------------------------------
  # ● 刷新圖像、名稱
  #--------------------------------------------------------------------------
  def refresh(index)
    
    # 取得戰鬥者資料
    @battler = $data_enemies[@battlers_list[index]]
    
    # 重新產生圖片
    @battler_sprite.bitmap = RPG::Cache.battler(@battler.battler_name, @battler.battler_hue)
    @battler_sprite.ox = @battler_sprite.bitmap.width / 2
    @battler_sprite.oy = @battler_sprite.bitmap.height 
    # 重新產生名稱
    @name_window.contents.clear
    @name_window.contents.draw_text(0,0,320-32,64, "#{@battler.name}", 0)
  end
  
end
