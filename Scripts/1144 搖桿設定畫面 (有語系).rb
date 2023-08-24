#==============================================================================
# ■ Scene_PadConfig
#------------------------------------------------------------------------------
# 進行搖桿設定的場景
#==============================================================================

class Scene_PadConfig  
  #--------------------------------------------------------------------------
  # ● 初始化物件
  #--------------------------------------------------------------------------
  def initialize(return_call)
    @return_call = return_call
  end
  
  #--------------------------------------------------------------------------
  # ● Main處理
  #--------------------------------------------------------------------------
  def main
    @window = WindowKeyPadConfig.new(1, @return_call)
    # 執行過渡
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
    @window.dispose
  end
  
  #--------------------------------------------------------------------------
  # ● 定期處理
  #--------------------------------------------------------------------------
  def update
    @window.update
  end
  
end #class end




#==============================================================================
# ■ 背景視窗
#==============================================================================
class Window_PadConfig_BG < Window_Base
  #--------------------------------------------------------------------------
  # ● 初始化物件
  #--------------------------------------------------------------------------
  def initialize
    super(0, 64, 640,416)
    self.contents = Bitmap.new(width - 32, height - 32)
    case $game_config.language
    # ======== 繁中
    when "tw"
      self.contents.draw_text(12, 88, 110, 42, "左")
      self.contents.draw_text(12, 130, 110, 42, "右")
      self.contents.draw_text(12, 172, 110, 42, "上/跳躍")
      self.contents.draw_text(12, 214, 110, 42, "下/蹲下")
      self.contents.draw_text(242, 88, 110, 42, "普通攻擊")
      self.contents.draw_text(242, 130, 110, 42, "必殺技")
      self.contents.draw_text(242, 172, 110, 42, "防禦")
      self.contents.draw_text(242, 214, 180, 42, "切換成芮德兒")
      self.contents.draw_text(242, 256, 180, 42, "切換成法蜜莉歐")
      self.contents.draw_text(242, 298, 180, 42, "切換成卡麥莉亞")
    # ======== 英文 
    when "en"
      self.contents.draw_text(12, 88, 110, 42, "Left")
      self.contents.draw_text(12, 130, 110, 42, "Right")
      self.contents.draw_text(12, 172, 110, 42, "Jump")
      self.contents.draw_text(12, 214, 110, 42, "Crouch")
      self.contents.draw_text(242, 88, 110, 42, "Attack")
      self.contents.draw_text(242, 130, 110, 42, "Skill")
      self.contents.draw_text(242, 172, 110, 42, "Defense")
      self.contents.draw_text(242, 214, 180, 42, "Change to Red")
      self.contents.draw_text(242, 256, 180, 42, "Change to Vermilion")
      self.contents.draw_text(242, 298, 180, 42, "Change to Camellia")
    # ======== 西班牙文
    when "es"
      self.contents.draw_text(12, 88, 110, 42, "Izquierda")
      self.contents.draw_text(12, 130, 110, 42, "Derecha")
      self.contents.draw_text(12, 172, 110, 42, "Arriba/Saltar")
      self.contents.draw_text(12, 214, 110, 42, "Abajo/Agacharse")
      self.contents.draw_text(242, 88, 110, 42, "Atacar")
      self.contents.draw_text(242, 130, 110, 42, "Técnica")
      self.contents.draw_text(242, 172, 110, 42, "Bloquear")
      self.contents.draw_text(242, 214, 180, 42, "Cambiar a Red")
      self.contents.draw_text(242, 256, 180, 42, "Cambiar a Vermillion")
      self.contents.draw_text(242, 298, 180, 42, "Cambiar a Camellia")
    # ======== 其他  
    else
      self.contents.draw_text(12, 88, 110, 42, "左")
      self.contents.draw_text(12, 130, 110, 42, "右")
      self.contents.draw_text(12, 172, 110, 42, "上/跳躍")
      self.contents.draw_text(12, 214, 110, 42, "下/蹲下")
      self.contents.draw_text(242, 88, 110, 42, "普通攻擊")
      self.contents.draw_text(242, 130, 110, 42, "必殺技")
      self.contents.draw_text(242, 172, 110, 42, "防禦")
      self.contents.draw_text(242, 214, 180, 42, "切換成芮德兒")
      self.contents.draw_text(242, 256, 180, 42, "切換成法蜜莉歐")
      self.contents.draw_text(242, 298, 180, 42, "切換成卡麥莉亞")
    end
    

  end
