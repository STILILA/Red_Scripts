#==============================================================================
# ■ 大槍的Motion


# 註：計算總動作時間時記得是每個wait
#==============================================================================
class Red_Hunter < Game_Motion
  
#--------------------------------------------------------------------------
# ○ 變量公開
#--------------------------------------------------------------------------
attr_reader :skill1_target  #記憶大招1的lock目標
#--------------------------------------------------------------------------
# ○ 人物生成/初始化
#--------------------------------------------------------------------------
def initialize(me,frame=0,anime="stand")
  super
  
  
  # 宣告所有動畫
  @anime = {"awake" => [], "stand" => [], "stand_idle" => [], "walk" => [], "story_walk" => [], "dash" => [], "dash_break" => [],
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
  "5z" => [], "5zz" => [], "6z" => [], "6zz" => [], "2z_gun" => [], "2z" => [], "2zz" => [],
  "6x" => [], "spark1" => [], "gun1" => [], "j2z_gun" => [], "spark2" => [],
  "jz" => [], "j6z" => [],
  "j2z" => [], 
  "skill1" => [], "skill1_failed" => [], "skill1_gun" => [], "skill1_gun2" => [], 
  "skill2" => [], "skill2_gun" => [], 
  "skill3" => [], "skill3_ball" => [],
  
  
  "dz_effect1" => [],
  "jz_effect1" => [], "jz_effect2" => [], "jz_effect3" => [],
  "ball" => [], "ball_b" => [], "ball2" => [], "ball2_b" => [], "big_ball" => [], "big_ball_b" => [], "dizzy1" => [], "dizzy2" => [], "binding" => [], "binding2" => [], "binding3" => [], "dead"=>[],
  
  "story_down" => [], "story_dash" => []}
  
  
  # 設定動作的影格
  frame_set
  @full_limit = 11
  @flag_2zz = false
  # 記憶大招1的lock目標
  @skill1_target = nil
  
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
@anime["stand"][18] = {"pic" => 19, "wait" => 4, "next" => 0}

#-------------------------------------------------------------------------------
# ○ 閒置
#-------------------------------------------------------------------------------
@anime["stand_idle"][0] = {"pic" => 20, "wait" => 4, "next" => 1}
@anime["stand_idle"][1] = {"pic" => 21, "wait" => 3, "next" => 2}
@anime["stand_idle"][2] = {"pic" => 22, "wait" => 2, "next" => 3}
@anime["stand_idle"][3] = {"pic" => 23, "wait" => 2, "next" => 4}
@anime["stand_idle"][4] = {"pic" => 24, "wait" => 1, "next" => 5}
@anime["stand_idle"][5] = {"pic" => 25, "wait" => 1, "next" => 6}
@anime["stand_idle"][6] = {"pic" => 26, "wait" => 2, "next" => 7}
@anime["stand_idle"][7] = {"pic" => 27, "wait" => 3, "next" => 8}
@anime["stand_idle"][8] = {"pic" => 28, "wait" => 3, "next" => 9}
@anime["stand_idle"][9] = {"pic" => 29, "wait" => 3, "next" => 10}
@anime["stand_idle"][10] = {"pic" => 30, "wait" => 3, "next" => 11}
@anime["stand_idle"][11] = {"pic" => 31, "wait" => 3, "next" => 12}
@anime["stand_idle"][12] = {"pic" => 32, "wait" => 3, "next" => 13}
@anime["stand_idle"][13] = {"pic" => 33, "wait" => 3, "next" => 14}
@anime["stand_idle"][14] = {"pic" => 34, "wait" => 3, "next" => 15}
@anime["stand_idle"][15] = {"pic" => 35, "wait" => 3, "next" => 16}
@anime["stand_idle"][16] = {"pic" => 36, "wait" => 3, "next" => 17}
@anime["stand_idle"][17] = {"pic" => 37, "wait" => 3, "next" => 18}
@anime["stand_idle"][18] = {"pic" => 38, "wait" => 3, "next" => 19}
@anime["stand_idle"][19] = {"pic" => 39, "wait" => 3, "next" => ["stand"]}


#@anime["stand"][39] = {"pic" => 40, "wait" => 3, "next" => 1}
#------------------------------------------------------------------------------
# ○ 走路
#-------------------------------------------------------------------------------
@anime["walk"][0] = {"pic" => 61, "wait" => 3, "next" => 1, "z_pos" =>  1}
@anime["walk"][1] = {"pic" => 62, "wait" => 3, "next" => 2}
@anime["walk"][2] = {"pic" => 63, "wait" => 3, "next" => 3}
@anime["walk"][3] = {"pic" => 64, "wait" => 3, "next" => 4}
@anime["walk"][4] = {"pic" => 65, "wait" => 3, "next" => 5}
@anime["walk"][5] = {"pic" => 66, "wait" => 3, "next" => 6}
@anime["walk"][6] = {"pic" => 67, "wait" => 3, "next" => 7}
@anime["walk"][7] = {"pic" => 68, "wait" => 3, "next" => 8}
@anime["walk"][8] = {"pic" => 69, "wait" => 3, "next" => 9}
@anime["walk"][9] = {"pic" => 70, "wait" => 3, "next" => 10}
@anime["walk"][10] = {"pic" => 71, "wait" => 3, "next" => 11}
@anime["walk"][11] = {"pic" => 72, "wait" => 3, "next" => 12}
@anime["walk"][12] = {"pic" => 73, "wait" => 3, "next" => 13}
@anime["walk"][13] = {"pic" => 74, "wait" => 3, "next" => 14}
@anime["walk"][14] = {"pic" => 75, "wait" => 3, "next" => 15}
@anime["walk"][15] = {"pic" => 76, "wait" => 3, "next" => 16}
@anime["walk"][16] = {"pic" => 77, "wait" => 3, "next" => 17}
@anime["walk"][17] = {"pic" => 78, "wait" => 3, "next" => 18}
@anime["walk"][18] = {"pic" => 79, "wait" => 3, "next" => 0}
#------------------------------------------------------------------------------
# ○ 走路(劇情用)
#-------------------------------------------------------------------------------
@anime["story_walk"][0] = {"pic" => 61, "wait" => 3, "next" => 1, "z_pos" =>  1}
@anime["story_walk"][1] = {"pic" => 62, "wait" => 3, "next" => 2}
@anime["story_walk"][2] = {"pic" => 63, "wait" => 3, "next" => 3}
@anime["story_walk"][3] = {"pic" => 64, "wait" => 3, "next" => 4}
@anime["story_walk"][4] = {"pic" => 65, "wait" => 3, "next" => 5}
@anime["story_walk"][5] = {"pic" => 66, "wait" => 3, "next" => 6}
@anime["story_walk"][6] = {"pic" => 67, "wait" => 3, "next" => 7}
@anime["story_walk"][7] = {"pic" => 68, "wait" => 3, "next" => 8}
@anime["story_walk"][8] = {"pic" => 69, "wait" => 3, "next" => 9}
@anime["story_walk"][9] = {"pic" => 70, "wait" => 3, "next" => 10}
@anime["story_walk"][10] = {"pic" => 71, "wait" => 3, "next" => 11}
@anime["story_walk"][11] = {"pic" => 72, "wait" => 3, "next" => 12}
@anime["story_walk"][12] = {"pic" => 73, "wait" => 3, "next" => 13}
@anime["story_walk"][13] = {"pic" => 74, "wait" => 3, "next" => 14}
@anime["story_walk"][14] = {"pic" => 75, "wait" => 3, "next" => 15}
@anime["story_walk"][15] = {"pic" => 76, "wait" => 3, "next" => 16}
@anime["story_walk"][16] = {"pic" => 77, "wait" => 3, "next" => 17}
@anime["story_walk"][17] = {"pic" => 78, "wait" => 3, "next" => 18}
@anime["story_walk"][18] = {"pic" => 79, "wait" => 3, "next" => 0}

#-------------------------------------------------------------------------------
# ○ 跑步
#-------------------------------------------------------------------------------

@anime["dash"][0] = {"pic" => 91, "wait" => 3, "next" => 2, "anime" => [11,0,0], "z_pos" =>  1}
#@anime["dash"][1] = {"pic" => 92, "wait" => 2, "next" => 2}
@anime["dash"][2] = {"pic" => 93, "wait" => 3, "next" => 4}
#@anime["dash"][3] = {"pic" => 94, "wait" => 2, "next" => 4}
@anime["dash"][4] = {"pic" => 95, "wait" => 3, "next" => 6}
#@anime["dash"][5] = {"pic" => 96, "wait" => 2, "next" => 6}
@anime["dash"][6] = {"pic" => 97, "wait" => 3, "next" => 8}
#@anime["dash"][7] = {"pic" => 98, "wait" => 2, "next" => 8}
@anime["dash"][8] = {"pic" => 99, "wait" => 3, "next" => 10}
#@anime["dash"][9] = {"pic" => 100, "wait" => 2, "next" => 10}
@anime["dash"][10] = {"pic" => 101, "wait" => 3, "next" => 12}
#@anime["dash"][11] = {"pic" => 102, "wait" => 2, "next" => 12}
@anime["dash"][12] = {"pic" => 103, "wait" => 3, "next" => 14}
#@anime["dash"][13] = {"pic" => 104, "wait" => 2, "next" => 14}
@anime["dash"][14] = {"pic" => 105, "wait" => 3, "next" => 16}
#@anime["dash"][15] = {"pic" => 106, "wait" => 2, "next" => 16}
@anime["dash"][16] = {"pic" => 107, "wait" => 3, "next" => 18}
#@anime["dash"][17] = {"pic" => 108, "wait" => 2, "next" => 18}
@anime["dash"][18] = {"pic" => 109, "wait" => 3, "next" => 0}
#@anime["dash"][19] = {"pic" => 110, "wait" => 2, "next" => 0}


