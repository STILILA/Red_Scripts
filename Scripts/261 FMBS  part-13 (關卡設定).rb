#==============================================================================
# ■ 關卡腳本
#------------------------------------------------------------------------------
# 　各關敵人事件安排、劇情腳本。
#==============================================================================

class Scene_Battle
  #--------------------------------------------------------------------------
  # ● 設置敵方陣容
  #       troop_id：資料庫 "敵方隊伍" 的ID
  #--------------------------------------------------------------------------
  def set_stage_script(troop_id)
    case troop_id
    # =============== 第一關道中
    when 1  
      @area_max = 4
      case @area
      when 1
        # 寬度在公共事件設定
        return "Stage1_1"
      when 2
        $game_temp.battle_field_w = 2400
        return "Stage1_2"
      when 3
        $scene.battle_field_objects[1].motion.do_hide
        $game_temp.battle_field_w = 3600
        return "Stage1_3"
      when 4
        $scene.battle_field_objects[2].motion.do_hide
        $game_temp.battle_field_w = 11000
        return "Stage1_4"
      else
        p "第一關這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 第一關BOSS  追逐戰
    when 2
      @area_max = 2
      case @area
      when 1
        # 寬度在公共事件設定
        return "Stage1_BOSS1"
      when 2
        return "Stage1_BOSS2"
      else
        p "第一關BOSS追逐戰　　這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 第一關 BOSS對決
    when 3
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "Stage1_BOSSBattle"
      else
        p "第一關BOSS對決　　這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 2-1 道中
    when 4 
      @area_max = 2
      case @area
      when 1
        # 寬度要在公用事件設定
        return "Stage21_1"
      when 2
        $scene.battle_field_objects[1].motion.do_hide
        $game_temp.battle_field_w = 1523
        return "Stage21_2"
      else
        p "2-1這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 2-2 道中
    when 5
      @area_max = 3
      case @area
      when 1
        # 寬度要在公用事件設定
        return "Stage22_1"
      when 2
        $scene.battle_field_objects[0].motion.do_hide
        $game_temp.battle_field_w = 3700
        return "Stage22_2"
      when 3
        $scene.battle_field_objects[1].motion.do_hide
        $game_temp.battle_field_w = 4520
        return "Stage22_3"
      else
        p "2-2這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 第二關 BOSS對決
    when 6
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "Stage2_BOSSBattle"
      else
        p "第二關BOSS對決　　這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
      
    # =============== 第三關，被追
    when 7
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "Stage3_RUNRUNRUN"
      else
        p "第三關追逐的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
      
    # =============== 第三關 BOSS 前哨戰
    when 8
      @area_max = 2
      case @area
      when 1
        # 寬度在公共事件設定
        return "Stage3_Senerio"
      when 2
        $game_temp.battle_field_w = 3700
        return "Stage3_Battle"
      else
        p "3-2 這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 第三關 BOSS 戰
    when 9
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "Stage3_Senerio2"
      when 2
        $game_temp.battle_field_w = 3700
        return "Stage3_Battle"
      else
        p "3-3 這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 第三關 真 BOSS 戰
    when 10
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "FinalBOSS"
      when 2
        $game_temp.battle_field_w = 3700
        return "Stage3_Battle"
      else
        p "3-3 這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
      
    # =============== 第二關boss戰後劇情
    when 11
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "Stage2_AfterBOSSBattle"
      else
        p "第二關boss戰後劇情的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 第三關戰後劇情
    when 12
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "Stage3_AfterBOSSBattle"
      else
        p "第三關boss戰後劇情的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 第三關尾聲
    when 13
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "Stage3_Ending"
      else
        p "第三關尾聲的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 結局A
    when 14
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "EndingA"
      else
        p "結局A的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 結局B
    when 15
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "EndingB"
      else
        p "結局B的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 測試用  
    when 20
     @area_max = 1
      case @area
      when 1
        return "Stage_Test"
      end  
     # =============== 測試用(空白場景)
    when 21
     @area_max = 1
      case @area
      when 1
        return "Stage_Test2"
      end  
   # =============== 測試用(打boss)   
    when 22
     @area_max = 1
      case @area
      when 1
        return "Stage_TestBOSS"
      end  
   # =============== 測試用(打boss2)   
    when 24
     @area_max = 1
      case @area
      when 1
        return "Stage_TestBOSS2"
      end  
    # =============== 測試用(？)  
    when 25
     @area_max = 1
      case @area
      when 1
        return "Stage_Test3"
      end  

    # =============== 第一關道中(展示)
    when 28 
      @area_max = 3
      case @area
      when 1
        $game_temp.battle_field_w = 2400
        return "Demo1_1"
      when 2
        $game_temp.battle_field_w = 3600
        return "Demo1_2"
      when 3
        $game_temp.battle_field_w = 11000
        return "Demo1_3"
      else
        p "展示第一關這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
      
    # =============== 2-2 道中(展示)
    when 29
      @area_max = 3
      case @area
      when 1
        # 寬度要在公用事件設定
        return "Demo22_1"
      when 2
        $game_temp.battle_field_w = 3700
        return "Demo22_2"
      when 3
        $game_temp.battle_field_w = 4520
        return "Demo22_3"
      else
        p "展示2-2這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 第二關 BOSS對決(展示)
    when 30
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "Demo_BOSSBattle"
      else
        p "展示BOSS對決　這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 練習
    when 34
      @area_max = 1
      case @area
      when 1
        return "Practice_STAGE"
      else
        p "練習這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 教學
    when 35
      @area_max = 1
      case @area
      when 1
        return "Tutorial_STAGE"
      else
        p "教學這區的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 挑戰模式1
    when 39
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "EXstage1"
      else
        p "挑戰模式1 的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 挑戰模式2
    when 40
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "EXstage2"
      else
        p "挑戰模式2 的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 挑戰模式3
    when 41
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "EXstage3"
      else
        p "挑戰模式3 的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
    # =============== 挑戰模式4
    when 42
      @area_max = 1
      case @area
      when 1
        # 寬度在公共事件設定
        return "EXstage4"
      else
        p "挑戰模式4 的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
        exit
      end
      
      
    else # 除此之外的情況
      p "這組合的敵人或故事劇本未設定，請檢查 set_stage_script 的設定"
      exit
    end
  end