end


#==============================================================================
# ■ 選擇欲修改的按鍵
#==============================================================================
class Window_Edit_pad < Window_Base
  #--------------------------------------------------------------------------
  # ● 公開變量
  #-------------------------------------------------------------------------- 
  attr_reader   :index                    # 游標位置
  attr_accessor :help_window              # 說明視窗
  #--------------------------------------------------------------------------
  # ● 鍵值對應說明
  #-------------------------------------------------------------------------- 
  KEY_DATA = {1=>"A", 2=>"B", 4=>"X", 8=>"Y", 16=>"L1", 32=>"R1", 64=>"SELECT", 
                          128=>"START",   256=>"L3", 512=>"R3", 1024=>"L2", 2048=>"R2"}
                          
                          
  KEY_LIST = ["Z", "X", "C", "CHANGE", "CHANGE2", "CHANGE3", "CHECK"]                         
                          
  COMMAND_DATA = {
    "tw" => ["普通攻擊", "必殺技", "防禦", "切換成芮德兒", "切換成法蜜莉歐", "切換成卡麥莉亞", "調查"],
    "en" => ["Attack", "Skill", "Defense", "Change to Red", "Change to Vermilion", "Change to Camellia", "Check"],
    "es" => ["Atacar", "Técnica", "Bloquear", "Cambiar a Red", "Cambiar a Vermillion", "Cambiar a Camellia", "Cheque"]
  }
  HEIGHT = 36
  #--------------------------------------------------------------------------
  # ● 初始化物件
  #-------------------------------------------------------------------------- 
   def initialize(return_call)
     super(0, 64, 640,416)
     self.contents = Bitmap.new(width - 32, height - 32)
     @item_max = KEY_LIST.size + 2  # 7 #項目數(要編輯的按鍵+還原預設+確定)
  #   self.opacity = 0#130
     self.active = true
     self.index = 0
     self.z = 99999
     @mode = 0
     @pad_id = 0
     @temp_set = $game_config.battle_pad.dup
     @return_call = return_call
     refresh
   end
  #--------------------------------------------------------------------------
  # ● 刷新
  #-------------------------------------------------------------------------- 
  def refresh
    self.contents.clear
    self.contents.font.color = crisis_color
    
    x = 120
    y = 0
    
    key_name_list = COMMAND_DATA[$game_config.language]
    
    KEY_LIST.size.times {|t|
      key = KEY_LIST[t]
      key_name = key_name_list[t]
      self.contents.font.color = normal_color
      self.contents.draw_text(x, y, 360, HEIGHT, key_name)
      self.contents.font.color = crisis_color
      self.contents.draw_text(x, y, 360, HEIGHT, KEY_DATA[$game_config.battle_pad[key]], 2)
      y += HEIGHT
    }
    
    
=begin    
    self.contents.draw_text(352, 88, 80, 42, KEY_DATA[$game_config.battle_pad["Z"]],2)
    self.contents.draw_text(352, 130, 80, 42, KEY_DATA[$game_config.battle_pad["X"]],2)
    self.contents.draw_text(352, 172, 80, 42, KEY_DATA[$game_config.battle_pad["C"]],2)
    self.contents.draw_text(352, 214, 80, 42, KEY_DATA[$game_config.battle_pad["CHANGE"]],2)
    self.contents.draw_text(352, 256, 80, 42, KEY_DATA[$game_config.battle_pad["CHANGE2"]],2)
    self.contents.draw_text(352, 298, 80, 42, KEY_DATA[$game_config.battle_pad["CHANGE3"]],2)