=begin
@anime["dash"][0] = {"pic" => 91, "wait" => 2, "next" => 1, "anime" => [11,0,0], "z_pos" =>  1}
@anime["dash"][1] = {"pic" => 92, "wait" => 2, "next" => 2}
@anime["dash"][2] = {"pic" => 93, "wait" => 2, "next" => 3}
@anime["dash"][3] = {"pic" => 94, "wait" => 2, "next" => 4}
@anime["dash"][4] = {"pic" => 95, "wait" => 2, "next" => 5}
@anime["dash"][5] = {"pic" => 96, "wait" => 2, "next" => 6}
@anime["dash"][6] = {"pic" => 97, "wait" => 2, "next" => 7}
@anime["dash"][7] = {"pic" => 98, "wait" => 2, "next" => 8}
@anime["dash"][8] = {"pic" => 99, "wait" => 2, "next" => 9}
@anime["dash"][9] = {"pic" => 100, "wait" => 2, "next" => 10}
@anime["dash"][10] = {"pic" => 101, "wait" => 2, "next" => 11}
@anime["dash"][11] = {"pic" => 102, "wait" => 2, "next" => 12}
@anime["dash"][12] = {"pic" => 103, "wait" => 2, "next" => 13}
@anime["dash"][13] = {"pic" => 104, "wait" => 2, "next" => 14}
@anime["dash"][14] = {"pic" => 105, "wait" => 2, "next" => 15}
@anime["dash"][15] = {"pic" => 106, "wait" => 2, "next" => 16}
@anime["dash"][16] = {"pic" => 107, "wait" => 2, "next" => 17}
@anime["dash"][17] = {"pic" => 108, "wait" => 2, "next" => 18}
@anime["dash"][18] = {"pic" => 109, "wait" => 2, "next" => 19}
@anime["dash"][19] = {"pic" => 110, "wait" => 2, "next" => 0}
=end


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
@anime["jump"][2] = {"pic" => 123, "wait" => 16, "next" => ["jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity}
@anime["jump_fall"][0] = {"pic" => 124, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 前跳躍  / 落下
#-------------------------------------------------------------------------------
@anime["f_jump"][0] = {"pic" => 121, "wait" => 3, "next" => 1, "ab_uncancel" => 7, "y_fixed" => true}
@anime["f_jump"][1] = {"pic" => 122, "wait" => 2, "next" => 2, "anime" => [12,0,0], "var_reset" => true}
@anime["f_jump"][2] = {"pic" => 123, "wait" => 16, "next" => ["f_jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity/1.2, "x_speed" => @me.dash_x_speed}
@anime["f_jump_fall"][0] = {"pic" => 124, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 二段跳 / 落下
#-------------------------------------------------------------------------------
@anime["double_jump"][0] = {"pic" => 121, "wait" => 3, "next" => 1, "y_fixed" => true, "ab_uncancel" => 5}
@anime["double_jump"][1] = {"pic" => 122, "wait" => 2, "next" => 2}
@anime["double_jump"][2] = {"pic" => 123, "wait" => 3, "next" => ["double_jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity}
@anime["double_jump_fall"][0] = {"pic" => 124, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 大跳 / 落下
#-------------------------------------------------------------------------------
@anime["h_jump"][0] = {"pic" => 121, "wait" => 5, "next" => 1, "blur" => true, "x_speed" => 0, "ab_uncancel" => 8, "y_fixed" => true}
@anime["h_jump"][1] = {"pic" => 122, "wait" => 2, "next" => 2}
@anime["h_jump"][2] = {"pic" => 123, "wait" => 5, "next" => 3, "x_speed" => (@me.dash_x_speed/1.5), "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity + 1.4}
@anime["h_jump"][3] = {"pic" => 123, "wait" => 3, "next" => ["h_jump_fall"]}
@anime["h_jump_fall"][0] = {"pic" => 124, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 前大跳  / 落下
#-------------------------------------------------------------------------------
@anime["hf_jump"][0] = {"pic" => 121, "wait" => 2, "next" => 1, "ab_uncancel" => 2, "y_fixed" => true}
@anime["hf_jump"][1] = {"pic" => 123, "wait" => 9, "next" => ["hf_jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity - 5.5, "x_speed" => @me.dash_x_speed * 1.5}
@anime["hf_jump_fall"][0] = {"pic" => 124, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 著地
#-------------------------------------------------------------------------------
@anime["landing"][0] = {"pic" => 125, "wait" => 4, "next" => 1, "anime" => [12,0,0], "ab_uncancel" => 2}
@anime["landing"][1] = {"pic" => 121, "wait" => 3, "next" => ["stand"], "var_reset" => true}
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
@anime["damage1"][2] = {"pic" => 133, "wait" => -1, "next" => 2}
@anime["damage1"][3] = {"pic" => 134, "wait" => 2, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 受傷2
#-------------------------------------------------------------------------------
@anime["damage2"][0] = {"pic" => 131, "wait" => 2, "next" => 1}
@anime["damage2"][1] = {"pic" => 132, "wait" => 2, "next" => 2}
@anime["damage2"][2] = {"pic" => 133, "wait" => -1, "next" => 2}
@anime["damage2"][3] = {"pic" => 134, "wait" => 2, "next" => ["stand"]}
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
@anime["f_down_stand"][0] = {"pic" => 125, "wait" => 6, "next" => ["stand"], "ab_uncancel" => 8, "var_reset" => true, "body" => @me.sit_body_rect}
@anime["bounce_f_down"][0] = {"pic" => 146, "wait" => -1, "next" => 0, "body" => @me.down_body_rect}  # 反彈
#-------------------------------------------------------------------------------
# ○ 倒地－－面朝下/反彈/起身
#-------------------------------------------------------------------------------
@anime["b_down"][0] = {"pic" => 155, "wait" => -1, "next" => 0, "ab_uncancel" => 22, "body" => @me.down_body_rect}
@anime["b_down_stand"][0] = {"pic" => 125, "wait" => 6, "next" => ["stand"], "ab_uncancel" => 8, "var_reset" => true, "body" => @me.sit_body_rect}
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
@anime["dizzy1"][0] = {"pic" => 91, "wait" => 3, "next" => 1}
@anime["dizzy1"][1] = {"pic" => 92, "wait" => 3, "next" => 0}
@anime["dizzy2"][0] = {"pic" => 101, "wait" => 3, "next" => 1}
@anime["dizzy2"][1] = {"pic" => 102, "wait" => 3, "next" => 0}

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
@anime["f_flee"][2] = {"pic" => 482, "wait" => 3, "next" => 3, "x_speed" => 18.2, "y_speed" => 3.2}
@anime["f_flee"][3] = {"pic" => 481, "wait" => 88, "next" => 3}
@anime["f_flee"][4] = {"pic" => 484, "wait" => 3, "next" => 5, "eva" => 10, "ab_uncancel" => 4} # 著地
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
@anime["b_flee"][4] = {"pic" => 122, "wait" => 9, "next" => 5, "x_speed" => -8.2}
@anime["b_flee"][5] = {"pic" => 125, "wait" => 8, "next" => ["stand"], "var_reset" => true, "penetrate" => false, "ab_uncancel" => 4, "eva" => 3}
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
# ○ 踢腿 (Z)
#-------------------------------------------------------------------------------
@anime["5z"][0] = {"pic" => 221, "wait" => 2, "next" => 1, "ab_uncancel" => 14, "z_pos" => 3}
@anime["5z"][1] = {"pic" => 222, "wait" => 2, "next" => 2}
@anime["5z"][2] = {"pic" => 223, "wait" => 2, "next" => 3}
@anime["5z"][3] = {"pic" => 225, "wait" => 2, "next" => 4, "atk" => [Rect.new(10, -75, 99, 75)], "se"=> ["swing2", 70, 105], "x_speed" => 2.2}
@anime["5z"][4] = {"pic" => 226, "wait" => 2, "next" => 5}
@anime["5z"][5] = {"pic" => 227, "wait" => 2, "next" => 6}
@anime["5z"][6] = {"pic" => 228, "wait" => 3, "next" => 7, "atk" => 0}
@anime["5z"][7] = {"pic" => 229, "wait" => 2, "next" => 8}
@anime["5z"][8] = {"pic" => 230, "wait" => 2, "next" => 9}
@anime["5z"][9] = {"pic" => 231, "wait" => 2, "next" => 10}
@anime["5z"][10] = {"pic" => 232, "wait" => 4, "next" => 11}
@anime["5z"][11] = {"pic" => 233, "wait" => 3, "next" => 12}
@anime["5z"][12] = {"pic" => 234, "wait" => 3, "next" => 13}
@anime["5z"][13] = {"pic" => 235, "wait" => 3, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 開槍 (ZZ)
#-------------------------------------------------------------------------------
@anime["5zz"][0] = {"pic" => 201, "wait" => 3, "next" => 1, "ab_uncancel" => 31, "z_pos" => 3}
@anime["5zz"][1] = {"pic" => 202, "wait" => 3, "next" => 2, "se"=> ["gun_ready", 96, 100]}
@anime["5zz"][2] = {"pic" => 203, "wait" => 2, "next" => 3}
@anime["5zz"][3] = {"pic" => 209, "wait" => 2, "next" => 4}

@anime["5zz"][4] = {"pic" => 498, "wait" => 2, "next" => 5, "bullet" => [@me, "spark1", 0, 109, 69, false, false], "se"=> ["gun_fire1", 73, 80]}
@anime["5zz"][5] = {"pic" => 499, "wait" => 3, "next" => 6, "bullet" => [@me, "gun1", 0, 65, 0, false, false]}
@anime["5zz"][6] = {"pic" => 209, "wait" => 2, "next" => 7}

@anime["5zz"][7] = {"pic" => 498, "wait" => 2, "next" => 8, "bullet" => [@me, "spark1", 0, 109, 69, false, false], "se"=> ["gun_fire1", 73, 80]}
@anime["5zz"][8] = {"pic" => 499, "wait" => 3, "next" => 9, "bullet" => [@me, "gun1", 0, 65, 0, false, false]}
@anime["5zz"][9] = {"pic" => 209, "wait" => 2, "next" => 10}

@anime["5zz"][10] = {"pic" => 498, "wait" => 2, "next" => 11, "bullet" => [@me, "spark1", 0, 109, 69, false, false], "se"=> ["gun_fire1", 73, 80]}
@anime["5zz"][11] = {"pic" => 499, "wait" => 3, "next" => 12, "bullet" => [@me, "gun1", 0, 65, 0, false, false]}
@anime["5zz"][12] = {"pic" => 209, "wait" => 2, "next" => 13}

@anime["5zz"][13] = {"pic" => 498, "wait" => 2, "next" => 14, "bullet" => [@me, "spark1", 0, 109, 69, false, false], "se"=> ["gun_fire1", 73, 80]}
@anime["5zz"][14] = {"pic" => 499, "wait" => 3, "next" => 15, "bullet" => [@me, "gun1", 0, 65, 0, false, false]}
@anime["5zz"][15] = {"pic" => 209, "wait" => 2, "next" => 16}

@anime["5zz"][16] = {"pic" => 498, "wait" => 2, "next" => 17, "bullet" => [@me, "spark1", 0, 109, 69, false, false], "se"=> ["gun_fire1", 73, 80]}
@anime["5zz"][17] = {"pic" => 499, "wait" => 3, "next" => 18, "bullet" => [@me, "gun1", 0, 65, 0, false, false]}
@anime["5zz"][18] = {"pic" => 209, "wait" => 15, "next" => 19}

@anime["5zz"][19] = {"pic" => 205, "wait" => 1, "next" => 20, "bullet" => [@me, "spark1", 0, 109, 73, false, false], "se"=> ["gun_fire1", 73, 80]}
@anime["5zz"][20] = {"pic" => 205, "wait" => 5, "next" => 21, "bullet" => [@me, "2z_gun", 0, 65, 0, false, false], "x_speed" => -8.2}
@anime["5zz"][21] = {"pic" => 204, "wait" => 5, "next" => 22}
@anime["5zz"][22] = {"pic" => 202, "wait" => 5, "next" => 23}
@anime["5zz"][23] = {"pic" => 201, "wait" => 5, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 火花
#-------------------------------------------------------------------------------
@anime["spark1"][0] = {"pic" => 206, "wait" => 2, "next" => 1, "z_pos" =>  3}
@anime["spark1"][1] = {"pic" => 207, "wait" => 2, "next" => 2}
@anime["spark1"][2] = {"pic" => 208, "wait" => 2, "next" => ["dispose"]}
#-------------------------------------------------------------------------------
# ○ 對地開槍火花
#-------------------------------------------------------------------------------
@anime["spark2"][0] = {"pic" => 371, "wait" => 2, "next" => 1, "z_pos" =>  3}
@anime["spark2"][1] = {"pic" => 372, "wait" => 2, "next" => 2}
@anime["spark2"][2] = {"pic" => 373, "wait" => 2, "next" => ["dispose"]}
#-------------------------------------------------------------------------------
# ○ 子彈
#-------------------------------------------------------------------------------
@anime["gun1"][0] = {"pic" => 999, "wait" => 1, "next" => 0, "z_pos" =>  3, "atk" => [Rect.new(20, -115, 90, 110)], "x_speed" => 25.5, "loop" => [7, ["gun1",1]]}
@anime["gun1"][1] = {"pic" => 999, "wait" => 2, "next" => ["dispose"], "atk" => 0}
#-------------------------------------------------------------------------------
# ○ 槍托打 (→Z)
#-------------------------------------------------------------------------------
@anime["6z"][0] = {"pic" => 245, "wait" => 3, "next" => 1, "ab_uncancel" => 21, "uncancel" => true, "z_pos" => 3}
@anime["6z"][1] = {"pic" => 491, "wait" => 3, "next" => 2, "x_speed" => 16.7, "y_speed" => 6.4}
@anime["6z"][2] = {"pic" => 492, "wait" => 3, "next" => 3}
@anime["6z"][3] = {"pic" => 493, "wait" => 3, "next" => 4, "se"=> ["swing2", 65, 105]}
@anime["6z"][4] = {"pic" => 494, "wait" => 4, "next" => 5, "atk" => [Rect.new(2, -155, 104, 135)]}
@anime["6z"][5] = {"pic" => 495, "wait" => 4, "next" => 6, "atk" => 0}
@anime["6z"][6] = {"pic" => 496, "wait" => 8, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 踢腿補彈
#-------------------------------------------------------------------------------
@anime["2z_gun"][0] = {"pic" => 999, "wait" => 1, "next" => 0, "z_pos" =>  3, "atk" => [Rect.new(20, -85, 90, 60)], "x_speed" => 24.5, "loop" => [5, ["2z_gun",1]]}
@anime["2z_gun"][1] = {"pic" => 999, "wait" => 2, "next" => ["dispose"], "atk" => 0}


#-------------------------------------------------------------------------------
# ○ 槍托上尻
#-------------------------------------------------------------------------------
@anime["2z"][0] = {"pic" => 242, "wait" => 2, "next" => 1, "ab_uncancel" => 19,"uncancel" => true, "z_pos" => 3}
@anime["2z"][1] = {"pic" => 243, "wait" => 2, "next" => 2}
@anime["2z"][2] = {"pic" => 244, "wait" => 2, "next" => 3}
@anime["2z"][3] = {"pic" => 245, "wait" => 2, "next" => 4}
@anime["2z"][4] = {"pic" => 246, "wait" => 2, "next" => 5}
@anime["2z"][5] = {"pic" => 247, "wait" => 3, "next" => 6, "se"=> ["swing2", 76, 90], "x_speed" => 9.8}
@anime["2z"][6] = {"pic" => 248, "wait" => 3, "next" => 7, "atk" => [Rect.new(10, -120, 134, 95)]}
@anime["2z"][7] = {"pic" => 249, "wait" => 3, "next" => 8, "atk" => [Rect.new(-10, -220, 76, 210)]}
@anime["2z"][8] = {"pic" => 250, "wait" => 3, "next" => 9}
@anime["2z"][9] = {"pic" => 251, "wait" => 3, "next" => 10, "atk" => 0}
@anime["2z"][10] = {"pic" => 252, "wait" => 3, "next" => 11}
@anime["2z"][11] = {"pic" => 253, "wait" => 3, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 蹲下開槍
#-------------------------------------------------------------------------------
@anime["2zz"][0] = {"pic" => 261, "wait" => 2, "next" => 1, "ab_uncancel" => 21,"uncancel" => true, "z_pos" => 3, "se"=> ["swing3", 88, 110]}
@anime["2zz"][1] = {"pic" => 262,  "wait" => 2, "next" => 2}
@anime["2zz"][2] = {"pic" => 263, "wait" => 2, "next" => 3}
@anime["2zz"][3] = {"pic" => 264, "wait" => 2, "next" => 4, "se"=> ["swing3", 88, 110]}
@anime["2zz"][4] = {"pic" => 265, "wait" => 2, "next" => 5}
@anime["2zz"][5] = {"pic" => 266, "wait" => 2, "next" => 6}
@anime["2zz"][6] = {"pic" => 267, "wait" => 2, "next" => 7, "se"=> ["swing3", 88, 110]}
@anime["2zz"][7] = {"pic" => 268, "wait" => 3, "next" => 8}
@anime["2zz"][8] = {"pic" => 269, "wait" => 4, "next" => 9, "se"=> ["gun_ready", 96, 100]}
@anime["2zz"][9] = {"pic" => 270, "wait" => 7, "next" => 10}
@anime["2zz"][10] = {"pic" => 271, "wait" => 1, "next" => 11, "bullet" => [@me, "spark1", 0, 69, 53, false, false], "se"=> ["gun_fire1", 73, 80]}
@anime["2zz"][11] = {"pic" => 272, "wait" => 4, "next" => 12, "bullet" => [@me, "2z_gun", 0, 45, 0, false, false], "x_speed" => -6.2}
@anime["2zz"][12] = {"pic" => 273, "wait" => 3, "next" => 13}
@anime["2zz"][13] = {"pic" => 274, "wait" => 3, "next" => 14}
@anime["2zz"][14] = {"pic" => 275, "wait" => 3, "next" => 15}
@anime["2zz"][15] = {"pic" => 276, "wait" => 3, "next" => 16}
@anime["2zz"][16] = {"pic" => 277, "wait" => 4, "next" => 17}
@anime["2zz"][17] = {"pic" => 278, "wait" => 2, "next" => 18}
@anime["2zz"][18] = {"pic" => 279, "wait" => 2, "next" => 19}
@anime["2zz"][19] = {"pic" => 280, "wait" => 2, "next" => 20}
@anime["2zz"][20] = {"pic" => 281, "wait" => 2, "next" => 21}
@anime["2zz"][21] = {"pic" => 282, "wait" => 3, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 蹲砍特效
#-------------------------------------------------------------------------------
@anime["dz_effect1"][0] = {"pic" => 361, "wait" => 12, "next" => ["dispose"], "z_pos" =>  3}


#-------------------------------------------------------------------------------
# ○ 砍
#-------------------------------------------------------------------------------
@anime["jz"][0] = {"pic" => 301, "wait" => 7, "next" => 1, "ab_uncancel" => 18, "uncancel" => true, "z_pos" => 3}
@anime["jz"][1] = {"pic" => 561, "wait" => 2, "next" => 2, "atk" => [Rect.new(6, -121, 102, 100)], "se"=> ["swing2", 65, 105], "bullet" => [@me, "jz_effect1", 0, 30, 53, false, false]}
@anime["jz"][2] = {"pic" => 562, "wait" => 2, "next" => 3, "atk" => [Rect.new(6, -121, 102, 100)], "hit_reset" => true, "se"=> ["swing2", 65, 105], "bullet" => [@me, "jz_effect2", 0, 30, 73, false, false]}
@anime["jz"][3] = {"pic" => 563, "wait" => 2, "next" => 4, "atk" => [Rect.new(6, -121, 102, 100)], "hit_reset" => true, "se"=> ["swing2", 65, 105], "bullet" => [@me, "jz_effect3", 0, 30, 23, false, false]}
@anime["jz"][4] = {"pic" => 564, "wait" => 2, "next" => 5, "atk" => [Rect.new(6, -121, 102, 100)], "hit_reset" => true, "se"=> ["swing2", 65, 105], "bullet" => [@me, "jz_effect1", 0, 30, 53, false, false]}
@anime["jz"][5] = {"pic" => 304, "wait" => 3, "next" => 6}
@anime["jz"][6] = {"pic" => 305, "wait" => 6, "next" => ["jump_fall"], "atk" => 0, "var_reset" => true}


#-------------------------------------------------------------------------------
# ○ 前砍
#-------------------------------------------------------------------------------
@anime["j6z"][0] = {"pic" => 301, "wait" => 12, "next" => 1, "ab_uncancel" => 15, "uncancel" => true, "z_pos" => 3, "y_speed" => 5.2}
@anime["j6z"][1] = {"pic" => 303, "wait" => 4, "next" => 2, "atk" => [Rect.new(0, -70, 132, 72)], "se"=> ["swing2", 65, 105], "bullet" => [@me, "jz_effect3", 0, 30, 23, false, false]}
@anime["j6z"][2] = {"pic" => 304, "wait" => 4, "next" => 3}
@anime["j6z"][3] = {"pic" => 305, "wait" => 8, "next" => ["jump_fall"], "atk" => 0, "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 跳砍特效
#-------------------------------------------------------------------------------
@anime["jz_effect1"][0] = {"pic" => 571, "wait" => 12, "next" => ["dispose"], "z_pos" =>  3}
@anime["jz_effect2"][0] = {"pic" => 572, "wait" => 12, "next" => ["dispose"], "z_pos" =>  3}
@anime["jz_effect3"][0] = {"pic" => 573, "wait" => 12, "next" => ["dispose"], "z_pos" =>  3}


#-------------------------------------------------------------------------------
# ○ 對地開槍
#-------------------------------------------------------------------------------
@anime["j2z"][0] = {"pic" => 351, "wait" => 2, "next" => 1, "ab_uncancel" => 6, "uncancel" => true, "z_pos" => 3, "y_fixed" => true}
@anime["j2z"][1] = {"pic" => 341, "wait" => 8, "next" => 2}
@anime["j2z"][2] = {"pic" => 342, "wait" => 3, "next" => 3, "se"=> ["gun_ready", 96, 100]}
@anime["j2z"][3] = {"pic" => 343, "wait" => 3, "next" => 4}
@anime["j2z"][4] = {"pic" => 344, "wait" => 9, "next" => 5}
@anime["j2z"][5] = {"pic" => 345, "wait" => 3, "next" => 6, "se"=> ["gun_fire1", 73, 80]}
@anime["j2z"][6] = {"pic" => 346, "wait" => 2, "next" => 7}
@anime["j2z"][7] = {"pic" => 347, "wait" => 2, "next" => 8}
@anime["j2z"][8] = {"pic" => 348, "wait" => 3, "next" => 9}
@anime["j2z"][9] = {"pic" => 349, "wait" => 100, "next" => ["jump_fall"], "var_reset" => true}


#-------------------------------------------------------------------------------
# ○ 對地開槍判定
#-------------------------------------------------------------------------------
@anime["j2z_gun"][0] = {"pic" => 999, "wait" => 4, "next" => 1, "z_pos" =>  3, "atk" => [Rect.new(0, -70, 295, 80)]}
@anime["j2z_gun"][1] = {"pic" => 999, "wait" => 2, "next" => ["dispose"], "atk" => 0}

#-------------------------------------------------------------------------------
# ○ 槍林彈雨 (空版)
#-------------------------------------------------------------------------------
# 拿雙槍
@anime["skill1"][0] = {"pic" => 362, "wait" => 3, "next" => 1, "ab_uncancel" => 51, "uncancel" => true, "anime" => [1,0,0], "superstop" => 20, "camera" => [48,30,30], "black" => [48,50], "fps" => [23, 55], "blur" => true, "z_pos" => 3, "y_fixed" => true}

@anime["skill1"][1] = {"pic" => 362, "wait" => 1, "next" => 2, "se"=> ["gun_ready", 96, 100], "y_fixed" => false}
@anime["skill1"][2] = {"pic" => 362, "wait" => 1, "next" => 3}
@anime["skill1"][3] = {"pic" => 363, "wait" => 1, "next" => 4}
# 一槍
@anime["skill1"][4] = {"pic" => 364, "wait" => 3, "next" => 5, "se"=> ["gun_fire1", 73, 80], "bullet" => [@me, "spark2", 0, 109, 11, false, false]}
@anime["skill1"][5] = {"pic" => 365, "wait" => 3, "next" => 6, "bullet" => [@me, "skill1_gun", 0, 50, 20, false, true]}
# 兩槍
@anime["skill1"][6] = {"pic" => 366, "wait" => 3, "next" => 7, "se"=> ["gun_fire1", 73, 80], "bullet" => [@me, "spark2", 0, 109, 11, false, false]}
@anime["skill1"][7] = {"pic" => 365, "wait" => 3, "next" => 8, "bullet" => [@me, "skill1_gun", 0, 50, 20, false, true]}
# 三槍
@anime["skill1"][8] = {"pic" => 364, "wait" => 3, "next" => 9, "se"=> ["gun_fire1", 73, 80], "bullet" => [@me, "spark2", 0, 109, 11, false, false]}
@anime["skill1"][9] = {"pic" => 365, "wait" => 3, "next" => 10, "bullet" => [@me, "skill1_gun", 0, 50, 20, false, true]}
# 四槍
@anime["skill1"][10] = {"pic" => 366, "wait" => 3, "next" => 11, "se"=> ["gun_fire1", 73, 80], "bullet" => [@me, "spark2", 0, 109, 11, false, false]}
@anime["skill1"][11] = {"pic" => 365, "wait" => 3, "next" => 12, "bullet" => [@me, "skill1_gun", 0,50, 20, false, true]}
# 五槍
@anime["skill1"][12] = {"pic" => 364, "wait" => 3, "next" => 13, "se"=> ["gun_fire1", 73, 80], "bullet" => [@me, "spark2", 0, 109, 11, false, false]}
@anime["skill1"][13] = {"pic" => 365, "wait" => 3, "next" => 14, "bullet" => [@me, "skill1_gun", 0, 50, 20, false, true]}
# 六槍
@anime["skill1"][14] = {"pic" => 366, "wait" => 3, "next" => 15, "se"=> ["gun_fire1", 73, 80], "bullet" => [@me, "spark2", 0, 109, 11, false, false]}
@anime["skill1"][15] = {"pic" => 365, "wait" => 3, "next" => 16, "bullet" => [@me, "skill1_gun", 0, 50, 20, false, true]}

# 大槍
@anime["skill1"][16] = {"pic" => 367, "wait" => 3, "next" => 17, "atk" => 0}
@anime["skill1"][17] = {"pic" => 368, "wait" => 3, "next" => 18}
@anime["skill1"][18] = {"pic" => 369, "wait" => 3, "next" => 19}
@anime["skill1"][19] = {"pic" => 351, "wait" => 2, "next" => 20, "ab_uncancel" => 6, "uncancel" => true, "z_pos" => 3}
@anime["skill1"][20] = {"pic" => 341, "wait" => 8, "next" => 21}
@anime["skill1"][21] = {"pic" => 342, "wait" => 3, "next" => 22, "se"=> ["gun_ready", 96, 100]}
@anime["skill1"][22] = {"pic" => 343, "wait" => 3, "next" => 23}
@anime["skill1"][23] = {"pic" => 344, "wait" => 9, "next" => 24}
@anime["skill1"][24] = {"pic" => 345, "wait" => 3, "next" => 25, "se"=> ["gun_fire1", 73, 80], "bullet" => [@me, "spark2", 0, 89, 11, false, false]}
@anime["skill1"][25] = {"pic" => 346, "wait" => 2, "next" => 26}
@anime["skill1"][26] = {"pic" => 347, "wait" => 2, "next" => 27}
@anime["skill1"][27] = {"pic" => 348, "wait" => 3, "next" => 28}
@anime["skill1"][28] = {"pic" => 349, "wait" => 100, "next" => ["jump_fall"], "var_reset" => true}


#-------------------------------------------------------------------------------
# ○ 槍林彈雨判定
#-------------------------------------------------------------------------------
@anime["skill1_gun"][0] = {"pic" => 999, "wait" => 22, "next" => 1, "z_pos" =>  3, "atk" => [Rect.new(-70, -80, 180, 90)]}
@anime["skill1_gun"][1] = {"pic" => 999, "wait" => 2, "next" => ["dispose"], "atk" => 0}
#-------------------------------------------------------------------------------
# ○ 槍林彈雨判定－最後一擊
#-------------------------------------------------------------------------------
@anime["skill1_gun2"][0] = {"pic" => 999, "wait" => 22, "next" => 1, "z_pos" =>  3, "atk" => [Rect.new(-70, -80, 180, 90)]}
@anime["skill1_gun2"][1] = {"pic" => 999, "wait" => 2, "next" => ["dispose"], "atk" => 0}


#-------------------------------------------------------------------------------
# ○ 槍林彈雨(失敗)
#-------------------------------------------------------------------------------
@anime["skill1_failed"][0] = {"pic" => 252, "wait" => 3, "next" => 1, "ab_uncancel" => 5}
@anime["skill1_failed"][1] = {"pic" => 253, "wait" => 3, "next" => ["stand"], "var_reset" => true}


#-------------------------------------------------------------------------------
# ○ 連環火砲
#-------------------------------------------------------------------------------

@anime["skill2"][0] = {"pic" => 245, "wait" => 3, "next" => 1, "ab_uncancel" => 999, "uncancel" => true, "anime" => [1,0,0], "superstop" => 20, "camera" => [48,30,30], "black" => [48,50], "fps" => [23, 55], "blur" => true, "z_pos" => 3, "eva" => 6}
@anime["skill2"][1] = {"pic" => 246, "wait" => 2, "next" => 2}
@anime["skill2"][2] = {"pic" => 247, "wait" => 2, "next" => 3, "se"=> ["swing2", 76, 90], "x_speed" => 9.8}
@anime["skill2"][3] = {"pic" => 249, "wait" => 3, "next" => 4, "atk" => [Rect.new(-10, -180, 76, 180), Rect.new(-10, -120, 116, 80)]}
@anime["skill2"][4] = {"pic" => 250, "wait" => 2, "next" => 5}
@anime["skill2"][5] = {"pic" => 261, "wait" => 3, "next" => 6, "se"=> ["swing3", 88, 110], "atk" => 0}
@anime["skill2"][6] = {"pic" => 262, "wait" => 3, "next" => 7}
@anime["skill2"][7] = {"pic" => 263, "wait" => 3, "next" => 8, "se"=> ["swing3", 88, 110]}
@anime["skill2"][8] = {"pic" => 264, "wait" => 3, "next" => 9}
@anime["skill2"][9] = {"pic" => 265, "wait" => 3, "next" => 10, "se"=> ["swing3", 88, 110]}
@anime["skill2"][10] = {"pic" => 266, "wait" => 3, "next" => 11}
@anime["skill2"][11] = {"pic" => 267, "wait" => 3, "next" => 12, "se"=> ["swing3", 88, 110]}
@anime["skill2"][12] = {"pic" => 268, "wait" => 3, "next" => 13}
@anime["skill2"][13] = {"pic" => 269, "wait" => 3, "next" => 14, "se"=> ["gun_ready", 96, 100]}
@anime["skill2"][14] = {"pic" => 270, "wait" => 15, "next" => 15}
@anime["skill2"][15] = {"pic" => 268, "wait" => 4, "next" => 16, "bullet" => [@me, "spark1", 0, 69, 43, false, false], "se"=> ["gun_fire1", 73, 80], "x_speed" => -2.2}
@anime["skill2"][16] = {"pic" => 270, "wait" => 16, "next" => 17, "bullet" => [@me, "skill2_gun", 0, 45, 0, false, false]}
@anime["skill2"][17] = {"pic" => 268, "wait" => 4, "next" => 18, "bullet" => [@me, "spark1", 0, 69, 43, false, false], "se"=> ["gun_fire1", 73, 80], "x_speed" => -2.2}
@anime["skill2"][18] = {"pic" => 270, "wait" => 16, "next" => 19, "bullet" => [@me, "skill2_gun", 0, 45, 0, false, false]}
@anime["skill2"][19] = {"pic" => 268, "wait" => 4, "next" => 20, "bullet" => [@me, "spark1", 0, 69, 43, false, false], "se"=> ["gun_fire1", 73, 80], "x_speed" => -2.2}
@anime["skill2"][20] = {"pic" => 270, "wait" => 16, "next" => 21, "bullet" => [@me, "skill2_gun", 0, 45, 0, false, false]}
@anime["skill2"][21] = {"pic" => 268, "wait" => 4, "next" => 22, "bullet" => [@me, "spark1", 0, 69, 43, false, false], "se"=> ["gun_fire1", 73, 80], "x_speed" => -2.2}
@anime["skill2"][22] = {"pic" => 270, "wait" => 22, "next" => 23, "bullet" => [@me, "skill2_gun", 0, 45, 0, false, false], "ab_uncancel" => 5}

@anime["skill2"][23] = {"pic" => 271, "wait" => 1, "next" => 24, "bullet" => [@me, "spark1", 0, 69, 43, false, false], "se"=> ["gun_fire1", 73, 80]}
@anime["skill2"][24] = {"pic" => 272, "wait" => 4, "next" => 25, "bullet" => [@me, "skill2_gun", 0, 45, 0, false, false], "x_speed" => -9.2}

@anime["skill2"][25] = {"pic" => 273, "wait" => 3, "next" => 26}
@anime["skill2"][26] = {"pic" => 274, "wait" => 3, "next" => 27}
@anime["skill2"][27] = {"pic" => 275, "wait" => 3, "next" => 28}
@anime["skill2"][28] = {"pic" => 276, "wait" => 3, "next" => 29}
@anime["skill2"][29] = {"pic" => 277, "wait" => 4, "next" => 30}
@anime["skill2"][30] = {"pic" => 278, "wait" => 2, "next" => 31}
@anime["skill2"][31] = {"pic" => 279, "wait" => 2, "next" => 32}
@anime["skill2"][32] = {"pic" => 280, "wait" => 2, "next" => 33}
@anime["skill2"][33] = {"pic" => 281, "wait" => 2, "next" => 34}
@anime["skill2"][34] = {"pic" => 282, "wait" => 3, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 子彈
#-------------------------------------------------------------------------------
@anime["skill2_gun"][0] = {"pic" => 999, "wait" => 12, "next" => 1, "z_pos" =>  3, "atk" => [Rect.new(20, -115, 110, 90)], "x_speed" => 24.5}
@anime["skill2_gun"][1] = {"pic" => 999, "wait" => 2, "next" => ["dispose"], "atk" => 0}

#-------------------------------------------------------------------------------
# ○ 槍林彈雨
#-------------------------------------------------------------------------------
@anime["skill3"][0] = {"pic" => 501, "wait" => 3, "next" => 1, "ab_uncancel" => 500, "uncancel" => true, "anime" => [1,0,0], "superstop" => 20, "camera" => [48,30,30], "black" => [48,50], "fps" => [23, 55], "blur" => true, "z_pos" => 3, "eva" => 10}
@anime["skill3"][1] = {"pic" => 502, "wait" => 3, "next" => 2}
@anime["skill3"][2] = {"pic" => 503, "wait" => 3, "next" => 3, "se"=> ["swing2", 76, 90]}
@anime["skill3"][3] = {"pic" => 504, "wait" => 3, "next" => 4, "x_speed" => 9.8}
@anime["skill3"][4] = {"pic" => 505, "wait" => 3, "next" => 5, "atk" => [Rect.new(-50, -90, 166, 60)]}
@anime["skill3"][5] = {"pic" => 506, "wait" => 3, "next" => 6, "hit_reset" => true, "atk" => [Rect.new(0, -220, 86, 210)]}
@anime["skill3"][6] = {"pic" => 507, "wait" => 3, "next" => 7, "atk" => 0}
@anime["skill3"][7] = {"pic" => 508, "wait" => 3, "next" => 8}
@anime["skill3"][8] = {"pic" => 509, "wait" => 3, "next" => 9}
@anime["skill3"][9] = {"pic" => 510, "wait" => 3, "next" => 10}
@anime["skill3"][10] = {"pic" => 511, "wait" => 3, "next" => 11}
@anime["skill3"][11] = {"pic" => 512, "wait" => 3, "next" => 12}
@anime["skill3"][12] = {"pic" => 513, "wait" => 3, "next" => 13}
@anime["skill3"][13] = {"pic" => 514, "wait" => 3, "next" => 14}
@anime["skill3"][14] = {"pic" => 515, "wait" => 3, "next" => 15, "se"=> ["gun_ready", 96, 90]}
@anime["skill3"][15] = {"pic" => 516, "wait" => 3, "next" => 16}
@anime["skill3"][16] = {"pic" => 517, "wait" => 3, "next" => 17}
@anime["skill3"][17] = {"pic" => 518, "wait" => 3, "next" => 18}
@anime["skill3"][18] = {"pic" => 519, "wait" => 3, "next" => 19}
@anime["skill3"][19] = {"pic" => 520, "wait" => 3, "next" => 20, "bullet" => [@me, "skill3_ball", 0, 83, 140, false, true], "se"=> ["gun_fire1", 92, 60]}  # 1
@anime["skill3"][20] = {"pic" => 521, "wait" => 3, "next" => 21}
@anime["skill3"][21] = {"pic" => 522, "wait" => 3, "next" => 22, "bullet" => [@me, "skill3_ball", 0, 83, 140, false, true], "se"=> ["gun_fire1", 92, 60]} # 2 
@anime["skill3"][22] = {"pic" => 523, "wait" => 3, "next" => 23}
@anime["skill3"][23] = {"pic" => 524, "wait" => 3, "next" => 24, "bullet" => [@me, "skill3_ball", 0, 83, 140, false, true], "se"=> ["gun_fire1", 92, 60]} # 3
@anime["skill3"][24] = {"pic" => 525, "wait" => 3, "next" => 25}
@anime["skill3"][25] = {"pic" => 524, "wait" => 3, "next" => 26, "bullet" => [@me, "skill3_ball", 0, 83, 140, false, true], "se"=> ["gun_fire1", 92, 60]} # 4
@anime["skill3"][26] = {"pic" => 525, "wait" => 3, "next" => 27}
@anime["skill3"][27] = {"pic" => 524, "wait" => 3, "next" => 28, "bullet" => [@me, "skill3_ball", 0, 83, 140, false, true], "se"=> ["gun_fire1", 92, 60]} # 5
@anime["skill3"][28] = {"pic" => 525, "wait" => 3, "next" => 29}
@anime["skill3"][29] = {"pic" => 524, "wait" => 3, "next" => 30, "bullet" => [@me, "skill3_ball", 0, 83, 140, false, true], "se"=> ["gun_fire1", 92, 60]} # 6
@anime["skill3"][30] = {"pic" => 525, "wait" => 3, "next" => 31} 
@anime["skill3"][31] = {"pic" => 524, "wait" => 3, "next" => 32, "bullet" => [@me, "skill3_ball", 0, 83, 140, false, true], "se"=> ["gun_fire1", 92, 60]} # 7
@anime["skill3"][32] = {"pic" => 525, "wait" => 3, "next" => 33} 
@anime["skill3"][33] = {"pic" => 524, "wait" => 3, "next" => 34, "bullet" => [@me, "skill3_ball", 0, 83, 140, false, true], "se"=> ["gun_fire1", 92, 60]} # 8
@anime["skill3"][34] = {"pic" => 525, "wait" => 3, "next" => 35} 
@anime["skill3"][35] = {"pic" => 526, "wait" => 3, "next" => 36, "bullet" => [@me, "skill3_ball", 0, 83, 140, false, true], "se"=> ["gun_fire1", 92, 60]} # 9
@anime["skill3"][36] = {"pic" => 527, "wait" => 3, "next" => 37, "se"=> ["fire02", 80, 90]}
@anime["skill3"][37] = {"pic" => 528, "wait" => 3, "next" => 38}
@anime["skill3"][38] = {"pic" => 519, "wait" => 62, "next" => 39}
@anime["skill3"][39] = {"pic" => 529, "wait" => 4, "next" => 40}
@anime["skill3"][40] = {"pic" => 530, "wait" => 4, "next" => 41}
@anime["skill3"][41] = {"pic" => 531, "wait" => 4, "next" => 42}
@anime["skill3"][42] = {"pic" => 532, "wait" => 5, "next" => 43}
@anime["skill3"][43] = {"pic" => 533, "wait" => 5, "next" => ["stand"], "var_reset" => true, "ab_uncancel" => 0}


#-------------------------------------------------------------------------------
# ○ 技能3判定
#-------------------------------------------------------------------------------
@anime["skill3_ball"][0] = {"pic" => 544, "wait" => 40, "next" => 1, "z_pos" =>  3, "atk" => [Rect.new(-20, -40, 40, 40)], "x_speed" => 10.8, "y_speed" => 21.5}

# 落下
@anime["skill3_ball"][1] = {"pic" => 541, "wait" => 3, "next" => 2}
@anime["skill3_ball"][2]= {"pic" => 542, "wait" => 3, "next" => 3}
@anime["skill3_ball"][3] = {"pic" => 543, "wait" => 3, "next" => 4}
@anime["skill3_ball"][4] = {"pic" => 544, "wait" => 3, "next" => 1}

# 爆炸
@anime["skill3_ball"][5] = {"pic" => 546, "wait" => 4, "next" => 6, "atk" => [Rect.new(-100, -180, 160, 180)], "se"=> ["shoot3", 90, 80], "x_speed" => 0, "y_speed" => 0}
@anime["skill3_ball"][6] = {"pic" => 547, "wait" => 4, "next" => 7}
@anime["skill3_ball"][7] = {"pic" => 548, "wait" => 4, "next" => 8}
@anime["skill3_ball"][8] = {"pic" => 549, "wait" => 4, "next" => 9, "atk" => 0}
@anime["skill3_ball"][9] = {"pic" => 550, "wait" => 4, "next" => 10}
@anime["skill3_ball"][10] = {"pic" => 551, "wait" => 4, "next" => ["dispose"]}


#-------------------------------------------------------------------------------
# ○ 掛掉
#-------------------------------------------------------------------------------
@anime["dead"][0] = {"pic" => 131, "wait" => 2, "next" => 1, "ab_uncancel" => 8, "uncancel" => true}
@anime["dead"][1] = {"pic" => 132, "wait" => 2, "next" => 2, "x_speed" => -11.3}
@anime["dead"][2] = {"pic" => 133, "wait" => 2, "next" => 3}
@anime["dead"][3] = {"pic" => 134, "wait" => 2, "next" => 4}
@anime["dead"][4] = {"pic" => 172, "wait" => 120, "next" => 5}
@anime["dead"][5] = {"pic" => 172, "wait" => 20, "next" => "go_dead_transform", "anime" => [1,0,0], "superstop" => 21, "supermove" => 21, "black" => [40,50]}
#-------------------------------------------------------------------------------
# ○ 劇情用倒地
#-------------------------------------------------------------------------------
@anime["story_down"][0] = {"pic" => 155, "wait" => -1, "next" => 0}



#-------------------------------------------------------------------------------
# ○ 劇情用跑步
#-------------------------------------------------------------------------------

@anime["story_dash"][0] = {"pic" => 91, "wait" => 3, "next" => 2, "anime" => [11,0,0], "z_pos" =>  1, "penetrate" => true}
#@anime["dash"][1] = {"pic" => 92, "wait" => 2, "next" => 2}
@anime["story_dash"][2] = {"pic" => 93, "wait" => 3, "next" => 4}
#@anime["dash"][3] = {"pic" => 94, "wait" => 2, "next" => 4}
@anime["story_dash"][4] = {"pic" => 95, "wait" => 3, "next" => 6}
#@anime["dash"][5] = {"pic" => 96, "wait" => 2, "next" => 6}
@anime["story_dash"][6] = {"pic" => 97, "wait" => 3, "next" => 8}
#@anime["dash"][7] = {"pic" => 98, "wait" => 2, "next" => 8}
@anime["story_dash"][8] = {"pic" => 99, "wait" => 3, "next" => 10}
#@anime["dash"][9] = {"pic" => 100, "wait" => 2, "next" => 10}
@anime["story_dash"][10] = {"pic" => 101, "wait" => 3, "next" => 12}
#@anime["dash"][11] = {"pic" => 102, "wait" => 2, "next" => 12}
@anime["story_dash"][12] = {"pic" => 103, "wait" => 3, "next" => 14}
#@anime["dash"][13] = {"pic" => 104, "wait" => 2, "next" => 14}
@anime["story_dash"][14] = {"pic" => 105, "wait" => 3, "next" => 16}
#@anime["dash"][15] = {"pic" => 106, "wait" => 2, "next" => 16}
@anime["story_dash"][16] = {"pic" => 107, "wait" => 3, "next" => 18}
#@anime["dash"][17] = {"pic" => 108, "wait" => 2, "next" => 18}
@anime["story_dash"][18] = {"pic" => 109, "wait" => 3, "next" => 0}

end




#==============================================================================
# ■ 主模組補強
#==============================================================================
  #--------------------------------------------------------------------------
  # ◇ 執行其他預約指令
  #      處理5ZZ、5XX這種角色間不一定有的指令
  #--------------------------------------------------------------------------
  def do_other_plancommand
    case @command_plan
    # 槍托攻擊
    when "2z", "2zz"  
      dz_action
    else
      
      if @command_plan.include?("z")
        z_action
      elsif @command_plan.include?("x")
        x_action
      elsif @command_plan.include?("s") 
        s_action
      end    
    end

  end
  
  #--------------------------------------------------------------------------
  # ◇ 進入第三階段(魔鏡專用)
  #--------------------------------------------------------------------------
  def go_dead_transform
  #  @me.battle_sprite.battler_shadow.visible = false
 #   @me.dead_disappear = true
    @frame_duration = -1
    @me.combohit_clear
    @me.transform(13)
    @me.hp = @me.maxhp
    @me.sp = @me.maxsp
    var_reset
    #@me.animation.push([19, true,0,0])
    @eva_invincible_duration = 0
    @me.immortal = false
    @me.motion.change_anime("awake_boss") 
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
     $game_party.remove_actor(2)   
     $scene.actor_awake(x, y, xs, ys, dir, id, @me.awake_time)
  end
  #--------------------------------------------------------------------------
  # ◇ 著地
  #--------------------------------------------------------------------------
  def do_landing_step
    if @me.hp == 0
    elsif ["damage1", "damage2", "guard", "guard_shock"].include?(@state)
      @me.z_pos = 0
    elsif @state == "j2z_gun"
      return
    elsif @state == "skill1_gun" or @state == "skill1_gun2"
      change_anime(@state, 1)
      return
    elsif @state == "skill3_ball"
      change_anime("skill3_ball", 5)
      @me.now_x_speed = 0
      @me.now_y_speed = 0
      @me.z_pos = 3
       $game_screen.start_shake(2,4,8,1)
      @y_fixed = true 
      return
    elsif @state == "6z"
      @now_jumps = 0
      @me.now_y_speed = 0
      @me.now_x_speed = 5.2
      return
    elsif @state == "f_flee"
      change_anime("f_flee", 4)
      @me.z_pos = 0
    elsif @state == "b_flee" and @frame_number == 4
      change_anime("b_flee", 5)
      @me.z_pos = 0
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
    if !@me.is_a?(Game_BattleBullet)
      @me.ai.ai_trigger["jz_loop"] = 0
    end
  end
  #--------------------------------------------------------------------------
  # ◇ 攻擊中
  #--------------------------------------------------------------------------
  def attacking?
    return (z_skill? or x_skill?)
  end  
  #--------------------------------------------------------------------------
  # ◇ 輕攻擊
  #--------------------------------------------------------------------------
  def z_skill?
    return ["5z","5zz" ,"6z","2z", "2zz","jz","j2z", "j6z"].include?(@state)
  end  
  #--------------------------------------------------------------------------
  # ◇ 必殺
  #--------------------------------------------------------------------------
  def x_skill?
    return ["skill1", "5x","6x", "skill3", "skill2"].include?(@state)
  end  
#==============================================================================
# ■ 指令設置
#==============================================================================


  #-------------------------------------------------------------------------------
  # ○ 按住↑
  #      dir：左右方向
  #-------------------------------------------------------------------------------
  def hold_up(dir)
    @flag_2zz = false
    return if static?
    if ["stand", "stand_idle", "walk", "dash", "f_chase"].include?(@state) or 
      (z_skill? and !cannot_cancel_act? and @now_jumps < @me.max_jumps)
      if dir == 0
        change_anime("jump")
      else
        @me.direction = dir
        ["dash", "f_chase"].include?(@state) ? change_anime("hf_jump") : change_anime("f_jump")
      end
      @now_jumps += 1
    end
    if @knock_back_duration <= 0 and blowning?
      do_ukemi
    end
  end

  #-------------------------------------------------------------------------------
  # ○ 上
  #-------------------------------------------------------------------------------
  def up_action(dir)
    
  #  if ["jump_fall", "f_jump_fall", "b_jump_fall", "hf_jump_fall", "hb_jump_fall", "h_jump_fall"].include?(@state) and @now_jumps  < 2
    #  @me.direction = dir if dir != 0
   #    change_anime("double_jump")
   #   @now_jumps  += 1
  #  end
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
=begin
     if attacking?
       @me.ai.set_ai_trigger("8xx_lock", true) if do_act("u_chase", "88","chase") and rand(10) > 2
     end
=end
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
      if @state == "5z"
        do_act("5zz", "z","Z")
      else
        do_act("5z", "z","Z") if @state != "5zz"
      end
    end
  end
  #-------------------------------------------------------------------------------
  # ○ →Z
  #-------------------------------------------------------------------------------
  def fz_action
    if on_air?
      do_act("j6z", "6z","Z")
    else
      do_act("6z", "6z","Z", false, (@state == "5zz"))
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↓Z
  #-------------------------------------------------------------------------------
  def dz_action
    if on_air?
      do_act("j2z", "2z","Z")
    else
      if @state == "2z"
        if @frame_number == 7
          do_act("2zz", "2z","Z")
        elsif @frame_number < 7
          @flag_2zz = true
        else
          @flag_2zz = false
        end
      else
        do_act("2z", "2z","Z", false, (@state == "5zz"))
      end
    end
  end
  
  #-------------------------------------------------------------------------------
  # ○ ↑Z
  #-------------------------------------------------------------------------------
  def uz_action
    return if !on_air?
    z_action
  end
  #-------------------------------------------------------------------------------
  # ○ ←Z
  #-------------------------------------------------------------------------------
  def bz_action
    if on_air?
      do_act("j6z", "4z","Z")
    else
      unless ["stand", "walk", "run"].include?(@state) 
         do_act("6z", "4z","Z", false, (@state == "5zz"))
      end
    end
  end

  #-------------------------------------------------------------------------------
  # ○ X
  #-------------------------------------------------------------------------------
  def x_action
   # return
    if on_air?
     dx_action
    else
      do_act("skill2", "x","X", false, false, 60)
    end
  end
  #-------------------------------------------------------------------------------
  # ○ →X
  #-------------------------------------------------------------------------------
  def fx_action
    if on_air?
      dx_action
    else
      do_act("skill3", "6x","X", false, false, 60)
     #do_act("skill1", "x","X", false, false, 60)
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↓X
  #-------------------------------------------------------------------------------
  def dx_action
    if on_air?
      do_act("skill1", "2x","X", false, false, 60)
    else
      do_act("skill3", "2x","X", false, false, 60)
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↑X
  #-------------------------------------------------------------------------------
  def ux_action
    return if !on_air?
    dx_action
  end
  #-------------------------------------------------------------------------------
  # ○ ←X
  #-------------------------------------------------------------------------------
  def bx_action
  #  return
    if on_air?
      dx_action
    else
      unless ["stand", "walk", "run"].include?(@state) 
        do_act("skill3", "4x","X", false, false, 60)
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
      if ["stand", "stand_idle", "walk", "dash", "dash_break", "guard", "landing"].include?(@state) #or 
     #   (@state == "f_flee" and (4..5) === @frame_number)
        change_anime("f_flee")
      end
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↑C
  #-------------------------------------------------------------------------------
  def uc_action
  #  do_high_jump if ["guard", "landing"].include?(@state)
    
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
      if ["stand", "stand_idle", "walk", "dash", "dash_break", "guard", "landing"].include?(@state) #or
     #   (@state == "f_flee" and (4..5) === @frame_number) or (@state == "b_flee" and @frame_number == 5 and @frame_time > 6) 
         change_anime("b_flee")
      end  
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
  # ○ 黑影獸化前處理
  #-------------------------------------------------------------------------------
  def dead
    if (21..128) === @anime_time 
      if @anime_time < 50
      @me.animation.push([27, true, 0, 0]) if (@anime_time % 25 == 0)
      else
        @me.animation.push([27, true, 0, 0]) if (@anime_time % 18 == 0) 
        @me.animation.push([27, true, 0, 0]) if (@anime_time % 12 == 0) and @anime_time > 80
      end
    end
  end
  
  #-------------------------------------------------------------------------------
  # ○ 跳上砍
  #-------------------------------------------------------------------------------
  def jz
    @me.now_y_speed += 2.3 if @anime_time == 1
  end
  #-------------------------------------------------------------------------------
  # ○ 跳前砍
  #-------------------------------------------------------------------------------
  def j6z
    @me.now_y_speed += 1.3 if @anime_time == 1
  end
  #-------------------------------------------------------------------------------
  # ○ 對地開槍
  #-------------------------------------------------------------------------------
  def j2z
    case @anime_time
    when 3
      @y_fixed = false
      @me.now_y_speed = 22.6
      @me.now_x_speed = -5.6 * @me.direction
    when 6..27
      @me.now_y_speed = -0.6
    when 28
      @me.now_y_speed = 8.6
      @me.now_x_speed = -8.6 * @me.direction
      $scene.create_battle_bullets([@me, "j2z_gun", 0, 0, 9999, false, true])
    end
  end
  

  #-------------------------------------------------------------------------------
  # ○ 對地開槍判定
  #-------------------------------------------------------------------------------
  def j2z_gun
    if @anime_time == 1
      @me.y_pos = @me.root.y_min + 1 
      @y_fixed = true
    end
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ 槍林彈雨 (空)
  #-------------------------------------------------------------------------------
  def skill1
#    $scene.test_windows[2].refresh(@anime_time)
   
    $game_temp.black_time = [12, 50]
    $scene.camera_feature =  [12,30,30]
   
      
    if (2..3) === @anime_time  
      $game_temp.superstop_time = 2
      @supermove_time = 2
    end
    
    case @anime_time
    when 2..49
      @me.now_y_speed = 1.8
      @me.now_x_speed = -1.6 * @me.direction
    when 50
      @me.now_y_speed = 12.6
      @me.now_x_speed = -4.6 * @me.direction
    when 78
      @me.now_y_speed = 15.6
      @me.now_x_speed = -7.6 * @me.direction
      $scene.create_battle_bullets([@me, "skill1_gun2", 0, 50, 20, false, true])
    
      
  #  case @anime_time
 #   when 91, 97, 103, 109, 115, 121
   #   $scene.create_battle_bullets([@me, "spark2", 0, 109, 11, false, false])
  #  end
      
      
    #when 140
     # @skill1_target = nil
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 槍林彈雨 判定1
  #-------------------------------------------------------------------------------
  def skill1_gun
    @me.now_x_speed = 13.8 * @me.direction
    @me.now_y_speed = -25.8
    
    if @me.y_pos <= @me.root.y_min and @frame_number == 0
      change_anime("skill1_gun", 1)
      @me.now_y_speed = 0
    end
   # @me.x_pos = @me.root.motion.skill1_target.x_pos + (-1 * @me.direction)
  #  @me.y_pos = @me.root.motion.skill1_target.y_pos + 1
  end
  #-------------------------------------------------------------------------------
  # ○ 槍林彈雨 判定2
  #-------------------------------------------------------------------------------
  def skill1_gun2
    @me.now_x_speed = 13.8 * @me.direction
    @me.now_y_speed = -25.8
    
    if @me.y_pos <= @me.root.y_min and @frame_number == 0
      change_anime("skill1_gun2", 1)
      @me.now_y_speed = 0
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 大絕2
  #-------------------------------------------------------------------------------
  def skill2
    $game_temp.black_time = [12, 50]
    $scene.camera_feature =  [12,30,30]
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ 蹲砍特效
  #-------------------------------------------------------------------------------
  def dz_effect1
    @me.battle_sprite.opacity = (@frame_duration * (255/@anime[@state][0]["wait"]))
  end
  
  #-------------------------------------------------------------------------------
  # ○ 跳砍特效1
  #-------------------------------------------------------------------------------
  def jz_effect1
    @me.battle_sprite.opacity = (@frame_duration * (255/@anime[@state][0]["wait"]))
    @me.x_pos = @me.root.x_pos + 30 * @me.direction
    @me.y_pos = @me.root.y_pos + 40
  end
  #-------------------------------------------------------------------------------
  # ○ 跳砍特效2
  #-------------------------------------------------------------------------------
  def jz_effect2
    @me.battle_sprite.opacity = (@frame_duration * (255/@anime[@state][0]["wait"]))
    @me.x_pos = @me.root.x_pos + 30 * @me.direction
    @me.y_pos = @me.root.y_pos + 60
  end
  #-------------------------------------------------------------------------------
  # ○ 跳砍特效3
  #-------------------------------------------------------------------------------
  def jz_effect3
    @me.battle_sprite.opacity = (@frame_duration * (255/@anime[@state][0]["wait"]))
    @me.x_pos = @me.root.x_pos + 30 * @me.direction
    @me.y_pos = @me.root.y_pos + 20
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
  # ○ 超3
  #-------------------------------------------------------------------------------
  def skill3
    $game_temp.black_time = [30, 50]
    $scene.camera_feature =  [30,30,30]
  end
  
  #-------------------------------------------------------------------------------
  # ○ 超3砲彈
  #-------------------------------------------------------------------------------
  def skill3_ball
    
    # 記憶落下位置
    if @anime_time == 1
      @land_y = @me.root.y_min
    end
    
    
    if @anime_time == 40
      @me.x_pos += ((rand(9) - 10) * 65) * @me.direction
      @me.y_pos = 800
      @me.now_x_speed = 12.3 * @me.direction
      @me.now_y_speed = -11.3
      @attack_hit_targets.clear
    end
    
    
    if @me.y_pos <= @land_y and @frame_number < 5
      @me.y_pos = @land_y
      do_landing_step
    end
    
    
     if @anime_time > 40
       @me.now_y_speed += -2.3
     end
     
    
  end
  #-------------------------------------------------------------------------------
  # ○ 常時監視A (不受暫停、受傷定格效果影響)
  #      通常用在調整受傷、倒地這種不確定何時恢復姿勢的情況
  #-------------------------------------------------------------------------------
  def respective_updateA
    
    
    # 變黑
    @me.battle_sprite.tone = @black_tone.clone if @me.is_a?(Game_Enemy) and @me.battle_sprite.tone != @black_tone and !$game_switches[STILILA::ENDING]
    if $game_switches[STILILA::ENDING] and @me.battle_sprite.tone != @original_tone
      @me.battle_sprite.tone.set(0,0,0) 
    end
    
   # 陣亡 (敵方限定)
    if @me.hp == 0 and @state != "dead" and @me.is_a?(Game_Enemy) #and !downing?
      $game_system.se_play($data_system.enemy_collapse_se) 
      @eva_invincible_duration = 999
      change_anime("dead")
      @hit_stop_duration = 20
    end
    
    # 金手指
#    if @me.is_a?(Game_Actor) and $gold_finger
    #  @me.hp = @me.maxhp
    #  @me.sp = @me.maxsp
    #  @me.awake_time = 1200
   # end
    
    
  end
  #-------------------------------------------------------------------------------
  # ○ 常時監視B (受暫停、受傷定格效果影響)
  #-------------------------------------------------------------------------------
  def respective_updateB
    if ["damage1", "damage2"].include?(@state) and @knock_back_duration <= 0 and !@catched
      if @frame_number == 3
        var_reset
        on_air? ? change_anime("jump_fall") : change_anime("stand")
      else
        change_anime("damage1", 3)
      end   
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
    
    # 隨機出現閒置動作
    if @state == "stand" and @frame_number == 18 and @frame_duration == 1 and rand(3) == 1 and !$game_switches[STILILA::NO_IDLE]
     change_anime("stand_idle")
    end
    
    if @state == "2z" and @flag_2zz and @anime_time == 19
      do_act("2zz", "2z","Z")
      @flag_2zz = false
    end
    
    # 自己是氣功波
    if @state == "ball"
      # 使用者被打時爆破
      if @me.root.motion.blowning? or ["damage1", "damage2"].include?(@me.root.motion.state)
        change_anime("ball_b")
        @frame_loop = [0,0] 
      end
    end
    
    if @state == "ball2"
      # 使用者被打時爆破
      if @me.root.motion.blowning? or ["damage1", "damage2"].include?(@me.root.motion.state)
        change_anime("ball2_b")
        @frame_loop = [0,0] 
      end
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
    when "jz"
      @me.ai.ai_trigger["jz_loop"] += 1
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
      if @me.is_a?(Game_BattleBullet) and ["skill3_ball", "skill2_gun", "skill1_gun2", "skill1_gun"].include?(@state)
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
   
    case action
    when "gun1" # 槍1
       change_anime("gun1",1)
       @frame_loop = [0,0] 
    when "skill3" 
      if  !target.guarding? #and @frame_number == 4
        target.y_pos = @me.y_pos
        target.x_pos = @me.x_pos + 70 * @me.direction 
      end
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
      # 槍1
      if skill == "gun1"
        result["power"] = 30
        result["limit"] = 14
        result["blow_type"] = "None" # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 5
        result["t_hitstop"] = 5 
        result["correction"] = 3
        result["t_knockback"] = 16
        result["x_speed"] = 4    
        result["d_se"] = result["ko_se"] = ["Audio/SE/gun24", 80, 120]     
      # ======== 踢腿  
      elsif skill == "5z"
        result["power"] = 50
        result["limit"] = 15  
        result["scope"].delete("Blow") # 擊飛狀態打不到
        result["blow_type"] = "None" # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 5
        result["t_hitstop"] = 15                  
        result["t_knockback"] = 30
        result["x_speed"] = 11.9   
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se", 72, 105]                      
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 12
      # ========= 跳躍槍托打  
      elsif skill == "6z"
        result["power"] = 70
        result["limit"] = 35
        result["u_hitstop"] = 6
        result["t_hitstop"] = 9                   
        result["t_knockback"] = 26
        result["x_speed"] = 6.9   
        if target.motion.damaging?
          result["y_speed"] = 8.5 
        else
          result["t_knockback"] += 5
          result["t_hitstop"] += 5  
          result["blow_type"] = "None" # 擊中變受傷狀態，不擊飛
        end
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]                      
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 11
      # ======== 槍托打  
      elsif skill == "2z"
        result["power"] = 60
        result["limit"] = 15  
       # result["blow_type"] = "None" # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 8
        result["t_hitstop"] = 12                   
        result["t_knockback"] = 37
        result["x_speed"] = 3.9   
        result["y_speed"] = 15.9   
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]                      
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 9
      # ======== 槍托打2(槍擊)
      elsif skill == "2z_gun"
        result["power"] = 70
        result["limit"] = 35
        result["u_hitstop"] = 5
        result["t_hitstop"] = 5 
        result["correction"] = 3
        result["t_knockback"] = 26
        result["x_speed"] = 9.2
        result["y_speed"] = 7
        result["d_se"] = result["ko_se"] = ["Audio/SE/gun24", 80, 90]     
      # ======== 跳躍刀砍
      elsif skill == "jz"
        result["power"] = 15
        result["limit"] = 5
        result["u_hitstop"] = 3
        result["t_hitstop"] = 5              
        result["t_knockback"] = 22  
        if target.motion.on_air?    
          result["x_speed"] = 3.2  
          result["y_speed"] = 6.4 
        else
          result["blow_type"] = "None" # 擊中變受傷狀態，不擊飛
          result["x_speed"] = 5.2  
          result["y_speed"] = 0
        end
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 80, 145]    
        result["sp_recover"] = 0
        result["spark"] = [1, 5*rand(10), 9*(rand(6)+1)+30]
      # ======== 跳躍刀前砍  
      elsif skill == "j6z"
        result["power"] = 50
        result["limit"] = 20
        result["u_hitstop"] = 11
        result["t_hitstop"] = 13             
        result["t_knockback"] = 34
        result["x_speed"] = 5.9 
        if target.motion.on_air? 
          result["y_speed"] = -16.6 
        else
         result["y_speed"] = 7
        end
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se4", 80, 125]    
        result["sp_recover"] = 1
        result["spark"] = [1, 5*rand(10), 9*(rand(6)+1)+30]
        result["h_shake"] = [2,4,10,1]
        result["d_shake"] = [2,4,10,1]
      elsif skill == "j2z_gun"
        result["power"] = 60
        result["scope"].push("Down") # 倒地狀態可追打
        result["limit"] = 15
        result["u_hitstop"] = 0
        result["t_hitstop"] = 5                 
        result["t_knockback"] = 22  
        result["x_speed"] = 6 
        result["y_speed"] = 11          
        result["d_se"] = result["ko_se"] = ["Audio/SE/gun24", 80, 90]  
        result["sp_recover"] = 2
        result["h_shake"] = [1,3,8,1]
        result["d_shake"] = [2,4,8,1]
        result["full_count"] = 2
=begin        
      # ======== 槍林彈雨起手  
      elsif skill == "skill1" and @frame_number < 11
        result["power"] = 60
        result["limit"] = 15  
        result["u_hitstop"] = 15
        result["t_hitstop"] = 20                  
        result["t_knockback"] = 55
        result["x_speed"] = 1.9   
        result["y_speed"] = 19.9   
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]                      
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 0
        result["h_shake"] = [2,5,12,1]
        result["d_shake"] = [2,5,12,1]
      # ======== 槍林彈雨空中砍  
      elsif skill == "skill1" and (11..22) === @frame_number
        result["power"] = 20
        result["limit"] = 10
        result["u_hitstop"] = 3
        result["t_hitstop"] = 7              
        result["t_knockback"] = 55  
        result["x_speed"] = 0  
        result["y_speed"] = 6.4 
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 80, 145]    
        result["sp_recover"] = 0
       # 槍林彈雨空中砍倒 
      elsif skill == "skill1" and (22..26) === @frame_number
        result["power"] = 45
        result["limit"] = 15
        result["u_hitstop"] = 7
        result["t_hitstop"] = 10              
        result["t_knockback"] = 22
        result["x_speed"] = 6.9 
        if target.motion.on_air? 
          result["y_speed"] = -7.6 
        else
         result["y_speed"] = 5
        end
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 80, 145]    
        result["sp_recover"] = 1   
      # ======== 槍林彈雨－彈  
      elsif skill == "skill1" and @frame_number > 28
        result["power"] = 150
        result["scope"].push("Down") # 倒地狀態可追打
        result["limit"] = 120
        result["u_hitstop"] = 0
        result["t_hitstop"] = 36                
        result["t_knockback"] = 42 
        result["x_speed"] = 3 
        result["y_speed"] = 12      
        result["d_se"] = result["ko_se"] = ["Audio/SE/gun24", 80, 90]  
        result["sp_recover"] = 2
        result["h_shake"] = [2,5,12,1]
        result["d_shake"] = [2,5,12,1]
        result["full_count"] = 2
=end
      # ======== 槍林彈雨－彈  
      elsif skill == "skill1_gun"
        result["power"] = 65
        result["scope"].push("Down") # 倒地狀態可追打
        result["limit"] = 25
        result["u_hitstop"] = 0
        result["t_hitstop"] = 40                
        result["t_knockback"] = 42 
        result["x_speed"] = 6 
        result["y_speed"] = 12      
        result["d_se"] = result["ko_se"] = ["Audio/SE/gun24", 80, 90]  
        result["sp_recover"] = 2
        result["h_shake"] = [2,5,12,1]
        result["d_shake"] = [2,5,12,1]
        result["full_count"] = 2
      # ======== 槍林彈雨－彈  
      elsif skill == "skill1_gun2"
        result["power"] = 180
        result["scope"].push("Down") # 倒地狀態可追打
        result["limit"] = 120
        result["u_hitstop"] = 0
        result["t_hitstop"] = 36                
        result["t_knockback"] = 37 
        result["x_speed"] = 6 
        result["y_speed"] = 12      
        result["d_se"] = result["ko_se"] = ["Audio/SE/gun24", 80, 90]  
        result["sp_recover"] = 2
        result["h_shake"] = [2,5,12,1]
        result["d_shake"] = [2,5,12,1]
        result["full_count"] = 2
      # ======== 連環火砲起手  
      elsif skill == "skill2"
        result["power"] = 60
        result["limit"] = 35  
        result["blow_type"] = "None" # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 10
        result["t_hitstop"] = 15                  
        result["t_knockback"] = 85
        result["x_speed"] = 10.9   
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]                      
        result["sp_recover"] = 2
        result["full_count"] = 2
        result["hit_slide"] = 0
        result["h_shake"] = [2,5,12,1]
        result["d_shake"] = [2,5,12,1]
        result["hit_slide"] = 9
      # ======== 連環火砲－彈  
      elsif skill == "skill2_gun"
        result["power"] = 130
     #   result["scope"].push("Down") # 倒地狀態可追打
        result["limit"] = 60
        result["u_hitstop"] = 0
        result["t_hitstop"] = 26
        result["t_knockback"] = 42 
        result["x_speed"] = 16.6
        result["y_speed"] = 9      
        result["d_se"] = result["ko_se"] = ["Audio/SE/gun24", 80, 90]  
        result["sp_recover"] = 2
        result["h_shake"] = [3,6,16,0]
        result["d_shake"] = [3,6,16,0]
        result["full_count"] = 2
        
      # ===== 超3－本體判定
      elsif skill == "skill3" and @frame_number == 4
        result["power"] = 60
        result["limit"] = 40  
        result["blow_type"] = "None" # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 18
        result["t_hitstop"] = 23                 
        result["t_knockback"] = 90
        result["x_speed"] = 4.2  
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 80, 145]                       
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 7
        result["h_shake"] = [2,5,12,0]
        result["d_shake"] = [2,5,12,0]
      # ===== 超3－本體判定2  
      elsif skill == "skill3"
        result["power"] = 60
        result["limit"] = 40  
        result["u_hitstop"] = 5
        result["t_hitstop"] = 9                 
        result["t_knockback"] = 90
        result["x_speed"] = 2.8  
        result["y_speed"] = 23.3   
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se4", 80, 110]                    
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 9
        result["h_shake"] = [2,5,12,1]
        result["d_shake"] = [2,5,12,1]
     # ===== 超3－砲彈判定1   
      elsif skill == "skill3_ball" and @frame_number == 0
        result["power"] = 20
        result["limit"] = 10  
        result["u_hitstop"] = 5
        result["t_hitstop"] = 7                
        result["t_knockback"] = 45
        result["x_speed"] = 5.2
        result["y_speed"] = 8.9   
        result["d_se"] = result["ko_se"] = ["Audio/SE/gun24", 80, 70]                    
        result["sp_recover"] = 0
        result["full_count"] = 2
        result["hit_slide"] = 0
        result["h_shake"] = [2,5,12,1]
        result["d_shake"] = [2,5,12,1]
     # ===== 超3－砲彈判定2
      elsif skill == "skill3_ball" and @frame_number < 5
        result["power"] = 40
        result["limit"] = 30  
        result["u_hitstop"] = 5
        result["t_hitstop"] = 5                
        result["t_knockback"] = 45
        result["x_speed"] = 5.2
        result["y_speed"] = -8.9   
        result["d_se"] = result["ko_se"] = ["Audio/SE/gun24", 80, 70]                    
        result["sp_recover"] = 0
        result["full_count"] = 2
        result["hit_slide"] = 0
       # ===== 超3－爆炸判定   
      elsif skill == "skill3_ball" and @frame_number > 4
        result["power"] = 100
        result["limit"] = 50  
        result["u_hitstop"] = 0
        result["t_hitstop"] = 10                
        result["t_knockback"] = 35
        result["x_speed"] = 5.2
        result["y_speed"] = 13.9   
        result["d_se"] = result["ko_se"] = ["Audio/SE/gun24", 80, 70]                    
        result["sp_recover"] = 0
        result["full_count"] = 2
        result["hit_slide"] = 0
        result["h_shake"] = [2,5,12,1]
        result["d_shake"] = [2,5,12,1]
        
      else
      end #if end
      return result
  end #def end
end # class end
