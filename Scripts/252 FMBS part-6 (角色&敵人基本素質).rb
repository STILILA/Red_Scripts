# ▽△▽ バトルシステム 1. Full-Move Battle System バトルDB ▽△▽
# by 桜雅 在土

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler

  attr_reader   :ai_defence_level         # AI.防御に移行するレベル

  #--------------------------------------------------------------------------
  # ○ アクターの運動能力の設定
  #--------------------------------------------------------------------------
  
  def setup_actor_reflexes(actor_id)
    # 共通項目の設定
      @walk_x_speed         =  2.3    # 「歩行X速度」
      @frict_x_break        =  0.6   # 「摩擦Xブレーキ力」
      @dash_x_speed         =  6.1   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  4.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_maximum        =  22.0   # 「落下Y最大速度」
      @max_jumps            =  2    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 14.5  # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 11   # 「空中ジャンプY初速度」
      @ai_defence_level   = 30  #防禦機率 
      @stand_body_rect  = Rect.new(-26 , -128, 52, 127) #  直立時くらい判定(Rect)
      @sit_body_rect      = Rect.new( -17 , -32, 34, 31) # しゃがみ時くらい判定(Rect)
      @down_body_rect  = Rect.new( -62 , -22, 124, 21) # ダウン時くらい判定(Rect)
    # アクター個別の設定
    case actor_id
    when 1 # 鐮
      @walk_x_speed         =  3.5#2.9    # 「歩行X速度」
      @dash_x_speed         =  7.2#6.4   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 18.8#15.8 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 13   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
    when 2 # 獵
      @walk_x_speed         =  3.7#2.9    # 「歩行X速度」
      @dash_x_speed         =  7.4#6.4   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 18.6#16.1 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 13   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
    when 3 # 狼
      @walk_x_speed         =  3.7#3.2    # 「歩行X速度」
      @dash_x_speed         =  9.2#8.6   # 「跑步X速度」
      @air_x_velocity       =  2.2   # 「空中X加速度」
      @air_x_maximum        =  3.7   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  2    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 18.7#16.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 14   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
    when 4 # 狼(第一關限定)
      @walk_x_speed         =  4.8    # 「歩行X速度」
      @dash_x_speed         =  10.9   # 「跑步X速度」
      @air_x_velocity       =  4.6   # 「空中X加速度」
      @air_x_maximum        =  9.4   # 「空中X最大速度」
      @air_x_resistance     =  0.5   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  2    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 11.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 9   # 「空中ジャンプY初速度」
      @ai_defence_level   =  80  #防禦機率 
      
    when 6 # EX鐮
      @walk_x_speed         =  3.5#2.9    # 「歩行X速度」
      @dash_x_speed         =  7.2#6.4   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 18.8#15.8 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 13   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-26 , -128, 52, 127) #  直立時くらい判定(Rect)
    when 7 # EX槍
      @walk_x_speed         =  3.7#2.9    # 「歩行X速度」
      @dash_x_speed         =  7.4#6.4   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 18.6#16.1 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 13   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-26 , -128, 52, 127) #  直立時くらい判定(Rect)
    when 8 # EX狼
      @walk_x_speed         =  3.7#3.2    # 「歩行X速度」
      @dash_x_speed         =  9.2#8.6   # 「跑步X速度」
      @air_x_velocity       =  2.2   # 「空中X加速度」
      @air_x_maximum        =  3.7   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  2    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 18.7#16.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 14   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-26 , -128, 52, 127) #  直立時くらい判定(Rect)
    when 10 # ？
      @walk_x_speed         =  4.9    # 「歩行X速度」
      @dash_x_speed         =  8.4   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 16.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 13   # 「空中ジャンプY初速度」
      @stand_body_rect  = Rect.new(-26 , -128, 52, 127) #  直立時くらい判定(Rect)
      
    end
  end
  #--------------------------------------------------------------------------
  # ○ エネミーの運動能力の設定
  #--------------------------------------------------------------------------
  def setup_enemy_reflexes(enemy_id)  
    case $game_variables[STILILA::GAME_LEVEL] 
    when 0
      rate = -10
    when 1
      rate = 0
    when 2
      rate = 10
    when 3
      rate = 20
    end
    # 
    # --- 共通項目 ---
    #
      # 運動能力
    @walk_x_speed         =  1.6    # 「歩行X速度」
    @frict_x_break        =  0.6   # 「摩擦Xブレーキ力」
    @dash_x_speed         =  3.5   # 「跑步X速度」
    @air_x_velocity       =  0.8   # 「空中X加速度」
    @air_x_maximum        =  3.0   # 「空中X最大速度」
    @air_x_resistance     =  0.2   # 「空中X空気抵抗」
    @air_y_velocity       =  0.9   # 「落下Y加速度」
    @air_y_maximum        =  22.0   # 「落下Y最大速度」
    @max_jumps            =  2    # 「最高連続ジャンプ回数」
    @weight               =  0.50  # 「重さ」
    @jump_y_init_velocity    = 12.5  # 「地上ジャンプY初速度」
    @airjump_y_init_velocity = 11   # 「空中ジャンプY初速度」
    @stand_body_rect  = Rect.new(-17 , -63, 34, 54) #  直立時くらい判定(Rect)
    @sit_body_rect      = Rect.new( -17 , -32, 34, 31) # しゃがみ時くらい判定(Rect)
    @down_body_rect  = Rect.new( -62 , -22, 124, 21) # ダウン時くらい判定(Rect)
    # --- エネミー個別設定 ---
    #
    case enemy_id
    
    when 1 # 四葉草
      @walk_x_speed         =  1.6    # 「歩行X速度」
      @dash_x_speed         =  5.9   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  4.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 12.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 11   # 「空中ジャンプY初速度」
      @stand_body_rect  = Rect.new(-28 , -64, 62, 63) #  直立時くらい判定(Rect)
    when 2 # 蘑菇
      @stand_body_rect  = Rect.new(-40 , -133, 80, 132) #  直立時くらい判定(Rect)
    when 3 # 樹洞怪
      
    when 4 # 小葉豬
      @stand_body_rect  = Rect.new(-28 , -64, 62, 63) #  直立時くらい判定(Rect)
    when 5 # 蝙蝠
      @walk_x_speed         =  4.3    # 「歩行X速度」
      @dash_x_speed         =  7.9   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  4.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  2    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 12.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 11   # 「空中ジャンプY初速度」
       @stand_body_rect  = Rect.new(-20 , -163, 40, 112) #  直立時くらい判定(Rect)
    when 6 # 蜜蜂
      @walk_x_speed         =  5.3    # 「歩行X速度」
      @dash_x_speed         =  5.9   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  4.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 12.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 11   # 「空中ジャンプY初速度」
      @stand_body_rect  = Rect.new(-35 , -128, 70, 120) #  直立時くらい判定(Rect)

      
    when 10 # 皮革
      @walk_x_speed         =  5.7    # 「歩行X速度」
      @dash_x_speed         =  8.5   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.2   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  2    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 11.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 10   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-80 , -120, 160, 100) 
      @sit_body_rect      = Rect.new(-80 , -120, 160, 100) 
      @down_body_rect  = Rect.new(-80 , -120, 160, 100)   
      
      
    when 11 # 黑Red
      @walk_x_speed         =  3.5#2.9    # 「歩行X速度」
      @dash_x_speed         =  7.2#6.4   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 18.8#15.8 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 13   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-26 , -128, 52, 127) #  直立時くらい判定(Rect)
    when 12 # 黑槍
      @walk_x_speed         =  3.7#2.9    # 「歩行X速度」
      @dash_x_speed         =  7.4#6.4   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 18.6#16.1 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 13   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-26 , -128, 52, 127) #  直立時くらい判定(Rect)
    when 13 # 黑狼
      @walk_x_speed         =  3.7#3.2    # 「歩行X速度」
      @dash_x_speed         =  9.2#8.6   # 「跑步X速度」
      @air_x_velocity       =  2.2   # 「空中X加速度」
      @air_x_maximum        =  3.7   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  2    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 18.7#16.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 14   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-26 , -128, 52, 127) #  直立時くらい判定(Rect)
    when 14 # 皮革對決
      @walk_x_speed         =  5.7    # 「歩行X速度」
      @dash_x_speed         =  8.5   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.2   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  2    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 11.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 10   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-90 , -120, 180, 100) 
      @sit_body_rect      = Rect.new(-80 , -120, 160, 100) 
      @down_body_rect  = Rect.new(-80 , -120, 160, 100)   
      
    when 18 # 憤怒的皮革 (做這個的時候我也好憤怒啊)
      @walk_x_speed         =  5.7    # 「歩行X速度」
      @dash_x_speed         =  8.5   # 「跑步X速度」
      @air_x_velocity       =  6.7   # 「空中X加速度」
      @air_x_maximum        =  9.2   # 「空中X最大速度」
      @air_x_resistance     =  0.6  # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  2    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 11.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 10   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-85 , -120, 200, 100) 
      @sit_body_rect      = Rect.new(-85 , -120, 200, 100) 
      @down_body_rect  = Rect.new(-85 , -120, 200, 100) 
      
    when 23 # 蜘蛛
      @walk_x_speed         =  5.7    # 「歩行X速度」
      @dash_x_speed         =  8.5   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.2   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  2    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 11.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 10   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-90 , -320, 180, 300) 
      @sit_body_rect      = Rect.new(-80 , -120, 160, 100) 
      @down_body_rect  = Rect.new(-80 , -120, 160, 100)   
      
    when 30 # 奶奶
      @walk_x_speed         =  2.9    # 「歩行X速度」
      @dash_x_speed         =  6.4   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 14.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 11   # 「空中ジャンプY初速度」
      @stand_body_rect  = Rect.new(-25 , -128, 50, 127) #  直立時くらい判定(Rect)
    when 31 # 奶奶二
      @walk_x_speed         =  4.9    # 「歩行X速度」
      @dash_x_speed         =  8.4   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 16.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 13   # 「空中ジャンプY初速度」
      @stand_body_rect  = Rect.new(-50 , -248, 100, 177) #  直立時くらい判定(Rect)
      
      
      
    when 39 # EX皮革對決
      @walk_x_speed         =  5.7    # 「歩行X速度」
      @dash_x_speed         =  8.5   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.2   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  2    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 11.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 10   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-90 , -120, 180, 100) 
      @sit_body_rect      = Rect.new(-80 , -120, 160, 100) 
      @down_body_rect  = Rect.new(-80 , -120, 160, 100)  
    when 40 # EX黑Red
      @walk_x_speed         =  3.5#2.9    # 「歩行X速度」
      @dash_x_speed         =  7.2#6.4   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 18.8#15.8 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 13   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-26 , -128, 52, 127) #  直立時くらい判定(Rect)
    when 41 # EX黑槍
      @walk_x_speed         =  3.7#2.9    # 「歩行X速度」
      @dash_x_speed         =  7.4#6.4   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 18.6#16.1 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 13   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-26 , -128, 52, 127) #  直立時くらい判定(Rect)
    when 42 # EX黑狼
      @walk_x_speed         =  3.7#3.2    # 「歩行X速度」
      @dash_x_speed         =  9.2#8.6   # 「跑步X速度」
      @air_x_velocity       =  2.2   # 「空中X加速度」
      @air_x_maximum        =  3.7   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  2    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 18.7#16.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 14   # 「空中ジャンプY初速度」
      @ai_defence_level   = 80  #防禦機率 
      @stand_body_rect  = Rect.new(-26 , -128, 52, 127) #  直立時くらい判定(Rect)

    when 43 # EX奶奶
      @walk_x_speed         =  2.9    # 「歩行X速度」
      @dash_x_speed         =  6.4   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 14.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 11   # 「空中ジャンプY初速度」
      @stand_body_rect  = Rect.new(-25 , -128, 50, 127) #  直立時くらい判定(Rect)
    when 44 # EX奶奶二
      @walk_x_speed         =  4.9    # 「歩行X速度」
      @dash_x_speed         =  8.4   # 「跑步X速度」
      @air_x_velocity       =  0.8   # 「空中X加速度」
      @air_x_maximum        =  3.0   # 「空中X最大速度」
      @air_x_resistance     =  0.2   # 「空中X空気抵抗」
      @air_y_velocity       =  0.9  # 「落下Y加速度」
      @max_jumps            =  1    # 「最高連続ジャンプ回数」
      @weight               =  0.50  # 「重さ」
      @jump_y_init_velocity    = 16.5 # 「地上ジャンプY初速度」
      @airjump_y_init_velocity = 13   # 「空中ジャンプY初速度」
      @stand_body_rect  = Rect.new(-50 , -248, 100, 177) #  直立時くらい判定(Rect)
      
      
    when 52  # 彈跳菇
       @stand_body_rect  = Rect.new(-3 , -102, 6, 50) #  直立時くらい判定(Rect)
    when 53  # 販賣機
       @stand_body_rect  = Rect.new(-62 , -233, 124, 231) #  直立時くらい判定(Rect)
    when 54  # 沼澤書櫃1
       @stand_body_rect  = Rect.new(-91 , -75, 200, 30) #  直立時くらい判定(Rect)
    when 55  # 沼澤書櫃2
       @stand_body_rect  = Rect.new(-61 , -75, 137, 30) #  直立時くらい判定(Rect)
    when 56  # 沼澤書櫃3
       @stand_body_rect  = Rect.new(-66 , -75, 142, 60) #  直立時くらい判定(Rect)
    when 57  # 沼澤藥缸
       @stand_body_rect  = Rect.new(-60 , -65, 131, 30) #  直立時くらい判定(Rect)
    when 58  # 魔鏡
       @stand_body_rect  = Rect.new(-2 , -2, 4, 1) #  直立時くらい判定(Rect)
    when 59  # 攝影機
       @stand_body_rect  = Rect.new(-2 , -2, 4, 1) #  直立時くらい判定(Rect)
    end
  end
end
#------------------------------------------------- カスタマイズポイント End ---
