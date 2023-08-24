#============================================================================
# ■ 全手柄脚本
#----------------------------------------------------------------------------
# 　By: 洛克人SZ
#   Date: 2008.06.05
#   Version 1
#============================================================================


module Joyall
  #==========================================================================
  # 以下是常量列表
  #--------------------------------------------------------------------------
  JOYSTICKID1 = 0
  JOYSTICKID2 = 1

  JOY_POVCENTERED = -1
  JOY_POVFORWARD = 0
  JOY_POVRIGHT = 9000
  JOY_POVLEFT = 27000
  JOY_RETURNX = 0x0001
  JOY_RETURNY = 0x0002
  JOY_RETURNZ = 0x0004
  JOY_RETURNR = 0x0008
  JOY_RETURNU = 0x0010
  JOY_RETURNV = 0x0020
  JOY_RETURNPOV = 0x0040
  JOY_RETURNBUTTONS = 0x0080
  JOY_RETURNRAWDATA = 0x0100
  JOY_RETURNPOVCTS = 0x0200
  JOY_RETURNCENTERED = 0x0400
  JOY_USEDEADZONE = 0x0800
  JOY_RETURNALL = (JOY_RETURNX + JOY_RETURNY + JOY_RETURNZ + JOY_RETURNR + JOY_RETURNU + JOY_RETURNV + JOY_RETURNPOV + JOY_RETURNBUTTONS)
  JOY_CAL_READALWAYS = 0x10000
  JOY_CAL_READRONLY = 0x2000000
  JOY_CAL_READ3 = 0x40000
  JOY_CAL_READ4 = 0x80000
  JOY_CAL_READXONLY = 0x100000
  JOY_CAL_READYONLY = 0x200000
  JOY_CAL_READ5 = 0x400000
  JOY_CAL_READ6 = 0x800000
  JOY_CAL_READZONLY = 0x1000000
  JOY_CAL_READUONLY = 0x4000000
  JOY_CAL_READVONLY = 0x8000000
    
    
  # google來的返回值常量
  JOYERR_NOERROR = 0        # 手把正常
  MMSYSERR_NODRIVER = 6     # (錯誤)手把驅動不存在
  MMSYSERR_INVALPARAM = 11  # (錯誤)參數無效
  JOYERR_PARMS = 165        # (錯誤)指定的手把ID無效(啟動時沒插手把就會得到這個值)
  JOYERR_NOCANDO = 166      # (錯誤)必要なサービス(WIndows タイマなど)が利用できないため、ジョイスティックの入力をキャプチャできない。
  JOYERR_UNPLUGGED = 167    # (錯誤)手把未連接(插過，但是拔出來了)
    
  Keys = [
    JB_1 = 0x0001,
    JB_2 = 0x0002,
    JB_3 = 0x0004,
    JB_4 = 0x0008,
    JB_5 = 0x0010,
    JB_6 = 0x0020,
    JB_7 = 0x0040,
    JB_8 = 0x0080,
    JB_9 = 0x0100,
    JB_10 = 0x0200,
    JB_11 = 0x0400,
    JB_12 = 0x0800
    # 發現用不到這麼多，之後的都砍了
  ]
  
  
  #--------------------------------------------------------------------------
  # ● 常量
  #--------------------------------------------------------------------------
  # 調用JoyGetPosEx必須的結構體
  Pack_Temp = 'l*'
  JOYINFOEX = [64,JOY_RETURNALL,0,0,0,0,0,0,0,0,0,0,0].pack(Pack_Temp)
  
  Stick_left_up = 30000      # 香菇頭的值低於多少判定成往左／上 (MIN：0，中間值：32766 or 32767)
  Stick_right_down = 34000   # 香菇頭的值高於多少判定成往右／下 (MAX：65535，中間值：32766 or 32767)
  
  KeyRepeatWait = 20       # 長按，第一次間隔
  KeyRepeatInterval = 6    # 長按，第二次以後間格
  
  JoyNumber = 2 # 搖桿數(其實最多也只能用2個)
  #==========================================================================
  # 以下是 API 声明
  #--------------------------------------------------------------------------
  JoyGetPosEx = Win32API.new("winmm.dll", "joyGetPosEx", "lp", "l")
  JoySetCapture = Win32API.new("winmm.dll", "joySetCapture", "llll", "l")
  JoyReleaseCapture = Win32API.new("winmm.dll", "joyReleaseCapture", "l", "l")
  #--------------------------------------------------------------------------
  # ● 初始化
  #--------------------------------------------------------------------------
  @R_Button_Hash = {}
  @R_Button_Repeat = {}

  @joysticks = {}