=end    
    self.contents.font.color = normal_color
    case $game_config.language
    # ======== 繁中
    when "tw"
      self.contents.draw_text(x, y, 360, HEIGHT, "還原預設",1)
     # self.contents.draw_text(478, 342, 120, 42,"修改完畢",1)
      y += HEIGHT
      self.contents.draw_text(x, y, 360, HEIGHT,"修改完畢",1)
    # ======== 英文 
    when "en"
      self.contents.draw_text(x, y, 360, HEIGHT, "Default",1)
   #   self.contents.draw_text(478, 342, 120, 42,"Done",1)
      y += HEIGHT
      self.contents.draw_text(x, y, 360, HEIGHT,"Done",1)
    # ======== 西班牙文
    when "es"
      self.contents.draw_text(x, y, 360, HEIGHT, "Defecto",1)
     # self.contents.draw_text(478, 342, 120, 42,"Done",1)
      y += HEIGHT
      self.contents.draw_text(x, y, 360, HEIGHT,"Done",1)
    # ======== 其他  
    else
      self.contents.draw_text(x, y, 360, HEIGHT, "Default")
      y += HEIGHT
      self.contents.draw_text(x, y, 360, HEIGHT,"Done",1)
    end
    
  end
  
  
  #--------------------------------------------------------------------------
  # ● 修改按鍵
  #-------------------------------------------------------------------------- 
  def edit_key_value(key, value)
    # 無效鍵值時中斷
    unless KEY_DATA.include?(value)
      p "偵測到無效鍵值 #{value}，不過不影響執行" if $DEBUG
      return 
    end
    $game_config.battle_pad[key] = value
    refresh
  end
  #--------------------------------------------------------------------------
  # ● 更新游標
  #--------------------------------------------------------------------------
  def update_cursor_rect
    if @index < 0
      self.cursor_rect.empty
    #elsif @index == @item_max - 1
    #  self.cursor_rect.set(478, 342, 120, 42)
    else
      self.cursor_rect.set(120-4, (@index)*HEIGHT, 360+8, HEIGHT)
    end
  end
  #--------------------------------------------------------------------------
  # ● 定期更新
  #--------------------------------------------------------------------------
  def update
    super
    
    # 編輯按鍵的情況下
    if !self.active 
      update_edit
      
    # 移動游標的情況下
    elsif self.active and @item_max > 0 and @index >= 0
      # 方向鍵下被按下的情況下
      if Input.repeat?(Input::DOWN)
        $game_system.se_play($data_system.cursor_se)
        if @index == @item_max - 1
          @index = 0
        elsif @index < @item_max - 1
          # 游標向下移動
          @index += 1
        end
      end
      # 方向鍵上被按下的情況下
      if Input.repeat?(Input::UP)
        $game_system.se_play($data_system.cursor_se)
        if @index == 0
          @index = @item_max - 1
        elsif @index > 0
          # 游標向上移動
          @index -= 1
        end
      end
=begin
      # 方向鍵右被按下的情況下
      if Input.repeat?(Input::RIGHT)
        $game_system.se_play($data_system.cursor_se)
        if @index == @item_max - 1
          @index = 0
        else
          @index = @item_max - 1
        end
      end
      # 方向鍵左被按下的情況下
      if Input.repeat?(Input::LEFT)
        $game_system.se_play($data_system.cursor_se)
        if @index == @item_max - 1
          @index = @item_max - 2
        else
          @index = @item_max - 1
        end
      end
=end
      if Input.trigger?(Input::B)
    #  if Kboard.trigger?(27)  || Joyall.trigger?(2, @pad_id)
        $game_system.se_play($data_system.cancel_se)
        $game_config.system_save # 儲存按鍵
      #  $game_config.battle_pad = @temp_set  # 避免混亂不還原了
        @return_call.call
        return
      end
      if Input.trigger?(Input::C)
     # if Kboard.trigger?(13) || Joyall.trigger?(1, @pad_id)
        if self.index == @item_max - 1
          $game_system.se_play($data_system.load_se)
          $game_config.system_save # 儲存按鍵
