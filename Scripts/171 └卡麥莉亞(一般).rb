#==============================================================================
# ■ 狼模式


# 註：計算總動作時間時記得是每個wait
#==============================================================================
class Red_Beast < Game_Motion
#--------------------------------------------------------------------------
# ○ 人物生成/初始化
#--------------------------------------------------------------------------
def initialize(me,frame=0,anime="stand")
  super
  
  
  # 宣告所有動畫
  @anime = {"awake" => [], "awake_boss" => [], "stand" => [], "stand_idle" => [], "walk" => [], "dash" => [], "dash_break" => [],
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
  "5z" => [], "5zz" => [], "5zzz" => [], "6z" => [], "2z" => [], "j2z" => [], "g6z" => [], "j6z" => [], "dz2" => [],
  "5x" => [], "6x_start" => [], "6x" => [], "j2x" => [], "j2x_effect" => [], "2x" => [],
  "dizzy1" => [], "dizzy2" => [], "binding" => [], "binding2" => [], "binding3" => [],
  
  "story_down" => [], "story_dash" => []
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
@anime["awake"][0] = {"pic" => 261, "wait" => 2, "next" => 1, "ab_uncancel" => 2, "uncancel" => true, "superstop" => 31, "supermove" => 31, "z_pos" => 3, "x_speed" => 0, "y_speed" => 0, "y_fixed" => true, "eva" => 20}
@anime["awake"][1] = {"pic" => 263, "wait" => 2, "next" => 2}
@anime["awake"][2] = {"pic" => 264, "wait" => 2, "next" => 1}


#-------------------------------------------------------------------------------
# ○ 獸化(Boss用)
#-------------------------------------------------------------------------------
@anime["awake_boss"][0] = {"pic" => 261, "wait" => 2, "next" => 1, "ab_uncancel" => 41, "uncancel" => true, "superstop" => 31, "supermove" => 31, "z_pos" => 3, "x_speed" => 0, "y_speed" => 0, "y_fixed" => true, "eva" => 20}
@anime["awake_boss"][1] = {"pic" => 263, "wait" => 2, "next" => 2}
@anime["awake_boss"][2] = {"pic" => 264, "wait" => 2, "next" => 1}

#@anime["awake"][2] = {"pic" => 203, "wait" => 1, "next" => ["stand"], "var_reset" => true, "y_fixed" => false}
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
@anime["stand_idle"][0] = {"pic" => 21, "wait" => 3, "next" => 1}
@anime["stand_idle"][1] = {"pic" => 22, "wait" => 3, "next" => 2}
@anime["stand_idle"][2] = {"pic" => 23, "wait" => 3, "next" => 3}
@anime["stand_idle"][3] = {"pic" => 24, "wait" => 3, "next" => 4}
@anime["stand_idle"][4] = {"pic" => 25, "wait" => 4, "next" => 5}
@anime["stand_idle"][5] = {"pic" => 26, "wait" => 4, "next" => 6}
@anime["stand_idle"][6] = {"pic" => 27, "wait" => 4, "next" => 7}
@anime["stand_idle"][7] = {"pic" => 28, "wait" => 4, "next" => 8}
@anime["stand_idle"][8] = {"pic" => 29, "wait" => 4, "next" => 9}
@anime["stand_idle"][9] = {"pic" => 30, "wait" => 4, "next" => 10}
@anime["stand_idle"][10] = {"pic" => 31, "wait" => 4, "next" => 11}
@anime["stand_idle"][11] = {"pic" => 32, "wait" => 4, "next" => 12}
@anime["stand_idle"][12] = {"pic" => 33, "wait" => 4, "next" => 13}
@anime["stand_idle"][13] = {"pic" => 34, "wait" => 4, "next" => 14}
@anime["stand_idle"][14] = {"pic" => 35, "wait" => 4, "next" => 15}
@anime["stand_idle"][15] = {"pic" => 36, "wait" => 4, "next" => 16}
@anime["stand_idle"][16] = {"pic" => 37, "wait" => 4, "next" => 17}
@anime["stand_idle"][17] = {"pic" => 38, "wait" => 4, "next" => 18}
@anime["stand_idle"][18] = {"pic" => 39, "wait" => 4, "next" => 19}
@anime["stand_idle"][19] = {"pic" => 40, "wait" => 4, "next" => 20}
@anime["stand_idle"][20] = {"pic" => 24, "wait" => 4, "next" => 21}
@anime["stand_idle"][21] = {"pic" => 23, "wait" => 4, "next" => 22}
@anime["stand_idle"][22] = {"pic" => 22, "wait" => 4, "next" => ["stand"]}
#-------------------------------------------------------------------------------
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
#-------------------------------------------------------------------------------
# ○ 跑步
#-------------------------------------------------------------------------------
@anime["dash"][0] = {"pic" => 91, "wait" => 2, "next" => 1, "anime" => [11,0,0], "z_pos" =>  1}
@anime["dash"][1] = {"pic" => 92, "wait" => 2, "next" => 2}
@anime["dash"][2] = {"pic" => 93, "wait" => 2, "next" => 3}
@anime["dash"][3] = {"pic" => 94, "wait" => 2, "next" => 4}
@anime["dash"][4] = {"pic" => 95, "wait" => 2, "next" => 5}
@anime["dash"][5] = {"pic" => 96, "wait" => 2, "next" => 6}
@anime["dash"][6] = {"pic" => 97, "wait" => 2, "next" => 7}
@anime["dash"][7] = {"pic" => 98, "wait" => 2, "next" => 8}
@anime["dash"][8] = {"pic" => 99, "wait" => 2, "next" => 9}
@anime["dash"][9] = {"pic" => 100, "wait" =>2, "next" => 10}
@anime["dash"][10] = {"pic" => 101, "wait" => 2, "next" => 0}
@anime["dash_break"][0] = {"pic" => 110, "wait" => 6, "next" => ["stand"], "anime" => [12,0,0], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 跳躍  / 落下
#-------------------------------------------------------------------------------
@anime["jump"][0] = {"pic" => 110, "wait" => 3, "next" => 1, "ab_uncancel" => 8, "y_fixed" => true}
@anime["jump"][1] = {"pic" => 111, "wait" => 2, "next" => 2, "anime" => [12,0,0]}
@anime["jump"][2] = {"pic" => 112, "wait" => 1, "next" => 3, "var_reset" => true}
@anime["jump"][3] = {"pic" => 113, "wait" => 20, "next" => ["jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity}
@anime["jump_fall"][0] = {"pic" => 114, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 前跳躍  / 落下
#-------------------------------------------------------------------------------
@anime["f_jump"][0] = {"pic" => 110, "wait" => 3, "next" => 1, "ab_uncancel" => 8, "y_fixed" => true}
@anime["f_jump"][1] = {"pic" => 111, "wait" => 2, "next" => 2, "anime" => [12,0,0]}
@anime["f_jump"][2] = {"pic" => 112, "wait" => 1, "next" => 3, "var_reset" => true}
@anime["f_jump"][3] = {"pic" => 113, "wait" => 18, "next" => ["f_jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity/1.2, "x_speed" => @me.dash_x_speed}
@anime["f_jump_fall"][0] = {"pic" => 114, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 二段跳 / 落下
#-------------------------------------------------------------------------------
@anime["double_jump"][0] = {"pic" => 113, "wait" => 3, "next" => 1, "y_fixed" => true, "ab_uncancel" => 8}
@anime["double_jump"][1] = {"pic" => 111, "wait" => 2, "next" => 2}
@anime["double_jump"][2] = {"pic" => 112, "wait" => 1, "next" => 3}
@anime["double_jump"][3] = {"pic" => 113, "wait" => 18, "next" => ["double_jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity}
@anime["double_jump_fall"][0] = {"pic" => 114, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 大跳 / 落下
#-------------------------------------------------------------------------------
@anime["h_jump"][0] = {"pic" => 110, "wait" => 3, "next" => 1, "blur" => true, "x_speed" => 0, "ab_uncancel" => 8, "y_fixed" => true}
@anime["h_jump"][1] = {"pic" => 111, "wait" => 2, "next" => 2}
@anime["h_jump"][2] = {"pic" => 112, "wait" => 1, "next" => 3, "x_speed" => (@me.dash_x_speed/1.5), "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity + 1.4}
@anime["h_jump"][3] = {"pic" => 113, "wait" => 18, "next" => ["h_jump_fall"]}
@anime["h_jump_fall"][0] = {"pic" => 114, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 前大跳  / 落下
#-------------------------------------------------------------------------------
@anime["hf_jump"][0] = {"pic" => 110, "wait" => 3, "next" => 1, "ab_uncancel" => 2, "y_fixed" => true}
@anime["hf_jump"][1] = {"pic" => 111, "wait" => 2, "next" => 2, "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity - 5.5, "x_speed" => @me.dash_x_speed * 1.3}
@anime["hf_jump"][2] = {"pic" => 112, "wait" => 1, "next" => 3}
@anime["hf_jump"][3] = {"pic" => 113, "wait" => 18, "next" => ["hf_jump_fall"]}
@anime["hf_jump_fall"][0] = {"pic" => 114, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 著地
#-------------------------------------------------------------------------------
@anime["landing"][0] = {"pic" => 115, "wait" => 3, "next" => 1, "anime" => [12,0,0], "ab_uncancel" => 2}
@anime["landing"][1] = {"pic" => 115, "wait" => 3, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 蹲下 / 起來
#-------------------------------------------------------------------------------
@anime["crouch_start"][0] = {"pic" => 110, "wait" => 2, "next" => ["crouch"]}
@anime["crouch"][0] = {"pic" => 115, "wait" => -1, "next" => 0}
@anime["crouch_end"][0] = {"pic" => 110, "wait" => 2, "next" => ["stand"], "var_reset" => true}
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
@anime["b_blow"][0] = {"pic" => 151, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect}
@anime["b_blow"][1] = {"pic" => 152, "wait" => 5, "next" => 2}
@anime["b_blow"][2] = {"pic" => 153, "wait" => 6, "next" => 3}
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
@anime["vertical_blow"][0] = {"pic" => 119, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect}
@anime["vertical_blow"][1] = {"pic" => 118, "wait" => 3, "next" => 2}
@anime["vertical_blow"][2] = {"pic" => 117, "wait" => 3, "next" => 3}
@anime["vertical_blow"][3] = {"pic" => 116, "wait" => -1, "next" => 3}
#-------------------------------------------------------------------------------
# ○ 垂直擊飛後落下
#-------------------------------------------------------------------------------
@anime["vertical_blow_fall"][0] = {"pic" => 119, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect}
@anime["vertical_blow_fall"][1] = {"pic" => 118, "wait" => 3, "next" => 2}
@anime["vertical_blow_fall"][2] = {"pic" => 117, "wait" => 3, "next" => 3}
@anime["vertical_blow_fall"][3] = {"pic" => 116, "wait" => -1, "next" => 3}

#-------------------------------------------------------------------------------
# ○ 水平擊飛(正)
#-------------------------------------------------------------------------------
@anime["parallel_f_blow"][0] = {"pic" => 111, "wait" =>-1, "next" => 0, "body" => @me.stand_body_rect}
#-------------------------------------------------------------------------------
# ○ 水平擊飛(背)
#-------------------------------------------------------------------------------
@anime["parallel_b_blow"][0] = {"pic" => 119, "wait" => -1, "next" => 0, "body" => @me.stand_body_rect}

#-------------------------------------------------------------------------------
# ○ 倒地－－面朝上/反彈/起身
#-------------------------------------------------------------------------------
@anime["f_down"][0] = {"pic" => 145, "wait" => -1, "next" => 0, "ab_uncancel" => 22, "body" => @me.down_body_rect}
@anime["f_down_stand"][0] = {"pic" => 115, "wait" => 6, "next" => ["stand"], "ab_uncancel" => 8, "var_reset" => true, "body" => @me.sit_body_rect}
@anime["bounce_f_down"][0] = {"pic" => 146, "wait" => -1, "next" => 0, "body" => @me.down_body_rect}  # 反彈
#-------------------------------------------------------------------------------
# ○ 倒地－－面朝下/反彈/起身
#-------------------------------------------------------------------------------
@anime["b_down"][0] = {"pic" => 155, "wait" => -1, "next" => 0, "ab_uncancel" => 22, "body" => @me.down_body_rect}
@anime["b_down_stand"][0] = {"pic" => 115, "wait" => 6, "next" => ["stand"], "ab_uncancel" => 8, "var_reset" => true, "body" => @me.sit_body_rect}
@anime["bounce_b_down"][0] = {"pic" => 156, "wait" => -1, "next" => 0, "body" => @me.down_body_rect} # 反彈


#-------------------------------------------------------------------------------
# ○ 倒地－－壓制攻擊
#-------------------------------------------------------------------------------
@anime["pressure_f_down"][0] = {"pic" => 122, "wait" => 3, "next" => 0, "ab_uncancel" => 14, "body" => @me.down_body_rect}
@anime["pressure_b_down"][0] = {"pic" => 124, "wait" => 3, "next" => 0, "ab_uncancel" => 14, "body" => @me.down_body_rect}

#-------------------------------------------------------------------------------
# ○ 受身
#-------------------------------------------------------------------------------
@anime["ukemi"][0] = {"pic" => 114, "wait" => 7, "next" => ["jump_fall"]}


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
@anime["f_flee"][3] = {"pic" => 484, "wait" => 88, "next" => 3}
@anime["f_flee"][4] = {"pic" => 484, "wait" => 3, "next" => 5, "eva" => 10, "ab_uncancel" => 4} # 著地
@anime["f_flee"][5] = {"pic" => 485, "wait" => 2, "next" => 6}
@anime["f_flee"][6] = {"pic" => 486, "wait" => 2, "next" => 7}
@anime["f_flee"][7] = {"pic" => 487, "wait" => 2, "next" => 8}
@anime["f_flee"][8] = {"pic" => 488, "wait" => 3, "next" => ["stand"], "var_reset" => true, "penetrate" => false}
#-------------------------------------------------------------------------------
# ○ 後迴避
#-------------------------------------------------------------------------------
@anime["b_flee"][0] = {"pic" => 110, "wait" => 2, "next" => 1, "x_speed" => 0, "ab_uncancel" => 15, "eva" => 16, "penetrate" => true}
@anime["b_flee"][1] = {"pic" => 133, "wait" => 3, "next" => 2, "x_speed" => -17.2, "y_speed" => 4.5, "blur" => true}
@anime["b_flee"][2] = {"pic" => 133, "wait" => 3, "next" => 3}
@anime["b_flee"][3] = {"pic" => 133, "wait" => 3, "next" => 4}
@anime["b_flee"][4] = {"pic" => 134, "wait" => 9, "next" => 5, "x_speed" => -8.2}
@anime["b_flee"][5] = {"pic" => 131, "wait" => 8, "next" => ["stand"], "var_reset" => true, "penetrate" => false, "ab_uncancel" => 4, "eva" => 3}
#-------------------------------------------------------------------------------
# ○ 空突進
#-------------------------------------------------------------------------------
@anime["af_flee"][0] = {"pic" => 27, "wait" => 3, "next" => 1, "ab_uncancel" => 6, "eva" => 13, "y_fixed" => true, "penetrate" => true}
@anime["af_flee"][1] = {"pic" => 41, "wait" => 1, "next" => 2, "y_fixed" => false, "x_speed" => @me.dash_x_speed*1.2, "y_speed" => 7.9, "blur" => true}
@anime["af_flee"][2] = {"pic" => 41, "wait" => 12, "next" => 3}
@anime["af_flee"][3] = {"pic" => 46, "wait" => -1, "next" => 3, "penetrate" => false}
#-------------------------------------------------------------------------------
# ○ 空迴避
#-------------------------------------------------------------------------------
@anime["ab_flee"][0] = {"pic" => 27, "wait" => 5, "next" => 1, "y_fixed" => true, "ab_uncancel" => 6, "eva" => 13, "penetrate" => true}
@anime["ab_flee"][1] = {"pic" => 51, "wait" => 1, "next" => 2, "y_fixed" => false, "x_speed" => -@me.dash_x_speed*1.3, "y_speed" => 7.9, "blur" => true, "eva" => 11}
@anime["ab_flee"][2] = {"pic" => 51, "wait" => 12, "next" => 3}
@anime["ab_flee"][3] = {"pic" => 56, "wait" => -1, "next" => 3, "penetrate" => false}
#-------------------------------------------------------------------------------
# ○ 地上前追擊
#-------------------------------------------------------------------------------
@anime["f_chase"][0] = {"pic" => 21, "wait" => 3, "next" => 1, "x_speed" => (@me.dash_x_speed*1.2), "ab_uncancel" => 2, "blur" => true}
@anime["f_chase"][1] = {"pic" => 22, "wait" => 3, "next" => 2, "x_speed" => (@me.dash_x_speed*1.2)}
@anime["f_chase"][2] = {"pic" => 23, "wait" => 3, "next" => 3, "x_speed" => (@me.dash_x_speed*1.2)}
@anime["f_chase"][3] = {"pic" => 22, "wait" => 3, "next" => 4, "x_speed" => (@me.dash_x_speed*1.2)}
@anime["f_chase"][4] = {"pic" => 24, "wait" => 3, "next" => 5}
@anime["f_chase"][5] = {"pic" => 22, "wait" => 3, "next" => 6}
@anime["f_chase"][6] = {"pic" => 21, "wait" => 5, "next" => ["stand"], "var_reset" => true}
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
# ○ 拳擊(Z)
#-------------------------------------------------------------------------------
@anime["5z"][0] = {"pic" => 203, "wait" => 2, "next" => 4, "ab_uncancel" => 10, "uncancel" => true, "z_pos" => 3, "x_speed" => 4.5}
@anime["5z"][1] = {"pic" => 202, "wait" => 1, "next" => 2}
@anime["5z"][2] = {"pic" => 203, "wait" => 1, "next" => 4}
@anime["5z"][3] = {"pic" => 204, "wait" => 1, "next" => 4}
@anime["5z"][4] = {"pic" => 205, "wait" => 1, "next" => 5, "x_speed" => 5}
@anime["5z"][5] = {"pic" => 206, "wait" => 1, "next" => 6}
@anime["5z"][6] = {"pic" => 207, "wait" => 2, "next" => 7}
@anime["5z"][7] = {"pic" => 208, "wait" => 2, "next" => 8, "se"=> ["swing2", 70, 105]}
@anime["5z"][8] = {"pic" => 209, "wait" => 2, "next" => 9, "atk" => [Rect.new(0, -110, 75, 80)]}
@anime["5z"][9] = {"pic" => 210, "wait" => 2, "next" => 10}
@anime["5z"][10] = {"pic" => 211, "wait" => 2, "next" => 11, "atk" => 0}
@anime["5z"][11] = {"pic" => 212, "wait" => 2, "next" => 12}
@anime["5z"][12] = {"pic" => 213, "wait" => 2, "next" => 13}
@anime["5z"][13] = {"pic" => 214, "wait" => 2, "next" => 14}
@anime["5z"][14] = {"pic" => 215, "wait" => 2, "next" => 15}
@anime["5z"][15] = {"pic" => 216, "wait" => 2, "next" => 16}
@anime["5z"][16] = {"pic" => 217, "wait" => 2, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 拳擊(ZZ)
#-------------------------------------------------------------------------------
@anime["5zz"][0] = {"pic" => 221, "wait" => 2, "next" => 1, "ab_uncancel" => 8,"uncancel" => true, "x_speed" => 4.5, "z_pos" => 3}
@anime["5zz"][1] = {"pic" => 222, "wait" => 2, "next" => 2}
@anime["5zz"][2] = {"pic" => 223, "wait" => 2, "next" => 3}
@anime["5zz"][3] = {"pic" => 224, "wait" => 2, "next" => 4}
@anime["5zz"][4] = {"pic" => 225, "wait" => 2, "next" => 5, "atk" => [Rect.new(0, -130, 85, 95)]}
@anime["5zz"][5] = {"pic" => 226, "wait" => 2, "next" => 6}
@anime["5zz"][6] = {"pic" => 227, "wait" => 2, "next" => 7, "atk" => 0}
@anime["5zz"][7] = {"pic" => 228, "wait" => 2, "next" => 8}
@anime["5zz"][8] = {"pic" => 229, "wait" => 2, "next" => 9}
@anime["5zz"][9] = {"pic" => 230, "wait" => 2, "next" => 10}
@anime["5zz"][10] = {"pic" => 231, "wait" => 2, "next" => 11}
@anime["5zz"][11] = {"pic" => 232, "wait" => 2, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 拳擊(ZZZ)
#-------------------------------------------------------------------------------
@anime["5zzz"][0] = {"pic" => 241, "wait" => 2, "next" => 1, "ab_uncancel" => 23,"uncancel" => true, "x_speed" => 1.2, "z_pos" => 3}
@anime["5zzz"][1] = {"pic" => 242, "wait" => 3, "next" => 2}
@anime["5zzz"][2] = {"pic" => 243, "wait" => 7, "next" => 3, "x_speed" => 12.7, "y_speed" => 6.6}
@anime["5zzz"][3] = {"pic" => 244, "wait" => 2, "next" => 4, "se"=> ["swing2", 70, 105]}
@anime["5zzz"][4] = {"pic" => 245, "wait" => 2, "next" => 5, "atk" => [Rect.new(0, -120, 110, 95)]}
@anime["5zzz"][5] = {"pic" => 246, "wait" => 2, "next" => 6, "atk" => [Rect.new(0, -120, 110, 95)], "hit_reset" => true}
@anime["5zzz"][6] = {"pic" => 247, "wait" => 2, "next" => 7, "atk" => [Rect.new(0, -120, 110, 95)], "hit_reset" => true}
@anime["5zzz"][7] = {"pic" => 248, "wait" => 3, "next" => 8, "atk" => 0}
@anime["5zzz"][8] = {"pic" => 249, "wait" => 3, "next" => 9}
@anime["5zzz"][9] = {"pic" => 250, "wait" => 888, "next" => 10}
@anime["5zzz"][10] = {"pic" => 251, "wait" => 2, "next" => 11}
@anime["5zzz"][11] = {"pic" => 252, "wait" => 2, "next" => 12}
@anime["5zzz"][12] = {"pic" => 253, "wait" => 2, "next" => 13}
@anime["5zzz"][13] = {"pic" => 254, "wait" => 2, "next" => 14}
@anime["5zzz"][14] = {"pic" => 255, "wait" => 2, "next" => 15}
@anime["5zzz"][15] = {"pic" => 256, "wait" => 3, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 前衝拳(→Z)
#-------------------------------------------------------------------------------
@anime["6z"][0] = {"pic" => 511, "wait" => 9, "next" => 1, "ab_uncancel" => 14,"uncancel" => true, "x_speed" => 17.5, "z_pos" => 3}
@anime["6z"][1] = {"pic" => 512, "wait" => 2, "next" => 2, "atk" => [Rect.new(0, -110, 138, 115)], "se"=> ["swing2", 70, 105]}
@anime["6z"][2] = {"pic" => 513, "wait" => 2, "next" => 3}
@anime["6z"][3] = {"pic" => 514, "wait" => 4, "next" => 4, "atk" => 0}
@anime["6z"][4] = {"pic" => 515, "wait" => 4, "next" => 5}
@anime["6z"][5] = {"pic" => 516, "wait" => 4, "next" => 6}
@anime["6z"][6] = {"pic" => 517, "wait" => 5, "next" => ["stand"], "var_reset" => true}


#-------------------------------------------------------------------------------
# ○ 下拳(↓Z)
#-------------------------------------------------------------------------------
#@anime["2z"][0] = {"pic" => 321, "wait" => 2, "next" => 1, "ab_uncancel" => 8,"uncancel" => true, "z_pos" => 3}
#@anime["2z"][1] = {"pic" => 322, "wait" => 2, "next" => 2}
#@anime["2z"][2] = {"pic" => 323, "wait" => 2, "next" => 3}

#@anime["2z"][3] = {"pic" => 325, "wait" => 3, "next" => 4, "atk" => [Rect.new(0, -170, 95, 95)], "se"=> ["swing2", 70, 105]}
#@anime["2z"][4] = {"pic" => 326, "wait" => 3, "next" => 5, "atk" => 0}
#@anime["2z"][5] = {"pic" => 327, "wait" => 4, "next" => ["crouch"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 上鉤拳 (↓Z)
#-------------------------------------------------------------------------------
@anime["2z"][0] = {"pic" => 201, "wait" => 2, "next" => 1, "ab_uncancel" => 13, "uncancel" => true, "x_speed" => 9, "z_pos" => 3}
@anime["2z"][1] = {"pic" => 204, "wait" => 2, "next" => 2}
@anime["2z"][2] = {"pic" => 205, "wait" => 2, "next" => 3}
@anime["2z"][3] = {"pic" => 207, "wait" => 2, "next" => 4, "se"=> ["swing2", 70, 105]}
@anime["2z"][4] = {"pic" => 209, "wait" => 2, "next" => 5, "atk" => [Rect.new(0, -170, 75, 145)]}
@anime["2z"][5] = {"pic" => 210, "wait" => 2, "next" => 6}
@anime["2z"][6] = {"pic" => 211, "wait" => 2, "next" => 7, "atk" => 0}
@anime["2z"][7] = {"pic" => 212, "wait" => 2, "next" => 8}
@anime["2z"][8] = {"pic" => 213, "wait" => 2, "next" => 9}
@anime["2z"][9] = {"pic" => 214, "wait" => 2, "next" => 10}
@anime["2z"][10] = {"pic" => 215, "wait" => 2, "next" => 11}
@anime["2z"][11] = {"pic" => 216, "wait" => 2, "next" => 12}
@anime["2z"][12] = {"pic" => 217, "wait" => 3, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 上鉤拳 (↓Z2)
#-------------------------------------------------------------------------------
@anime["dz2"][0] = {"pic" => 491, "wait" => 3, "next" => 1, "ab_uncancel" => 16, "uncancel" => true, "x_speed" => 9, "z_pos" => 3}
@anime["dz2"][1] = {"pic" => 492, "wait" => 2, "next" => 2}
@anime["dz2"][2] = {"pic" => 493, "wait" => 4, "next" => 3}
@anime["dz2"][3] = {"pic" => 494, "wait" => 3, "next" => 4, "se"=> ["swing2", 70, 105], "atk" => [Rect.new(0, -170, 75, 145)], "x_speed" => 5.3, "y_speed" => 11.7}
@anime["dz2"][4] = {"pic" => 495, "wait" => 3, "next" => 5}
@anime["dz2"][5] = {"pic" => 496, "wait" => 2, "next" => 6, "atk" => 0}
@anime["dz2"][6] = {"pic" => 497, "wait" => 3, "next" => 7}
@anime["dz2"][7] = {"pic" => 498, "wait" => 99, "next" => 7}
@anime["dz2"][8] = {"pic" => 499, "wait" => 4, "next" => 9}
@anime["dz2"][9] = {"pic" => 500, "wait" => 4, "next" => 10}
@anime["dz2"][10] = {"pic" => 501, "wait" => 6, "next" => ["stand"], "var_reset" => true}


#-------------------------------------------------------------------------------
# ○ 跳前打
#-------------------------------------------------------------------------------
@anime["j6z"][0] = {"pic" => 331, "wait" => 3, "next" => 1, "ab_uncancel" => 11, "uncancel" => true, "z_pos" => 3}
@anime["j6z"][1] = {"pic" => 332, "wait" => 2, "next" => 2}
@anime["j6z"][2] = {"pic" => 334, "wait" => 2, "next" => 3, "atk" => [Rect.new(5, -105, 63, 100)], "se"=> ["swing2", 70, 105]}
@anime["j6z"][3] = {"pic" => 335, "wait" => 3, "next" => 4}
@anime["j6z"][4] = {"pic" => 336, "wait" => 5, "next" => 5, "atk" => 0}
@anime["j6z"][5] = {"pic" => 337, "wait" => 4, "next" => ["jump_fall"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 跳下打
#-------------------------------------------------------------------------------
@anime["j2z"][0] = {"pic" => 301, "wait" => 3, "next" => 1, "ab_uncancel" => 13, "uncancel" => true, "z_pos" => 3}
@anime["j2z"][1] = {"pic" => 302, "wait" => 6, "next" => 2}
@anime["j2z"][2] = {"pic" => 303, "wait" => 4, "next" => 3, "atk" => [Rect.new(5, -125, 83, 128)], "se"=> ["swing2", 70, 105]}
@anime["j2z"][3] = {"pic" => 304, "wait" => 13, "next" => ["jump_fall"], "atk" => 0, "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 血腥欲望
#-------------------------------------------------------------------------------
@anime["6x_start"][0] = {"pic" => 261, "wait" => 2, "next" => 1, "ab_uncancel" => 18, "uncancel" => true, "anime" => [1,0,0], "fps" => [16, 55], "superstop" => 16, "supermove" => 16, "camera" => [25,30,30], "super_armor" => 5, "z_pos" => 3, "eva" => 88}
@anime["6x_start"][1] = {"pic" => 262, "wait" => 2, "next" => 2, "superstop" => 26, "supermove" => 26}
@anime["6x_start"][2] = {"pic" => 263, "wait" => 2, "next" => 3}
@anime["6x_start"][3] = {"pic" => 264, "wait" => 2, "next" => 2} # 咆嘯

@anime["6x_start"][4] = {"pic" => 256, "wait" => 2, "next" => 5, "eva" => 12}
@anime["6x_start"][5] = {"pic" => 254, "wait" => 2, "next" => 6}
@anime["6x_start"][6] = {"pic" => 251, "wait" => 2, "next" => 7}
@anime["6x_start"][7] = {"pic" => 207, "wait" => 4, "next" => 8, "x_speed" => @me.dash_x_speed*2.4} # 往前衝
@anime["6x_start"][8] = {"pic" => 209, "wait" => 2, "next" => 9, "atk" => [Rect.new(0, -150, 75, 146)]}
@anime["6x_start"][9] = {"pic" => 211, "wait" => 2, "next" => 10}
@anime["6x_start"][10] = {"pic" => 213, "wait" => 2, "next" => 11, "atk" => 0}
@anime["6x_start"][11] = {"pic" => 215, "wait" => 2, "next" => 12}
@anime["6x_start"][12] = {"pic" => 216, "wait" => 2, "next" => 13}
@anime["6x_start"][13] = {"pic" => 217, "wait" => 2, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 血腥欲望(命中)
#-------------------------------------------------------------------------------
@anime["6x"][0] = {"pic" => 210, "wait" => 6, "next" => 1, "ab_uncancel" => 99, "uncancel" => true, "camera" => [80,25,25], "fps"=> [15,53], "black" => [130,50], "x_speed" => 2.9, "super_armor" => 22, "supermove" => 22, "superstop" => 22}
@anime["6x"][1] = {"pic" => 211, "wait" => 2, "next" => 2}
@anime["6x"][2] = {"pic" => 212, "wait" => 2, "next" => 3, "atk" => 0}
@anime["6x"][3] = {"pic" => 213, "wait" => 2, "next" => 4}
@anime["6x"][4] = {"pic" => 214, "wait" => 2, "next" => 5}
@anime["6x"][5] = {"pic" => 1, "wait" => 12, "next" => 6}

# 一拳
@anime["6x"][6] = {"pic" => 201, "wait" => 2, "next" => 7, "x_speed" => 5.8, "blur" => true, "camera" => [60,25,25]}
@anime["6x"][7] = {"pic" => 204, "wait" => 2, "next" => 8, "se"=> ["swing2", 70, 105]}
@anime["6x"][8] = {"pic" => 207, "wait" => 2, "next" => 9}
@anime["6x"][9] = {"pic" => 209, "wait" => 2, "next" => 10, "atk" => [Rect.new(0, -170, 95, 166)], "hit_reset" => true}
@anime["6x"][10] = {"pic" => 210, "wait" => 2, "next" => 11}

# 二拳
@anime["6x"][11] = {"pic" => 221, "wait" => 2, "next" => 12, "x_speed" => 5.8, "blur" => true, "camera" => [60,25,25], "ab_uncancel" => 99}
@anime["6x"][12] = {"pic" => 223, "wait" => 2, "next" => 13, "se"=> ["swing2", 70, 105]}
@anime["6x"][13] = {"pic" => 225, "wait" => 2, "next" => 14, "atk" => [Rect.new(0, -170, 95, 166)], "hit_reset" => true}
@anime["6x"][14] = {"pic" => 227, "wait" => 2, "next" => 15}
@anime["6x"][15] = {"pic" => 228, "wait" => 2, "next" => 16}

# 三拳
@anime["6x"][16] = {"pic" => 201, "wait" => 2, "next" => 17, "x_speed" => 5.8, "blur" => true, "camera" => [60,25,25]}
@anime["6x"][17] = {"pic" => 204, "wait" => 2, "next" => 18, "se"=> ["swing2", 70, 105]}
@anime["6x"][18] = {"pic" => 207, "wait" => 2, "next" => 19}
@anime["6x"][19] = {"pic" => 209, "wait" => 2, "next" => 20, "atk" => [Rect.new(0, -170, 95, 166)], "hit_reset" => true}
@anime["6x"][20] = {"pic" => 210, "wait" => 2, "next" => 21}

# 四拳
@anime["6x"][21] = {"pic" => 221, "wait" => 2, "next" => 22, "x_speed" => 5.8, "blur" => true, "camera" => [60,25,25]}
@anime["6x"][22] = {"pic" => 223, "wait" => 2, "next" => 23, "se"=> ["swing2", 70, 105]}
@anime["6x"][23] = {"pic" => 225, "wait" => 2, "next" => 24, "atk" => [Rect.new(0, -170, 95, 166)], "hit_reset" => true}
@anime["6x"][24] = {"pic" => 227, "wait" => 2, "next" => 25}
@anime["6x"][25] = {"pic" => 228, "wait" => 2, "next" => 26}

# 五拳
@anime["6x"][26] = {"pic" => 242, "wait" => 3, "next" => 27, "ab_uncancel" => 99}
@anime["6x"][27] = {"pic" => 243, "wait" => 7, "next" => 28}
@anime["6x"][28] = {"pic" => 245, "wait" => 2, "next" => 29, "atk" => [Rect.new(0, -120, 110, 110)], "se"=> ["swing2", 70, 105], "hit_reset" => true}
@anime["6x"][29] = {"pic" => 246, "wait" => 2, "next" => 30, "atk" => [Rect.new(0, -120, 110, 110)], "hit_reset" => true}
@anime["6x"][30] = {"pic" => 247, "wait" => 2, "next" => 31, "atk" => [Rect.new(0, -120, 110, 110)], "hit_reset" => true}
@anime["6x"][31] = {"pic" => 245, "wait" => 2, "next" => 32, "atk" => [Rect.new(0, -120, 110, 110)], "se"=> ["swing2", 70, 105], "hit_reset" => true}
@anime["6x"][32] = {"pic" => 246, "wait" => 2, "next" => 33, "atk" => [Rect.new(0, -120, 110, 110)], "hit_reset" => true}
@anime["6x"][33] = {"pic" => 247, "wait" => 2, "next" => 34, "atk" => [Rect.new(0, -120, 110, 110)], "hit_reset" => true}
@anime["6x"][34] = {"pic" => 245, "wait" => 2, "next" => 35, "atk" => [Rect.new(0, -120, 110, 110)], "se"=> ["swing2", 70, 105], "hit_reset" => true}
@anime["6x"][35] = {"pic" => 246, "wait" => 2, "next" => 36, "atk" => [Rect.new(0, -120, 110, 110)], "hit_reset" => true}
@anime["6x"][36] = {"pic" => 247, "wait" => 2, "next" => 37, "atk" => [Rect.new(0, -120, 110, 110)], "hit_reset" => true}
@anime["6x"][37] = {"pic" => 245, "wait" => 2, "next" => 38, "atk" => [Rect.new(0, -120, 110, 110)], "se"=> ["swing2", 70, 105], "hit_reset" => true}
@anime["6x"][38] = {"pic" => 246, "wait" => 2, "next" => 39, "atk" => [Rect.new(0, -120, 110, 110)], "hit_reset" => true}
@anime["6x"][39] = {"pic" => 247, "wait" => 2, "next" => 40, "atk" => [Rect.new(0, -120, 110, 110)], "hit_reset" => true}
@anime["6x"][40] = {"pic" => 248, "wait" => 3, "next" => 41, "atk" => 0, "ab_uncancel" => 3}

# 踢
@anime["6x"][41] = {"pic" => 251, "wait" => 3, "next" => 42, "x_speed" => 12.8}
@anime["6x"][42] = {"pic" => 273, "wait" => 3, "next" => 43, "camera" => [60,45,45], "fps"=> [15,53], "black" => [50,50]}
@anime["6x"][43] = {"pic" => 274, "wait" => 3, "next" => 44}
@anime["6x"][44] = {"pic" => 275, "wait" => 3, "next" => 45}
@anime["6x"][45] = {"pic" => 276, "wait" => 3, "next" => 46}
@anime["6x"][46] = {"pic" => 277, "wait" => 4, "next" => 47, "atk" => [Rect.new(0, -120, 110, 110)], "hit_reset" => true, "superstop"=> 10}
@anime["6x"][47] = {"pic" => 278, "wait" => 3, "next" => 48, "edge_spacing" => 0, "atk" => 0 }
@anime["6x"][48] = {"pic" => 279, "wait" => 3, "next" => 49}
@anime["6x"][49] = {"pic" => 280, "wait" => 3, "next" => 50}
@anime["6x"][50] = {"pic" => 281, "wait" => 3, "next" => ["stand"], "var_reset" => true}



#-------------------------------------------------------------------------------
# ○ 上鉤拳 (↓Z)
#-------------------------------------------------------------------------------
@anime["2x"][0] = {"pic" => 201, "wait" => 2, "next" => 1, "ab_uncancel" => 13, "uncancel" => true, "x_speed" => 9, "z_pos" => 3}
@anime["2x"][1] = {"pic" => 204, "wait" => 2, "next" => 2}
@anime["2x"][2] = {"pic" => 205, "wait" => 2, "next" => 3}
@anime["2x"][3] = {"pic" => 207, "wait" => 2, "next" => 4, "se"=> ["swing2", 70, 105]}
@anime["2x"][4] = {"pic" => 209, "wait" => 2, "next" => 5, "atk" => [Rect.new(0, -170, 75, 145)]}
@anime["2x"][5] = {"pic" => 210, "wait" => 2, "next" => 6}
@anime["2x"][6] = {"pic" => 211, "wait" => 2, "next" => 7, "atk" => 0}
@anime["2x"][7] = {"pic" => 212, "wait" => 2, "next" => 8}
@anime["2x"][8] = {"pic" => 213, "wait" => 2, "next" => 9}
@anime["2x"][9] = {"pic" => 214, "wait" => 2, "next" => 10}
@anime["2x"][10] = {"pic" => 215, "wait" => 2, "next" => 11}
@anime["2x"][11] = {"pic" => 216, "wait" => 2, "next" => 12}
@anime["2x"][12] = {"pic" => 217, "wait" => 3, "next" => ["stand"], "var_reset" => true}


#-------------------------------------------------------------------------------
# ○ 重擊
#-------------------------------------------------------------------------------
@anime["j2x"][0] = {"pic" => 521, "wait" => 3, "next" => 1, "ab_uncancel" => 23, "uncancel" => true, "anime" => [1,0,0], "fps" => [16, 55], "superstop" => 24, "camera" => [25,30,30], "z_pos" => 3, "y_fixed" => true, "y_speed" => 0, "x_speed" => 0}
@anime["j2x"][1] = {"pic" => 525, "wait" => 2, "next" => 2, "bullet" => [@me, "j2x_effect", 0, 50, 0, false, true]}
@anime["j2x"][2] = {"pic" => 526, "wait" => 2, "next" => 3, "se"=> ["swing2", 70, 105]}
@anime["j2x"][3] = {"pic" => 527, "wait" => 2, "next" => 4, "atk" => [Rect.new(5, -205, 143, 230), Rect.new(-40, -15, 173, 120)]}
@anime["j2x"][4] = {"pic" => 528, "wait" => 2, "next" => 5}
@anime["j2x"][5] = {"pic" => 529, "wait" => 2, "next" => 6, "atk" => 0}
@anime["j2x"][6] = {"pic" => 530, "wait" => 3, "next" => 7}
@anime["j2x"][7] = {"pic" => 531, "wait" => 3, "next" => 8}
@anime["j2x"][8] = {"pic" => 532, "wait" => 3, "next" => 9}
@anime["j2x"][9] = {"pic" => 114, "wait" => 888, "next" => 9, "var_reset" => true, "y_fixed" => false}
#-------------------------------------------------------------------------------
# ○ ↑特效
#-------------------------------------------------------------------------------
@anime["j2x_effect"][0] = {"pic" => 536, "wait" => 3, "next" => 1, "z_pos" =>  3}
@anime["j2x_effect"][1] = {"pic" => 537, "wait" => 3, "next" => 2}
@anime["j2x_effect"][2] = {"pic" => 538, "wait" => 3, "next" => 3}
@anime["j2x_effect"][3] = {"pic" => 539, "wait" => 3, "next" => ["dispose"]}

#-------------------------------------------------------------------------------
# ○ 劇情用倒地
#-------------------------------------------------------------------------------
@anime["story_down"][0] = {"pic" => 145, "wait" => -1, "next" => 0}


#-------------------------------------------------------------------------------
# ○ 劇情用跑步
#-------------------------------------------------------------------------------
@anime["story_dash"][0] = {"pic" => 91, "wait" => 2, "next" => 1, "anime" => [11,0,0], "z_pos" => 1, "penetrate" => true}
@anime["story_dash"][1] = {"pic" => 92, "wait" => 2, "next" => 2}
@anime["story_dash"][2] = {"pic" => 93, "wait" => 2, "next" => 3}
@anime["story_dash"][3] = {"pic" => 94, "wait" => 2, "next" => 4}
@anime["story_dash"][4] = {"pic" => 95, "wait" => 2, "next" => 5}
@anime["story_dash"][5] = {"pic" => 96, "wait" => 2, "next" => 6}
@anime["story_dash"][6] = {"pic" => 97, "wait" => 2, "next" => 7}
@anime["story_dash"][7] = {"pic" => 98, "wait" => 2, "next" => 8}
@anime["story_dash"][8] = {"pic" => 99, "wait" => 2, "next" => 9}
@anime["story_dash"][9] = {"pic" => 100, "wait" =>2, "next" => 10}
@anime["story_dash"][10] = {"pic" => 101, "wait" => 2, "next" => 0}


#-------------------------------------------------------------------------------
# ○ 蓄力拳測試
#-------------------------------------------------------------------------------
@anime["g6z"][0] = {"pic" => 209, "wait" => 3, "next" => 1, "se"=> ["swing2", 70, 105], "atk_phase" => 2, "anime" => [1,0,0], "x_speed" => 0, "atk" => 0}
@anime["g6z"][1] = {"pic" => 210, "wait" => 2, "next" => 2, "atk" => [Rect.new(3, -50, 37, 18)], "x_speed" => 18.6, "atk_phase" => 3}
@anime["g6z"][2] = {"pic" => 211, "wait" => 4, "next" => 3}
@anime["g6z"][3] = {"pic" => 212, "wait" => 2, "next" => 4, "atk" => 0, "atk_phase" => 4}
@anime["g6z"][4] = {"pic" => 213, "wait" => 3, "next" => 5}
@anime["g6z"][5] = {"pic" => 214, "wait" => 3, "next" => ["stand"], "var_reset" => true}

end




#==============================================================================
# ■ 主模組補強
#==============================================================================
  #--------------------------------------------------------------------------
  # ◇ 執行其他預約指令
  #      處理5ZZ、5XX這種角色間不一定有的指令
  #--------------------------------------------------------------------------
  def do_other_plancommand
  #  case @command_plan
  #  when "5zz"
  #  end
    
     if @command_plan.include?("z")
      z_action
    elsif @command_plan.include?("x")
      x_action
    elsif @command_plan.include?("s") 
      s_action
    end
    
  end
  #--------------------------------------------------------------------------
  # ◇ 著地
  #--------------------------------------------------------------------------
  def do_landing_step
    if ["damage1", "damage2", "guard", "guard_shock", "binding", "binding2", "binding3"].include?(@state)
      @me.z_pos = 0
    elsif @state == "5zzz" and @frame_number == 9
      change_anime(@state, 10)
    elsif @state == "j6x" and @frame_number == 18
      change_anime(@state, 19)
    elsif @state == "dz2"
      change_anime(@state, 8)
    elsif @state == "f_flee"
      change_anime("f_flee", 4)
      @me.z_pos = 0
    elsif @state == "b_flee" and @frame_number == 4
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
    return ["5z","5zz","5zzz","6z","2z","jz","j2z", "j6z", "dz2"].include?(@state)
  end  
  #--------------------------------------------------------------------------
  # ◇ 超必殺
  #--------------------------------------------------------------------------
  def x_skill?
    return ["x","6x","j6x","6x_start", "j2x"].include?(@state)
  end  
#==============================================================================
# ■ 指令設置
#==============================================================================



  #-------------------------------------------------------------------------------
  # ○ 解除獸化 (未使用)
  #-------------------------------------------------------------------------------
  def awake_break
     x = @me.x_pos
     y = @me.y_pos
     xs = @me.now_x_speed
     ys = @me.now_y_speed
     state = @state
     frame = @frame_number
     dir = @me.direction
     @me.awaking = false
     $game_party.add_actor(@me.before_awake_id)
      $game_party.remove_actor(3)

     
     awake_time = @me.awake_time
     
     
     # 設定攝影機跟隨 / 操縱的角色
     @xcam_watch_battler = $scene.handle_battler = $game_party.actors[0]

     
     # 重設位置
     $scene.handle_battler.x_pos = x
     $scene.handle_battler.y_pos = y
     $scene.handle_battler.direction = dir
     $scene.handle_battler.now_x_speed = xs
     $scene.handle_battler.now_y_speed = ys
     # 模組、數值初始化
     $scene.handle_battler.motion_setup($game_party.actors[0].id)
     $scene.handle_battler.setup_actor_reflexes($game_party.actors[0].id)
      # 初始戰鬥圖
    #  @handle_battler.transgraphic_basic_form
      # 身體判定
     $scene.handle_battler.body_rect = @me.stand_body_rect
     # 播放換人動畫
     $scene.handle_battler.animation.push([19, true, 0, 0])
     # 恢復先前的動作
     $scene.handle_battler.motion.change_anime(state, 0)
    # @me.awake_time = 0
     $scene.handle_battler.awake_time = awake_time
     
    
  end
  #-------------------------------------------------------------------------------
  # ○ 上
  #-------------------------------------------------------------------------------
  def up_action(dir)
    if ["jump_fall", "f_jump_fall", "b_jump_fall", "hf_jump_fall", "hb_jump_fall", "h_jump_fall"].include?(@state) and @now_jumps  < 2
      @me.direction = dir if dir != 0
      case dir
      when 1, -1
        change_anime("f_jump")
      else 
        change_anime("double_jump")
      end
      @now_jumps  += 1
    end
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
      dz_action
     # do_act("jz", "z","Z")
    else
      case @state
      when "5zzz"  # 正在出第3拳
         
      when "5zz"  # 正在出第2拳
         do_act("5zzz", "z","Z", true)
      when "5z"  # 正在出第一拳
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
      do_act("6z", "6z","Z")
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↓Z
  #-------------------------------------------------------------------------------
  def dz_action
    if on_air?
      do_act("j2z", "2z","Z")
    else
      do_act("dz2", "2z","Z")
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↑Z
  #-------------------------------------------------------------------------------
  def uz_action
    return if !on_air?
    dz_action
    
    
   # do_act("jz", "8z","Z")
  end
  #-------------------------------------------------------------------------------
  # ○ ←Z
  #-------------------------------------------------------------------------------
  def bz_action
    if on_air?
      do_act("j2z", "4z","Z")
    #   do_act("jz", "4z","Z")
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
      do_act("j2x", "x","X", false, false, 60)
    else
      fx_action
    end
  end
  #-------------------------------------------------------------------------------
  # ○ →X
  #-------------------------------------------------------------------------------
  def fx_action
    if on_air?
      do_act("j2x", "6x","X", false, false, 60)
    else
      return if @state == "6x"
      do_act("6x_start", "6x","X", false, false, 60)
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↓X
  #-------------------------------------------------------------------------------
  def dx_action
   # @valuereset_flag = false
    if on_air?
      do_act("j2x", "2x","X", false, false, 60)
    else
      fx_action
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
      do_act("j2x", "4x","X", false, false, 60)
    else
      unless ["stand", "stand_idle", "walk", "run"].include?(@state) 
        return if @state == "6x"
        do_act("6x_start", "4x","X", false, false, 60)
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
      if ["stand", "stand_idle", "walk", "dash", "dash_break", "guard", "landing"].include?(@state) #or
     #   (@state == "f_flee" and (4..5) === @frame_number) or (@state == "b_flee" and @frame_number == 5 and @frame_time > 6) 
         change_anime("b_flee")
      end  
    end
  end
  
  #-------------------------------------------------------------------------------
  # ○ 獸化
  #-------------------------------------------------------------------------------
  def awake
    
    @eva_invincible_duration = 2

    if @anime_time == 1
      $game_screen.start_shake(8,16,20,1)
      @attack_rect = [Rect.new(-125, -250, 250, 250)]
    end
    if @anime_time == 6
      @attack_rect.clear
    end
    
    if @anime_time == 41
      var_reset
      @y_fixed = false
      @eva_invincible_duration = 0
      change_anime("stand")
    end
  end
  #-------------------------------------------------------------------------------
  # ○  獸化(Boss用)
  #-------------------------------------------------------------------------------
  def awake_boss
    
    @eva_invincible_duration = 2
    
    if @anime_time == 1
      $game_screen.start_shake(8,16,20,1)
      @attack_rect = [Rect.new(-125, -250, 250, 250)]
    end
    if @anime_time == 6
      @attack_rect.clear
    end
    
    
    if @anime_time == 41
      var_reset
      @y_fixed = false
      @eva_invincible_duration = 0
      change_anime("stand")
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 劇情用奔跑
  #-------------------------------------------------------------------------------
  def story_dash
    @me.now_x_speed = @me.direction * 8.6#@me.dash_x_speed
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
  # ○ 跳下打
  #-------------------------------------------------------------------------------
  def j2z
    if @frame_number < 2
      @me.now_y_speed = [@me.now_y_speed, -5.2].max
    end
    
  end
  #-------------------------------------------------------------------------------
  # ○ 常時監視A (不受暫停、受傷定格效果影響)
  #      通常用在調整受傷、倒地這種不確定何時恢復姿勢的情況
  #-------------------------------------------------------------------------------
  def respective_updateA
    
    if @state == "j2x"
      $game_temp.black_time = [30, 50]
      $scene.camera_feature =  [30,25,25]
    end
    
    # 變黑
    @me.battle_sprite.tone = @black_tone.clone if @me.is_a?(Game_Enemy) and @me.battle_sprite.tone != @black_tone and !$game_switches[STILILA::ENDING]
    
    if $game_switches[STILILA::ENDING] and @me.battle_sprite.tone != @original_tone
      @me.battle_sprite.tone.set(0,0,0) 
    end
    
    # 金手指
#    if @me.is_a?(Game_Actor) and $gold_finger
    #  @me.hp = @me.maxhp
   #   @me.sp = @me.maxsp
   #   @me.awake_time = 1200
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
    # 隨機出現閒置動作
    if @state == "stand" and @frame_number == 18 and @frame_duration == 1 and rand(3) == 1 and !$game_switches[STILILA::NO_IDLE]
     change_anime("stand_idle")
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
    
    # 血腥慾望起始
    if @state == "6x_start"
      $game_temp.black_time = [2, 50]
      $scene.camera_feature =  [2,30,30]
   #   if @anime_time == 3
   #     $game_temp.fps_change = 0
     #   Graphics.frame_rate = $fps_set
   #   end
      if @anime_time == 26
        change_anime("6x_start", 4)
      end
    end
    
    
    if @state == "6x" and (27..40) === @frame_number
      @me.now_x_speed = 4.8 * @me.direction
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
      if @me.is_a?(Game_BattleBullet) #and ["skill3_ball", "skill2_gun", "skill1_gun2", "skill1_gun"].include?(@state)
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
    can_lock = false if (target.is_a?(Game_Enemy) && STILILA::NO_LOCK_ENEMY.include?(target.id)) or (target.motion.state == "stone_egg")
    can_catch = false if (target.is_a?(Game_Enemy) && STILILA::NO_CATCH_ENEMY.include?(target.id)) or (target.motion.state == "stone_egg")
    
    can_lock = true if target.is_a?(Game_Enemy) && target.id == 31
    
    
    
    case action
    when "6x_start"  # 血腥慾望
      @super_armor = 0
      @me.now_x_speed /= 1.5
      if (!target.guarding? and target.motion.hit_invincible_duration <= 0  and target.motion.timely_guard_time <= 0) and can_lock# and ((2..3) === @frame_number and @state == "6s")
        do_catch(target)
        # 調整姿勢 / 雙方位置
        @catching_target.body_rect = @catching_target.stand_body_rect
        @catching_target.motion.now_jumps = @now_jumps
        @catching_target.y_pos = @me.y_pos
        @catching_target.direction = @me.direction * -1
        if @me.direction == 1
          @me.x_pos = @catching_target.x_pos - @catching_target.body_rect.width/2 - @me.stand_body_rect.width/2 # - @catching_target.body_rect.width/3
        else
          @me.x_pos = @catching_target.x_pos + @catching_target.body_rect.width/2 + @me.stand_body_rect.width/2 #+ @catching_target.body_rect.width/3
        end   
        @me.edge_spacing = @catching_target.body_rect.width/2 + @me.stand_body_rect.width/2#+ @catching_target.body_rect.width/3
        @me.now_x_speed = 0
        change_anime("6x", 0)
      end # unelss end
    when "j2x"
      Audio.se_play("Audio/SE/slash_se4", 95 * $game_config.se_rate / 10, 85) if !target.guarding?
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
        result["power"] = 50
        result["limit"] = 25
   #     result["scope"].delete("Blow") # 擊飛狀態打不到
        result["blow_type"] = "None" if !target.motion.on_air? # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 4
        result["t_hitstop"] = 4 
        result["correction"] = 3
        result["t_knockback"] = 24
        result["x_speed"] = 2    
        result["y_speed"] = 6.2 if target.motion.on_air?
        result["d_se"] = ["Audio/SE/impact_se", 88, 100]     
        result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]
        result["sp_recover"] = 3
      elsif skill == "5zz"
        result["power"] = 50
        result["limit"] = 25
     #   result["scope"].delete("Blow") # 擊飛狀態打不到
        result["blow_type"] = "None" if !target.motion.on_air? # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 4
        result["t_hitstop"] = 4 
        result["correction"] = 3
        if target.guarding?
          result["t_knockback"] = 20
        else
          result["t_knockback"] = 50
        end
        result["x_speed"] = 2    
        result["y_speed"] = 6.2 if target.motion.on_air?
        result["d_se"] = ["Audio/SE/impact_se", 88, 100]     
        result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]
        result["sp_recover"] = 4
      elsif skill == "5zzz"
        result["power"] = 45
        result["limit"] = 15
        result["u_hitstop"] = 6
        result["t_hitstop"] = 7                   
        result["t_knockback"] = 16
        result["x_speed"] = 5.9   
        result["y_speed"] = 7.9 
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]                      
        result["sp_recover"] = 2
        result["full_count"] = 2
        result["hit_slide"] = 11
      elsif skill == "6z"
        result["power"] = 65
        result["limit"] = 25
        result["u_hitstop"] = 10
        result["t_hitstop"] = 11        
        result["blow_type"] = "None" if !target.motion.damaging? # 擊中變受傷狀態，不擊飛
        result["t_knockback"] = 22
        result["x_speed"] = 2.9   
        if target.motion.on_air?
          result["y_speed"] = 6.2
        else
          result["y_speed"] = 7.3
        end

        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]                      
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 11
      elsif skill == "2z"
        result["power"] = 65
        result["limit"] = 2
        result["u_hitstop"] = 7
        result["t_hitstop"] = 9                
        result["t_knockback"] = 21      
        result["x_speed"] = 4.3   
        result["y_speed"] = 17.6    
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]               
        result["sp_recover"] = 3
        result["h_shake"] = [1,3,8,1]
        result["d_shake"] = [2,4,8,1]
        result["full_count"] = 2
        
      elsif skill == "dz2"
        result["power"] = 65
        result["limit"] = 30
        result["u_hitstop"] = 11
        result["t_hitstop"] = 14               
        result["t_knockback"] = 25      
        result["x_speed"] = 4.3   
        result["y_speed"] = 12.6    
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]               
        result["sp_recover"] = 3
        result["h_shake"] = [1,3,8,1]
        result["d_shake"] = [2,4,8,1]
        result["full_count"] = 2
        
      elsif skill == "jz"
        result["power"] = 65
        result["limit"] = 3
        result["u_hitstop"] = 4
        result["t_hitstop"] = 4                 
        result["t_knockback"] = 13  
        result["x_speed"] = 5.6  
        result["y_speed"] = 4          
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]    
        result["sp_recover"] = 3
      elsif skill == "j6z"
        result["power"] = 70
        result["limit"] = 15
        result["u_hitstop"] = 12
        result["t_hitstop"] = 14                 
        result["t_knockback"] = 16   
        result["x_speed"] = 7 
        result["y_speed"] = 10          
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]   
        result["sp_recover"] = 3
        result["full_count"] = 2
      elsif skill == "j2z"
        result["power"] = 90
        result["limit"] = 15
        result["u_hitstop"] = 10
        result["t_hitstop"] = 12                 
        result["t_knockback"] = 19   
        result["x_speed"] = 4 
        if target.motion.on_air?
          result["y_speed"] = -25.5
        else
          result["y_speed"] = 10.8
        end
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]   
        result["sp_recover"] = 3
        result["h_shake"] = [1,3,8,1]
        result["d_shake"] = [2,4,8,1]
        result["full_count"] = 2
      elsif skill == "ball"
        result["power"] = 65
        result["limit"] = 15
        result["u_hitstop"] = 0
        result["t_hitstop"] = 1       
        result["t_knockback"] = 11 + ((target.combohit == 0) ? 5 : 0)
        result["x_speed"] = 3           
        result["y_speed"] = 5 if target.motion.blowning?     
        result["d_se"] = ["Audio/SE/impact_se2", 76, 170]                 
        result["ko_se"] = ["Audio/SE/impact_se4", 80, 100]
        result["g_se"] = ["Audio/SE/guard_se3", 80, 110] 
        result["sp_recover"] = 3
        result["hit_slide"] = 0
      elsif skill == "ball2"
        result["power"] = 45
        result["limit"] = 10
        result["u_hitstop"] = 0
        result["t_hitstop"] = 15   
        result["t_knockback"] = 11 + ((target.combohit == 0) ? 5 : 0)
        result["x_speed"] = 3           
        result["y_speed"] = 6# if target.motion.blowning?     
        result["d_se"] = ["Audio/SE/impact_se2", 76, 170]                 
        result["ko_se"] = ["Audio/SE/impact_se4", 80, 100]
        result["g_se"] = ["Audio/SE/guard_se3", 80, 110] 
        result["sp_recover"] = 3
        result["hit_slide"] = 0


      elsif skill == "6x_start"#  and (@frame_number < 7)
        result["power"] = 120
        result["limit"] = 30
        result["u_hitstop"] = 6
        result["t_hitstop"] = 6                 
        result["t_knockback"] = 25    
        result["x_speed"] = 3
        result["y_speed"] = 0
        result["correction"] = 1
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 120]                 
        result["ko_se"] = ["Audio/SE/impact_se4", 80, 100]
        result["sp_recover"] = 5
        result["h_zoom"] =  [9,14,15]
        result["d_zoom"] =  [10,17,19]
        result["h_shake"] = [3,7,15,0]
        result["d_shake"] = [4,9,15,0]
        result["catch_release"] = false
        result["full_count"] = -1
        result["t_state"] = (rand(2) == 1 ? ["damage1",0] : ["damage2",0])
        result["hit_slide"] = 0
      elsif skill == "6x"  and ((0..40) === @frame_number)
        result["power"] = 18
        result["limit"] = 5
        result["u_hitstop"] = 1
        result["t_hitstop"] = 1                 
        result["t_knockback"] = 16    
        result["x_speed"] = 3.2
        result["y_speed"] = 0
        result["correction"] = 0
        result["d_se"] = ["Audio/SE/impact_se", 60, 100]                 
        result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]
        result["sp_recover"] = 0
        result["catch_release"] = false
        result["full_count"] = 0
        result["t_state"] = (rand(2) == 1 ? ["damage1",0] : ["damage2",0])
        result["hit_slide"] = 0
      elsif skill == "6x" and (@frame_number > 40)
        result["power"] = 250
        result["correction"] = 10
        result["limit"] = 180
        result["u_hitstop"] = 20
        result["t_hitstop"] = 7                 
        result["t_knockback"] = 35   
        result["x_speed"] = 13.5
        result["y_speed"] = 8.5
        result["blow_type"] = "H"
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se4", 80, 100]                
        result["sp_recover"] = 5
        result["h_zoom"] =  [5,20,21]
        result["d_zoom"] =  [5,22,22]
        result["h_shake"] = [7,11,26,0]
        result["d_shake"] = [7,11,26,0]
        result["full_count"] = 4
        result["hit_slide"] = 13
      elsif skill == "2x" and ((3..8) === @frame_number) 
        result["power"] = 60
        result["limit"] = 12
        result["u_hitstop"] = 2
        result["t_hitstop"] = 1
        result["correction"] = 1
        result["t_knockback"] = 35  
        result["x_speed"] = 0
        result["y_speed"] = 7.3
        result["d_se"] = ["Audio/SE/impact_se2", 80, 116]                 
        result["ko_se"] = ["Audio/SE/impact_se4", 80, 100]
        result["sp_recover"] = 0
        result["h_shake"] = [5,2,4,1]
        result["d_shake"] = [5,2,4,1]
        result["full_count"] = 0
      elsif skill == "2x" and (@frame_number == 2) 
        result["power"] = 90
        result["limit"] = 45
        result["correction"] = 0
        result["u_hitstop"] = 8
        result["t_hitstop"] = 7                 
        result["t_knockback"] = 30 
        result["x_speed"] = 0
        result["y_speed"] = 15.3
        result["d_se"] = ["Audio/SE/impact_se2", 80, 116]                 
        result["ko_se"] = ["Audio/SE/impact_se4", 80, 100]
        result["sp_recover"] = 3
        result["h_zoom"] =  [4,9,9]
        result["d_zoom"] =  [4,11,11]
        result["h_shake"] = [4,8,8,1]
        result["d_shake"] = [4,9,8,1]
        result["full_count"] = -1
      elsif skill == "2x" and (@frame_number == 9)
        result["power"] = 160
        result["limit"] = 135
        result["u_hitstop"] = 12
        result["t_hitstop"] = 12                 
        result["t_knockback"] = 29 
        result["x_speed"] = 8
        result["y_speed"] = 15.3
        result["d_se"] = ["Audio/SE/impact_se4", 80, 100]                
        result["ko_se"] = ["Audio/SE/impact_se4", 80, 100]
        result["sp_recover"] = 3
        result["h_zoom"] =  [12,30,30]
        result["d_zoom"] =  [12,30,30]
        result["h_shake"] = [4,7,25,1]
        result["d_shake"] = [5,8,25,1]
        result["full_count"] = 9
        result["blow_type"] = "H"
      elsif skill == "j6x" and (@frame_number == 2) 
        result["power"] = 60
        result["limit"] = 40
        result["u_hitstop"] = 4
        result["t_hitstop"] = 4                 
        result["t_knockback"] = 15 
        result["x_speed"] = 0
        result["y_speed"] = 0
        result["d_se"] = ["Audio/SE/impact_se2", 80, 116]                 
        result["ko_se"] = ["Audio/SE/impact_se4", 80, 100]
        result["sp_recover"] = 3
        result["catch_release"] = false
        result["full_count"] = -1
       elsif skill == "j6x" and ((4..16) === @frame_number) 
        result["power"] = 70
        result["limit"] = 47
        result["correction"] = 0
        result["u_hitstop"] = 0
        result["t_hitstop"] = 0                 
        result["t_knockback"] = 15 
        result["x_speed"] = 0
        result["y_speed"] = 0
        result["d_se"] = ["Audio/SE/impact_se2", 80, 116]                 
        result["ko_se"] = ["Audio/SE/impact_se4", 80, 100]
        result["sp_recover"] = 0
        result["catch_release"] = false
        result["full_count"] = 0
      elsif skill == "j6x" and (@frame_number == 20)
        result["power"] = 280
        result["correction"] = 10
        result["limit"] = 240
        result["u_hitstop"] = 1#12
        result["t_hitstop"] = 1#16                 
        result["t_knockback"] = 80 
        result["x_speed"] = 0
        result["y_speed"] = 11.8
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se4", 80, 100]                
        result["sp_recover"] = 5
        result["h_zoom"] =  [0,30,30]
        result["d_zoom"] =  [0,30,30]
        result["h_shake"] = [4,7,30,1]
        result["d_shake"] = [5,8,30,1]
        result["t_state"] = ["pressure_f_down", 0]
        result["down_type"] = "P"
        result["full_count"] = 4
        result["hit_slide"] = 0
      elsif skill == "big_ball"  
        result["power"] = 460
        result["imit"] = 220
        result["u_hitstop"] = 4
        result["t_hitstop"] = 4                
        result["t_knockback"] = 39 
        result["x_speed"] = 16.7
        result["y_speed"] = 9.9
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se4", 80, 100]                 
        result["sp_recover"] = 4
        result["h_shake"] = [6,4,20,0]
        result["d_shake"] = [6,4,20,0]
        result["full_count"] = 5
        result["blow_type"] = "H"
        result["hit_slide"] = 0
      elsif skill == "g6z"
        result["power"] = 60
        result["limit"] = 15 
        result["u_hitstop"] = 5
        result["t_hitstop"] = 5                   
        result["t_knockback"] = 13
        result["x_speed"] = 52.9   
        result["y_speed"] = 8
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]                      
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 11
      elsif skill == "j2x"
        result["power"] = 400
        result["limit"] = 320
        result["correction"] = 10
        result["u_hitstop"] = 30
        result["t_hitstop"] = 30                 
        result["t_knockback"] = 35   
        result["x_speed"] = 0
        if target.motion.on_air?
          result["y_speed"] = -28.5
        else
          result["y_speed"] = 15.8
        end
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se4", 80, 100]                
        result["sp_recover"] = 5
     #   result["h_zoom"] =  [5,20,21]
     #   result["d_zoom"] =  [5,22,22]
        result["h_shake"] = [7,11,26,1]
        result["d_shake"] = [7,11,26,1]
        result["full_count"] = 4
        result["hit_slide"] = 13
     # 獸化暴氣
      elsif skill == "awake"
        result["power"] = 0
        result["limit"] = 0
        result["u_hitstop"] = 8
        result["t_hitstop"] = 8      
        result["t_knockback"] = 22
        result["x_speed"] = 14.9   
        result["y_speed"] = 14.3
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]                      
        result["sp_recover"] = 0
        result["full_count"] = 2
        result["hit_slide"] = 0
        result["spark"] = [0, 5*rand(10), 9*(rand(6)+1)+30]
     
      elsif skill == "awake_boss"
        result["power"] = 0
        result["limit"] = 0
        result["u_hitstop"] = 8
        result["t_hitstop"] = 8      
        result["t_knockback"] = 22
        result["x_speed"] = 14.9   
        result["y_speed"] = 14.3
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]                      
        result["sp_recover"] = 0
        result["full_count"] = 2
        result["hit_slide"] = 0
        result["spark"] = [0, 5*rand(10), 9*(rand(6)+1)+30]
      else
      end #if end
      return result
  end #def end
end # class end
