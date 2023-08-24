#==============================================================================
# ■ 場地區塊設定
#------------------------------------------------------------------------------
# 　負責設置場地內各種平台、地面。
#==============================================================================


#==============================================================================
# ■ Scene_Battle
#==============================================================================
class Scene_Battle
  #--------------------------------------------------------------------------
  # ○ 公開變量
  #--------------------------------------------------------------------------
  attr_reader :field_blocks
  
  #--------------------------------------------------------------------------
  # ○ 戰鬥場地地板判定
    # @field_blocks    # 地面、牆
   #  @field_boards   #  小平台
  #--------------------------------------------------------------------------
  def setup_battle_field_blocks
    # 初期化
    @field_blocks = []   # 地面、牆
    @field_boards = []  #  平台
    @field_events = []    # 事件觸發區域
    @field_blocks.push(BattleField_Rect.new(-896,0,1792,384))
    # 「バトルバック」によって分岐
    case $game_temp.battleback_name
    when "stage1"  # STAGE 1
      @field_blocks.clear
      @field_blocks.push(BattleField_Rect.new(-5,0,13500,284))
   #   @field_boards.push(BattleField_Rect.new(-312,-194,212,30))
    when "stage2" # 2-1
      @field_blocks.clear
      @field_blocks.push(BattleField_Rect.new(-5,0,1094,984))

      # 往下跳觸發事件
      @field_events.push(BattleField_Rect.new(1090,1200,1000,100,19))
      
      # 底層設個平台免得主角掉下去(額，好像不用了)
    #  @field_blocks.push(BattleField_Rect.new(1090,1300,1000,80))
      
    when "stage22" # 2-2
      @field_blocks.clear
      # 左邊香菇
      @field_blocks.push(BattleField_Rect.new(-1005,89,1295,90))
      # 左邊那大塊
      @field_blocks.push(BattleField_Rect.new(-5,150,2060,984))
      # 地洞
      @field_blocks.push(BattleField_Rect.new(2058,684,1618,40))
      # 地洞右邊牆
      @field_blocks.push(BattleField_Rect.new(3675,160,40,564))
      # 右半部大塊平台
      @field_blocks.push(BattleField_Rect.new(2504,150,1618,40))
      # 右半部牆
      @field_blocks.push(BattleField_Rect.new(3570,-340,1080,620))
      
      # 香菇階梯
      @field_boards.push(BattleField_Rect.new(3104,135,224,30))
      @field_boards.push(BattleField_Rect.new(3166,12,225,30))
      @field_boards.push(BattleField_Rect.new(3281,-67,181,30))
      @field_boards.push(BattleField_Rect.new(3311,-172,161,30))
      @field_boards.push(BattleField_Rect.new(3271,-298,237,30))
      @field_boards.push(BattleField_Rect.new(3271,-298,237,30))
    #  @field_boards.push(BattleField_Rect.new(3492,-400,256,30))
      @field_blocks.push(BattleField_Rect.new(3492,-390,256,60))
      # 終點高台
   #   @field_blocks.push(BattleField_Rect.new(3570,-320,500,600))
   
      # 終點事件
      @field_events.push(BattleField_Rect.new(3900,-400,286,60,23))

    when "stage23"  # STAGE 2 BOSS
      @field_blocks.clear
      @field_blocks.push(BattleField_Rect.new(-20,170,1330,284))
    when "stage31"  # STAGE 3
      @field_blocks.clear
      @field_blocks.push(BattleField_Rect.new(-1,0,4752,284))
      @field_blocks.push(BattleField_Rect.new(4750,0,2100,284))
=begin
      @field_blocks.push(BattleField_Rect.new(-1,0,556,284))
      @field_blocks.push(BattleField_Rect.new(620,0,405,284))
      @field_blocks.push(BattleField_Rect.new(1125,0,100,284))
      @field_blocks.push(BattleField_Rect.new(1295,0,335,284))
      @field_blocks.push(BattleField_Rect.new(1735,0,225,284))
      @field_blocks.push(BattleField_Rect.new(2050,0,2100,284))