end

#==============================================================================
# ■ 1-1劇情
#==============================================================================
module Stage1_1
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [
    [48, 733, 0, true, false]
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = []
  # 呼叫公共事件
  Event = 0
end
#==============================================================================
# ■ 1-2內容
#==============================================================================
module Stage1_2
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [
    [3, 1020, 0, false, false], [1, 1120, 0, false, false], [2, 1290, 0, false, false],
    [3, 1950, 0, false, false], [1, 1860, 0, false, false], [1, 1690, 0, false, false], [2, 1990, 0, false, false]
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[60, 2620, 70], [65, 2430, 0], [65, 3630, 0]]
  # 呼叫公共事件
  Event = 2
end
#==============================================================================
# ■ 1-3內容
#==============================================================================
module Stage1_3
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[1, 2530, 0, false, false],[2, 2580, 0, false, false],
    [3, 2730, 0, false, false], [3, 3190, 0, false, false], [2, 2920, 0, false, false],  [2, 3090, 0, false, false]
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = []
  # 呼叫公共事件
  Event = 15
end
#==============================================================================
# ■ 1-4 劇情
#==============================================================================
module Stage1_4
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [ 
  [10, 4560, 0, false, false]
  #[1, 0, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = []
  # 呼叫公共事件
  Event = 4
end

#==============================================================================
# ■ 第一關 追逐戰劇情
#==============================================================================
module Stage1_BOSS1
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [ 
  [10, 1500, 0, false, true]
  #[1, 0, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = []
  # 計時器時間到時呼叫公共事件
  TimeUP = 12
  # 呼叫公共事件
  Event = 11
end
#==============================================================================
# ■ 第一關 追逐戰
#==============================================================================
module Stage1_BOSS2
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [ 
  [1, 0, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = []
  # 呼叫公共事件
  Event = 13
end
#==============================================================================
# ■ 第一關 正式Boss戰
#==============================================================================
module Stage1_BOSSBattle
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[14, 1500, 0, false, false]#, 
 # [1, 1200, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 1200, 1]]
  # 呼叫公共事件
  Event = 0
end

#==============================================================================
# ■ 2-1-1內容
#==============================================================================
module Stage21_1
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [ 
  [4, 465, 0, false, false], [5, 516, 0, false, false], [2, 585, 0, false, false], [3, 885, 0, false, false],
  [4, 691, 0, false, false], [1, 785, 0, false, false], [2, 944, 0, false, false]
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[60, 1064, 70], [65, 1106, 0]]
  # 呼叫公共事件
  Event = 0
end
#==============================================================================
# ■ 2-1-2內容
#==============================================================================
module Stage21_2
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [ 
  [1, 77, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = []
  # 呼叫公共事件
  Event = 15
end
#==============================================================================
# ■ 2-2-1內容
#==============================================================================
module Stage22_1
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [
  [2, 483, -150, false, false], [4, 707, -150, false, false],
  [1, 1070, -150, false, false], [4, 1434, -150, false, false], [5, 1660, -150, false, false],
  [2, 1900, -150, false, false]
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[65, 2070, -150], [65, 3730, 380]]
  # 呼叫公共事件
  Event = 0
end
#==============================================================================
# ■ 2-2-2內容
#==============================================================================
module Stage22_2
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [
  [4, 2218, -684, false, false], [1, 2795, -684, false, false], [5, 3268, -684, false, false], 
  [4, 2818, -150, false, false], [3, 2842, -150, false, false], [2, 3048, -150, false, false],
 # [23, 2822, -694, false, false]
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [
  [52, 2455, -694], [54, 3014, -648], [55, 3225, -648], [56, 3408, -663], [57, 3605, -713], [60, 2984, -130]
  ]
  # 呼叫公共事件
  Event = 22
end
#==============================================================================
# ■ 2-2-3 劇情
#==============================================================================
module Stage22_3
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[11, 4400, 350, true, false],
  [1, 0, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[58, 4400, 350]
  #[52, 2455, -694], [54, 3014, -648], [55, 3225, -648], [56, 3408, -663], [57, 3605, -713], [58, 4400, 350]
  ]
  # 呼叫公共事件
  Event = 16
end

#==============================================================================
# ■ 第二關 BOSS
#==============================================================================
module Stage2_BOSSBattle
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[11, 600, -170, false, true]#, 
 # [1, 1200, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 450, -169]]
  # 呼叫公共事件
  Event = 0
end

#==============================================================================
# ■ 第二關 BOSS戰後劇情
#==============================================================================
module Stage2_AfterBOSSBattle
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [
  [1, 600, -170, true, false] # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 450, -169]]
  # 呼叫公共事件
  Event = 0
end


#==============================================================================
# ■ 3-1
#==============================================================================
module Stage3_RUNRUNRUN
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[18, 0, 0, true, true], 
  #[1, 1200, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[66, 270, 0], [67, 4700, 0], [68, 4710, 50], [59, 670, 0]]
  # 呼叫公共事件
  Event = 0
end
#==============================================================================
# ■ 3-2 劇情
#==============================================================================
module Stage3_Senerio
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[30, 900, 0, false, true], 
  [6, 870, 0, true, false], [6, 1020, 0, true, false], [6, 1150, 0, true, false], 
  [6, 250, 0, true, false], [6, 350, 0, true, false], [6, 520, 0, true, false]
 # [1, 1200, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 450, -169]]
  # 呼叫公共事件
  Event = 0
end


#==============================================================================
# ■ 3-3 劇情
#==============================================================================
module Stage3_Senerio2
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[30, 600, 0, false, true]
 # [1, 1200, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 450, -169]]
  # 呼叫公共事件
  Event = 0
end

#==============================================================================
# ■ 最終戰
#==============================================================================
module FinalBOSS
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[31, 900, 0, false, false]
 # [1, 1200, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 750, 0]]
  # 呼叫公共事件
  Event = 0
end

#==============================================================================
# ■ 第三關 BOSS戰後劇情
#==============================================================================
module Stage3_AfterBOSSBattle
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[31, 900, 0, false, false], 
  [1, 600, 0, true, false] # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 950, 0]]
  # 呼叫公共事件
  Event = 0
end


#==============================================================================
# ■ 第三關 尾聲
#==============================================================================
module Stage3_Ending
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[62, 970, 0, false, false], [64, 1050, 0, false, false],
  [12, 730, 0, true, false], [13, 930, 0, true, false], [1, 600, 0, true, false] 
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 950, 0], [61, 900, 0]]
  # 呼叫公共事件
  Event = 0
end

#==============================================================================
# ■ 結局A
#==============================================================================
module EndingA
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[63, 930, 0, false, false],
  
  [1, 720, 0, false, true], [5, 756, 0, false, true], [4, 790, 0, false, true], [4, 835, 0, false, true],
  [1, 985, 0, false, true], [4, 1041, 0, false, true], [5, 1096, 0, false, true],
  
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 900, 0]]
  # 呼叫公共事件
  Event = 0
end
#==============================================================================
# ■ 結局B
#==============================================================================
module EndingB
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[63, 930, 0, false, false],
  [1, 720, 0, false, true], [1, 985, 0, false, true], [5, 756, 0, false, true], [4, 790, 0, false, true], 
  [4, 835, 0, false, true], [4, 1041, 0, false, true], [5, 1096, 0, false, true]
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 900, 0]]
  # 呼叫公共事件
  Event = 0
end

#==============================================================================
# ■ 測試1
#==============================================================================
module Stage_Test
  Enemies = [ 
  [1, 550, 0, false, false], [1, 1020, 0, false, false], [5, 1120, 0, false, false], [5, 660, 0, true, false],  # <=卡住關卡用
  [2, 1350, 0, false, false], [2, 1650, 0, false, false], [1, 1440, 0, false, false], [5, 1940, 0, false, false],
  [4, 1715, 0, false, false], [3, 2140, 0, false, false], [4, 2240, 0, false, false]]
  # 設置物件(敵人角色ID、X、Y)
  Objects = []
  Event = 0
end

#==============================================================================
# ■ 測試2
#==============================================================================
module Stage_Test2
  Enemies = [[13, 300, 0, true, true],
  [23, 600, 0, false, false]
  ] # <=卡住關卡用
  
  # 設置物件(敵人角色ID、X、Y)
  Objects = [
 # [53, 550, 0], [52, 2340, -684]
  ]
  Event = 0
end


#==============================================================================
# ■ 測試3
#==============================================================================
module Stage_TestBOSS
  Enemies = [[11, 900, 0, false, false], [1, 40, 0, true, false]]
  
  # 設置物件(敵人角色ID、X、Y)
  Objects = [
  ]
  Event = 0
end

#==============================================================================
# ■ 測試4 隨便boss
#==============================================================================
module Stage_TestBOSS2
  Enemies = [[12, 900, 0, false, false]]
  
  # 設置物件(敵人角色ID、X、Y)
  Objects = [
  ]
  Event = 0
end

#==============================================================================
# ■ 測試5 奶奶
#==============================================================================
module Stage_Test3
  Enemies = [[30, 900, 0, false, false], [1, 40, 0, true, false]
  ]
  
  # 設置物件(敵人角色ID、X、Y)
  Objects = [
  ]
  Event = 0
end




#==============================================================================
# ■ 展示1-1內容
#==============================================================================
module Demo1_1
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[1, 920, 0, false, false], [2, 860, 0, false, false], [2, 960, 0, false, false], [1, 660, 0, false, false],
    [3, 1020, 0, false, false], [1, 1120, 0, false, false], [2, 1290, 0, false, false],
    [3, 1950, 0, false, false], [1, 1860, 0, false, false], [1, 1690, 0, false, false], [2, 1990, 0, false, false]
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[60, 2620, 70],
  [70, 50, 0]
  ]
  # 呼叫公共事件
  Event = 15
end
#==============================================================================
# ■ 展示1-2內容
#==============================================================================
module Demo1_2
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[1, 2530, 0, false, false],[2, 2580, 0, false, false], [1, 2680, 0, false, false],
    [3, 2730, 0, false, false], [3, 3190, 0, false, false], [2, 2920, 0, false, false],  [2, 3090, 0, false, false]
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = []
  # 呼叫公共事件
  Event = 15
end

#==============================================================================
# ■ 展示1-3內容
#==============================================================================
module Demo1_3
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[1, 3530, 0, false, false], [2, 4520, 0, false, false],
    [3, 3930, 0, false, false], [3, 4190, 0, false, false], [2, 5920, 0, false, false],  [2, 4090, 0, false, false],
    [1, 5530, 0, false, false], [1, 5030, 0, false, false], [3, 4630, 0, false, false], [2, 6030, 0, false, false], 
    [3, 6630, 0, false, false], [1, 6230, 0, false, false], [3, 6430, 0, false, false], [1, 7530, 0, true, true]
    
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = []
  # 呼叫公共事件
  Event = 15
end

#==============================================================================
# ■ 展示2-2-1內容
#==============================================================================
module Demo22_1
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [
  [2, 483, -150, false, false], [4, 707, -150, false, false], [3, 803, -150, false, false],
  [1, 1070, -150, false, false], [4, 1434, -150, false, false], [5, 1660, -150, false, false],
  [2, 1900, -150, false, false]
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[70, 50, 0]]
  # 呼叫公共事件
  Event = 0
end
#==============================================================================
# ■ 展示2-2-2內容
#==============================================================================
module Demo22_2
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [
  [4, 2218, -684, false, false], [1, 2795, -684, false, false], [5, 3268, -684, false, false], 
  [4, 2818, -150, false, false], [3, 2842, -150, false, false], [2, 3048, -150, false, false],
  [23, 2822, -694, false, false]
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [
  [54, 3014, -648], [55, 3225, -648], [56, 3408, -663], [57, 3605, -713], [60, 2984, -130]
  ]
  # 呼叫公共事件
  Event = 15
end
#==============================================================================
# ■ 展示2-2-3 劇情
#==============================================================================
module Demo22_3
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[11, 4400, 350, true, false],
  [1, 0, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[58, 4400, 350]
  #[52, 2455, -694], [54, 3014, -648], [55, 3225, -648], [56, 3408, -663], [57, 3605, -713], [58, 4400, 350]
  ]
  # 呼叫公共事件
  Event = 16
end

#==============================================================================
# ■ 展示BOSS
#==============================================================================
module Demo_BOSSBattle
  Enemies = [[11, 900, -170, false, false], [1, 40, 0, true, false]]
  
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[70, 50, -170]
  ]
  Event = 0
end
#==============================================================================
# ■ 練習
#==============================================================================
module Practice_STAGE
  Enemies = []  # 這在Scene_Battle的main設定
  # 設置物件(敵人角色ID、X、Y)
  Objects = [
  ]
  Event = 0
end
#==============================================================================
# ■ 教學
#==============================================================================
module Tutorial_STAGE
  Enemies = [[1, 5140, 0, true, false]]
  
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[71, 50, -170],
  ]
  Event = 0
end


#==============================================================================
# ■ 挑戰模式 1
#==============================================================================
module EXstage1
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[39, 1500, 0, false, false], 
  #[4, 1540, 0, false, false], [4, 1580, 0, false, false], [4, 1620, 0, false, false], [4, 1660, 0, false, false], [4, 1700, 0, false, false], 
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 1200, 1]]
  # 呼叫公共事件
  Event = 0
end

#==============================================================================
# ■ 挑戰模式 2
#==============================================================================
module EXstage2
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[40, 600, -170, false, true]#, 
 # [1, 1200, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 450, -169]]
  # 呼叫公共事件
  Event = 0
end


#==============================================================================
# ■ 挑戰模式 3
#==============================================================================
module EXstage3
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[43, 600, 0, false, false]
 # [1, 1200, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 450, -169]]
  # 呼叫公共事件
  Event = 0
end

#==============================================================================
# ■ 挑戰模式 4
#==============================================================================
module EXstage4
  # 敵人群(ID、X、Y、隱藏判定、不死判定)
  Enemies = [[44, 900, 0, false, false]
 # [1, 1200, 0, true, false]  # <=卡住關卡用
  ]
  # 設置物件(敵人角色ID、X、Y)
  Objects = [[59, 750, 0]]
  # 呼叫公共事件
  Event = 0
end
