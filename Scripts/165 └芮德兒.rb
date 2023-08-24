#==============================================================================
# ■ Red的Motion


# 註：計算總動作時間時記得是每個wait
#==============================================================================
class Red_Sickle < Game_Motion
#--------------------------------------------------------------------------
# ○ 人物生成/初始化
#--------------------------------------------------------------------------
def initialize(me,frame=0,anime="stand")
  super
  
  
  # 宣告所有動畫
  @anime = {"awake" => [], "stand" => [], "stand_idle" => [], "walk" => [], "story_walk" => [], "dash" => [], "story_dash" => [], "dash_break" => [],
  "jump" => [], "double_jump" => [], "f_jump" => [], "b_jump" => [], "h_jump" => [],
  "hf_jump" => [], "hb_jump" => [], 
  "jump_fall" => [], "double_jump_fall" => [], "f_jump_fall" => [], "b_jump_fall" => [],
  "hf_jump_fall" => [], "hb_jump_fall" => [], "h_jump_fall" => [],
  "landing" => [], "crouch_start" => [], "crouch" => [], "crouch_end" => [],
  "guard" => [], "guard_shock" => [], "damage1" => [], "damage2" => [],
  "f_blow" => [], "b_blow" => [], "hf_blow" => [], "hb_blow" => [],
  "vertical_blow" => [], "vertical_blow_fall" => [], "parallel_f_blow" => [], "parallel_b_blow" => [],
  "f_down" => [], "b_down" => [], "hf_down" => [], "hb_down" => [], 
  "bounce_f_down" => [], "bounce_b_down" => [], "pressure_f_down" => [], "pressure_b_down" => [],
  "f_down_stand" => [], "b_down_stand" => [], 
  "f_chase" => [], "b_chase" => [], "u_chase" => [], "d_chase" => [], "af_chase" => [], "ab_chase" => [],
  "f_flee" => [], "b_flee" => [], "af_flee" => [], "ab_flee" => [],
  "ukemi" => [], "f_ukemi" => [], "b_ukemi" => [], "a_ukemi" => [], "af_ukemi" => [], "ab_ukemi" => [],
  "5z" => [], "5zz" => [], "5zzz" => [], "6z" => [], "2z" => [],
  "jz" => [], "j2z" => [], "j6z" => [],
   "5x" => [], "j2x" => [],
   "jz_effect1" => [],
  "ball" => [], "ball_b" => [], "dizzy1" => [], "dizzy2" => [], "binding" => [], "binding2" => [], "binding3" => [], "dead"=>[],
  
  "story_down" => [], "story_5x" => [], "story_ball" => [],
  "story_stand" => [], "story_idle" => [], "story_6z" => [], "story_dash2" => [], "dash_break2" => []
  
  }
  
  
  # 設定動作的影格
  frame_set
  
  @full_limit = 11
   
  @black_tone = Tone.new(-125,-165,-125)
  @original_tone = Tone.new(0,0,0)
end

#==============================================================================
# ■影格設置
#==============================================================================
#==============================================================================
=begin
 state 對應表：
 

 0：站著
 1：行走
 2：跑
 3：剎車/一般行動中
 4：跳躍準備
 5：跳躍中/落下
 6：空突進
 7：空迴避
 10：防禦
 11：防禦硬直
 12：蹲下
 13：受傷
 14：擊飛(一般)
 15：擊飛(垂直)
 16：擊飛(橫向)
 17：倒地
 18：倒地反彈
 20：被捉
 
 21：弱攻擊
 22：強攻擊
 23：超必殺

 
 
=end
#==============================================================================


def frame_set
#-------------------------------------------------------------------------------
# ○ 獸化
#-------------------------------------------------------------------------------
@anime["awake"][0] = {"pic" => 1, "wait" => 20, "next" => "to_awake", "ab_uncancel" => 10, "uncancel" => true, "anime" => [1,0,0], "superstop" => 21, "supermove" => 21, "camera" => [25,30,30], "black" => [40,50], "fps" => [23, 55], "z_pos" => 3, "y_fixed" => true, "x_speed" => 0, "y_speed" => 0, "eva" => 20}
  