#~   # 依搖桿數量生成判斷變數
#~   JoyNumber.times { |num|
#~     @joysticks[num] = {}
#~     @joysticks[num][:currentDir] = {:cross => [], :left_stick => [], :right_stick => []}
#~     @joysticks[num][:currentState] = {}
#~     @joysticks[num][:previousState] = {}
#~     @joysticks[num][:previousState] = {}
#~     @joysticks[num][:latestButton] = nil
#~     @joysticks[num][:pressedTime] = 0
#~     @joysticks[num][:state] = 0
#~     # 啟動遊戲時，判斷一次搖桿狀態，如果未連結以後不在update更新
#~     @joysticks[num][:usable] = JoyGetPosEx.call(num, JOYINFOEX.dup) != JOYERR_PARMS
#~     
#~     if @joysticks[num][:usable]
#~       print("搖桿 #{num} 號已就緒\n")
#~     else
#~       print("搖桿 #{num} 號未連結，如要使用請插上搖桿並重開遊戲\n")
#~     end
#~     
#~     
#~   }
  #==========================================================================
  module_function
  #--------------------------------------------------------------------------
  # ● 搖桿就緒？
  #--------------------------------------------------------------------------
  def usable?(id)
    return @joysticks[id][:usable] && @joysticks[id][:state] == JOYERR_NOERROR
  end
  #--------------------------------------------------------------------------
  # ● 插入檢查
  #--------------------------------------------------------------------------
  def check_insert
    # 依搖桿數量生成判斷變數
    JoyNumber.times { |num|
      @joysticks[num] = {}
      
      joy = @joysticks[num]
      
      joy[:currentDir] = {:cross => [], :left_stick => [], :right_stick => []}
      joy[:currentState] = {}
      joy[:previousState] = {}
      joy[:previousState] = {}
      joy[:latestButton] = nil
      joy[:pressedTime] = 0
    #  @joysticks[num][:state] = 0
      # 啟動遊戲時，判斷一次搖桿狀態，如果未連結以後不在update更新
      JoyGetPosEx.call(num, JOYINFOEX.dup)  # 不懂為什麼試一次出錯後，要連續叫兩次才有，可能是初始化的緣故
      joy[:usable] = JoyGetPosEx.call(num, JOYINFOEX.dup) != JOYERR_PARMS
      joy[:state] = JoyGetPosEx.call(num, JOYINFOEX.dup)
    #  if usable?(num)#@joysticks[num][:usable]
    #    print("搖桿 #{num} 號已就緒\n")
  #    else
     #   print("搖桿 #{num} 號未連結，如要使用請插上搖桿並重開遊戲\n")
    #  end 
    }  
  end
  check_insert # 遊戲啟動時執行一次
  #--------------------------------------------------------------------------
  # ● 取得按鍵狀態 (joyID：第幾個搖桿，從0開始)
  #--------------------------------------------------------------------------
  def get_joypos(joyID = 0)
    myjoy = JOYINFOEX#.dup  # 結構體，C語言需要
    @joysticks[joyID][:state] = JoyGetPosEx.call(joyID, myjoy) 
    myjoy = myjoy.unpack(Pack_Temp)
    return myjoy
  end

  
  #==========================================================================
  # ANALOG 模式下对应十字键(x, y)   
  # 7：31500
  # 8：0
  # 9：4500
  # 4：27000
  # 5: 65535
  # 6：9000
  # 1：22500
  # 2：18000
  # 3：13500
  #--------------------------------------------------------------------------
  def direction_a(myjoy)
    case myjoy[10]
    when 0
      return 8
    when 18000
      return 2
    when 27000
      return 4
    when 9000
      return 6
    when 31500
      return 7
    when 4500
      return 9
    when 22500
      return 1
    when 13500
      return 3
    else
      return 5
    end

 #   return myjoy[10]
  end
  #==========================================================================
  # ANALOG 模式下对应左摇杆(x, y)   
  #--------------------------------------------------------------------------
  def direction_b(myjoy)
    x = myjoy[2]
    y = myjoy[3]