=begin          
          # 如果是從標題畫面進來的話回標題畫面
          if $game_temp.title_to_keyconfig
            $scene = Scene_Option.new
            $game_temp.title_to_keyconfig = false
          else
            $scene = Scene_Option.new
          end
=end
          @return_call.call
          return
        # 還原預設值
        elsif self.index == @item_max - 2
          $game_system.se_play($data_system.load_se)
          $game_config.battle_pad_default.each { |key, value|
            $game_config.battle_pad[key] = value
          }
          refresh
        else
          @mode = 1
          case $game_config.language
          # ======== 繁中
          when "tw"
            @help_window.set_text("請輸入按鍵", 1)
          # ======== 英文 
          when "en"
            @help_window.set_text("Please, enter the new key", 1)
          # ======== 西班牙文
          when "es"
            @help_window.set_text("Ahora, pulse la nueva tecla que haya elegido.", 1)
          # ======== 其他  
          else
            @help_window.set_text("請輸入按鍵", 1)
          end
          self.active = false
          $game_system.se_play($data_system.decision_se)
          return
        end
      end
      
      
      
      
    end
    # 更新游標矩形
    update_cursor_rect
    
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
  # ● 更新主操作
  #--------------------------------------------------------------------------
  def update_edit
    
    # 取消
    if Kboard.trigger?(27)
     @mode = 0
     $game_system.se_play($data_system.cancel_se)
      case $game_config.language
      # ======== 繁中
      when "tw"
        @help_window.set_text("請選擇需修改的按鍵", 1)
      # ======== 英文 
      when "en"
        @help_window.set_text("Please, choose the key you want to modify.", 1)
      # ======== 西班牙文
      when "es"
        @help_window.set_text("Por favor, elija la acción que desea modificar.", 1)
      # ======== 其他  
      else
        @help_window.set_text("請選擇需修改的按鍵", 1)
      end
     self.active = true
      return
    end
    
    for value in [1,2,4,8,16,32,64,128,256,512,1024,2048]
      if Joyall.trigger?(value, @pad_id)
#=begin        
        # 選單鍵除外
        if [64].include?(value)
          case $game_config.language
          # ======== 繁中
          when "tw"
            @help_window.set_text("無法使用的按鍵，請設定其他按鍵", 1)
          # ======== 英文 
          when "en"
            @help_window.set_text("You can't use this key, please change it to other one.", 1)
          # ======== 西班牙文
          when "es"
            @help_window.set_text("No se puede usar esta tecla, por favor, cámbiela. ", 1)
          # ======== 其他  
          else
            @help_window.set_text("無法使用的按鍵，請設定其他按鍵", 1)
          end
          $game_system.se_play($data_system.buzzer_se)
          return
        end
#=end
        # 設置按鍵
        case self.index
        when 0
          edit_key_value("Z", value)
        when 1
          edit_key_value("X", value)
        when 2
          edit_key_value("C", value)
        when 3
          edit_key_value("CHANGE", value)
        when 4
          edit_key_value("CHANGE2", value)
        when 5
          edit_key_value("CHANGE3", value)
        when 6
          edit_key_value("CHECK", value)
        end
        $game_system.se_play($data_system.decision_se)
        @mode = 0
          case $game_config.language
          # ======== 繁中
          when "tw"
            @help_window.set_text("請選擇需修改的按鍵", 1)
          # ======== 英文 
          when "en"
            @help_window.set_text("Please choose the keyboard you want to modify", 1)
          # ======== 西班牙文
          when "es"
            @help_window.set_text("Por favor, elija la acción que desea modificar.", 1)
          # ======== 其他  
          else
            @help_window.set_text("請選擇需修改的按鍵", 1)
          end
        self.active = true
        return
      end  #  if Kboard.trigger?(value)
    end #  for value in 5..230
  end
  
  
  
end
 