#-------------------------------------------------------------------------------
# ○ 站立
#-------------------------------------------------------------------------------
@anime["stand"][0] = {"pic" => 1, "wait" => 4, "next" => 1, "body" => @me.stand_body_rect, "z_pos" =>  1}
@anime["stand"][1] = {"pic" => 2, "wait" => 4, "next" => 2}
@anime["stand"][2] = {"pic" => 3, "wait" => 4, "next" => 3}
@anime["stand"][3] = {"pic" => 4, "wait" => 4, "next" => 4}
@anime["stand"][4] = {"pic" => 5, "wait" => 4, "next" => 5}
@anime["stand"][5] = {"pic" => 6, "wait" => 4, "next" => 6}
@anime["stand"][6] = {"pic" => 7, "wait" => 4, "next" => 7}
@anime["stand"][7] = {"pic" => 8, "wait" => 4, "next" => 8}
@anime["stand"][8] = {"pic" => 9, "wait" => 4, "next" => 9}
@anime["stand"][9] = {"pic" => 10, "wait" => 4, "next" => 10}
@anime["stand"][10] = {"pic" => 11, "wait" => 4, "next" => 11}
@anime["stand"][11] = {"pic" => 12, "wait" => 4, "next" => 12}
@anime["stand"][12] = {"pic" => 13, "wait" => 4, "next" => 13}
@anime["stand"][13] = {"pic" => 14, "wait" => 4, "next" => 14}
@anime["stand"][14] = {"pic" => 15, "wait" => 4, "next" => 15}
@anime["stand"][15] = {"pic" => 16, "wait" => 4, "next" => 16}
@anime["stand"][16] = {"pic" => 17, "wait" => 4, "next" => 17}
@anime["stand"][17] = {"pic" => 18, "wait" => 4, "next" => 18}
@anime["stand"][18] = {"pic" => 19, "wait" => 4, "next" => 19}
@anime["stand"][19] = {"pic" => 20, "wait" => 4, "next" => 20}
@anime["stand"][20] = {"pic" => 21, "wait" => 4, "next" => 21}
@anime["stand"][21] = {"pic" => 22, "wait" => 4, "next" => 22}
@anime["stand"][22] = {"pic" => 23, "wait" => 4, "next" => 23}
@anime["stand"][23] = {"pic" => 24, "wait" => 4, "next" => 24}
@anime["stand"][24] = {"pic" => 25, "wait" => 4, "next" => 25}
@anime["stand"][25] = {"pic" => 26, "wait" => 4, "next" => 26}
@anime["stand"][26] = {"pic" => 27, "wait" => 4, "next" => 27}
@anime["stand"][27] = {"pic" => 28, "wait" => 4, "next" => 28}
@anime["stand"][28] = {"pic" => 29, "wait" => 4, "next" => 29}
@anime["stand"][29] = {"pic" => 30, "wait" => 4, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 閒置
#-------------------------------------------------------------------------------
@anime["stand_idle"][0] = {"pic" => 31, "wait" => 3, "next" => 1}
@anime["stand_idle"][1] = {"pic" => 32, "wait" => 3, "next" => 2}
@anime["stand_idle"][2] = {"pic" => 33, "wait" => 3, "next" => 3}
@anime["stand_idle"][3] = {"pic" => 34, "wait" => 3, "next" => 4}
@anime["stand_idle"][4] = {"pic" => 35, "wait" => 3, "next" => 5}
@anime["stand_idle"][5] = {"pic" => 36, "wait" => 3, "next" => 6}
@anime["stand_idle"][6] = {"pic" => 37, "wait" => 3, "next" => 7}
@anime["stand_idle"][7] = {"pic" => 38, "wait" => 3, "next" => 8}
@anime["stand_idle"][8] = {"pic" => 39, "wait" => 3, "next" => 9}
@anime["stand_idle"][9] = {"pic" => 40, "wait" => 3, "next" => 10}
@anime["stand_idle"][10] = {"pic" => 34, "wait" => 3, "next" => 11}
@anime["stand_idle"][11] = {"pic" => 35, "wait" => 3, "next" => 12}
@anime["stand_idle"][12] = {"pic" => 36, "wait" => 3, "next" => 13}
@anime["stand_idle"][13] = {"pic" => 37, "wait" => 3, "next" => 14}
@anime["stand_idle"][14] = {"pic" => 38, "wait" => 3, "next" => 15}
@anime["stand_idle"][15] = {"pic" => 39, "wait" => 3, "next" => 16}
@anime["stand_idle"][16] = {"pic" => 40, "wait" => 3, "next" => 17}
@anime["stand_idle"][17] = {"pic" => 33, "wait" => 3, "next" => 18}
@anime["stand_idle"][18] = {"pic" => 32, "wait" => 3, "next" => 19}
@anime["stand_idle"][19] = {"pic" => 31, "wait" => 3, "next" => 20}
@anime["stand_idle"][20] = {"pic" => 30, "wait" => 3, "next" => ["stand"]}

#------------------------------------------------------------------------------
# ○ 走路
#-------------------------------------------------------------------------------
@anime["walk"][0] = {"pic" => 51, "wait" => 3, "next" => 1, "z_pos" =>  1}
@anime["walk"][1] = {"pic" => 52, "wait" => 3, "next" => 2}
@anime["walk"][2] = {"pic" => 53, "wait" => 3, "next" => 3}
@anime["walk"][3] = {"pic" => 54, "wait" => 3, "next" => 4}
@anime["walk"][4] = {"pic" => 55, "wait" => 3, "next" => 5}
@anime["walk"][5] = {"pic" => 56, "wait" => 3, "next" => 6}
@anime["walk"][6] = {"pic" => 57, "wait" => 3, "next" => 7}
@anime["walk"][7] = {"pic" => 58, "wait" => 3, "next" => 8}
@anime["walk"][8] = {"pic" => 59, "wait" => 3, "next" => 9}
@anime["walk"][9] = {"pic" => 60, "wait" => 3, "next" => 10}
@anime["walk"][10] = {"pic" => 61, "wait" => 3, "next" => 11}
@anime["walk"][11] = {"pic" => 62, "wait" => 3, "next" => 12}
@anime["walk"][12] = {"pic" => 63, "wait" => 3, "next" => 13}
@anime["walk"][13] = {"pic" => 64, "wait" => 3, "next" => 14}
@anime["walk"][14] = {"pic" => 65, "wait" => 3, "next" => 15}
@anime["walk"][15] = {"pic" => 66, "wait" => 3, "next" => 16}
@anime["walk"][16] = {"pic" => 67, "wait" => 3, "next" => 17}
@anime["walk"][17] = {"pic" => 68, "wait" => 3, "next" => 18}
@anime["walk"][18] = {"pic" => 69, "wait" => 3, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 走路(劇情用)
#-------------------------------------------------------------------------------
@anime["story_walk"][0] = {"pic" => 51, "wait" => 3, "next" => 1, "z_pos" =>  1}
@anime["story_walk"][1] = {"pic" => 52, "wait" => 3, "next" => 2}
@anime["story_walk"][2] = {"pic" => 53, "wait" => 3, "next" => 3}
@anime["story_walk"][3] = {"pic" => 54, "wait" => 3, "next" => 4}
@anime["story_walk"][4] = {"pic" => 55, "wait" => 3, "next" => 5}
@anime["story_walk"][5] = {"pic" => 56, "wait" => 3, "next" => 6}
@anime["story_walk"][6] = {"pic" => 57, "wait" => 3, "next" => 7}
@anime["story_walk"][7] = {"pic" => 58, "wait" => 3, "next" => 8}
@anime["story_walk"][8] = {"pic" => 59, "wait" => 3, "next" => 9}
@anime["story_walk"][9] = {"pic" => 60, "wait" => 3, "next" => 10}
@anime["story_walk"][10] = {"pic" => 61, "wait" => 3, "next" => 11}
@anime["story_walk"][11] = {"pic" => 62, "wait" => 3, "next" => 12}
@anime["story_walk"][12] = {"pic" => 63, "wait" => 3, "next" => 13}
@anime["story_walk"][13] = {"pic" => 64, "wait" => 3, "next" => 14}
@anime["story_walk"][14] = {"pic" => 65, "wait" => 3, "next" => 15}
@anime["story_walk"][15] = {"pic" => 66, "wait" => 3, "next" => 16}
@anime["story_walk"][16] = {"pic" => 67, "wait" => 3, "next" => 17}
@anime["story_walk"][17] = {"pic" => 68, "wait" => 3, "next" => 18}
@anime["story_walk"][18] = {"pic" => 69, "wait" => 3, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 跑步
#-------------------------------------------------------------------------------
@anime["dash"][0] = {"pic" => 81, "wait" => 1, "next" => 1, "anime" => [11,0,0], "z_pos" =>  1}
@anime["dash"][1] = {"pic" => 82, "wait" => 1, "next" => 2}
@anime["dash"][2] = {"pic" => 83, "wait" => 1, "next" => 3}
@anime["dash"][3] = {"pic" => 84, "wait" => 1, "next" => 4}
@anime["dash"][4] = {"pic" => 85, "wait" => 1, "next" => 5}
@anime["dash"][5] = {"pic" => 86, "wait" => 1, "next" => 6}
@anime["dash"][6] = {"pic" => 87, "wait" => 1, "next" => 7}
@anime["dash"][7] = {"pic" => 88, "wait" => 1, "next" => 8}
@anime["dash"][8] = {"pic" => 89, "wait" => 1, "next" => 9}
@anime["dash"][9] = {"pic" => 90, "wait" => 1, "next" => 10}
@anime["dash"][10] = {"pic" => 91, "wait" => 1, "next" => 11}
@anime["dash"][11] = {"pic" => 92, "wait" => 1, "next" => 12}
@anime["dash"][12] = {"pic" => 93, "wait" => 1, "next" => 13}
@anime["dash"][13] = {"pic" => 94, "wait" => 1, "next" => 14}
@anime["dash"][14] = {"pic" => 95, "wait" => 1, "next" => 15}
@anime["dash"][15] = {"pic" => 96, "wait" => 1, "next" => 16}
@anime["dash"][16] = {"pic" => 97, "wait" => 1, "next" => 17}
@anime["dash"][17] = {"pic" => 98, "wait" => 1, "next" => 18}
@anime["dash"][18] = {"pic" => 99, "wait" => 1, "next" => 19}
@anime["dash"][19] = {"pic" => 100, "wait" => 1, "next" => 20}
@anime["dash"][20] = {"pic" => 101, "wait" => 1, "next" => 21}
@anime["dash"][21] = {"pic" => 102, "wait" => 1, "next" => 22}
@anime["dash"][22] = {"pic" => 103, "wait" => 1, "next" => 23}
@anime["dash"][23] = {"pic" => 104, "wait" => 1, "next" => 24}
@anime["dash"][24] = {"pic" => 105, "wait" => 1, "next" => 25}
@anime["dash"][25] = {"pic" => 106, "wait" => 1, "next" => 26}
@anime["dash"][26] = {"pic" => 107, "wait" => 1, "next" => 27}
@anime["dash"][27] = {"pic" => 108, "wait" => 1, "next" => 28}
@anime["dash"][28] = {"pic" => 109, "wait" => 1, "next" => 0}

#-------------------------------------------------------------------------------
# ○ 劇情用跑步
#-------------------------------------------------------------------------------
@anime["story_dash"][0] = {"pic" => 81, "wait" => 1, "next" => 1, "anime" => [11,0,0], "z_pos" =>  1}
@anime["story_dash"][1] = {"pic" => 82, "wait" => 1, "next" => 2}
@anime["story_dash"][2] = {"pic" => 83, "wait" => 1, "next" => 3}
@anime["story_dash"][3] = {"pic" => 84, "wait" => 1, "next" => 4}
@anime["story_dash"][4] = {"pic" => 85, "wait" => 1, "next" => 5}
@anime["story_dash"][5] = {"pic" => 86, "wait" => 1, "next" => 6}
@anime["story_dash"][6] = {"pic" => 87, "wait" => 1, "next" => 7}
@anime["story_dash"][7] = {"pic" => 88, "wait" => 1, "next" => 8}
@anime["story_dash"][8] = {"pic" => 89, "wait" => 1, "next" => 9}
@anime["story_dash"][9] = {"pic" => 90, "wait" => 1, "next" => 10}
@anime["story_dash"][10] = {"pic" => 91, "wait" => 1, "next" => 11}
@anime["story_dash"][11] = {"pic" => 92, "wait" => 1, "next" => 12}
@anime["story_dash"][12] = {"pic" => 93, "wait" => 1, "next" => 13}
@anime["story_dash"][13] = {"pic" => 94, "wait" => 1, "next" => 14}
@anime["story_dash"][14] = {"pic" => 95, "wait" => 1, "next" => 15}
@anime["story_dash"][15] = {"pic" => 96, "wait" => 1, "next" => 16}
@anime["story_dash"][16] = {"pic" => 97, "wait" => 1, "next" => 17}
@anime["story_dash"][17] = {"pic" => 98, "wait" => 1, "next" => 18}
@anime["story_dash"][18] = {"pic" => 99, "wait" => 1, "next" => 19}
@anime["story_dash"][19] = {"pic" => 100, "wait" => 1, "next" => 20}
@anime["story_dash"][20] = {"pic" => 101, "wait" => 1, "next" => 21}
@anime["story_dash"][21] = {"pic" => 102, "wait" => 1, "next" => 22}
@anime["story_dash"][22] = {"pic" => 103, "wait" => 1, "next" => 23}
@anime["story_dash"][23] = {"pic" => 104, "wait" => 1, "next" => 24}
@anime["story_dash"][24] = {"pic" => 105, "wait" => 1, "next" => 25}
@anime["story_dash"][25] = {"pic" => 106, "wait" => 1, "next" => 26}
@anime["story_dash"][26] = {"pic" => 107, "wait" => 1, "next" => 27}
@anime["story_dash"][27] = {"pic" => 108, "wait" => 1, "next" => 28}
@anime["story_dash"][28] = {"pic" => 109, "wait" => 1, "next" => 0}




#@anime["dash"][0] = {"pic" => 93, "wait" => 4, "next" => 1, "anime" => [11,0,0], "z_pos" =>  1}
#@anime["dash"][1] = {"pic" => 96, "wait" => 4, "next" => 2}
#@anime["dash"][2] = {"pic" => 99, "wait" => 4, "next" => 3}
#@anime["dash"][3] = {"pic" => 105, "wait" => 4, "next" => 4}
#@anime["dash"][4] = {"pic" => 111, "wait" => 4, "next" => 5}
#@anime["dash"][5] = {"pic" => 115, "wait" => 4, "next" => 0}

@anime["dash_break"][0] = {"pic" => 121, "wait" => 6, "next" => ["stand"], "anime" => [12,0,0], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 跳躍  / 落下
#-------------------------------------------------------------------------------
@anime["jump"][0] = {"pic" => 121, "wait" => 3, "next" => 1, "ab_uncancel" => 7, "y_fixed" => true}
@anime["jump"][1] = {"pic" => 122, "wait" => 2, "next" => 2, "anime" => [12,0,0], "var_reset" => true}
@anime["jump"][2] = {"pic" => 123, "wait" => 24, "next" => ["jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity}
@anime["jump_fall"][0] = {"pic" => 134, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 前跳躍  / 落下
#-------------------------------------------------------------------------------
@anime["f_jump"][0] = {"pic" => 121, "wait" => 3, "next" => 1, "ab_uncancel" => 7, "y_fixed" => true}
@anime["f_jump"][1] = {"pic" => 122, "wait" => 2, "next" => 2, "anime" => [12,0,0], "var_reset" => true}
@anime["f_jump"][2] = {"pic" => 123, "wait" => 24, "next" => ["f_jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity/1.2, "x_speed" => @me.dash_x_speed}
@anime["f_jump_fall"][0] = {"pic" => 134, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 二段跳 / 落下
#-------------------------------------------------------------------------------
@anime["double_jump"][0] = {"pic" => 121, "wait" => 3, "next" => 1, "y_fixed" => true, "ab_uncancel" => 7}
@anime["double_jump"][1] = {"pic" => 122, "wait" => 2, "next" => 2}
@anime["double_jump"][2] = {"pic" => 123, "wait" => 24, "next" => ["double_jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity}
@anime["double_jump_fall"][0] = {"pic" => 134, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 大跳 / 落下
#-------------------------------------------------------------------------------
@anime["h_jump"][0] = {"pic" => 121, "wait" => 5, "next" => 1, "blur" => true, "x_speed" => 0, "ab_uncancel" => 8, "y_fixed" => true}
@anime["h_jump"][1] = {"pic" => 122, "wait" => 2, "next" => 2}
@anime["h_jump"][2] = {"pic" => 123, "wait" => 5, "next" => 3, "x_speed" => (@me.dash_x_speed/1.5), "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity + 1.4}
@anime["h_jump"][3] = {"pic" => 123, "wait" => 3, "next" => ["h_jump_fall"]}
@anime["h_jump_fall"][0] = {"pic" => 134, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 前大跳  / 落下
#-------------------------------------------------------------------------------
@anime["hf_jump"][0] = {"pic" => 122, "wait" => 2, "next" => 1, "ab_uncancel" => 2, "y_fixed" => true}
@anime["hf_jump"][1] = {"pic" => 123, "wait" => 9, "next" => ["hf_jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity - 5.5, "x_speed" => @me.dash_x_speed * 1.5}
@anime["hf_jump_fall"][0] = {"pic" => 134, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 著地
#-------------------------------------------------------------------------------
@anime["landing"][0] = {"pic" => 134, "wait" => 4, "next" => 1, "anime" => [12,0,0], "ab_uncancel" => 2}
@anime["landing"][1] = {"pic" => 133, "wait" => 4, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 蹲下 / 起來
#-------------------------------------------------------------------------------
@anime["crouch_start"][0] = {"pic" => 171, "wait" => 4, "next" => ["crouch"]}
@anime["crouch"][0] = {"pic" => 172, "wait" => -1, "next" => 0}
@anime["crouch_end"][0] = {"pic" => 171, "wait" => 4, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 防禦/硬直
#-------------------------------------------------------------------------------
@anime["guard"][0] = {"pic" => 161, "wait" => 2, "next" => 0, "var_reset" => true}
@anime["guard_shock"][0] = {"pic" => 162, "wait" => -1, "next" => 0}

#-------------------------------------------------------------------------------
# ○ 受傷1
#-------------------------------------------------------------------------------
@anime["damage1"][0] = {"pic" => 131, "wait" => 2, "next" => 1}
@anime["damage1"][1] = {"pic" => 132, "wait" => 2, "next" => 2}
@anime["damage1"][2] = {"pic" => 133, "wait" => 2, "next" => 3}
@anime["damage1"][3] = {"pic" => 134, "wait" => -1, "next" => 3}

#-------------------------------------------------------------------------------
# ○ 受傷2
#-------------------------------------------------------------------------------
@anime["damage2"][0] = {"pic" => 131, "wait" => 2, "next" => 1}
@anime["damage2"][1] = {"pic" => 132, "wait" => 2, "next" => 2}
@anime["damage2"][2] = {"pic" => 133, "wait" => 2, "next" => 3}
@anime["damage2"][3] = {"pic" => 134, "wait" => -1, "next" => 3}

#-------------------------------------------------------------------------------
# ○ 正面擊飛
#-------------------------------------------------------------------------------
@anime["f_blow"][0] = {"pic" => 141, "wait" => 2, "next" => 1, "body" => @me.stand_body_rect}
@anime["f_blow"][1] = {"pic" => 142, "wait" => 2, "next" => 2}
@anime["f_blow"][2] = {"pic" => 143, "wait" => 2, "next" => 3}
@anime["f_blow"][3] = {"pic" => 144, "wait" => -1, "next" => 3}
#-------------------------------------------------------------------------------
# ○ 背面擊飛
#-------------------------------------------------------------------------------
@anime["b_blow"][0] = {"pic" => 151, "wait" => 2, "next" => 1, "body" => @me.stand_body_rect}
@anime["b_blow"][1] = {"pic" => 152, "wait" => 2, "next" => 2}
@anime["b_blow"][2] = {"pic" => 153, "wait" => 2, "next" => 3}
@anime["b_blow"][3] = {"pic" => 154, "wait" => -1, "next" => 3}

#-------------------------------------------------------------------------------
# ○ 正面擊飛(重)
#-------------------------------------------------------------------------------
@anime["hf_blow"][0] = {"pic" => 141, "wait" => 2, "next" => 1, "body" => @me.stand_body_rect}
@anime["hf_blow"][1] = {"pic" => 142, "wait" => 2, "next" => 2}
@anime["hf_blow"][2] = {"pic" => 143, "wait" => 2, "next" => 3}
@anime["hf_blow"][3] = {"pic" => 144, "wait" => 2, "next" => 3}
#-------------------------------------------------------------------------------
# ○ 背面擊飛(重)
#-------------------------------------------------------------------------------
@anime["hb_blow"][0] = {"pic" => 151, "wait" => 2, "next" => 1, "body" => @me.stand_body_rect}
@anime["hb_blow"][1] = {"pic" => 152, "wait" => 2, "next" => 2}
@anime["hb_blow"][2] = {"pic" => 153, "wait" => 2, "next" => 3}
@anime["hb_blow"][3] = {"pic" => 154, "wait" => 2, "next" => 3}

#-------------------------------------------------------------------------------
# ○ 垂直擊飛
#-------------------------------------------------------------------------------
@anime["vertical_blow"][0] = {"pic" => 82, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect}
@anime["vertical_blow"][1] = {"pic" => 118, "wait" => 3, "next" => 2}
@anime["vertical_blow"][2] = {"pic" => 117, "wait" => 3, "next" => 3}
@anime["vertical_blow"][3] = {"pic" => 116, "wait" => -1, "next" => 3}
#-------------------------------------------------------------------------------
# ○ 垂直擊飛後落下
#-------------------------------------------------------------------------------
@anime["vertical_blow_fall"][0] = {"pic" => 82, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect}
@anime["vertical_blow_fall"][1] = {"pic" => 118, "wait" => 3, "next" => 2}
@anime["vertical_blow_fall"][2] = {"pic" => 117, "wait" => 3, "next" => 3}
@anime["vertical_blow_fall"][3] = {"pic" => 116, "wait" => -1, "next" => 3}

#-------------------------------------------------------------------------------
# ○ 水平擊飛(正)
#-------------------------------------------------------------------------------
@anime["parallel_f_blow"][0] = {"pic" => 82, "wait" =>-1, "next" => 0, "body" => @me.stand_body_rect}
#-------------------------------------------------------------------------------
# ○ 水平擊飛(背)
#-------------------------------------------------------------------------------
@anime["parallel_b_blow"][0] = {"pic" => 82, "wait" => -1, "next" => 0, "body" => @me.stand_body_rect}

#-------------------------------------------------------------------------------
# ○ 倒地－－面朝上/反彈/起身
#-------------------------------------------------------------------------------
@anime["f_down"][0] = {"pic" => 145, "wait" => -1, "next" => 0, "ab_uncancel" => 22, "body" => @me.down_body_rect}
@anime["f_down_stand"][0] = {"pic" => 83, "wait" => 6, "next" => ["stand"], "ab_uncancel" => 8, "var_reset" => true, "body" => @me.sit_body_rect}
@anime["bounce_f_down"][0] = {"pic" => 146, "wait" => -1, "next" => 0, "body" => @me.down_body_rect}  # 反彈
#-------------------------------------------------------------------------------
# ○ 倒地－－面朝下/反彈/起身
#-------------------------------------------------------------------------------
@anime["b_down"][0] = {"pic" => 155, "wait" => -1, "next" => 0, "ab_uncancel" => 22, "body" => @me.down_body_rect}
@anime["b_down_stand"][0] = {"pic" => 83, "wait" => 6, "next" => ["stand"], "ab_uncancel" => 8, "var_reset" => true, "body" => @me.sit_body_rect}
@anime["bounce_b_down"][0] = {"pic" => 156, "wait" => -1, "next" => 0, "body" => @me.down_body_rect} # 反彈


#-------------------------------------------------------------------------------
# ○ 倒地－－壓制攻擊
#-------------------------------------------------------------------------------
@anime["pressure_f_down"][0] = {"pic" => 122, "wait" => 3, "next" => 0, "ab_uncancel" => 14, "body" => @me.down_body_rect}
@anime["pressure_b_down"][0] = {"pic" => 124, "wait" => 3, "next" => 0, "ab_uncancel" => 14, "body" => @me.down_body_rect}

#-------------------------------------------------------------------------------
# ○ 受身
#-------------------------------------------------------------------------------
@anime["ukemi"][0] = {"pic" => 124, "wait" => 7, "next" => ["jump_fall"]}


#-------------------------------------------------------------------------------
# ○ 被捉的動作
#-------------------------------------------------------------------------------
# 肚子痛
@anime["dizzy1"][0] = {"pic" => 489, "wait" => 3, "next" => 1}
@anime["dizzy1"][1] = {"pic" => 489, "wait" => 3, "next" => 0}
@anime["dizzy2"][0] = {"pic" => 134, "wait" => 3, "next" => 1}
@anime["dizzy2"][1] = {"pic" => 134, "wait" => 3, "next" => 0}

@anime["binding"][0] = {"pic" => 451, "wait" => 3, "next" => 1} 
@anime["binding"][1] = {"pic" => 452, "wait" => 3, "next" => 2} 
@anime["binding"][2] = {"pic" => 453, "wait" => 3, "next" => 3}
@anime["binding"][3] = {"pic" => 454, "wait" => 3, "next" => 4} 
@anime["binding"][4] = {"pic" => 455, "wait" => 3, "next" => 0}

@anime["binding2"][0] = {"pic" => 461, "wait" => 3, "next" => 1} 
@anime["binding2"][1] = {"pic" => 462, "wait" => 3, "next" => 2} 
@anime["binding2"][2] = {"pic" => 463, "wait" => 3, "next" => 3}
@anime["binding2"][3] = {"pic" => 464, "wait" => 3, "next" => 4} 
@anime["binding2"][4] = {"pic" => 465, "wait" => 3, "next" => 0}

@anime["binding3"][0] = {"pic" => 471, "wait" => 3, "next" => 1} 
@anime["binding3"][1] = {"pic" => 472, "wait" => 3, "next" => 2} 
@anime["binding3"][2] = {"pic" => 473, "wait" => 3, "next" => 3}
@anime["binding3"][3] = {"pic" => 474, "wait" => 3, "next" => 4} 
@anime["binding3"][4] = {"pic" => 475, "wait" => 3, "next" => 0}

#-------------------------------------------------------------------------------
# ○ 前迴避
#-------------------------------------------------------------------------------
@anime["f_flee"][0] = {"pic" => 481, "wait" => 4, "next" => 1, "ab_uncancel" => 50, "blur" => true, "eva" => 50, "penetrate" => true}
@anime["f_flee"][1] = {"pic" => 482, "wait" => 3, "next" => 2, "x_speed" => 5}
@anime["f_flee"][2] = {"pic" => 484, "wait" => 3, "next" => 3, "x_speed" => 18.2, "y_speed" => 3.2}
@anime["f_flee"][3] = {"pic" => 484, "wait" => 88, "next" => 3}
@anime["f_flee"][4] = {"pic" => 484, "wait" => 3, "next" => 5, "eva" => 10, "ab_uncancel" => 3} # 著地
@anime["f_flee"][5] = {"pic" => 485, "wait" => 2, "next" => 6}
@anime["f_flee"][6] = {"pic" => 486, "wait" => 2, "next" => 7}
@anime["f_flee"][7] = {"pic" => 487, "wait" => 2, "next" => 8}
@anime["f_flee"][8] = {"pic" => 488, "wait" => 3, "next" => ["stand"], "var_reset" => true, "penetrate" => false}
#-------------------------------------------------------------------------------
# ○ 後迴避
#-------------------------------------------------------------------------------
@anime["b_flee"][0] = {"pic" => 125, "wait" => 2, "next" => 1, "x_speed" => 0, "ab_uncancel" => 15, "eva" => 16, "penetrate" => true}
@anime["b_flee"][1] = {"pic" => 124, "wait" => 3, "next" => 2, "x_speed" => -17.2, "y_speed" => 4.5, "blur" => true}
@anime["b_flee"][2] = {"pic" => 124, "wait" => 3, "next" => 3}
@anime["b_flee"][3] = {"pic" => 124, "wait" => 3, "next" => 4}
@anime["b_flee"][4] = {"pic" => 123, "wait" => 9, "next" => 5, "x_speed" => -8.2}
@anime["b_flee"][5] = {"pic" => 134, "wait" => 8, "next" => ["stand"], "var_reset" => true, "penetrate" => false, "ab_uncancel" => 4, "eva" => 3}
#-------------------------------------------------------------------------------
# ○ 空突進
#-------------------------------------------------------------------------------
@anime["af_flee"][0] = {"pic" => 27, "wait" => 3, "next" => 1, "ab_uncancel" => 6, "eva" => 13, "y_fixed" => true, "penetrate" => true}
@anime["af_flee"][1] = {"pic" => 41, "wait" => 1, "next" => 2, "y_fixed" => false, "x_speed" => 10.9, "y_speed" => 7.9, "blur" => true}
@anime["af_flee"][2] = {"pic" => 41, "wait" => 12, "next" => 3}
@anime["af_flee"][3] = {"pic" => 46, "wait" => -1, "next" => 3, "penetrate" => false}
#-------------------------------------------------------------------------------
# ○ 空迴避
#-------------------------------------------------------------------------------
@anime["ab_flee"][0] = {"pic" => 27, "wait" => 5, "next" => 1, "y_fixed" => true, "ab_uncancel" => 6, "eva" => 13, "penetrate" => true}
@anime["ab_flee"][1] = {"pic" => 51, "wait" => 1, "next" => 2, "y_fixed" => false, "x_speed" => -10.9, "y_speed" => 7.9, "blur" => true, "eva" => 11}
@anime["ab_flee"][2] = {"pic" => 51, "wait" => 12, "next" => 3}
@anime["ab_flee"][3] = {"pic" => 56, "wait" => -1, "next" => 3, "penetrate" => false}
#-------------------------------------------------------------------------------
# ○ 地上前追擊
#-------------------------------------------------------------------------------
@anime["f_chase"][0] = {"pic" => 16, "wait" => 3, "next" => 1, "x_speed" => (@me.dash_x_speed*1.5), "ab_uncancel" => 2, "blur" => true}
@anime["f_chase"][1] = {"pic" => 17, "wait" => 3, "next" => 2, "x_speed" => (@me.dash_x_speed*1.5)}
@anime["f_chase"][2] = {"pic" => 18, "wait" => 3, "next" => 3, "x_speed" => (@me.dash_x_speed*1.5)}
@anime["f_chase"][3] = {"pic" => 17, "wait" => 3, "next" => 4, "x_speed" => (@me.dash_x_speed*1.5)}
@anime["f_chase"][4] = {"pic" => 16, "wait" => 3, "next" => 5}
@anime["f_chase"][5] = {"pic" => 17, "wait" => 3, "next" => 6}
@anime["f_chase"][6] = {"pic" => 23, "wait" => 5, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 地上後追擊
#-------------------------------------------------------------------------------
@anime["b_chase"][0] = {"pic" => 26, "wait" => 1, "next" => 1, "x_speed" => ((@me.dash_x_speed+2) * -1), "y_speed" => (@me.jump_y_init_velocity/2), "penetrate" => true, "ab_uncancel" => 17, "blur" => true, "eva" => 14}
@anime["b_chase"][1] = {"pic" => 31, "wait" => 3, "next" => 2}
@anime["b_chase"][2] = {"pic" => 31, "wait" => 3, "next" => 3}
@anime["b_chase"][3] = {"pic" => 31, "wait" => 3, "next" => 4}
@anime["b_chase"][4] = {"pic" => 31, "wait" => 9, "next" => 5}
@anime["b_chase"][5] = {"pic" => 26, "wait" => 1, "next" => ["stand"], "var_reset" => true, "penetrate" => false}
#-------------------------------------------------------------------------------
# ○ 空中前追擊
#-------------------------------------------------------------------------------
@anime["af_chase"][0] = {"pic" => 27, "wait" => 1, "next" => 1, "ab_uncancel" => 4}
@anime["af_chase"][1] = {"pic" => 41, "wait" => 1, "next" => 2, "x_speed" => 12.9, "y_speed" => 7.9, "blur" => true}
@anime["af_chase"][2] = {"pic" => 41, "wait" => 12, "next" => 3, "var_reset" => true}
@anime["af_chase"][3] = {"pic" => 46, "wait" => -1, "next" => 3}
#-------------------------------------------------------------------------------
# ○ 空中後追擊
#-------------------------------------------------------------------------------
@anime["ab_chase"][0] = {"pic" => 27, "wait" => 1, "next" => 1, "ab_uncancel" => 9, "penetrate" => true}
@anime["ab_chase"][1] = {"pic" => 51, "wait" => 0, "next" => 2,"x_speed" => -10.9, "y_speed" => 7.9, "blur" => true, "eva" => 11}
@anime["ab_chase"][2] = {"pic" => 51, "wait" => 12, "next" => 3, "var_reset" => true}
@anime["ab_chase"][3] = {"pic" => 56, "wait" => -1, "next" => 3, "penetrate" => false}
#-------------------------------------------------------------------------------
# ○ 向上追擊
#-------------------------------------------------------------------------------
@anime["u_chase"][0] = {"pic" => 26, "wait" => 2, "next" => 1, "blur" => true, "x_speed" => 0, "ab_uncancel" => 4, "y_fixed" => true}
@anime["u_chase"][1] = {"pic" => 27, "wait" => 1, "next" => 2, "x_speed" => (@me.dash_x_speed/1.5), "y_speed" => @me.jump_y_init_velocity + 1.4, "y_fixed" => false}
@anime["u_chase"][2] = {"pic" => 31, "wait" => 6, "next" => ["jump_fall"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 向下追擊
#-------------------------------------------------------------------------------
@anime["d_chase"] = {"pic" => 999, "wait" => 0, "next" => ["jump_fall"], "blur" => false, "x_speed" => 0, "ab_uncancel" => 1, "var_reset" => true}



# 技

#-------------------------------------------------------------------------------
# ○ 一段斬 (Z)
#-------------------------------------------------------------------------------
@anime["5z"][0] = {"pic" => 198, "wait" => 2, "next" => 1, "ab_uncancel" => 13, "uncancel" => true, "atk_phase" => 2, "z_pos" => 3}
@anime["5z"][1] = {"pic" => 199, "wait" => 1, "next" => 2}
@anime["5z"][2] = {"pic" => 200, "wait" => 1, "next" => 3}
@anime["5z"][3] = {"pic" => 201, "wait" => 2, "next" => 4}
@anime["5z"][4] = {"pic" => 203, "wait" => 2, "next" => 5, "se"=> ["swing2", 70, 80], "atk_phase" => 3}
@anime["5z"][5] = {"pic" => 204, "wait" => 2, "next" => 6, "x_speed" => 2.4} # , "atk" => [Rect.new(12, -140, 88, 100)]
@anime["5z"][6] = {"pic" => 205, "wait" => 2, "next" => 7, "atk" => [Rect.new(12, -160, 133, 160)], "keep_atk_rect" => true}
@anime["5z"][7] = {"pic" => 211, "wait" => 2, "next" => 8, "atk" => 0}
@anime["5z"][8] = {"pic" => 251, "wait" => 2, "next" => 9}
@anime["5z"][9] = {"pic" => 252, "wait" => 2, "next" => 10}
@anime["5z"][10] = {"pic" => 253, "wait" => 2, "next" => 11}
@anime["5z"][11] = {"pic" => 254, "wait" => 2, "next" => 12}
@anime["5z"][12] = {"pic" => 255, "wait" => 2, "next" => 13}
@anime["5z"][13] = {"pic" => 256, "wait" => 2, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 二段斬 (ZZ)
#-------------------------------------------------------------------------------
@anime["5zz"][0] = {"pic" => 211, "wait" => 2, "next" => 1, "ab_uncancel" => 14,"uncancel" => true, "atk_phase" => 1, "z_pos" => 3}
@anime["5zz"][1] = {"pic" => 212, "wait" => 1, "next" => 2}
@anime["5zz"][2] = {"pic" => 213, "wait" => 1, "next" => 3}
@anime["5zz"][3] = {"pic" => 214, "wait" => 2, "next" => 4}
@anime["5zz"][4] = {"pic" => 215, "wait" => 2, "next" => 5}
@anime["5zz"][5] = {"pic" => 216, "wait" => 2, "next" => 6}
@anime["5zz"][6] = {"pic" => 217, "wait" => 2, "next" => 7, "se"=> ["swing2", 70, 80]}
@anime["5zz"][7] = {"pic" => 218, "wait" => 2, "next" => 8, "atk" => [Rect.new(20, -120, 135, 120)]}
@anime["5zz"][8] = {"pic" => 219, "wait" => 2, "next" => 9}
@anime["5zz"][9] = {"pic" => 220, "wait" => 2, "next" => 10}
@anime["5zz"][10] = {"pic" => 221, "wait" => 2, "next" => 11, "atk" => 0}
@anime["5zz"][11] = {"pic" => 261, "wait" => 2, "next" => 12}
@anime["5zz"][12] = {"pic" => 262, "wait" => 2, "next" => 13}
@anime["5zz"][13] = {"pic" => 263, "wait" => 2, "next" => 14}
@anime["5zz"][14] = {"pic" => 264, "wait" => 2, "next" => 15}
@anime["5zz"][15] = {"pic" => 265, "wait" => 2, "next" => 16}
@anime["5zz"][16] = {"pic" => 266, "wait" => 2, "next" => 17}
@anime["5zz"][17] = {"pic" => 267, "wait" => 3, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 三段斬 (ZZZ)
#-------------------------------------------------------------------------------
@anime["5zzz"][0] = {"pic" => 231, "wait" => 2, "next" => 1, "ab_uncancel" => 20,"uncancel" => true, "x_speed" => 2.4, "atk_phase" => 1, "z_pos" => 3}
@anime["5zzz"][1] = {"pic" => 232, "wait" => 2, "next" => 2}
@anime["5zzz"][2] = {"pic" => 233, "wait" => 2, "next" => 3}
@anime["5zzz"][3] = {"pic" => 234, "wait" => 2, "next" => 4}
@anime["5zzz"][4] = {"pic" => 235, "wait" => 2, "next" => 5}
@anime["5zzz"][5] = {"pic" => 236, "wait" => 2, "next" => 6}
@anime["5zzz"][6] = {"pic" => 237, "wait" => 2, "next" => 7}
@anime["5zzz"][7] = {"pic" => 238, "wait" => 2, "next" => 8, "atk" => [Rect.new(35, -170, 105, 170)], "se"=> ["swing2", 70, 80]}
@anime["5zzz"][8] = {"pic" => 239, "wait" => 2, "next" => 9}
@anime["5zzz"][9] = {"pic" => 240, "wait" => 2, "next" => 10, "atk" => 0}
@anime["5zzz"][10] = {"pic" => 241, "wait" => 3, "next" => 11}
@anime["5zzz"][11] = {"pic" => 242, "wait" => 3, "next" => 12}
@anime["5zzz"][12] = {"pic" => 243, "wait" => 3, "next" => 13}
@anime["5zzz"][13] = {"pic" => 244, "wait" => 3, "next" => 14}
@anime["5zzz"][14] = {"pic" => 245, "wait" => 3, "next" => ["stand"], "var_reset" => true}


# =====新定義
@anime["5zzz"][0] = {"pic" => 271, "wait" => 4, "next" => 1, "ab_uncancel" => 16, "uncancel" => true, "atk_phase" => 1, "z_pos" => 3, "x_speed" => @me.dash_x_speed * 1.2, "anime" => [11,0,0]}
@anime["5zzz"][1] = {"pic" => 272, "wait" => 3, "next" => 2, "x_speed" => 2, "se"=> ["swing2", 70, 80]}
@anime["5zzz"][2] = {"pic" => 273, "wait" => 3, "next" => 4}
@anime["5zzz"][4] = {"pic" => 275, "wait" => 3, "next" => 5, "atk" => [Rect.new(65, -170, 105, 170)]}
@anime["5zzz"][5] = {"pic" => 276, "wait" => 2, "next" => 6}
@anime["5zzz"][6] = {"pic" => 277, "wait" => 12, "next" => 7, "atk" => 0}
@anime["5zzz"][7] = {"pic" => 278, "wait" => 2, "next" => 8}
@anime["5zzz"][8] = {"pic" => 279, "wait" => 2, "next" => 9}
@anime["5zzz"][9] = {"pic" => 280, "wait" => 2, "next" => 10}
@anime["5zzz"][10] = {"pic" => 281, "wait" => 2, "next" => 11}
@anime["5zzz"][11] = {"pic" => 282, "wait" => 2, "next" => 12}
@anime["5zzz"][12] = {"pic" => 283, "wait" => 2, "next" => 13}
@anime["5zzz"][13] = {"pic" => 284, "wait" => 2, "next" => 14}
@anime["5zzz"][14] = {"pic" => 285, "wait" => 2, "next" => 15}
@anime["5zzz"][15] = {"pic" => 286, "wait" => 3, "next" => ["stand"], "var_reset" => true, "anime" => [12,0,0]}





#-------------------------------------------------------------------------------
# ○ 前斬 (→Z)
#-------------------------------------------------------------------------------
@anime["6z"][0] = {"pic" => 411, "wait" => 3, "next" => 1, "ab_uncancel" => 15, "uncancel" => true, "z_pos" => 3, "x_speed" => @me.dash_x_speed * 1.6, "anime" => [12,0,0]}
@anime["6z"][1] = {"pic" => 412, "wait" => 2, "next" => 2}
@anime["6z"][2] = {"pic" => 414, "wait" => 6, "next" => 3}
@anime["6z"][3] = {"pic" => 415, "wait" => 3, "next" => 4, "atk" => [Rect.new(-80, -130, 250, 120)], "x_speed" => @me.dash_x_speed * 2.2, "se"=> ["swing2", 70, 80], "anime" => [12,0,0]}
@anime["6z"][4] = {"pic" => 417, "wait" => 2, "next" => 5}
@anime["6z"][5] = {"pic" => 418, "wait" => 12, "next" => 6, "atk" => 0}
@anime["6z"][6] = {"pic" => 419, "wait" => 3, "next" => 7}
@anime["6z"][7] = {"pic" => 420, "wait" => 3,  "next" => ["stand"], "var_reset" => true, "anime" => [12,0,0]}


#-------------------------------------------------------------------------------
# ○ 下斬 (↓Z)
#-------------------------------------------------------------------------------
@anime["2z"][0] = {"pic" => 391, "wait" => 3, "next" => 1, "ab_uncancel" => 9, "uncancel" => true, "z_pos" => 3}
@anime["2z"][1] = {"pic" => 392, "wait" => 3, "next" => 2}
@anime["2z"][2] = {"pic" => 393, "wait" => 4, "next" => 3, "atk" => [Rect.new(105, -170, 105, 170)], "se"=> ["swing2", 70, 80]}
@anime["2z"][3] = {"pic" => 394, "wait" => 8, "next" => 4, "atk" => 0}
@anime["2z"][4] = {"pic" => 395, "wait" => 3, "next" => 5}
@anime["2z"][5] = {"pic" => 396, "wait" => 4, "next" => ["stand"], "var_reset" => true}

# ==== 新定義
@anime["2z"][0] = {"pic" => 233, "wait" => 3, "next" => 1, "ab_uncancel" => 12,"uncancel" => true, "x_speed" => 2.4, "z_pos" => 3}
@anime["2z"][1] = {"pic" => 234, "wait" => 3, "next" => 2}
@anime["2z"][2] = {"pic" => 236, "wait" => 2, "next" => 3}
@anime["2z"][3] = {"pic" => 237, "wait" => 2, "next" => 4, "atk" => [Rect.new(15, -170, 105, 170)], "se"=> ["swing2", 70, 80]}
@anime["2z"][4] = {"pic" => 238, "wait" => 2, "next" => 5}
@anime["2z"][5] = {"pic" => 239, "wait" => 2, "next" => 6, "atk" => 0}
@anime["2z"][6] = {"pic" => 240, "wait" => 2, "next" => 7}
@anime["2z"][7] = {"pic" => 241, "wait" => 3, "next" => 8}
@anime["2z"][8] = {"pic" => 242, "wait" => 3, "next" => 9}
@anime["2z"][9] = {"pic" => 243, "wait" => 3, "next" => 10}
@anime["2z"][10] = {"pic" => 244, "wait" => 3, "next" => 11}
@anime["2z"][11] = {"pic" => 245, "wait" => 3, "next" => ["stand"], "var_reset" => true}


#-------------------------------------------------------------------------------
# ○ 跳砍
#-------------------------------------------------------------------------------
@anime["jz"][0] = {"pic" => 371, "wait" => 2, "next" => 1, "ab_uncancel" => 10, "uncancel" => true, "z_pos" => 3}
@anime["jz"][1] = {"pic" => 372, "wait" => 2, "next" => 2}
@anime["jz"][2] = {"pic" => 373, "wait" => 5, "next" => 3}
@anime["jz"][3] = {"pic" => 374, "wait" => 3, "next" => 4, "atk" => [Rect.new(-80, -75, 200, 86)],"se"=> ["swing2", 70, 80], "bullet" => [@me, "jz_effect1", 0, 5, -30, false, false]}
@anime["jz"][4] = {"pic" => 375, "wait" => 8, "next" => 5, "atk" => 0}
@anime["jz"][5] = {"pic" => 375, "wait" => 100, "next" => ["jump_fall"], "var_reset" => true}  # 落下姿

@anime["jz"][6] = {"pic" => 376, "wait" => 3, "next" => 7}  # 落下姿
@anime["jz"][7] = {"pic" => 121, "wait" => 4, "next" => ["stand"], "var_reset" => true}  # 落下姿
#-------------------------------------------------------------------------------
# ○ 跳砍特效
#-------------------------------------------------------------------------------
@anime["jz_effect1"][0] = {"pic" => 501, "wait" => 12, "next" => ["dispose"], "z_pos" =>  3}


#-------------------------------------------------------------------------------
# ○ 跳前砍
#-------------------------------------------------------------------------------
@anime["j6z"][0] = {"pic" => 371, "wait" => 7, "next" => 1, "ab_uncancel" => 13, "uncancel" => true, "z_pos" => 3}
@anime["j6z"][1] = {"pic" => 401, "wait" => 2, "next" => 2}
@anime["j6z"][2] = {"pic" => 402, "wait" => 2, "next" => 3}
@anime["j6z"][3] = {"pic" => 403, "wait" => 3, "next" => 4, "atk" => [Rect.new(-80, -75, 175, 86)],"se"=> ["swing2", 70, 80], "bullet" => [@me, "jz_effect1", 0, 35, -30, false, false]}
@anime["j6z"][4] = {"pic" => 404, "wait" => 3, "next" => 5}
@anime["j6z"][5] = {"pic" => 405, "wait" => 3, "next" => 6, "atk" => 0}
@anime["j6z"][6] = {"pic" => 406, "wait" => 3, "next" => 7}
@anime["j6z"][7] = {"pic" => 407, "wait" => 3, "next" => 8}
@anime["j6z"][8] = {"pic" => 375, "wait" => 5, "next" => ["jump_fall"], "var_reset" => true}  # 落下姿


#-------------------------------------------------------------------------------
# ○ 旋轉斬
#-------------------------------------------------------------------------------
@anime["j2z"][0] = {"pic" => 373, "wait" => 6, "next" => 1, "ab_uncancel" => 12, "uncancel" => true, "z_pos" => 3} # , "y_speed" => 13.7
@anime["j2z"][1] = {"pic" => 381, "wait" => 3, "next" => 2, "atk" => [Rect.new(-90, -155, 180, 155)],"se"=> ["swing2", 70, 80]}
@anime["j2z"][2] = {"pic" => 382, "wait" => 3, "next" => 3}
@anime["j2z"][3] = {"pic" => 383, "wait" => 3, "next" => 4}
@anime["j2z"][4] = {"pic" => 375, "wait" => 3, "next" => 5, "atk" => 0}
@anime["j2z"][5] = {"pic" => 375, "wait" => 3, "next" => ["jump_fall"], "var_reset" => true}  # 落下姿



#-------------------------------------------------------------------------------
# ○ 泣鐮
#-------------------------------------------------------------------------------
@anime["5x"][0] = {"pic" => 301, "wait" => 2, "next" => 1, "ab_uncancel" => 81, "uncancel" => true, "anime" => [1,0,0], "superstop" => 28, "supermove" => 28, "camera" => [48,30,30], "black" => [48,50], "fps" => [23, 55], "blur" => true, "z_pos" => 3, "se"=> ["eco00", 70, 116], "eva" => 10}  #,  "se"=> ["eco00", 80, 110]
@anime["5x"][1] = {"pic" => 302, "wait" => 2, "next" => 2}
@anime["5x"][2] = {"pic" => 303, "wait" => 2, "next" => 3}
@anime["5x"][3] = {"pic" => 304, "wait" => 2, "next" => 4, "se"=> ["swing06_r", 80, 90]}
@anime["5x"][4] = {"pic" => 305, "wait" => 2, "next" => 5}
@anime["5x"][5] = {"pic" => 306, "wait" => 2, "next" => 6}
@anime["5x"][6] = {"pic" => 307, "wait" => 2, "next" => 7}
@anime["5x"][7] = {"pic" => 308, "wait" => 2, "next" => 8}
@anime["5x"][8] = {"pic" => 309, "wait" => 2, "next" => 9}
@anime["5x"][9] = {"pic" => 310, "wait" => 2, "next" => 10}
@anime["5x"][10] = {"pic" => 311, "wait" => 2, "next" => 11}
@anime["5x"][11] = {"pic" => 312, "wait" => 2, "next" => 12, "se"=> ["swing06_r", 80, 90]}
@anime["5x"][12] = {"pic" => 313, "wait" => 2, "next" => 13}
@anime["5x"][13] = {"pic" => 314, "wait" => 2, "next" => 14}
@anime["5x"][14] = {"pic" => 315, "wait" => 2, "next" => 15}
@anime["5x"][15] = {"pic" => 316, "wait" => 2, "next" => 16}
@anime["5x"][16] = {"pic" => 317, "wait" => 2, "next" => 17}
@anime["5x"][17] = {"pic" => 318, "wait" => 2, "next" => 18}
@anime["5x"][18] = {"pic" => 319, "wait" => 2, "next" => 19}
@anime["5x"][19] = {"pic" => 320, "wait" => 2, "next" => 20}
@anime["5x"][20] = {"pic" => 321, "wait" => 2, "next" => 21, "bullet" => [@me, "ball", 0, 45, 0, false, true],"se"=> ["swing06_r", 80, 90]}
# 跳起
@anime["5x"][21] = {"pic" => 322, "wait" => 2, "next" => 22, "x_speed"=> -11.2, "y_speed"=> 5}
@anime["5x"][22] = {"pic" => 323, "wait" => 2, "next" => 23}
@anime["5x"][23] = {"pic" => 324, "wait" => 2, "next" => 24}
@anime["5x"][24] = {"pic" => 325, "wait" => 2, "next" => 24, "ab_uncancel" => 51, "uncancel" => true} # <= 維持在這格

# 著地
@anime["5x"][25] = {"pic" => 326, "wait" => 2, "next" => 26, "x_speed"=> -6.2, "ab_uncancel" => 81, "uncancel" => true}
@anime["5x"][26] = {"pic" => 327, "wait" => 2, "next" => 27}
@anime["5x"][27] = {"pic" => 328, "wait" => 2, "next" => 28}
@anime["5x"][28] = {"pic" => 329, "wait" => 2, "next" => 29}
@anime["5x"][29] = {"pic" => 330, "wait" => 2, "next" => 30}
@anime["5x"][30] = {"pic" => 331, "wait" => 2, "next" => 31}
@anime["5x"][31] = {"pic" => 332, "wait" => 80, "next" => 32}
@anime["5x"][32] = {"pic" => 333, "wait" => 2, "next" => 33}
@anime["5x"][33] = {"pic" => 334, "wait" => 2, "next" => 34}
@anime["5x"][34] = {"pic" => 335, "wait" => 2, "next" => 35}
@anime["5x"][35] = {"pic" => 336, "wait" => 2, "next" => 36}
@anime["5x"][36] = {"pic" => 337, "wait" => 2, "next" => 37,"se"=> ["impact_se3", 72, 135], "ab_uncancel" => 0, "uncancel" => false}
@anime["5x"][37] = {"pic" => 338, "wait" => 2, "next" => 38, "x_speed"=> -6.2, "anime" => [11,0,0]}
@anime["5x"][38] = {"pic" => 339, "wait" => 4, "next" => 39, "blur" => false}
@anime["5x"][39] = {"pic" => 340, "wait" => 2, "next" => 40}
@anime["5x"][40] = {"pic" => 341, "wait" => 2, "next" => 41}
@anime["5x"][41] = {"pic" => 342, "wait" => 2, "next" => 42}
@anime["5x"][42] = {"pic" => 343, "wait" => 2, "next" => 43}
@anime["5x"][43] = {"pic" => 344, "wait" => 2, "next" => 44}
@anime["5x"][44] = {"pic" => 345, "wait" => 2, "next" => 45}
@anime["5x"][45] = {"pic" => 346, "wait" => 2, "next" => 46}
@anime["5x"][46] = {"pic" => 347, "wait" => 2, "next" => 47}
@anime["5x"][47] = {"pic" => 348, "wait" => 2, "next" => 48}
@anime["5x"][48] = {"pic" => 349, "wait" => 2, "next" => ["stand"], "var_reset" => true, "x_speed"=> 4.2}


#@anime["5x"][9] = {"pic" => 227, "wait" => 1, "next" => 10, "atk_phase" => 1}
#@anime["5x"][10] = {"pic" => 320, "wait" => 1, "next" => 11, "atk_phase" => 1, "black" => [40,50]}
#@anime["5x"][11] = {"pic" => 227, "wait" => 1, "next" => 12, "atk_phase" => 1}
#@anime["5x"][12] = {"pic" => 320, "wait" => 1, "next" => 13, "atk_phase" => 1}
#@anime["5x"][13] = {"pic" => 227, "wait" => 1, "next" => 14, "atk_phase" => 1}
#@anime["5x"][14] = {"pic" => 320, "wait" => 1, "next" => 15, "atk_phase" => 1}
#@anime["5x"][15] = {"pic" => 227, "wait" => 1, "next" => 16, "atk_phase" => 2, "camera" => [25,-10, 0]}
#@anime["5x"][16] = {"pic" => 320, "wait" => 1, "next" => 17, "atk_phase" => 2}

#@anime["5x"][17] = {"pic" => 231, "wait" => 2, "next" => 18, "atk_phase" => 2, "se" => ["Davis_voice", 92, 105], "black" => [40,50]}
#@anime["5x"][18] = {"pic" => 321, "wait" => 2, "next" => 19, "bullet" => [@me, "big_ball", 0, 45, 0, false, true], "se"=> ["wave", 100, 100], "atk_phase" => 3, "x_speed" => -9.1,  "se"=> ["shoot3", 87, 85]}
#@anime["5x"][19] = {"pic" => 322, "wait" => 1, "next" => 20, "atk_phase" => 3,  "se"=> ["shoot1", 89, 75]}
#@anime["5x"][20] = {"pic" => 323, "wait" => 18, "next" => 21, "atk_phase" => 4}
#@anime["5x"][21] = {"pic" => 231, "wait" => 3, "next" => ["stand"], "atk_phase" => 4, "var_reset" => true}


#-------------------------------------------------------------------------------
# ○ 死亡迴旋斬
#-------------------------------------------------------------------------------
@anime["j2x"][0] = {"pic" => 373, "wait" => 1, "next" => 1, "ab_uncancel" => 29, "uncancel" => true, "anime" => [1,0,0], "superstop" => 28, "camera" => [48,30,30], "black" => [48,50], "fps" => [23, 55], "blur" => true, "z_pos" => 3, "y_fixed" => true} # , "y_speed" => 13.7
@anime["j2x"][1] = {"pic" => 381, "wait" => 3, "next" => 2, "atk" => [Rect.new(-90, -155, 180, 155)],"se"=> ["swing2", 70, 80]}
@anime["j2x"][2] = {"pic" => 382, "wait" => 3, "next" => 3, "atk" => [Rect.new(-90, -155, 180, 155)], "hit_reset" => true}
@anime["j2x"][3] = {"pic" => 383, "wait" => 3, "next" => 4, "atk" => [Rect.new(-90, -155, 180, 155)], "hit_reset" => true}
@anime["j2x"][4] = {"pic" => 381, "wait" => 3, "next" => 5, "atk" => [Rect.new(-90, -155, 180, 155)], "hit_reset" => true, "se"=> ["swing2", 70, 80]}
@anime["j2x"][5] = {"pic" => 382, "wait" => 3, "next" => 6, "atk" => [Rect.new(-90, -155, 180, 155)], "hit_reset" => true}
@anime["j2x"][6] = {"pic" => 383, "wait" => 3, "next" => 7, "atk" => [Rect.new(-90, -155, 180, 155)], "hit_reset" => true}
@anime["j2x"][7] = {"pic" => 381, "wait" => 3, "next" => 8, "atk" => [Rect.new(-90, -155, 180, 155)], "hit_reset" => true, "se"=> ["swing2", 70, 80]}
@anime["j2x"][8] = {"pic" => 382, "wait" => 3, "next" => 9, "atk" => [Rect.new(-90, -155, 180, 155)], "hit_reset" => true}
@anime["j2x"][9] = {"pic" => 383, "wait" => 3, "next" => 10, "atk" => [Rect.new(-90, -155, 180, 155)], "hit_reset" => true}
@anime["j2x"][10] = {"pic" => 381, "wait" => 3, "next" => 11, "atk" => [Rect.new(-90, -155, 180, 155)], "hit_reset" => true, "se"=> ["swing2", 70, 80]}
@anime["j2x"][11] = {"pic" => 382, "wait" => 3, "next" => 12, "atk" => [Rect.new(-90, -155, 180, 155)], "hit_reset" => true}
@anime["j2x"][12] = {"pic" => 383, "wait" => 3, "next" => 13, "atk" => [Rect.new(-90, -155, 180, 155)], "hit_reset" => true}
@anime["j2x"][13] = {"pic" => 381, "wait" => 3, "next" => 14, "atk" => [Rect.new(-90, -155, 180, 155)], "se"=> ["swing2", 70, 80]}
@anime["j2x"][14] = {"pic" => 382, "wait" => 3, "next" => 15, "atk" => [Rect.new(-90, -155, 180, 155)], "hit_reset" => true}
@anime["j2x"][15] = {"pic" => 383, "wait" => 3, "next" => 16, "atk" => [Rect.new(-90, -155, 180, 155)], "hit_reset" => true}

@anime["j2x"][16] = {"pic" => 371, "wait" => 2, "next" => 17, "atk"=> 0}
@anime["j2x"][17] = {"pic" => 372, "wait" => 2, "next" => 18}
@anime["j2x"][18] = {"pic" => 373, "wait" => 11, "next" => 19}
@anime["j2x"][19] = {"pic" => 374, "wait" => 3, "next" => 20, "atk" => [Rect.new(-80, -75, 180, 86), Rect.new(35, -170, 105, 170)],"se"=> ["swing2", 70, 80], "bullet" => [@me, "jz_effect1", 0, 5, -30, false, false], "hit_reset" => true}
@anime["j2x"][20] = {"pic" => 375, "wait" => 8, "next" => 21, "atk" => 0}
@anime["j2x"][21] = {"pic" => 375, "wait" => 100, "next" => ["jump_fall"], "var_reset" => true}  # 落下姿




#-------------------------------------------------------------------------------
# ○ 鐮刀
#-------------------------------------------------------------------------------
@anime["ball"][0] = {"pic" => 350, "wait" => 2, "next" => 1, "atk" => [Rect.new(-85, -178, 170, 178)], "x_speed" => 15.3, "se"=> ["swing06_r", 80, 90], "z_pos" => 3}
@anime["ball"][1] = {"pic" => 351, "wait" => 2, "next" => 2, "x_speed" => 21.3, "blur" => true}
@anime["ball"][2] = {"pic" => 352, "wait" => 2, "next" => 3, "x_speed" => 24.3}
@anime["ball"][3] = {"pic" => 353, "wait" => 2, "next" => 4, "x_speed" => 28.5}
@anime["ball"][4] = {"pic" => 354, "wait" => 2, "next" => 5, "x_speed" => 31.8}
@anime["ball"][5] = {"pic" => 355, "wait" => 2, "next" => 6, "x_speed" => 32.7}
@anime["ball"][6] = {"pic" => 356, "wait" => 2, "next" => 7, "x_speed" => 14.3,"se"=> ["swing06_r", 80, 90]}
@anime["ball"][7] = {"pic" => 357, "wait" => 2, "next" => 8, "x_speed" => 5.3, "y_speed"=> 19.3}
@anime["ball"][8] = {"pic" => 358, "wait" => 2, "next" => 9, "x_speed" => -7.3, "y_speed"=> 21.3}
@anime["ball"][9] = {"pic" => 359, "wait" => 2, "next" => 10, "x_speed" => -12.3, "y_speed"=> 11.3, "hit_reset" => true}
@anime["ball"][10] = {"pic" => 360, "wait" => 2, "next" => 11, "x_speed" => -16.3, "y_speed"=> 5.3}
@anime["ball"][11] = {"pic" => 361, "wait" => 2, "next" => 12, "x_speed" => -19.3, "y_speed"=> 3.3}
@anime["ball"][12] = {"pic" => 362, "wait" => 2, "next" => 13, "x_speed" => -21.3, "y_speed"=> -6.3,"se"=> ["swing06_r", 80, 90]}
@anime["ball"][13] = {"pic" => 351, "wait" => 2, "next" => 14, "x_speed" => -27.5, "y_speed"=> -9.3}
@anime["ball"][14] = {"pic" => 352, "wait" => 2, "next" => 15, "x_speed" => -29.3, "y_speed"=> -12.3}
@anime["ball"][15] = {"pic" => 353, "wait" => 2, "next" => 16, "x_speed" => -31.2, "y_speed"=> -14.3}
@anime["ball"][16] = {"pic" => 354, "wait" => 2, "next" => 17, "x_speed" => -34.3, "y_speed"=> -16.3}
@anime["ball"][17] = {"pic" => 355, "wait" => 2, "next" => 18, "x_speed" => -38.3, "y_speed"=> -18.3}
@anime["ball"][18] = {"pic" => 356, "wait" => 2, "next" => 19, "x_speed" => -42.3, "y_speed"=> -22.3,"se"=> ["swing06_r", 80, 90]}
@anime["ball"][19] = {"pic" => 357, "wait" => 2, "next" => 20, "x_speed" => -48.3, "y_speed"=> -24.3}
@anime["ball"][20] = {"pic" => 358, "wait" => 2, "next" => 21, "x_speed" => -48.3, "y_speed"=> -24.3}
@anime["ball"][21] = {"pic" => 359, "wait" => 2, "next" => "do_dispose", "x_speed" => -48.3, "y_speed"=> -24.3}
#-------------------------------------------------------------------------------
# ○ 氣功波本身(爆破)
#-------------------------------------------------------------------------------
@anime["ball_b"][0] = {"pic" => 301, "wait" => 3, "next" => 1, "atk" => 0, "x_speed" => 2}
@anime["ball_b"][1] = {"pic" => 302, "wait" => 3, "next" => 2}
@anime["ball_b"][2] = {"pic" => 303, "wait" => 3, "next" => 3}
@anime["ball_b"][3] = {"pic" => 304, "wait" => 3, "next" => ["dispose"]}


#-------------------------------------------------------------------------------
# ○ 掛掉
#-------------------------------------------------------------------------------
@anime["dead"][0] = {"pic" => 131, "wait" => 2, "next" => 1, "ab_uncancel" => 8, "uncancel" => true}
@anime["dead"][1] = {"pic" => 132, "wait" => 2, "next" => 2, "x_speed" => -11.3}
@anime["dead"][2] = {"pic" => 133, "wait" => 2, "next" => 3}
@anime["dead"][3] = {"pic" => 134, "wait" => 2, "next" => 4}
@anime["dead"][4] = {"pic" => 172, "wait" => 40, "next" => "go_dead_transform"}




#-------------------------------------------------------------------------------
# ○ 泣鐮(劇情用)
#-------------------------------------------------------------------------------
@anime["story_5x"][0] = {"pic" => 301, "wait" => 2, "next" => 1, "ab_uncancel" => 51, "uncancel" => true, "anime" => [1,0,0], "superstop" => 28, "supermove" => 28, "black" => [48,50], "fps" => [23, 55], "blur" => true, "z_pos" => 3,"se"=> ["eco00", 70, 116]}  #,  "se"=> ["eco00", 80, 110]
@anime["story_5x"][1] = {"pic" => 302, "wait" => 2, "next" => 2}
@anime["story_5x"][2] = {"pic" => 303, "wait" => 2, "next" => 3}
@anime["story_5x"][3] = {"pic" => 304, "wait" => 2, "next" => 4, "se"=> ["swing06_r", 80, 90]}
@anime["story_5x"][4] = {"pic" => 305, "wait" => 2, "next" => 5}
@anime["story_5x"][5] = {"pic" => 306, "wait" => 2, "next" => 6}
@anime["story_5x"][6] = {"pic" => 307, "wait" => 2, "next" => 7}
@anime["story_5x"][7] = {"pic" => 308, "wait" => 2, "next" => 8}
@anime["story_5x"][8] = {"pic" => 309, "wait" => 2, "next" => 9}
@anime["story_5x"][9] = {"pic" => 310, "wait" => 2, "next" => 10}
@anime["story_5x"][10] = {"pic" => 311, "wait" => 2, "next" => 11}
@anime["story_5x"][11] = {"pic" => 312, "wait" => 2, "next" => 12, "se"=> ["swing06_r", 80, 90]}
@anime["story_5x"][12] = {"pic" => 313, "wait" => 2, "next" => 13}
@anime["story_5x"][13] = {"pic" => 314, "wait" => 2, "next" => 14}
@anime["story_5x"][14] = {"pic" => 315, "wait" => 2, "next" => 15}
@anime["story_5x"][15] = {"pic" => 316, "wait" => 2, "next" => 16}
@anime["story_5x"][16] = {"pic" => 317, "wait" => 2, "next" => 17}
@anime["story_5x"][17] = {"pic" => 318, "wait" => 2, "next" => 18}
@anime["story_5x"][18] = {"pic" => 319, "wait" => 2, "next" => 19}
@anime["story_5x"][19] = {"pic" => 320, "wait" => 2, "next" => 20}
@anime["story_5x"][20] = {"pic" => 321, "wait" => 2, "next" => 21, "bullet" => [@me, "story_ball", 0, 70, 0, false, true],"se"=> ["swing06_r", 80, 90]}
# 跳起
@anime["story_5x"][21] = {"pic" => 322, "wait" => 2, "next" => 22}
@anime["story_5x"][22] = {"pic" => 323, "wait" => 2, "next" => 23}
@anime["story_5x"][23] = {"pic" => 324, "wait" => 2, "next" => 24}
@anime["story_5x"][24] = {"pic" => 325, "wait" => 2, "next" => 24} # <= 維持在這格

# 著地
@anime["story_5x"][25] = {"pic" => 326, "wait" => 2, "next" => 26, "x_speed"=> -6.2}
@anime["story_5x"][26] = {"pic" => 327, "wait" => 2, "next" => 27}
@anime["story_5x"][27] = {"pic" => 328, "wait" => 2, "next" => 28}
@anime["story_5x"][28] = {"pic" => 329, "wait" => 2, "next" => 29}
@anime["story_5x"][29] = {"pic" => 330, "wait" => 2, "next" => 30}
@anime["story_5x"][30] = {"pic" => 331, "wait" => 2, "next" => 31}
@anime["story_5x"][31] = {"pic" => 332, "wait" => 80, "next" => 32}
@anime["story_5x"][32] = {"pic" => 333, "wait" => 2, "next" => 33}
@anime["story_5x"][33] = {"pic" => 334, "wait" => 2, "next" => 34}
@anime["story_5x"][34] = {"pic" => 335, "wait" => 2, "next" => 35}
@anime["story_5x"][35] = {"pic" => 336, "wait" => 2, "next" => 36}
@anime["story_5x"][36] = {"pic" => 337, "wait" => 2, "next" => 37,"se"=> ["impact_se3", 72, 135]}
@anime["story_5x"][37] = {"pic" => 338, "wait" => 2, "next" => 38, "x_speed"=> -6.2, "anime" => [11,0,0]}
@anime["story_5x"][38] = {"pic" => 339, "wait" => 4, "next" => 39, "blur" => false}
@anime["story_5x"][39] = {"pic" => 340, "wait" => 2, "next" => 40}
@anime["story_5x"][40] = {"pic" => 341, "wait" => 2, "next" => 41}
@anime["story_5x"][41] = {"pic" => 342, "wait" => 2, "next" => 42}
@anime["story_5x"][42] = {"pic" => 343, "wait" => 2, "next" => 43}
@anime["story_5x"][43] = {"pic" => 344, "wait" => 2, "next" => 44}
@anime["story_5x"][44] = {"pic" => 345, "wait" => 2, "next" => 45}
@anime["story_5x"][45] = {"pic" => 346, "wait" => 2, "next" => 46}
@anime["story_5x"][46] = {"pic" => 347, "wait" => 2, "next" => 47}
@anime["story_5x"][47] = {"pic" => 348, "wait" => 2, "next" => 48}
@anime["story_5x"][48] = {"pic" => 349, "wait" => 2, "next" => ["stand"], "var_reset" => true, "x_speed"=> 4.2}

#-------------------------------------------------------------------------------
# ○ 鐮刀
#-------------------------------------------------------------------------------
@anime["story_ball"][0] = {"pic" => 350, "wait" => 2, "next" => 1, "atk" => [Rect.new(-85, -178, 170, 178)], "x_speed" => 15.3,"se"=> ["swing06_r", 80, 90], "z_pos" => 3}
@anime["story_ball"][1] = {"pic" => 351, "wait" => 2, "next" => 2, "x_speed" => 38.3, "blur" => true}
@anime["story_ball"][2] = {"pic" => 352, "wait" => 2, "next" => 3, "x_speed" => 42.3}
@anime["story_ball"][3] = {"pic" => 353, "wait" => 2, "next" => 4, "x_speed" => 48.5}
@anime["story_ball"][4] = {"pic" => 354, "wait" => 2, "next" => 5, "x_speed" => 52.8}
@anime["story_ball"][5] = {"pic" => 355, "wait" => 2, "next" => 6, "x_speed" => 58.7}
@anime["story_ball"][6] = {"pic" => 356, "wait" => 2, "next" => 7, "x_speed" => 28.3,"se"=> ["swing06_r", 80, 90]}
@anime["story_ball"][7] = {"pic" => 357, "wait" => 2, "next" => 8, "x_speed" => 13.3, "y_speed"=> 19.3}
@anime["story_ball"][8] = {"pic" => 358, "wait" => 2, "next" => 9, "x_speed" => -7.3, "y_speed"=> 21.3}
@anime["story_ball"][9] = {"pic" => 359, "wait" => 2, "next" => 10, "x_speed" => -12.3, "y_speed"=> 11.3, "hit_reset" => true}
@anime["story_ball"][10] = {"pic" => 360, "wait" => 2, "next" => 11, "x_speed" => -16.3, "y_speed"=> 5.3}
@anime["story_ball"][11] = {"pic" => 361, "wait" => 2, "next" => 12, "x_speed" => -19.3, "y_speed"=> 3.3}
@anime["story_ball"][12] = {"pic" => 362, "wait" => 2, "next" => 13, "x_speed" => -21.3, "y_speed"=> -6.3,"se"=> ["swing06_r", 80, 90]}
@anime["story_ball"][13] = {"pic" => 351, "wait" => 2, "next" => 14, "x_speed" => -27.5, "y_speed"=> -9.3}
@anime["story_ball"][14] = {"pic" => 352, "wait" => 2, "next" => 15, "x_speed" => -29.3, "y_speed"=> -12.3}
@anime["story_ball"][15] = {"pic" => 353, "wait" => 2, "next" => 16, "x_speed" => -31.2, "y_speed"=> -14.3}
@anime["story_ball"][16] = {"pic" => 354, "wait" => 2, "next" => 17, "x_speed" => -34.3, "y_speed"=> -16.3}
@anime["story_ball"][17] = {"pic" => 355, "wait" => 2, "next" => 18, "x_speed" => -38.3, "y_speed"=> -18.3}
@anime["story_ball"][18] = {"pic" => 356, "wait" => 2, "next" => 19, "x_speed" => -42.3, "y_speed"=> -22.3,"se"=> ["swing06_r", 80, 90]}
@anime["story_ball"][19] = {"pic" => 357, "wait" => 2, "next" => 20, "x_speed" => -48.3, "y_speed"=> -24.3}
@anime["story_ball"][20] = {"pic" => 358, "wait" => 2, "next" => 21, "x_speed" => -48.3, "y_speed"=> -24.3}
@anime["story_ball"][21] = {"pic" => 359, "wait" => 2, "next" => "do_dispose", "x_speed" => -48.3, "y_speed"=> -24.3}

#-------------------------------------------------------------------------------
# ○ 劇情用倒地
#-------------------------------------------------------------------------------
@anime["story_down"][0] = {"pic" => 145, "wait" => -1, "next" => 0}



#-------------------------------------------------------------------------------
# ○ 站立(有帽)
#-------------------------------------------------------------------------------
@anime["story_stand"][0] = {"pic" => 701, "wait" => 4, "next" => 1, "body" => @me.stand_body_rect, "z_pos" =>  1}
@anime["story_stand"][1] = {"pic" => 702, "wait" => 4, "next" => 2}
@anime["story_stand"][2] = {"pic" => 703, "wait" => 4, "next" => 3}
@anime["story_stand"][3] = {"pic" => 704, "wait" => 4, "next" => 4}
@anime["story_stand"][4] = {"pic" => 705, "wait" => 4, "next" => 5}
@anime["story_stand"][5] = {"pic" => 706, "wait" => 4, "next" => 6}
@anime["story_stand"][6] = {"pic" => 707, "wait" => 4, "next" => 7}
@anime["story_stand"][7] = {"pic" => 708, "wait" => 4, "next" => 8}
@anime["story_stand"][8] = {"pic" => 709, "wait" => 4, "next" => 9}
@anime["story_stand"][9] = {"pic" => 710, "wait" => 4, "next" => 10}
@anime["story_stand"][10] = {"pic" => 711, "wait" => 4, "next" => 11}
@anime["story_stand"][11] = {"pic" => 712, "wait" => 4, "next" => 12}
@anime["story_stand"][12] = {"pic" => 713, "wait" => 4, "next" => 13}
@anime["story_stand"][13] = {"pic" => 714, "wait" => 4, "next" => 14}
@anime["story_stand"][14] = {"pic" => 715, "wait" => 4, "next" => 15}
@anime["story_stand"][15] = {"pic" => 716, "wait" => 4, "next" => 16}
@anime["story_stand"][16] = {"pic" => 717, "wait" => 4, "next" => 17}
@anime["story_stand"][17] = {"pic" => 718, "wait" => 4, "next" => 18}
@anime["story_stand"][18] = {"pic" => 719, "wait" => 4, "next" => 19}
@anime["story_stand"][19] = {"pic" => 720, "wait" => 4, "next" => 20}
@anime["story_stand"][20] = {"pic" => 721, "wait" => 4, "next" => 21}
@anime["story_stand"][21] = {"pic" => 722, "wait" => 4, "next" => 22}
@anime["story_stand"][22] = {"pic" => 723, "wait" => 4, "next" => 23}
@anime["story_stand"][23] = {"pic" => 724, "wait" => 4, "next" => 24}
@anime["story_stand"][24] = {"pic" => 725, "wait" => 4, "next" => 25}
@anime["story_stand"][25] = {"pic" => 726, "wait" => 4, "next" => 26}
@anime["story_stand"][26] = {"pic" => 727, "wait" => 4, "next" => 27}
@anime["story_stand"][27] = {"pic" => 728, "wait" => 4, "next" => 28}
@anime["story_stand"][28] = {"pic" => 729, "wait" => 4, "next" => 29}
@anime["story_stand"][29] = {"pic" => 730, "wait" => 4, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 閒置(有帽)
#-------------------------------------------------------------------------------
@anime["story_idle"][0] = {"pic" => 731, "wait" => 3, "next" => 1}
@anime["story_idle"][1] = {"pic" => 732, "wait" => 3, "next" => 2}
@anime["story_idle"][2] = {"pic" => 733, "wait" => 3, "next" => 3}
@anime["story_idle"][3] = {"pic" => 734, "wait" => 3, "next" => 4}
@anime["story_idle"][4] = {"pic" => 735, "wait" => 3, "next" => 5}
@anime["story_idle"][5] = {"pic" => 736, "wait" => 3, "next" => 6}
@anime["story_idle"][6] = {"pic" => 737, "wait" => 3, "next" => 7}
@anime["story_idle"][7] = {"pic" => 738, "wait" => 3, "next" => 8}
@anime["story_idle"][8] = {"pic" => 739, "wait" => 3, "next" => 9}
@anime["story_idle"][9] = {"pic" => 740, "wait" => 3, "next" => 10}
@anime["story_idle"][10] = {"pic" => 734, "wait" => 3, "next" => 11}
@anime["story_idle"][11] = {"pic" => 735, "wait" => 3, "next" => 12}
@anime["story_idle"][12] = {"pic" => 736, "wait" => 3, "next" => 13}
@anime["story_idle"][13] = {"pic" => 737, "wait" => 3, "next" => 14}
@anime["story_idle"][14] = {"pic" => 738, "wait" => 3, "next" => 15}
@anime["story_idle"][15] = {"pic" => 739, "wait" => 3, "next" => 16}
@anime["story_idle"][16] = {"pic" => 740, "wait" => 3, "next" => 17}
@anime["story_idle"][17] = {"pic" => 733, "wait" => 3, "next" => 18}
@anime["story_idle"][18] = {"pic" => 732, "wait" => 3, "next" => 19}
@anime["story_idle"][19] = {"pic" => 731, "wait" => 3, "next" => 20}
@anime["story_idle"][20] = {"pic" => 730, "wait" => 3, "next" => ["story_stand"]}

#-------------------------------------------------------------------------------
# ○ 劇情用跑步(有帽)
#-------------------------------------------------------------------------------
@anime["story_dash2"][0] = {"pic" => 741, "wait" => 1, "next" => 1, "anime" => [11,0,0], "z_pos" =>  1}
@anime["story_dash2"][1] = {"pic" => 742, "wait" => 1, "next" => 2}
@anime["story_dash2"][2] = {"pic" => 743, "wait" => 1, "next" => 3}
@anime["story_dash2"][3] = {"pic" => 744, "wait" => 1, "next" => 4}
@anime["story_dash2"][4] = {"pic" => 745, "wait" => 1, "next" => 5}
@anime["story_dash2"][5] = {"pic" => 746, "wait" => 1, "next" => 6}
@anime["story_dash2"][6] = {"pic" => 747, "wait" => 1, "next" => 7}
@anime["story_dash2"][7] = {"pic" => 748, "wait" => 1, "next" => 8}
@anime["story_dash2"][8] = {"pic" => 749, "wait" => 1, "next" => 9}
@anime["story_dash2"][9] = {"pic" => 750, "wait" => 1, "next" => 10}
@anime["story_dash2"][10] = {"pic" => 751, "wait" => 1, "next" => 11}
@anime["story_dash2"][11] = {"pic" => 752, "wait" => 1, "next" => 12}
@anime["story_dash2"][12] = {"pic" => 753, "wait" => 1, "next" => 13}
@anime["story_dash2"][13] = {"pic" => 754, "wait" => 1, "next" => 14}
@anime["story_dash2"][14] = {"pic" => 755, "wait" => 1, "next" => 15}
@anime["story_dash2"][15] = {"pic" => 756, "wait" => 1, "next" => 16}
@anime["story_dash2"][16] = {"pic" => 757, "wait" => 1, "next" => 17}
@anime["story_dash2"][17] = {"pic" => 758, "wait" => 1, "next" => 18}
@anime["story_dash2"][18] = {"pic" => 759, "wait" => 1, "next" => 19}
@anime["story_dash2"][19] = {"pic" => 760, "wait" => 1, "next" => 20}
@anime["story_dash2"][20] = {"pic" => 761, "wait" => 1, "next" => 21}
@anime["story_dash2"][21] = {"pic" => 762, "wait" => 1, "next" => 22}
@anime["story_dash2"][22] = {"pic" => 763, "wait" => 1, "next" => 23}
@anime["story_dash2"][23] = {"pic" => 764, "wait" => 1, "next" => 24}
@anime["story_dash2"][24] = {"pic" => 765, "wait" => 1, "next" => 25}
@anime["story_dash2"][25] = {"pic" => 766, "wait" => 1, "next" => 26}
@anime["story_dash2"][26] = {"pic" => 767, "wait" => 1, "next" => 27}
@anime["story_dash2"][27] = {"pic" => 768, "wait" => 1, "next" => 28}
@anime["story_dash2"][28] = {"pic" => 769, "wait" => 1, "next" => 0}

#-------------------------------------------------------------------------------
# ○ 前斬 (有帽)
#-------------------------------------------------------------------------------
@anime["story_6z"][0] = {"pic" => 771, "wait" => 28, "next" => 1, "ab_uncancel" => 15, "uncancel" => true, "z_pos" => 3, "anime" => [12,0,0], "penetrate" => true, "x_speed" => 13.3}
@anime["story_6z"][1] = {"pic" => 772, "wait" => 2, "next" => 2}
@anime["story_6z"][2] = {"pic" => 774, "wait" => 6, "next" => 3}
@anime["story_6z"][3] = {"pic" => 775, "wait" => 4, "next" => 4, "atk" => [Rect.new(-80, -130, 250, 120)], "x_speed" => @me.dash_x_speed * 4.7, "se"=> ["swing2", 70, 80], "anime" => [12,0,0]}
@anime["story_6z"][4] = {"pic" => 777, "wait" => 9, "next" => 5}
@anime["story_6z"][5] = {"pic" => 778, "wait" => 12, "next" => 6, "atk" => 0, "x_speed" => 5.7}
@anime["story_6z"][6] = {"pic" => 779, "wait" => 3, "next" => 7}
@anime["story_6z"][7] = {"pic" => 780, "wait" => 3,  "next" => ["story_stand"], "var_reset" => true, "anime" => [12,0,0]}


#-------------------------------------------------------------------------------
# ○ 中斷跑步(有帽)
#-------------------------------------------------------------------------------
@anime["dash_break2"][0] = {"pic" => 771, "wait" => 6, "next" => ["story_stand"], "anime" => [12,0,0], "var_reset" => true}

end




#==============================================================================
# ■ 主模組補強
#==============================================================================

  #--------------------------------------------------------------------------
  # ◇ 執行其他預約指令
  #      處理5ZZ、5XX這種角色間不一定有的指令
  #--------------------------------------------------------------------------
  def do_other_plancommand
    
     if @command_plan.include?("z")
      z_action
    elsif @command_plan.include?("x")
      x_action
    elsif @command_plan.include?("s") 
      s_action
    end
   # case @command_plan
    #when "5zz"
   # end
 end
 
  #--------------------------------------------------------------------------
  # ◇ 進入第二階段(魔鏡專用)
  #--------------------------------------------------------------------------
  def go_dead_transform
  #  @me.battle_sprite.battler_shadow.visible = false
 #   @me.dead_disappear = true
    @frame_duration = -1
    @me.combohit_clear
    @me.transform(12)
    @me.hp = @me.maxhp
    @me.sp = @me.maxsp
    var_reset
    @me.animation.push([19, true,0,0])
    @eva_invincible_duration = 0
  end 
  
  #--------------------------------------------------------------------------
  # ◇ 獸化 
  #--------------------------------------------------------------------------
  def to_awake
     x = @me.x_pos
     y = @me.y_pos
     xs = @me.now_x_speed
     ys = @me.now_y_speed
    # state = @handle_battler.motion.state
   #  frame = @handle_battler.motion.frame_number
     dir = @me.direction
     id = @me.id
     @y_fixed = false
     $game_party.add_actor(3)
     $game_party.remove_actor(1)  
     $scene.actor_awake(x, y, xs, ys, dir, id, @me.awake_time)
  end
  
  #--------------------------------------------------------------------------
  # ◇ 著地
  #--------------------------------------------------------------------------
  def do_landing_step
    if @me.hp == 0
    elsif ["damage1", "damage2", "guard", "guard_shock", "binding", "binding2", "binding3"].include?(@state)
      @me.z_pos = 0
    elsif @state == "ball" or @state == "story_ball"
      return
    elsif @state == "5x" and @frame_number == 24
      change_anime(@state, 25)
    elsif @state == "jz" and @frame_number == 5
      change_anime(@state, 6)
    elsif @state == "f_flee"
      change_anime("f_flee", 4)
      @me.z_pos = 0
    elsif @state == "b_flee" #and @frame_number == 4
      change_anime("b_flee", 5)
      @me.z_pos = 0
    elsif @state == "ball2"
       change_anime("ball2_b")
      @frame_loop = [0,0] 
    else
      change_anime("landing")
      @me.z_pos = 0
    end
    Audio.se_play("Audio/SE/" + CROUCH_SE, 75 * $game_config.se_rate / 10, 90)
    @me.now_x_speed = 0
    @me.now_y_speed = 0

    @attack_rect  = [] # 攻擊判定消除
    @command_plan = ""
    @high_jump = false
    @now_jumps = 0
    @airdash_times = 0
    @uncancel_flag = false 
    @y_fixed = false
    @frame_loop[0] = 0
    @frame_loop[1] = 0
    @now_full_lv = 0
    @me.edge_spacing = 0
    @me.animation.push([10+rand(3),true,0,0])
  end
  #--------------------------------------------------------------------------
  # ◇ 攻擊中
  #--------------------------------------------------------------------------
  def attacking?
    return (z_skill? or x_skill?)
  end 
  #--------------------------------------------------------------------------
  # ◇ 普通攻擊
  #--------------------------------------------------------------------------
  def z_skill?
    return ["5z","5zz", "5zzz", "6z","2z","jz","j2z", "j6z"].include?(@state)
  end  
  #--------------------------------------------------------------------------
  # ◇ 必殺
  #--------------------------------------------------------------------------
  def x_skill?
    return ["5x","j2x"].include?(@state)
  end  
#==============================================================================
# ■ 指令設置
#==============================================================================


  #-------------------------------------------------------------------------------
  # ○ 上
  #-------------------------------------------------------------------------------
  def up_action(dir)
  #  if ["jump_fall", "f_jump_fall", "b_jump_fall", "hf_jump_fall", "hb_jump_fall", "h_jump_fall"].include?(@state) and @now_jumps  < 2
   #   @me.direction = dir if dir != 0
    #   change_anime("double_jump")
    #  @now_jumps  += 1
   # end
  end
  #-------------------------------------------------------------------------------
  # ○ 下
  #-------------------------------------------------------------------------------
  def down_action
  end
  #-------------------------------------------------------------------------------
  # ○ 前
  #-------------------------------------------------------------------------------
  def front_action
  end
  #-------------------------------------------------------------------------------
  # ○ 後
  #-------------------------------------------------------------------------------
  def back_action
  end
  #--------------------------------------------------------------------------
  # ◇ →→
  #--------------------------------------------------------------------------
  def do_66
     if ["stand", "stand_idle", "walk"].include?(@state)
       do_dash(1)
     end    
     return
     if ["jump_fall", "double_jump_fall", "f_jump_fall", "b_jump_fall", "hf_jump_fall", "hb_jump_fall", "h_jump_fall"].include?(@state) and @airdash_times < 2
        change_anime("af_flee")
        @airdash_times += 1
    end
     if attacking?
       if on_air?
         return if @state == "af_chase"
         @me.ai.set_ai_trigger("66_lock", true) if do_act("af_chase", "66","chase") and rand(5) > 2 
       else
         return if @state == "f_chase"
         do_act("f_chase", "66","chase") 
       end
     end
     
  end
  #--------------------------------------------------------------------------
  # ◇ ←←
  #--------------------------------------------------------------------------
  def do_44
    if ["stand", "stand_idle", "walk"].include?(@state)
       do_dash(-1)
     end
     return
     if ["jump_fall", "double_jump_fall", "f_jump_fall", "b_jump_fall", "hf_jump_fall", "hb_jump_fall", "h_jump_fall"].include?(@state) and @airdash_times < 2
        change_anime("ab_flee")
        @airdash_times += 1
    end
    if attacking?
      if on_air?
        return if @action_name == "ab_chase"
        do_act("ab_chase", "44","chase") 
      else
        return if @action_name == "b_chase"
        do_act("b_chase", "44","chase") 
      end
    end
  end

  #--------------------------------------------------------------------------
  # ◇ ↑↑
  #--------------------------------------------------------------------------
  def do_88 
    return
     if attacking?
       @me.ai.set_ai_trigger("8xx_lock", true) if do_act("u_chase", "88","chase") and rand(10) > 2
     end
  end
  #--------------------------------------------------------------------------
  # ◇ ↓↓
  #--------------------------------------------------------------------------
  def do_22 
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ Z
  #-------------------------------------------------------------------------------
  def z_action
    if on_air?
      do_act("jz", "z","Z")
    else
      case @state
      when "5zzz" # 正在出第三擊
        # 沒反應
      when "5zz" # 正在出第二擊
         do_act("5zzz", "zz","Z", true)
      when "5z"  # 正在出第一擊
         do_act("5zz", "z","Z", true)
      else # 除外的情況
         do_act("5z", "z","Z", (@action_name == "x"))
      end
    end
  end
  #-------------------------------------------------------------------------------
  # ○ →Z
  #-------------------------------------------------------------------------------
  def fz_action
    if on_air?
      do_act("j6z", "j6z","Z")
    else
      if @state == "6x" and [7,8,9].include?(@frame_number)
        do_act("6x2", "6z","X", true)
      else
        do_act("6z", "6z","Z")
      end
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↓Z
  #-------------------------------------------------------------------------------
  def dz_action
   # return
    if on_air?
      do_act("j2z", "2z","Z")
    else
      do_act("2z", "2z","Z") 
    end
  end
  
  #-------------------------------------------------------------------------------
  # ○ ↑Z
  #-------------------------------------------------------------------------------
  def uz_action
    #return
    return if !on_air?
    do_act("j2z", "8z","Z")
  end
  #-------------------------------------------------------------------------------
  # ○ ←Z
  #-------------------------------------------------------------------------------
  def bz_action
    if on_air?
       do_act("j6z", "4z","Z")
    else
      unless ["stand", "stand_idle", "walk", "run"].include?(@state) 
        do_act("6z", "4z","Z", (@state == "5x")) 
      end
    end
  end
  #-------------------------------------------------------------------------------
  # ○ X
  #-------------------------------------------------------------------------------
  def x_action
    if on_air?
      do_act("j2x", "5x","X", false, false, 60) 
    else
      do_act("5x", "5x","X", false, false, 60)
    end
  end
  #-------------------------------------------------------------------------------
  # ○ →X
  #-------------------------------------------------------------------------------
  def fx_action
    if on_air?
       x_action
    else
      x_action
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↓X
  #-------------------------------------------------------------------------------
  def dx_action
    if on_air?
      do_act("j2x", "2x","X", false, false, 60) 
    else
      x_action
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↑X
  #-------------------------------------------------------------------------------
  def ux_action
    return if !on_air?
    do_act("j2x", "8x","X", false, false, 60) 
  end
  #-------------------------------------------------------------------------------
  # ○ ←X
  #-------------------------------------------------------------------------------
  def bx_action
    if on_air?
      x_action
    else
      unless ["stand", "stand_idle", "walk", "run"].include?(@state) 
        do_act("5x", "4x","X", false, false, 60)
      end
    end
  end
  #-------------------------------------------------------------------------------
  # ○ C
  #-------------------------------------------------------------------------------
  def c_action
    return if !controllable?
    @timely_guard_time = TIMELY_GUARD_TIME
  end
  #-------------------------------------------------------------------------------
  # ○ →C
  #-------------------------------------------------------------------------------
  def fc_action
  #  return
    if on_air?
     # if ["jump_fall", "f_jump_fall", "b_jump_fall", "guard"].include?(@state)
     #   change_anime("af_flee")
    #  end
    else
      if ["stand", "stand_idle", "walk", "dash", "dash_break", "guard", "landing"].include?(@state) 
        change_anime("f_flee")
      end
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↑C
  #-------------------------------------------------------------------------------
  def uc_action
   # do_high_jump if ["guard", "landing"].include?(@state)
  end
  #-------------------------------------------------------------------------------
  # ○ ↓C
  #-------------------------------------------------------------------------------
  def dc_action
  end
  #-------------------------------------------------------------------------------
  # ○ ←C
  #-------------------------------------------------------------------------------
  def bc_action
  #  return
    if on_air?
    #  if ["jump_fall", "f_jump_fall", "b_jump_fall", "guard"].include?(@state)
     #   change_anime("ab_flee")
    #  end
    else
      if ["stand", "stand_idle", "walk", "dash", "dash_break", "guard", "landing"].include?(@state)# or
     #   (@state == "f_flee" and (4..5) === @frame_number) or (@state == "b_flee" and @frame_number == 5 and @frame_time > 6) 
         change_anime("b_flee")
      end  
    end
  end
  
  #-------------------------------------------------------------------------------
  # ○ 跳砍特效
  #-------------------------------------------------------------------------------
  def jz_effect1
    @me.battle_sprite.opacity = (@frame_duration * (255/@anime[@state][0]["wait"]))
  end
  
  #-------------------------------------------------------------------------------
  # ○ 死亡迴旋斬
  #-------------------------------------------------------------------------------
  def j2x
      
    case @anime_time
    when 1
      @physical = false
      @me.now_y_speed = 11.5
    when 2..50
      @y_fixed = false
      @me.now_y_speed = [@me.now_y_speed-0.4, -6].max
    when 51
      @me.now_y_speed = 5
    when 52..63
      @me.now_y_speed = [@me.now_y_speed-0.7, -6].max
    when 64
      @physical = true
    end
    
  end  
  
  
  #-------------------------------------------------------------------------------
  # ○ 劇情用走路
  #-------------------------------------------------------------------------------
  def story_walk
    @me.now_x_speed = @me.direction * 2.9#@me.dash_x_speed
  end
  #-------------------------------------------------------------------------------
  # ○ 劇情用奔跑
  #-------------------------------------------------------------------------------
  def story_dash
    @me.now_x_speed = @me.direction * 6.4#@me.dash_x_speed
  end
  #-------------------------------------------------------------------------------
  # ○ 劇情用奔跑(有帽)
  #-------------------------------------------------------------------------------
  def story_dash2
    @me.now_x_speed = @me.direction * 6.4#@me.dash_x_speed
  end
  
  #-------------------------------------------------------------------------------
  # ○ 被網住
  #-------------------------------------------------------------------------------
  def binding
    if @anime_time == 70
      var_reset
      @me.animation.push([9, true,0,0])
      change_anime("stand")
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 被網住
  #-------------------------------------------------------------------------------
  def binding2
    if @anime_time == 70
      var_reset
      @me.animation.push([9, true,0,0])
      change_anime("stand")
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 被網住
  #-------------------------------------------------------------------------------
  def binding3
    if @anime_time == 70
      var_reset
      @me.animation.push([9, true,0,0])
      change_anime("stand")
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 常時監視A (不受暫停、受傷定格效果影響)
  #-------------------------------------------------------------------------------
  def respective_updateA

    # 變黑
    @me.battle_sprite.tone = @black_tone.clone if @me.is_a?(Game_Enemy) and @me.battle_sprite.tone != @black_tone and !$game_switches[STILILA::ENDING]
    
    if $game_switches[STILILA::ENDING] and @me.battle_sprite.tone != @original_tone
      @me.battle_sprite.tone.set(0,0,0) 
    end
    
    
    if @state == "j2x" and @anime_time < 69
      $game_temp.black_time = [2, 50]  
    end
    
   # 陣亡 (敵方限定)
    if  @me.hp == 0 and @state != "dead" and @me.is_a?(Game_Enemy) #and !downing?
      $game_system.se_play($data_system.enemy_collapse_se) 
      @eva_invincible_duration = 999
      change_anime("dead")
      @hit_stop_duration = 20
    end
    
    # 金手指
   # if @me.is_a?(Game_Actor) and $gold_finger
     # @me.hp = @me.maxhp
    #  @me.sp = @me.maxsp
    #  @me.awake_time = 1200
   # end
    
  end
  
  
  
  #-------------------------------------------------------------------------------
  # ○ 常時監視B (受暫停、受傷定格效果影響)
  #-------------------------------------------------------------------------------
  def respective_updateB
    
    if ["damage1", "damage2"].include?(@state) and @knock_back_duration <= 0 and !@catched
      var_reset
      on_air? ? change_anime("jump_fall") : change_anime("stand")
    end
    
    if ["guard_shock"].include?(@state) and @knock_back_duration <= 0
      change_anime("guard")
    end
    if ["f_down", "b_down"].include?(@state) and @down_count <= 0 and !@catched
      @me.combohit_clear
      unless @me.dead?
         if @me.is_a?(Game_Actor)
          @eva_invincible_duration = 80
        else
          @eva_invincible_duration = 10
        end
        (@state == "f_down") ? change_anime("f_down_stand") : change_anime("b_down_stand")
      end
    end
    if on_air? and freemove?
      change_anime("jump_fall")
    end
    
    if @state == "ball"
      # 使用者變身的情況自毀
      if @me.root.is_a?(Game_Actor) and @me.root != $game_party.actors[0]
        do_dispose
        return
      end
      
      if @me.root.direction == 1
        if @me.x_pos <= @me.root.x_pos
          do_dispose
          @me.root.motion.change_anime("5x", 34)
        end
      else
        if @me.x_pos >= @me.root.x_pos
          do_dispose
          @me.root.motion.change_anime("5x", 34)
        end
      end
    end
    
    if @state == "story_ball"
      if @me.root.direction == 1
        if @me.x_pos <= @me.root.x_pos
          do_dispose
          @me.root.motion.change_anime("story_5x", 34)
        end
      else
        if @me.x_pos >= @me.root.x_pos
          do_dispose
          @me.root.motion.change_anime("story_5x", 34)
        end
      end
    end
      
    
    # 隨機出現閒置動作
    if @state == "stand" and @frame_number == 29 and @frame_duration == 1 and rand(3) == 1 and !$game_switches[STILILA::NO_IDLE]
     change_anime("stand_idle")
    end

    # 隨機出現閒置動作(有帽)
    if @state == "story_stand" and @frame_number == 29 and @frame_duration == 1 and rand(3) == 1 and !$game_switches[STILILA::NO_IDLE]
     change_anime("story_idle")
   end
   
    if @me.dead? and (["stand"].include?(@state) or (["damage1", "damage2"].include?(@state) and !@catched))
       change_anime("f_blow")
      @me.now_y_speed += 4
    end
    
    
  end
  
  
#==============================================================================
# ■ 其他
#==============================================================================
  
  #--------------------------------------------------------------------------
  # ◇ 碰撞判定時的變數設置
  #--------------------------------------------------------------------------  
  def collision_varset(action, target)
    case action
    when "x"
      @me.root.ai.set_ai_trigger("x_constant", true) 
    when "jz"
      @me.ai.set_ai_trigger("6s_constant", true)  if (0..25) === @me.y_pos 
    when "jx"
      @me.ai.set_ai_trigger("8xx_lock", true) 
    when "2x"
      @me.ai.set_ai_trigger("ground_2x", true)  unless target.motion.on_air?
    end
    # 命中判定(AI用)
    if @me.is_a?(Game_BattleBullet)  # 飛道的情況
     @me.root.ai.contact_time = 1  # 碰撞計數
      if (!target.guarding? and target.motion.hit_invincible_duration <= 0  and target.motion.timely_guard_time <= 0)
        @me.root.ai.hit_time = 1  # 命中計數
      end
      if target.guarding?
        @me.root.ai.guard_time = 1
      end
    else # 角色本身的情況
      @me.ai.contact_time = 1  # 碰撞計數
      if (!target.guarding? and target.motion.hit_invincible_duration <= 0  and target.motion.timely_guard_time <= 0)
        @me.ai.hit_time = 1 # 命中計數
      end
      if target.guarding?
        @me.ai.guard_time = 1
      end
    end
    
    # 成就解鎖：帥氣的結尾
    if target.is_a?(Game_Enemy) and target.dead? and STILILA::SUPER_FINISH.include?(target.id)
      if @me.is_a?(Game_BattleBullet) and @state == "ball"
        $game_config.get_achievement(4)
      elsif @me.is_a?(Game_Actor) and x_skill?
        $game_config.get_achievement(4)
      end
    end
    
    
    #p @me.y_pos if @me.is_a?(Game_Enemy)
  end
  #--------------------------------------------------------------------------
  # ◇ 碰撞行為
  # skill_name：招式名稱
  # target：目標
  # 構想：處刑演出(目標血量or自己血量小於定值)
  #--------------------------------------------------------------------------  
  def collision_action(action, target)   
    
    can_lock = true
    can_catch = true
    can_lock = false if (target.is_a?(Game_Enemy) && STILILA::NO_LOCK_ENEMY.include?(target.id))
    can_catch = false if (target.is_a?(Game_Enemy) && STILILA::NO_CATCH_ENEMY.include?(target.id))
    
    case action
    when 1
    else
    end # case end
    
  end
  
  #--------------------------------------------------------------------------
  # ◇ 取得攻擊目標範圍
  #     (1：敵方、2：我方、3：使用者)
  #--------------------------------------------------------------------------  
  def get_skill_scope
    return 1
  end 
  #--------------------------------------------------------------------------
  # ◇ 攻擊效果設定
  #--------------------------------------------------------------------------  
  def skill_effect(skill, target)
    
      result = super(skill, target)
      
      
      result["spark"] = [1, 5*rand(10), 9*(rand(6)+1)+30]
      
      if skill == "5z"
        result["power"] = 45
        result["limit"] = 30
        result["scope"].delete("Blow") # 擊飛狀態打不到
        result["blow_type"] = "None" # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 4
        result["t_hitstop"] = 4 
        result["correction"] = 3
        result["t_knockback"] = 19
        result["x_speed"] = 4    
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 70, 90]      
     elsif skill == "5zz" # 前兩斬
        result["power"] = 45
        result["limit"] = 25
        result["scope"].delete("Blow") # 擊飛狀態打不到
        result["blow_type"] = "None" # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 4
        result["t_hitstop"] = 4 
        result["correction"] = 3
        result["t_knockback"] = 30
        result["x_speed"] = 4    
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 70, 90]   
      elsif skill == "5zzz"   and  @frame_number >= 4  # 第三斬
        result["power"] = 60
        result["limit"] = 15
        result["u_hitstop"] = 5
        result["t_hitstop"] = 5                   
        result["t_knockback"] = 25
        result["x_speed"] = 6.9   
        result["y_speed"] = 6 
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 70, 90]                       
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 11
        
      elsif skill == "ball" or skill == "story_ball"  # 泣鐮
        result["power"] = 160
        result["limit"] = 100
        result["u_hitstop"] = 5
        result["t_hitstop"] = 8                   
        result["t_knockback"] = 30
        result["x_speed"] = 8.9   
        result["y_speed"] = 11.6
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se4", 80, 110]                   
        result["sp_recover"] = 5
        result["full_count"] = 2
        result["hit_slide"] = 0
        result["h_shake"] = [4,9,12,0]
        result["d_shake"] = [6,10,12,0]
        
      elsif skill == "6z"
        result["power"] = 60
        result["limit"] = 15
        result["blow_type"] = "None" if !target.motion.on_air? # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 5
        result["t_hitstop"] = 5                   
        result["t_knockback"] = 25
        result["x_speed"] = 5.9   
        result["y_speed"] = 9.4 if target.motion.on_air?
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 70, 90]                     
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 11
      elsif skill == "story_6z"
        result["power"] = 60
        result["limit"] = 15
        result["u_hitstop"] = 5
        result["t_hitstop"] = 5                   
        result["t_knockback"] = 25
        result["x_speed"] = -7.9   
        result["y_speed"] = 15.4
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 70, 90]                     
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 11
      elsif skill == "2z"
        result["power"] = 60
        result["limit"] = 2
        result["u_hitstop"] = 5
        result["t_hitstop"] = 7                
        result["t_knockback"] = 30     
        result["x_speed"] = 3.3   
        result["y_speed"] = 15.4   
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 70, 90]
        result["sp_recover"] = 3
        result["h_shake"] = [1,3,8,1]
        result["d_shake"] = [2,4,8,1]
        result["full_count"] = 2
      elsif skill == "jz"
        result["power"] = 55
        result["limit"] = 3
        result["u_hitstop"] = 8
        result["t_hitstop"] = 10                 
        result["t_knockback"] = 20  
        result["x_speed"] = 5.6  
        result["y_speed"] = 4          
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 70, 90]       
        result["sp_recover"] = 1
      elsif skill == "j6z"
        result["power"] = 55
        result["limit"] = 30
        result["u_hitstop"] = 10
        result["t_hitstop"] = 13                
        result["t_knockback"] = 36
        result["x_speed"] = 9.6  
        result["y_speed"] = 4          
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 70, 90]       
        result["sp_recover"] = 1
      elsif skill == "j2z"
        result["power"] = 60
        result["limit"] = 15
        result["u_hitstop"] = 5
        result["t_hitstop"] = 7                 
        result["t_knockback"] = 22   
        result["x_speed"] = 4.7 
        result["y_speed"] = -21.2          
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 70, 90]      
        result["sp_recover"] = 2
        result["h_shake"] = [1,3,8,1]
        result["d_shake"] = [2,4,8,1]
        result["full_count"] = 2
      elsif skill == "j2x" and @frame_number < 19
        result["power"] = 30
        result["limit"] = 8
        result["u_hitstop"] = 1
        result["t_hitstop"] = 2              
        result["t_knockback"] = 50  
        result["x_speed"] = 0 
        result["y_speed"] = [@me.now_y_speed + 3, 5.7].max
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 80, 145]     
        result["sp_recover"] = 1
        result["full_count"] = 2
      elsif skill == "j2x" and @frame_number == 19
        result["power"] = 250
        result["limit"] = 170
        result["u_hitstop"] = 20
        result["t_hitstop"] = 20                
        result["t_knockback"] = 52  
        result["x_speed"] = 12 
        result["y_speed"] = -22    
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se4", 80, 110]      
        result["sp_recover"] = 5
        result["h_shake"] = [3,5,20,1]
        result["d_shake"] = [3,5,20,1]
        result["full_count"] = 2
      else
      end #if end
      return result
  end #def end
end # class end