#~     # === 8
#~     if y == 0
#~       return 8
#~     # === 2
#~     elsif y == 65535
#~       return 2 
#~     # === 4
#~     elsif x == 0
#~       return 4
#~     # === 6
#~     elsif x == 65535
#~       return 6
#~     # === 7  
#~     elsif x < Stick_left_up && y < Stick_left_up
#~       return 7
#~     # === 9
#~     elsif x > Stick_right_down && y < Stick_left_up
#~       return 9
#~     # === 1
#~     elsif x < Stick_left_up && y > Stick_right_down
#~       return 1
#~     # === 3
#~     elsif x > Stick_right_down && y > Stick_right_down
#~       return 3
#~     # === 5
#~     else
#~       return 5
#~     end
    
    if x < Stick_left_up
      x = -1
    elsif x > Stick_right_down
      x = 1
    else
      x = 0
    end
    
    if y < Stick_left_up
      y = -1
    elsif y > Stick_right_down
      y = 1
    else
      y = 0
    end
    
    # MV來的方向算式(左(x:-1)、右(x:1)、上(y:-1)、下(y:1))
    return  5 - y * 3 + x
    
    
  end
#~   #==========================================================================
#~   # ANALOG 模式下对应右摇杆(x, y)  (data(4)~data(7)變數太多，而且這系統用不到，跳過) 
#~   #--------------------------------------------------------------------------
#~   def direction_c
#~     myjoy = get_joypos(0)
#~     return myjoy[4], myjoy[5]
#~   end
  #==========================================================================
  # 同時按鍵數(不包含十字鍵)
  #--------------------------------------------------------------------------
  def press_buttons(myjoy)
    return myjoy[9]
  end
  #--------------------------------------------------------------------------
  # ● 按了 (joyID：第幾號搖桿，0開始)
  #--------------------------------------------------------------------------
  def press?(rkey, joyID)
    return @joysticks[joyID][:currentState][rkey]
  end
  #--------------------------------------------------------------------------
  # ● 按下
  #--------------------------------------------------------------------------
  def trigger?(rkey, joyID)
    return (@joysticks[joyID][:latestButton] == rkey && @joysticks[joyID][:pressedTime] == 0)
  end
  #--------------------------------------------------------------------------
  # ● 按住
  #--------------------------------------------------------------------------
  def repeat?(rkey, joyID)
    myjoy = @joysticks[joyID]
    return (myjoy[:latestButton] == rkey && 
            (myjoy[:pressedTime] == 0 ||
            (myjoy[:pressedTime] >= KeyRepeatWait && myjoy[:pressedTime] % KeyRepeatInterval == 0)))
  end    
  #--------------------------------------------------------------------------
  # ● 方向檢查
  #--------------------------------------------------------------------------
  def dir8(joyID)
    currentDir = @joysticks[joyID][:currentDir]
    if currentDir[:left_stick][0] == nil
      return 5
    else
      return (currentDir[:left_stick][0] != 5 ? currentDir[:left_stick][0] : currentDir[:cross][0])
    end 
  end
  
  #--------------------------------------------------------------------------
  # 方向判斷 (press)
  #--------------------------------------------------------------------------
  def press_dir?(dir, joyID)
    currentDir = @joysticks[joyID][:currentDir]
    return (currentDir[:left_stick][0] != 5 ? currentDir[:left_stick][0] == dir : currentDir[:cross][0] == dir)
  end
  
  #--------------------------------------------------------------------------
  # 方向判斷 (trigger)
  #--------------------------------------------------------------------------
  def trigger_dir?(dir, joyID) 
    currentDir = @joysticks[joyID][:currentDir]
    return (currentDir[:left_stick][0] != 5 ? (currentDir[:left_stick][0] == dir && currentDir[:left_stick][1] == 0) :
            (currentDir[:cross][0] == dir && currentDir[:cross][1] == 0))
  
  end
  #--------------------------------------------------------------------------
  # 方向判斷 (repeat)
  #--------------------------------------------------------------------------
  def repeat_dir?(dir, joyID) 
    currentDir = @joysticks[joyID][:currentDir]
    stick = currentDir[:left_stick]
    cross = currentDir[:cross]
    return (stick[0] != 5 ? (stick[0] == dir && (stick[1] == 0 || (stick[1] >= KeyRepeatWait && stick[1] % KeyRepeatInterval == 0))) :
            (cross[0] == dir && (cross[1] == 0 || (cross[1] >= KeyRepeatWait && cross[1] % KeyRepeatInterval == 0))))
  end
  
  #--------------------------------------------------------------------------
  # ● 定期更新
  #--------------------------------------------------------------------------
  def update
    for id in @joysticks.keys
      
      # 取得Joyall判斷變數
      joystates = @joysticks[id]
      # 搖桿不可使用時跳過(不然會重處理)
      next if !usable?(id) #joystates[:usable]
      # 取得搖桿狀態
      myjoy = get_joypos(id)
      current = joystates[:currentState]
      Keys.each do |key|
        if joystates[:state] == JOYERR_NOERROR
          case key
          when 1024  # L2
            current[key] = (myjoy[4] > 32767)
          when 2048  # R2
            current[key] = (myjoy[4] < 32767)
          else
            current[key] = (myjoy[8] == key)
          end   
  #~         if myjoy[8] == key# && joystates[:state] == JOYERR_NOERROR
  #~           current[key] = true
  #~         else
  #~           current[key] = false
  #~         end
        else
          current[key] = false
        end
      end
      if current[joystates[:latestButton]]
        joystates[:pressedTime] += 1
      else 
        joystates[:latestButton] = nil
      end
      current.keys.each do |key|
        if (current[key] && !joystates[:previousState][key])
            # 記憶最後按鍵(trigger判斷用)
            joystates[:latestButton] = key
            joystates[:pressedTime] = 0
        end
        joystates[:previousState][key] = current[key]
      end
      # 搖桿是正常運作的情況
      if joystates[:state] == JOYERR_NOERROR
        # 取得方向(十字鍵)
        now_cross = direction_a(myjoy)
        currentDir = joystates[:currentDir]
        currentCross = currentDir[:cross]
        if currentCross[0] != now_cross
          currentCross[0] = now_cross
          currentCross[1] = 0
        elsif currentCross[0] != 5
          currentCross[1] += 1
        end
        # 取得方向(左蘑菇)
        now_left_stick = direction_b(myjoy)
        currentLStick = currentDir[:left_stick]
        if currentLStick[0] != now_left_stick
          currentLStick[0] = now_left_stick
          currentLStick[1] = 0
        elsif currentLStick[0] != 5
          currentLStick[1] += 1
        end
      else
        currentDir = joystates[:currentDir]
        currentCross = currentDir[:cross]
        currentLStick = currentDir[:left_stick]
        currentCross[0] = currentLStick[0] = 5
        currentCross[1] = currentLStick[1] = 0
      end
      
    end # for id in @joysticks.keys
  end # def end

end


class << Input
  alias :alljoy_update :update unless method_defined?("alljoy_update")
  def update
     alljoy_update
     Joyall.update
  end
end





#~ # 測速用
#~ a = Time.now
#~ 100000.times {Joyall.update}
#~ b = Time.now - a
#~ p "執行 Kboard.update 10萬次，耗時 #{b} 秒"

#~ a = Time.now
#~ 100000.times {Joyall.update2}
#~ b = Time.now - a
#~ p "執行 Kboard.update 10萬次，耗時 #{b} 秒"



