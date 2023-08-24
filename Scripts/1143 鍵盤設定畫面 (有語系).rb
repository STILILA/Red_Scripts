#==============================================================================
# ■ Scene_KeyConfig
#------------------------------------------------------------------------------
# 進行鍵盤設定的場景
#==============================================================================

class Scene_KeyConfig
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
    
    @window = WindowKeyPadConfig.new(0, @return_call)

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
class Window_KeyConfig_BG < Window_Base
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
class Window_Edit_key < Window_Base
  #--------------------------------------------------------------------------
  # ● 公開變量
  #-------------------------------------------------------------------------- 
  attr_reader   :index                    # 游標位置
  attr_accessor   :help_window              # 說明視窗
  #--------------------------------------------------------------------------
  # ● 鍵值對應說明
  #-------------------------------------------------------------------------- 
  KEY_DATA = {
    "tw" =>   {192 => "`", 9 => "Tab", 32 => "空白鍵",
                    160 => "左Shift", 161 => "右Shift", 162 => "左Ctrl", 163 => "右Ctrl", 164 => "左Alt", 165 => "右Alt", 93 => "清單鍵",
                    49 => "1", 50 => "2", 51 => "3", 52 => "4", 53 => "5", 54 => "6", 55 => "7", 56 => "8", 57 => "9", 48 => "0",
                    189=>"-", 187=>"=", 220=>"\\", 8=>"倒回鍵",
                    219=>"[", 221=>"]", 186=>";", 222=>"'",188=>",",190=>".",191=>"/",
                    81=>"Q",87=>"W",69=>"E",82=>"R",84=>"T",89=>"Y",85=>"U",73=>"I",79=>"O",80=>"P",
                    65=>"A",83=>"S",68=>"D",70=>"F",71=>"G",72=>"H",74=>"J",75=>"K",76=>"L",
                    90=>"Z",88=>"X",67=>"C",86=>"V",66=>"B",78=>"N",77=>"M",
                    37=>"←",38=>"↑",39=>"→",40=>"↓",
                    44=>"Prt",19=>"Pause",45=>"Ins",36=>"Home",33=>"PageUp",46=>"Del",35=>"End",34=>"PageDown",
                    111=>"數字鍵/",106=>"數字鍵*",109=>"數字鍵-",107=>"數字鍵+",110=>"數字鍵.",
                    96=>"數字鍵0",97=>"數字鍵1",98=>"數字鍵2",99=>"數字鍵3",100=>"數字鍵4",
                    101=>"數字鍵5",102=>"數字鍵6",103=>"數字鍵7",104=>"數字鍵8",105=>"數字鍵9"},
                    
    "en" =>  {192 => "`", 9 => "Tab", 32 => "Spacebar",
                        160 => "left shift", 161 => " right shift", 162 => " left Ctrl", 163 => "right Ctrl", 164 => "left Alt", 165 => "right Alt", 93 => "esc",
                        49 => "1", 50 => "2", 51 => "3", 52 => "4", 53 => "5", 54 => "6", 55 => "7", 56 => "8", 57 => "9", 48 => "0",
                        189=>"-", 187=>"=", 220=>"\\", 8=>" backspace",
                        219=>"[", 221=>"]", 186=>";", 222=>"'",188=>",",190=>".",191=>"/",
                        81=>"Q",87=>"W",69=>"E",82=>"R",84=>"T",89=>"Y",85=>"U",73=>"I",79=>"O",80=>"P",
                        65=>"A",83=>"S",68=>"D",70=>"F",71=>"G",72=>"H",74=>"J",75=>"K",76=>"L",
                        90=>"Z",88=>"X",67=>"C",86=>"V",66=>"B",78=>"N",77=>"M",
                        37=>"←",38=>"↑",39=>"→",40=>"↓",
                        44=>"Prt",19=>"Pause",45=>"Ins",36=>"Home",33=>"PageUp",46=>"Del",35=>"End",34=>"PageDown",
                        111=>"number area/",106=>"number area*",109=>"number area-",107=>"number area+",110=>"number area.",
                        96=>"number area0",97=>"number area1",98=>"number area2",99=>"number area3",100=>"number area4",
                        101=>"number area5",102=>"number area6",103=>"number area7",104=>"number area8",105=>"number area9"},
    "es" => {192 => "`", 9 => "Tab", 32 => "Barra espaciadora",
                        160 => "Mayusc. Izquierdo", 161 => " Mayusc. Derecho", 162 => " left Ctrl", 163 => "right Ctrl", 164 => "left Alt", 165 => "right Alt", 93 => "Escape",
                        49 => "1", 50 => "2", 51 => "3", 52 => "4", 53 => "5", 54 => "6", 55 => "7", 56 => "8", 57 => "9", 48 => "0",
                        189=>"-", 187=>"=", 220=>"\\", 8=>" Retroceso",
                        219=>"[", 221=>"]", 186=>";", 222=>"'",188=>",",190=>".",191=>"/",
                        81=>"Q",87=>"W",69=>"E",82=>"R",84=>"T",89=>"Y",85=>"U",73=>"I",79=>"O",80=>"P",
                        65=>"A",83=>"S",68=>"D",70=>"F",71=>"G",72=>"H",74=>"J",75=>"K",76=>"L",
                        90=>"Z",88=>"X",67=>"C",86=>"V",66=>"B",78=>"N",77=>"M",
                        37=>"←",38=>"↑",39=>"→",40=>"↓",
                        44=>"Prt",19=>"Pause",45=>"Ins",36=>"Home",33=>"PageUp",46=>"Del",35=>"End",34=>"PageDown",
                        111=>"Teclado numérico/",106=>"Teclado numérico*",109=>"Teclado numérico-",107=>"Teclado numérico+",110=>"Teclado numérico.",
                        96=>"Teclado numéricoa0",97=>"Teclado numérico1",98=>"Teclado numérico2",99=>"Teclado numérico3",100=>"Teclado numérico4",
                        101=>"Teclado numérico5",102=>"Teclado numérico6",103=>"Teclado numérico7",104=>"Teclado numérico8",105=>"Teclado numérico9"}
  }


                          
  KEY_LIST = ["LEFT", "RIGHT", "UP", "DOWN", "Z", "X", "C", "CHANGE", "CHANGE2", "CHANGE3", "CHECK"]                         
                    
  COMMAND_DATA = {
    "tw" => ["左",  "右", "上/跳躍", "下/蹲下", "普通攻擊", "必殺技", "防禦", "切換成芮德兒", "切換成法蜜莉歐", "切換成卡麥莉亞", "調查"],
    "en" => ["Left", "Right", "Up/Jump", "Down/Crouch", "Attack", "Skill", "Defense", "Change to Red", "Change to Vermilion", "Change to Camellia", "Check"],
    "es" => ["Izquierda", "Derecha", "Arriba/Saltar", "Abajo/Agacharse", "Atacar", "Técnica", "Bloquear", "Cambiar a Red", "Cambiar a Vermillion", "Cambiar a Camellia", "Cheque"]
  }              
  
  HEIGHT = 28
  #--------------------------------------------------------------------------
  # ● 初始化物件
  #-------------------------------------------------------------------------- 
   def initialize(return_call)
     super(0, 64, 640,416)
     self.contents = Bitmap.new(width - 32, height - 32)
     @item_max = KEY_LIST.size + 2 #11 #項目數
  #   self.opacity = 0#130
     self.active = true
     self.index = 0
     self.z = 99999
     @temp_set = $game_config.battle_key.dup
     @return_call = return_call
     refresh

   end
  #--------------------------------------------------------------------------
  # ● 刷新
  #-------------------------------------------------------------------------- 
  def refresh
    self.contents.clear