=end      
=begin
      @field_blocks.push(BattleField_Rect.new(-1,0,2001,284))
      @field_blocks.push(BattleField_Rect.new(2100,0,1000,284))
      @field_blocks.push(BattleField_Rect.new(3200,0,1000,284))
      @field_blocks.push(BattleField_Rect.new(4300,0,500,284))
      @field_blocks.push(BattleField_Rect.new(4900,0,800,284))
      @field_blocks.push(BattleField_Rect.new(5800,0,300,284))
      @field_blocks.push(BattleField_Rect.new(6200,0,600,284))
      @field_blocks.push(BattleField_Rect.new(6900,0,400,284))
      @field_blocks.push(BattleField_Rect.new(7400,0,900,284))
      @field_blocks.push(BattleField_Rect.new(8400,0,450,284))
      @field_blocks.push(BattleField_Rect.new(8950,0,150,284))
      @field_blocks.push(BattleField_Rect.new(9200,0,600,284))
      @field_blocks.push(BattleField_Rect.new(9900,0,800,284))
      @field_blocks.push(BattleField_Rect.new(10800,0,500,284))
      @field_blocks.push(BattleField_Rect.new(11400,0,300,284))
      @field_blocks.push(BattleField_Rect.new(11800,0,500,284))
      @field_blocks.push(BattleField_Rect.new(12400,0,200,284))
      @field_blocks.push(BattleField_Rect.new(12700,0,400,284))
      @field_blocks.push(BattleField_Rect.new(13200,0,400,284))
      @field_blocks.push(BattleField_Rect.new(13700,0,1000,284))
=end
      # 落地事件
      #@field_events.push(BattleField_Rect.new(0,600,13100,384,66))
      
      
    when "stage32"#
      @field_blocks.clear
      @field_blocks.push(BattleField_Rect.new(-350,0,2630,284))
      
    when "stage33" #
      @field_blocks.clear
      @field_blocks.push(BattleField_Rect.new(-350,0,2630,284))
      
    when "stageEX"  # 挑戰最後
      @field_blocks.clear
      @field_blocks.push(BattleField_Rect.new(-20,170,1330,284))
      
    when "lftt"#"ttor"
      @field_blocks.clear
      @field_blocks.push(BattleField_Rect.new(-896,0,302,284))
      @field_blocks.push(BattleField_Rect.new(-796,250,1502,184))
      
      @field_blocks.push(BattleField_Rect.new(0,66,352,104))
      
      
    #  @field_blocks.push(Rect.new(0,-144,352,90))
      @field_blocks.push(BattleField_Rect.new(0,-104,352,104))
      @field_blocks.push(BattleField_Rect.new(120,-206,120,320))
      @field_blocks.push(BattleField_Rect.new(290,-486,160,310))
      @field_blocks.push(BattleField_Rect.new(570,-106,180,220))
      @field_boards.push(BattleField_Rect.new(-312,-194,212,30))
    when "Torre"
      @field_blocks.clear
      @field_blocks.push(BattleField_Rect.new(-362,0,550,384))
    when "x40-Tower02"
      @field_blocks.clear
      @field_blocks.push(BattleField_Rect.new(-384,0,768,384))
    when "xxx-ProtoField"
      @field_boards.push(BattleField_Rect.new(-256,-128,192,4))
      @field_blocks.push(BattleField_Rect.new(96,-156,32,28))
    when "lf"#"ttor"
      @field_blocks.clear
      
      #@field_blocks.push(BattleField_Rect.new(0,-34,150,60,0))
      #@field_blocks.push(BattleField_Rect.new(149,0,150,35,-1))
      @field_blocks.push(BattleField_Rect.new(0,0,151,35,1))
      @field_blocks.push(BattleField_Rect.new(150,-34,150,60))

    end
  end
end





class BattleField_Rect < Rect
  #--------------------------------------------------------------------------
  # ● 公開變量
  #--------------------------------------------------------------------------
  attr_reader :id                             # 用來識別的ID
  attr_reader :battlers                     # 記憶站在上面的戰鬥者
  attr_reader :common_event_id    # 碰撞時會觸發的公用事件ID
  attr_reader :slope                         # 斜坡屬性(1：往上、-1：往下、0：平地)
  attr_accessor :move_type            # 移動方式(0：沒動作、1：左右、2：上下)
  attr_accessor :x_speed                # 橫移速度
  attr_accessor :y_speed                # 縱移速度
  #--------------------------------------------------------------------------
  # ● 物件初始化
  #--------------------------------------------------------------------------
  def initialize(x,y,w,h, common_event_id = 0,slope = 0, id=nil, move_type=0,x_speed=0, y_speed=0)
    #@id =  id
    @battlers = {}
    @x_speed = x_speed
    @y_speed = y_speed
    @common_event_id = common_event_id
    @slope = slope
    @move_type = move_type
    super(x,y,w,h)
  end
  #--------------------------------------------------------------------------
  # ● 取得斜坡高
  #--------------------------------------------------------------------------
  def get_slope_height(now_x)
    case @slope
    when 0
      return 0#self.height
    when 1
      return now_x * get_slope_value
    when -1

      return now_x * get_slope_value
    end
  end
  #--------------------------------------------------------------------------
  # ● 取得斜坡高
  #--------------------------------------------------------------------------
  def get_slope_value
    case @slope
    when 0
      return 0
    when 1
      return -(self.height - self.y + 0.0) / (self.width - self.x)
    when -1
      return (self.height - self.y + 0.0) / (self.width - self.x)
    end
  end
  
end