=begin    
    self.contents.font.color = crisis_color
    self.contents.draw_text(112, 88, 80, 42, KEY_DATA[$game_config.battle_key["LEFT"]],2)
    self.contents.draw_text(112, 130, 80, 42, KEY_DATA[$game_config.battle_key["RIGHT"]],2)
    self.contents.draw_text(112, 172, 80, 42, KEY_DATA[$game_config.battle_key["UP"]],2)
    self.contents.draw_text(112, 214, 80, 42, KEY_DATA[$game_config.battle_key["DOWN"]],2)
    self.contents.draw_text(352, 88, 80, 42, KEY_DATA[$game_config.battle_key["Z"]],2)
    self.contents.draw_text(352, 130, 80, 42, KEY_DATA[$game_config.battle_key["X"]],2)
    self.contents.draw_text(352, 172, 80, 42, KEY_DATA[$game_config.battle_key["C"]],2)
    self.contents.draw_text(352, 214, 80, 42, KEY_DATA[$game_config.battle_key["CHANGE"]],2)
    self.contents.draw_text(352, 256, 80, 42, KEY_DATA[$game_config.battle_key["CHANGE2"]],2)
    self.contents.draw_text(352, 298, 80, 42, KEY_DATA[$game_config.battle_key["CHANGE3"]],2)
=end
 
    x = 120
    y = 0
    key_name_list = COMMAND_DATA[$game_config.language]
    @key_data = KEY_DATA[$game_config.language]
    
    
    KEY_LIST.size.times {|t|
      key = KEY_LIST[t]
      key_name = key_name_list[t]
      self.contents.font.color = normal_color
      self.contents.draw_text(x, y, 360, HEIGHT, key_name)
      self.contents.font.color = crisis_color
      self.contents.draw_text(x, y, 360, HEIGHT, @key_data[$game_config.battle_key[key]], 2)
      y += HEIGHT
    }
    self.contents.font.color = normal_color
    case $game_config.language
    # ======== 繁中
    when "tw"
      self.contents.draw_text(x, y, 360, HEIGHT, "還原預設",1)
      #self.contents.draw_text(478, 342, 120, 42,"修改完畢",1)
       y += HEIGHT
      self.contents.draw_text(x, y, 360, HEIGHT,"修改完畢",1)
    # ======== 英文 
    when "en"
      self.contents.draw_text(x, y, 360, HEIGHT, "Default",1)
    #  self.contents.draw_text(478, 342, 120, 42,"Done",1)
      y += HEIGHT
      self.contents.draw_text(x, y, 360, HEIGHT,"Done",1)
    # ======== 西班牙文
    when "es"
      self.contents.draw_text(x, y, 360, HEIGHT, "Defecto",1)
   #   self.contents.draw_text(478, 342, 120, 42,"done",1)
      y += HEIGHT
      self.contents.draw_text(x, y, 360, HEIGHT,"Done",1)
    # ======== 其他  
    else
      self.contents.draw_text(x, y, 360, HEIGHT, "Default",1)
      y += HEIGHT
      self.contents.draw_text(x, y, 360, HEIGHT,"Done",1)
    end
    
  end
  #--------------------------------------------------------------------------
  # ● 修改按鍵
  #-------------------------------------------------------------------------- 
  def edit_key_value(key, value)

    # 無效鍵值時中斷
    unless @key_data.include?(value)
      p "偵測到無效鍵值 #{value}，不過不影響執行" if $DEBUG
      return 
    end
    $game_config.battle_key[key] = value
    refresh
  end
  #--------------------------------------------------------------------------
  # ● 更新游標
  #--------------------------------------------------------------------------
  def update_cursor_rect
    if @index < 0
      self.cursor_rect.empty
   # elsif @index == @item_max - 1
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
      # 取消
      if Kboard.trigger?(27) || Joyall.trigger?(2,0)
        $game_system.se_play($data_system.cancel_se)
        $game_config.system_save # 儲存按鍵
        #$game_config.battle_key = @temp_set # 避免混亂，不還原了
        #    $scene = Scene_Option.new
        @return_call.call  # 用用看callback
        return
      end
      
      
      # 確定
     # if Input.trigger?(Input::C)
      if Kboard.trigger?(13)
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
          @return_call.call  # 用用看callback
          return
        # 還原預設值
        elsif self.index == @item_max - 2
          $game_system.se_play($data_system.load_se)
          $game_config.battle_key_default.each { |key, value|
            $game_config.battle_key[key] = value
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
  # ● 定期更新－編輯
  #--------------------------------------------------------------------------
  def update_edit
    
    for value in 5..230
      if Kboard.trigger?(value)
        if value == 27
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
        if value == 13
         @mode = 0
         $game_system.se_play($data_system.decision_se)
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
        # Windows鍵、Enter鍵、F1~F12、3個Lock鍵除外
        if [12,13,16,17,18,20,27,91,92,112,113,114,115,116,117,118,119,120,121,122,123,144,145].include?(value)
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
        case @index
        when 0
          edit_key_value("LEFT", value)
        when 1
          edit_key_value("RIGHT", value)
        when 2
          edit_key_value("UP", value)
        when 3
          edit_key_value("DOWN", value)
        when 4
          edit_key_value("Z", value)
        when 5
          edit_key_value("X", value)
        when 6
          edit_key_value("C", value)
        when 7
          edit_key_value("CHANGE", value)
        when 8
          edit_key_value("CHANGE2", value)
        when 9
          edit_key_value("CHANGE3", value)
        when 10
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
  #--------------------------------------------------------------------------
  # ● 設置游標的位置
  #     index : 新的游標位置
  #--------------------------------------------------------------------------
  def index=(index)
    @index = index
    # 更新游標矩形
    update_cursor_rect
  end
  
end
 
