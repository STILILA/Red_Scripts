#==============================================================================
# ■ 奶奶的Motion
#--------------------------------------------------------------------------
# ○ 使用圖片

#      61~65：虛弱
#      221~231：普攻1
#      241~253：普攻2
#      261~270：技能1
#      271~286：技能2
#      501~506：地柱
#      511~515：殞石
#==============================================================================
class Corals < Game_Motion
  
  
#--------------------------------------------------------------------------
# ○ 常量
#--------------------------------------------------------------------------

#--------------------------------------------------------------------------
# ○ 人物生成/初始化
#--------------------------------------------------------------------------
def initialize(me,frame=0,anime="stand")
  super
  
  
  # 宣告所有動畫
  @anime = {"stand" => [], "walk" => [], "dash" => [], "dash_break" => [], "story_stand" => [],
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

  "atk1" => [], "atk2" => [], "skill1" => [], "skill2" => [], "sp1" => [],
  "ball1" => [], "ball2" => [], "ball2_break" => [], "ball2_helper" => [],
  "thunder" => [], "thunder_helper" => [], "thunder_helper_root" => [], 
  "thunder2" => [], "thunder_helper2" => [],
  "skill2_waterpolo_up" => [], "skill2_waterpolo_mid" => [], "skill2_waterpolo_down" => [],

  "ball1B" => [], "ball1C" => [], 
  
  "magic_circleA" => [], 
  "magic_circleB" => [], "magic_circleC" => [], "sp_thunder" => [],
  
  "risk" => [], "stone_egg" => [], "egg_helper" => [], 
  "dizzy1" => [], "dizzy2" => [], "catched" => []}
  
  
  
  
  
  
  # 設定動作的影格
  frame_set
  

  # 超必殺記憶目標
  @sp1_target = nil
  
  
  # 石蛋閃爍顏色
  @egg_flash_color = Color.new(255,255,0)
  # 石蛋閃爍時間
  @egg_flash_time = 0
  # 石蛋閃爍時間(總共)
  @egg_flash_time_max = 0
  @full_limit = 11
  @atk_cd = 0

  
  
end

#==============================================================================
# ■影格設置
#==============================================================================

#--------------------------------------------------------------------------
# ○ 使用圖片
#--------------------------------------------------------------------------



def frame_set
#-------------------------------------------------------------------------------
# ○ 站立
#-------------------------------------------------------------------------------
@anime["stand"][0] = {"pic" => 1, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect, "z_pos" =>  1}
@anime["stand"][1] = {"pic" => 2, "wait" => 3, "next" => 2}
@anime["stand"][2] = {"pic" => 3, "wait" => 3, "next" => 3}
@anime["stand"][3] = {"pic" => 4, "wait" => 3, "next" => 4}
@anime["stand"][4] = {"pic" => 5, "wait" => 3, "next" => 5}
@anime["stand"][5] = {"pic" => 6, "wait" => 3, "next" => 6}
@anime["stand"][6] = {"pic" => 7, "wait" => 3, "next" => 7}
@anime["stand"][7] = {"pic" => 8, "wait" => 3, "next" => 8}
@anime["stand"][8] = {"pic" => 9, "wait" => 3, "next" => 9}
@anime["stand"][9] = {"pic" => 10, "wait" => 3, "next" => 10}
@anime["stand"][10] = {"pic" => 11, "wait" => 3, "next" => 11}
@anime["stand"][11] = {"pic" => 12, "wait" => 3, "next" => 12}
@anime["stand"][12] = {"pic" => 13, "wait" => 3, "next" => 13}
@anime["stand"][13] = {"pic" => 14, "wait" => 3, "next" => 14}
@anime["stand"][14] = {"pic" => 15, "wait" => 3, "next" => 15}
@anime["stand"][15] = {"pic" => 16, "wait" => 3, "next" => 16}
@anime["stand"][16] = {"pic" => 17, "wait" => 3, "next" => 17}
@anime["stand"][17] = {"pic" => 18, "wait" => 3, "next" => 18}
@anime["stand"][18] = {"pic" => 19, "wait" => 3, "next" => 19}
@anime["stand"][19] = {"pic" => 1, "wait" => 3, "next" => 1}

#-------------------------------------------------------------------------------
# ○ 劇情用站立
#-------------------------------------------------------------------------------
@anime["story_stand"][0] = {"pic" => 201, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect, "z_pos" =>  1}
@anime["story_stand"][1] = {"pic" => 202, "wait" => 3, "next" => 2}
@anime["story_stand"][2] = {"pic" => 203, "wait" => 3, "next" => 3}
@anime["story_stand"][3] = {"pic" => 204, "wait" => 3, "next" => 4}
@anime["story_stand"][4] = {"pic" => 205, "wait" => 3, "next" => 5}
@anime["story_stand"][5] = {"pic" => 206, "wait" => 3, "next" => 6}
@anime["story_stand"][6] = {"pic" => 207, "wait" => 3, "next" => 7}
@anime["story_stand"][7] = {"pic" => 208, "wait" => 3, "next" => 8}
@anime["story_stand"][8] = {"pic" => 209, "wait" => 3, "next" => 9}
@anime["story_stand"][9] = {"pic" => 210, "wait" => 3, "next" => 10}
@anime["story_stand"][10] = {"pic" => 211, "wait" => 3, "next" => 11}
@anime["story_stand"][11] = {"pic" => 212, "wait" => 3, "next" => 12}
@anime["story_stand"][12] = {"pic" => 213, "wait" => 3, "next" => 13}
@anime["story_stand"][13] = {"pic" => 214, "wait" => 3, "next" => 14}
@anime["story_stand"][14] = {"pic" => 215, "wait" => 3, "next" => 15}
@anime["story_stand"][15] = {"pic" => 216, "wait" => 3, "next" => 16}
@anime["story_stand"][16] = {"pic" => 217, "wait" => 3, "next" => 17}
@anime["story_stand"][17] = {"pic" => 218, "wait" => 3, "next" => 18}
@anime["story_stand"][18] = {"pic" => 219, "wait" => 3, "next" => 19}
@anime["story_stand"][19] = {"pic" => 201, "wait" => 3, "next" => 1}



# 測試用定義，要刪
#@anime["stand"][0] = {"pic" => 1, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect, "atk" => [@me.stand_body_rect], "z_pos" => -100, "penetrate" => true}


#-------------------------------------------------------------------------------
# ○ 走路
#-------------------------------------------------------------------------------
@anime["walk"][0] = {"pic" => 21, "wait" => 4, "next" => 1, "z_pos" =>  1}
@anime["walk"][1] = {"pic" => 22, "wait" => 4, "next" => 2}
@anime["walk"][2] = {"pic" => 23, "wait" => 4, "next" => 3}
@anime["walk"][3] = {"pic" => 24, "wait" => 4, "next" => 4}
@anime["walk"][4] = {"pic" => 25, "wait" => 4, "next" => 5}
@anime["walk"][5] = {"pic" => 26, "wait" => 4, "next" => 6}
@anime["walk"][6] = {"pic" => 27, "wait" => 4, "next" => 7}
@anime["walk"][7] = {"pic" => 28, "wait" => 4, "next" => 8}
@anime["walk"][8] = {"pic" => 29, "wait" => 4, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 跑步
#-------------------------------------------------------------------------------
@anime["dash"][0] = {"pic" => 25, "wait" => 26, "next" => 1, "x_speed" => 0, "ab_uncancel" => 24, "eva" => 35, "penetrate" => true, "y_fixed" => true}
@anime["dash"][1] = {"pic" => 26, "wait" => 3, "next" => 2}
@anime["dash"][2] = {"pic" => 27, "wait" => 3, "next" => 3}
@anime["dash"][3] = {"pic" => 28, "wait" => 3, "next" => ["stand"], "var_reset" => true, "y_fixed" => false}

@anime["dash_break"][0] = {"pic" => 23, "wait" => 6, "next" => ["stand"], "anime" => [12,0,0], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 跳躍  / 落下
#-------------------------------------------------------------------------------
@anime["jump"][0] = {"pic" => 26, "wait" => 3, "next" => 1, "ab_uncancel" => 5, "y_fixed" => true}
@anime["jump"][1] = {"pic" => 27, "wait" => 1, "next" => 2, "anime" => [12,0,0], "var_reset" => true}
@anime["jump"][2] = {"pic" => 31, "wait" => 9, "next" => ["jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity}
@anime["jump_fall"][0] = {"pic" => 36, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 前跳躍  / 落下
#-------------------------------------------------------------------------------
@anime["f_jump"][0] = {"pic" => 26, "wait" => 3, "next" => 1, "ab_uncancel" => 5, "y_fixed" => true}
@anime["f_jump"][1] = {"pic" => 27, "wait" => 1, "next" => 2, "anime" => [12,0,0], "var_reset" => true}
@anime["f_jump"][2] = {"pic" => 31, "wait" => 9, "next" => ["f_jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity, "x_speed" => @me.walk_x_speed}
@anime["f_jump_fall"][0] = {"pic" => 36, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 二段跳 / 落下
#-------------------------------------------------------------------------------
@anime["double_jump"][0] = {"pic" => 26, "wait" => 3, "next" => 1, "y_fixed" => true, "ab_uncancel" => 5}
@anime["double_jump"][1] = {"pic" => 27, "wait" => 0, "next" => 2}
@anime["double_jump"][2] = {"pic" => 31, "wait" => 3, "next" => ["double_jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity}
@anime["double_jump_fall"][0] = {"pic" => 36, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 大跳 / 落下
#-------------------------------------------------------------------------------
@anime["h_jump"][0] = {"pic" => 26, "wait" => 5, "next" => 1, "blur" => true, "x_speed" => 0, "ab_uncancel" => 8, "y_fixed" => true}
@anime["h_jump"][1] = {"pic" => 27, "wait" => 1, "next" => 2}
@anime["h_jump"][2] = {"pic" => 31, "wait" => 5, "next" => 3, "x_speed" => (@me.dash_x_speed/1.5), "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity + 1.4}
@anime["h_jump"][3] = {"pic" => 31, "wait" => 3, "next" => ["h_jump_fall"]}
@anime["h_jump_fall"][0] = {"pic" => 31, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 前大跳  / 落下
#-------------------------------------------------------------------------------
@anime["hf_jump"][0] = {"pic" => 27, "wait" => 1, "next" => 1, "ab_uncancel" => 2, "y_fixed" => true}
@anime["hf_jump"][1] = {"pic" => 41, "wait" => 9, "next" => ["hf_jump_fall"], "y_fixed" => false, "y_speed" => @me.jump_y_init_velocity - 5.5, "x_speed" => @me.dash_x_speed * 1.5}
@anime["hf_jump_fall"][0] = {"pic" => 46, "wait" => -1, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 著地
#-------------------------------------------------------------------------------
@anime["landing"][0] = {"pic" => 26, "wait" => 1, "next" => 1, "anime" => [12,0,0], "ab_uncancel" => 2}
@anime["landing"][1] = {"pic" => 26, "wait" => 2, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 蹲下 / 起來
#-------------------------------------------------------------------------------
@anime["crouch_start"][0] = {"pic" => 26, "wait" => 1, "next" => ["crouch"]}
@anime["crouch"][0] = {"pic" => 26, "wait" => -1, "next" => 0}
@anime["crouch_end"][0] = {"pic" => 26, "wait" => 1, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 防禦/硬直
#-------------------------------------------------------------------------------
@anime["guard"][0] = {"pic" => 81, "wait" => 2, "next" => 0, "var_reset" => true}
@anime["guard_shock"][0] = {"pic" => 86, "wait" => -1, "next" => 0}

#-------------------------------------------------------------------------------
# ○ 受傷1
#-------------------------------------------------------------------------------
@anime["damage1"][0] = {"pic" => 32, "wait" => 3, "next" => 1}
@anime["damage1"][1] = {"pic" => 33, "wait" => 3, "next" => 2}
@anime["damage1"][2] = {"pic" => 34, "wait" => -1, "next" => 2}

#-------------------------------------------------------------------------------
# ○ 受傷2
#-------------------------------------------------------------------------------
@anime["damage2"][0] = {"pic" => 32, "wait" => 3, "next" => 1}
@anime["damage2"][1] = {"pic" => 33, "wait" => 3, "next" => 2}
@anime["damage2"][2] = {"pic" => 34, "wait" => -1, "next" => 2}

#-------------------------------------------------------------------------------
# ○ 正面擊飛
#-------------------------------------------------------------------------------
@anime["f_blow"][0] = {"pic" => 34, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect}
@anime["f_blow"][1] = {"pic" => 301, "wait" => 3, "next" => 2}
@anime["f_blow"][2] = {"pic" => 302, "wait" => 3, "next" => 3}
@anime["f_blow"][3] = {"pic" => 303, "wait" => 3, "next" => 4}
@anime["f_blow"][4] = {"pic" => 304, "wait" => -1, "next" => 4}
#-------------------------------------------------------------------------------
# ○ 背面擊飛
#-------------------------------------------------------------------------------
@anime["b_blow"][0] = {"pic" => 301, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect}
@anime["b_blow"][1] = {"pic" => 311, "wait" => 3, "next" => 2}
@anime["b_blow"][2] = {"pic" => 312, "wait" => 3, "next" => 3}
@anime["b_blow"][3] = {"pic" => 313, "wait" => 3, "next" => 4}
@anime["b_blow"][4] = {"pic" => 314, "wait" => -1, "next" => 4}
#-------------------------------------------------------------------------------
# ○ 正面擊飛(重)
#-------------------------------------------------------------------------------
@anime["hf_blow"][0] = {"pic" => 34, "wait" => 2, "next" => 1, "body" => @me.stand_body_rect}
@anime["hf_blow"][1] = {"pic" => 301, "wait" => 3, "next" => 2}
@anime["hf_blow"][2] = {"pic" => 302, "wait" => 3, "next" => 3}
@anime["hf_blow"][3] = {"pic" => 303, "wait" => 3, "next" => 4}
@anime["hf_blow"][4] = {"pic" => 304, "wait" => -1, "next" => 4}
#-------------------------------------------------------------------------------
# ○ 背面擊飛(重)
#-------------------------------------------------------------------------------
@anime["hb_blow"][0] = {"pic" => 301, "wait" => 2, "next" => 1, "body" => @me.stand_body_rect}
@anime["hb_blow"][1] = {"pic" => 311, "wait" => 3, "next" => 2}
@anime["hb_blow"][2] = {"pic" => 312, "wait" => 3, "next" => 3}
@anime["hb_blow"][3] = {"pic" => 313, "wait" => 3, "next" => 4}
@anime["hb_blow"][4] = {"pic" => 314, "wait" => -1, "next" => 4}

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
@anime["f_down"][0] = {"pic" => 305, "wait" => -1, "next" => 0, "ab_uncancel" => 22, "body" => @me.down_body_rect}
@anime["f_down_stand"][0] = {"pic" => 65, "wait" => 6, "next" => ["stand"], "ab_uncancel" => 8, "var_reset" => true, "body" => @me.sit_body_rect, "eva" => 10}
@anime["bounce_f_down"][0] = {"pic" => 306, "wait" => -1, "next" => 0, "body" => @me.down_body_rect}  # 反彈
#-------------------------------------------------------------------------------
# ○ 倒地－－面朝下/反彈/起身
#-------------------------------------------------------------------------------
@anime["b_down"][0] = {"pic" => 315, "wait" => -1, "next" => 0, "ab_uncancel" => 22, "body" => @me.down_body_rect}
@anime["b_down_stand"][0] = {"pic" => 65, "wait" => 6, "next" => ["stand"], "ab_uncancel" => 8, "var_reset" => true, "body" => @me.sit_body_rect, "eva" => 10}
@anime["bounce_b_down"][0] = {"pic" => 316, "wait" => -1, "next" => 0, "body" => @me.down_body_rect} # 反彈


#-------------------------------------------------------------------------------
# ○ 倒地－－壓制攻擊
#-------------------------------------------------------------------------------
@anime["pressure_f_down"][0] = {"pic" => 122, "wait" => 3, "next" => 0, "ab_uncancel" => 14, "body" => @me.down_body_rect}
@anime["pressure_b_down"][0] = {"pic" => 124, "wait" => 3, "next" => 0, "ab_uncancel" => 14, "body" => @me.down_body_rect}

#-------------------------------------------------------------------------------
# ○ 受身
#-------------------------------------------------------------------------------
@anime["ukemi"][0] = {"pic" => 25, "wait" => 7, "next" => ["dash"]}


#-------------------------------------------------------------------------------
# ○ 被捉的動作
#-------------------------------------------------------------------------------
# 肚子痛
@anime["dizzy1"][0] = {"pic" => 91, "wait" => 3, "next" => 1}
@anime["dizzy1"][1] = {"pic" => 92, "wait" => 3, "next" => 0}
@anime["dizzy2"][0] = {"pic" => 101, "wait" => 3, "next" => 1}
@anime["dizzy2"][1] = {"pic" => 102, "wait" => 3, "next" => 0}

@anime["catched"][0] = {"pic" => 91, "wait" => -1, "next" => 0} 
@anime["catched"][1] = {"pic" => 101, "wait" => -1, "next" => 1} 
@anime["catched"][2] = {"pic" => 111, "wait" => -1, "next" => 2}
@anime["catched"][3] = {"pic" => 112, "wait" => -1, "next" => 3} 
@anime["catched"][4] = {"pic" => 113, "wait" => -1, "next" => 4}
@anime["catched"][5] = {"pic" => 114, "wait" => -1, "next" => 5} 
@anime["catched"][6] = {"pic" => 115, "wait" => -1, "next" => 6}  
@anime["catched"][7] = {"pic" => 116, "wait" => -1, "next" => 7} 
@anime["catched"][8] = {"pic" => 117, "wait" => -1, "next" => 8}  
@anime["catched"][9] = {"pic" => 118, "wait" => -1, "next" => 9} 
@anime["catched"][10] = {"pic" => 119, "wait" => -1, "next" => 10} 
@anime["catched"][11] = {"pic" => 121, "wait" => -1, "next" => 11} 
@anime["catched"][12] = {"pic" => 122, "wait" => -1, "next" => 12}  





#-------------------------------------------------------------------------------
# ○ 前迴避
#-------------------------------------------------------------------------------
@anime["f_flee"][0] = {"pic" => 41, "wait" => 4, "next" => 1, "x_speed" => 0, "ab_uncancel" => 8, "blur" => true, "eva" => 18, "penetrate" => true, "y_fixed" => true}
@anime["f_flee"][1] = {"pic" => 42, "wait" => 3, "next" => 2, "x_speed" => (@me.dash_x_speed*1.8)}
@anime["f_flee"][2] = {"pic" => 43, "wait" => 3, "next" => 3}
@anime["f_flee"][3] = {"pic" => 44, "wait" => 3, "next" => ["stand"], "var_reset" => true, "penetrate" => false, "y_fixed" => false}
#-------------------------------------------------------------------------------
# ○ 後迴避
#-------------------------------------------------------------------------------
@anime["b_flee"][0] = {"pic" => 41, "wait" => 4, "next" => 1, "x_speed" => 0, "ab_uncancel" => 8, "blur" => true, "eva" => 18, "penetrate" => true, "y_fixed" => true}
@anime["b_flee"][1] = {"pic" => 42, "wait" => 3, "next" => 2, "x_speed" => (@me.dash_x_speed*-3.2)}
@anime["b_flee"][2] = {"pic" => 43, "wait" => 3, "next" => 3}
@anime["b_flee"][3] = {"pic" => 44, "wait" => 3, "next" => ["stand"], "var_reset" => true, "penetrate" => false, "y_fixed" => false}
#-------------------------------------------------------------------------------
# ○ 空突進
#-------------------------------------------------------------------------------
@anime["af_flee"][0] = {"pic" => 27, "wait" => 3, "next" => 1, "ab_uncancel" => 6, "eva" => 13, "y_fixed" => true, "penetrate" => true, "y_fixed" => true}
@anime["af_flee"][1] = {"pic" => 41, "wait" => 1, "next" => 2, "y_fixed" => false, "x_speed" => 10.9, "y_speed" => 7.9, "blur" => true}
@anime["af_flee"][2] = {"pic" => 41, "wait" => 12, "next" => 3}
@anime["af_flee"][3] = {"pic" => 46, "wait" => -1, "next" => 3, "penetrate" => false, "y_fixed" => false}
#-------------------------------------------------------------------------------
# ○ 空迴避
#-------------------------------------------------------------------------------
@anime["ab_flee"][0] = {"pic" => 27, "wait" => 5, "next" => 1, "y_fixed" => true, "ab_uncancel" => 6, "eva" => 13, "penetrate" => true, "y_fixed" => true}
@anime["ab_flee"][1] = {"pic" => 51, "wait" => 1, "next" => 2, "y_fixed" => false, "x_speed" => -10.9, "y_speed" => 7.9, "blur" => true, "eva" => 11}
@anime["ab_flee"][2] = {"pic" => 51, "wait" => 12, "next" => 3}
@anime["ab_flee"][3] = {"pic" => 56, "wait" => -1, "next" => 3, "penetrate" => false, "y_fixed" => false}
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
# ○ 地柱術
#-------------------------------------------------------------------------------
@anime["atk1"][0] = {"pic" => 221, "wait" => 2, "next" => 1, "ab_uncancel" => 16, "uncancel" => true, "z_pos" => 3, "se"=> ["108-Heal04", 90, 50], "y_fixed" => true}
@anime["atk1"][1] = {"pic" => 222, "wait" => 2, "next" => 2}
@anime["atk1"][2] = {"pic" => 223, "wait" => 2, "next" => 3}
@anime["atk1"][3] = {"pic" => 224, "wait" => 10, "next" => 4}
@anime["atk1"][4] = {"pic" => 227, "wait" => 3, "next" => 5, "se"=> ["swing2", 96, 100], "bullet" => [@me, "ball1", 0, 0, 0, false, true]}
@anime["atk1"][5] = {"pic" => 228, "wait" => 3, "next" => 6}
@anime["atk1"][6] = {"pic" => 229, "wait" => 4, "next" => 7}
@anime["atk1"][7] = {"pic" => 230, "wait" => 4, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 殞石術
#-------------------------------------------------------------------------------
@anime["atk2"][0] = {"pic" => 241, "wait" => 2, "next" => 1, "ab_uncancel" => 16, "uncancel" => true, "z_pos" => 3, "se"=> ["108-Heal04", 90, 50], "y_fixed" => true}
@anime["atk2"][1] = {"pic" => 242, "wait" => 2, "next" => 2}
@anime["atk2"][2] = {"pic" => 243, "wait" => 2, "next" => 3}
@anime["atk2"][3] = {"pic" => 244, "wait" => 2, "next" => 4}
@anime["atk2"][4] = {"pic" => 245, "wait" => 2, "next" => 5}
@anime["atk2"][5] = {"pic" => 246, "wait" => 2, "next" => 6}
@anime["atk2"][6] = {"pic" => 247, "wait" => 7, "next" => 7}
@anime["atk2"][7] = {"pic" => 249, "wait" => 3, "next" => 8, "se"=> ["swing2", 96, 100], "bullet" => [@me, "ball2_helper", 0, 109, 443, false, true]}
@anime["atk2"][8] = {"pic" => 249, "wait" => 3, "next" => 9}
@anime["atk2"][9] = {"pic" => 249, "wait" => 3, "next" => 10}
@anime["atk2"][10] = {"pic" => 250, "wait" => 3, "next" => 11}
@anime["atk2"][11] = {"pic" => 251, "wait" => 9, "next" => 12}
@anime["atk2"][12] = {"pic" => 252, "wait" => 3, "next" => ["stand"], "var_reset" => true}


#-------------------------------------------------------------------------------
# ○ 雷擊術
#-------------------------------------------------------------------------------
@anime["skill1"][0] = {"pic" => 272, "wait" => 3, "next" => 1, "ab_uncancel" => 36, "uncancel" => true, "z_pos" => 3, "se"=> ["108-Heal04", 90, 50], "y_fixed" => true}
@anime["skill1"][1] = {"pic" => 273, "wait" => 3, "next" => 2}
@anime["skill1"][2] = {"pic" => 274, "wait" => 3, "next" => 3}
@anime["skill1"][3] = {"pic" => 275, "wait" => 3, "next" => 4}
@anime["skill1"][4] = {"pic" => 276, "wait" => 3, "next" => 5}
@anime["skill1"][5] = {"pic" => 277, "wait" => 3, "next" => 6}
@anime["skill1"][6] = {"pic" => 278, "wait" => 3, "next" => 7}
@anime["skill1"][7] = {"pic" => 279, "wait" => 10, "next" => 9}
@anime["skill1"][8] = {"pic" => 280, "wait" => 2, "next" => 9}
#@anime["skill1"][9] = {"pic" => 281, "wait" => 3, "next" => 10, "se"=> ["swing2", 96, 100]}
@anime["skill1"][9] = {"pic" => 281, "wait" => 3, "next" => 10, "se"=> ["swing2", 96, 100], "bullet" => [@me, "thunder_helper_root", 0, 0, 0, false, true]}
@anime["skill1"][10] = {"pic" => 282, "wait" => 3, "next" => 11}
@anime["skill1"][11] = {"pic" => 281, "wait" => 3, "next" => 12}
@anime["skill1"][12] = {"pic" => 282, "wait" => 3, "next" => 13}
@anime["skill1"][13] = {"pic" => 281, "wait" => 3, "next" => 14}
@anime["skill1"][14] = {"pic" => 284, "wait" => 3, "next" => 15}
@anime["skill1"][15] = {"pic" => 285, "wait" => 3, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 水球術
#-------------------------------------------------------------------------------
@anime["skill2"][0] = {"pic" => 262, "wait" => 4, "next" => 1, "ab_uncancel" => 16, "uncancel" => true, "z_pos" => 3, "se"=> ["108-Heal04", 90, 50], "bullet" => [@me, "magic_circleA", 0, 50, 0, false, true]}
@anime["skill2"][1] = {"pic" => 263, "wait" => 4, "next" => 2}
@anime["skill2"][2] = {"pic" => 264, "wait" => 4, "next" => 3}
@anime["skill2"][3] = {"pic" => 265, "wait" => 4, "next" => 4}
@anime["skill2"][4] = {"pic" => 265, "wait" => 12, "next" => 5}
@anime["skill2"][5] = {"pic" => 266, "wait" => 4, "next" => 6}
@anime["skill2"][6] = {"pic" => 267, "wait" => 4, "next" => 7}
@anime["skill2"][7] = {"pic" => 268, "wait" => 4, "next" => 8}
@anime["skill2"][8] = {"pic" => 269, "wait" => 6, "next" => ["stand"], "var_reset" => true}


#-------------------------------------------------------------------------------
# ○ 地柱本體
#-------------------------------------------------------------------------------
@anime["ball1"][0] = {"pic" => 501, "wait" => 40, "next" => 1, "z_pos" => 3, "se"=> ["Earth10", 86, 90]}
@anime["ball1"][1] = {"pic" => 502, "wait" => 3, "next" => 2}
@anime["ball1"][2] = {"pic" => 503, "wait" => 3, "next" => 3, "atk" => [Rect.new(-70, -100, 230, 90)], "se"=> ["Earth5", 86, 90]}
@anime["ball1"][3] = {"pic" => 504, "wait" => 3, "next" => 4}
@anime["ball1"][4] = {"pic" => 505, "wait" => 20, "next" => 5, "atk" => 0}
@anime["ball1"][5] = {"pic" => 506, "wait" => 3, "next" => ["dispose"]}


#-------------------------------------------------------------------------------
# ○ 地柱本體(蛋左)
#-------------------------------------------------------------------------------
@anime["ball1B"][0] = {"pic" => 501, "wait" => 40, "next" => 1, "z_pos" => 3, "se"=> ["Earth10", 86, 90]}
@anime["ball1B"][1] = {"pic" => 502, "wait" => 3, "next" => 2}
@anime["ball1B"][2] = {"pic" => 503, "wait" => 3, "next" => 3, "atk" => [Rect.new(-70, -100, 230, 90)], "se"=> ["Earth5", 86, 90]}
@anime["ball1B"][3] = {"pic" => 504, "wait" => 3, "next" => 4}
@anime["ball1B"][4] = {"pic" => 505, "wait" => 20, "next" => 5, "atk" => 0}
@anime["ball1B"][5] = {"pic" => 506, "wait" => 3, "next" => ["dispose"]}
#-------------------------------------------------------------------------------
# ○ 地柱本體(蛋佑)
#-------------------------------------------------------------------------------
@anime["ball1C"][0] = {"pic" => 501, "wait" => 40, "next" => 1, "z_pos" => 3, "se"=> ["Earth10", 86, 90]}
@anime["ball1C"][1] = {"pic" => 502, "wait" => 3, "next" => 2}
@anime["ball1C"][2] = {"pic" => 503, "wait" => 3, "next" => 3, "atk" => [Rect.new(-70, -100, 230, 90)], "se"=> ["Earth5", 86, 90]}
@anime["ball1C"][3] = {"pic" => 504, "wait" => 3, "next" => 4}
@anime["ball1C"][4] = {"pic" => 505, "wait" => 20, "next" => 5, "atk" => 0}
@anime["ball1C"][5] = {"pic" => 506, "wait" => 3, "next" => ["dispose"]}

#-------------------------------------------------------------------------------
# ○ 殞石發射器
#-------------------------------------------------------------------------------
@anime["ball2_helper"][0] = {"pic" => 999, "wait" => 122, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 殞石本體
#-------------------------------------------------------------------------------
@anime["ball2"][0] = {"pic" => 511, "wait" => 3, "next" => 1, "z_pos" => 3, "x_speed" => 17, "y_speed"=> -25}
@anime["ball2"][1] = {"pic" => 512, "wait" => 3, "next" => 0, "x_speed" => 17, "y_speed"=> -25}
#-------------------------------------------------------------------------------
# ○ 殞石著地
#-------------------------------------------------------------------------------
@anime["ball2_break"][0] = {"pic" => 513, "wait" => 1, "next" => 1, "se"=> ["shoot3", 70, 90]}
@anime["ball2_break"][1] = {"pic" => 513, "wait" => 2, "next" => 2, "atk" => [Rect.new(-70, -80, 120, 79)]}
@anime["ball2_break"][2] = {"pic" => 514, "wait" => 3, "next" => 3, "atk" => 0}
@anime["ball2_break"][3] = {"pic" => 515, "wait" => 3, "next" => 4}
@anime["ball2_break"][4] = {"pic" => 516, "wait" => 10, "next" => ["dispose"]} 


#-------------------------------------------------------------------------------
# ○ 閃電發射器
#-------------------------------------------------------------------------------
@anime["thunder_helper"][0] = {"pic" => 538, "wait" => 122, "next" => ["dispose"], "z_pos" => -1}

#-------------------------------------------------------------------------------
# ○ 閃電發射器(母體)
#-------------------------------------------------------------------------------
@anime["thunder_helper_root"][0] = {"pic" => 0, "wait" => 100, "next" => ["dispose"], "z_pos" => -1}



#-------------------------------------------------------------------------------
# ○ 閃電
#-------------------------------------------------------------------------------
@anime["thunder"][0] = {"pic" => 531, "wait" => 3, "next" => 1, "z_pos" => 3, "se"=> ["123-Thunder01", 86, 90]}
@anime["thunder"][1] = {"pic" => 532, "wait" => 3, "next" => 2}
@anime["thunder"][2] = {"pic" => 0, "wait" => 30, "next" => 3}
@anime["thunder"][3] = {"pic" => 532, "wait" => 3, "next" => 4}
@anime["thunder"][4] = {"pic" => 533, "wait" => 2, "next" => 5, "se"=> ["124-Thunder02", 86, 90]}
@anime["thunder"][5] = {"pic" => 534, "wait" => 2, "next" => 6, "atk" => [Rect.new(-75, -520, 150, 520)]}
@anime["thunder"][6] = {"pic" => 535, "wait" => 2, "next" => 7}
@anime["thunder"][7] = {"pic" => 536, "wait" => 2, "next" => 8}
@anime["thunder"][8] = {"pic" => 535, "wait" => 2, "next" => 9}
@anime["thunder"][9] = {"pic" => 0, "wait" => 8, "next" => 10, "atk" => 0}
@anime["thunder"][10] = {"pic" => 532, "wait" => 3, "next" => 11}
@anime["thunder"][11] = {"pic" => 531, "wait" => 3, "next" => 12}
@anime["thunder"][12] = {"pic" => 0, "wait" => 3, "next" => ["dispose"]}


#-------------------------------------------------------------------------------
# ○ 閃電發射器2
#-------------------------------------------------------------------------------
@anime["thunder_helper2"][0] = {"pic" => 538, "wait" => 122, "next" => ["dispose"], "z_pos" => -1}

#-------------------------------------------------------------------------------
# ○ 閃電2
#-------------------------------------------------------------------------------
@anime["thunder2"][0] = {"pic" => 531, "wait" => 3, "next" => 1, "z_pos" => 3}
@anime["thunder2"][1] = {"pic" => 532, "wait" => 3, "next" => 2}
@anime["thunder2"][2] = {"pic" => 0, "wait" => 30, "next" => 3}
@anime["thunder2"][3] = {"pic" => 532, "wait" => 3, "next" => 4}
@anime["thunder2"][4] = {"pic" => 533, "wait" => 2, "next" => 5}
@anime["thunder2"][5] = {"pic" => 534, "wait" => 2, "next" => 6, "atk" => [Rect.new(-75, -520, 150, 520)]}
@anime["thunder2"][6] = {"pic" => 535, "wait" => 2, "next" => 7}
@anime["thunder2"][7] = {"pic" => 536, "wait" => 2, "next" => 8}
@anime["thunder2"][8] = {"pic" => 535, "wait" => 2, "next" => 9}
@anime["thunder2"][9] = {"pic" => 0, "wait" => 8, "next" => 10, "atk" => 0}
@anime["thunder2"][10] = {"pic" => 533, "wait" => 2, "next" => 11}
@anime["thunder2"][11] = {"pic" => 531, "wait" => 3, "next" => 12}
@anime["thunder2"][12] = {"pic" => 0, "wait" => 3, "next" => ["dispose"]}



#-------------------------------------------------------------------------------
# ○ 水球上
#-------------------------------------------------------------------------------
@anime["skill2_waterpolo_up"][0] = {"pic" => 563, "wait" => 2, "next" => 1, "z_pos" => 3}
@anime["skill2_waterpolo_up"][1] = {"pic" => 564, "wait" => 2, "next" => 2, "x_speed" => 18}
@anime["skill2_waterpolo_up"][2] = {"pic" => 565, "wait" => 2, "next" => 3, "atk" => [Rect.new(0, -40, 52, 40)]}
@anime["skill2_waterpolo_up"][3] = {"pic" => 551, "wait" => 2, "next" => 4}
@anime["skill2_waterpolo_up"][4] = {"pic" => 552, "wait" => 2, "next" => 5}
@anime["skill2_waterpolo_up"][5] = {"pic" => 553, "wait" => 2, "next" => 6, "atk" => 0}
@anime["skill2_waterpolo_up"][6] = {"pic" => 554, "wait" => 2, "next" =>  ["dispose"]}
#-------------------------------------------------------------------------------
# ○ 水球中
#-------------------------------------------------------------------------------
@anime["skill2_waterpolo_mid"][0] = {"pic" => 563, "wait" => 2, "next" => 1, "z_pos" => 3}
@anime["skill2_waterpolo_mid"][1] = {"pic" => 564, "wait" => 2, "next" => 2, "x_speed" => 18}
@anime["skill2_waterpolo_mid"][2] = {"pic" => 565, "wait" => 2, "next" => 3, "atk" => [Rect.new(0, -40, 52, 40)]}
@anime["skill2_waterpolo_mid"][3] = {"pic" => 559, "wait" => 2, "next" => 4}
@anime["skill2_waterpolo_mid"][4] = {"pic" => 560, "wait" => 2, "next" => 5}
@anime["skill2_waterpolo_mid"][5] = {"pic" => 561, "wait" => 2, "next" => 6, "atk" => 0}
@anime["skill2_waterpolo_mid"][6] = {"pic" => 562, "wait" => 2, "next" =>  ["dispose"]}
#-------------------------------------------------------------------------------
# ○ 水球下
#-------------------------------------------------------------------------------
@anime["skill2_waterpolo_down"][0] = {"pic" => 563, "wait" => 2, "next" => 1, "z_pos" => 3}
@anime["skill2_waterpolo_down"][1] = {"pic" => 564, "wait" => 2, "next" => 2, "x_speed" => 18}
@anime["skill2_waterpolo_down"][2] = {"pic" => 565, "wait" => 2, "next" => 3, "atk" => [Rect.new(0, -40, 52, 40)]}
@anime["skill2_waterpolo_down"][3] = {"pic" => 555, "wait" => 2, "next" => 4}
@anime["skill2_waterpolo_down"][4] = {"pic" => 556, "wait" => 2, "next" => 5}
@anime["skill2_waterpolo_down"][5] = {"pic" => 557, "wait" => 2, "next" => 6, "atk" => 0}
@anime["skill2_waterpolo_down"][6] = {"pic" => 558, "wait" => 2, "next" =>  ["dispose"]}

#-------------------------------------------------------------------------------
# ○ 魔法陣縱
#-------------------------------------------------------------------------------
@anime["magic_circleA"][0] = {"pic" => 542, "wait" => 3, "next" => 1, "z_pos" => 3}
@anime["magic_circleA"][1] = {"pic" => 543, "wait" => 3, "next" => 2}
@anime["magic_circleA"][2] = {"pic" => 544, "wait" => 3, "next" => 3}
@anime["magic_circleA"][3] = {"pic" => 545, "wait" => 3, "next" => 4}
@anime["magic_circleA"][4] = {"pic" => 546, "wait" => 3, "next" => 5}
@anime["magic_circleA"][5] = {"pic" => 547, "wait" => 3, "next" => 0}




#-------------------------------------------------------------------------------
# ○ 超必殺
#-------------------------------------------------------------------------------
@anime["sp1"][0] = {"pic" => 262, "wait" => 4, "next" => 1, "ab_uncancel" => 80, "uncancel" => true, "z_pos" => 3, "anime" => [1,0,0], "superstop" => 22, "camera" => [48,30,30], "black" => [48,50], "fps" => [23, 55], "eva" => 10}
@anime["sp1"][1] = {"pic" => 263, "wait" => 4, "next" => 2, "se"=> ["108-Heal04", 90, 50], "bullet" => [@me, "magic_circleA", 0, 100, 0, false, true]}
@anime["sp1"][2] = {"pic" => 264, "wait" => 4, "next" => 3, "atk" => [Rect.new(10, -220, 145, 200)]}
@anime["sp1"][3] = {"pic" => 265, "wait" => 4, "next" => 4}
@anime["sp1"][4] = {"pic" => 265, "wait" => 12, "next" => 5}
@anime["sp1"][5] = {"pic" => 266, "wait" => 4, "next" => 6, "atk" => 0}
@anime["sp1"][6] = {"pic" => 267, "wait" => 4, "next" => 7}
@anime["sp1"][7] = {"pic" => 268, "wait" => 4, "next" => 8}
@anime["sp1"][8] = {"pic" => 269, "wait" => 6, "next" => ["stand"], "var_reset" => true}

# 命中
@anime["sp1"][9] = {"pic" => 265, "wait" => 4, "next" => 10, "ab_uncancel" => 80}
@anime["sp1"][10] = {"pic" => 266, "wait" => 4, "next" => 11}
@anime["sp1"][11] = {"pic" => 267, "wait" => 4, "next" => 12}
@anime["sp1"][12] = {"pic" => 268, "wait" => 4, "next" => 13}
@anime["sp1"][13] = {"pic" => 269, "wait" => 6, "next" => 14}

# 看主角被扁
@anime["sp1"][14] = {"pic" => 1, "wait" => 3, "next" => 15, "ab_uncancel" => 80}
@anime["sp1"][15] = {"pic" => 2, "wait" => 3, "next" => 16}
@anime["sp1"][16] = {"pic" => 3, "wait" => 3, "next" => 17}
@anime["sp1"][17] = {"pic" => 4, "wait" => 3, "next" => 18}
@anime["sp1"][18] = {"pic" => 5, "wait" => 3, "next" => 19}
@anime["sp1"][19] = {"pic" => 6, "wait" => 3, "next" => 20}
@anime["sp1"][20] = {"pic" => 7, "wait" => 3, "next" => 21}
@anime["sp1"][21] = {"pic" => 8, "wait" => 3, "next" => 22}
@anime["sp1"][22] = {"pic" => 9, "wait" => 3, "next" => 23}
@anime["sp1"][23] = {"pic" => 10, "wait" => 3, "next" => 24}
@anime["sp1"][24] = {"pic" => 11, "wait" => 3, "next" => 25}
@anime["sp1"][25] = {"pic" => 12, "wait" => 3, "next" => 26}
@anime["sp1"][26] = {"pic" => 13, "wait" => 3, "next" => 27}
@anime["sp1"][27] = {"pic" => 14, "wait" => 3, "next" => 28}
@anime["sp1"][28] = {"pic" => 15, "wait" => 3, "next" => 29}
@anime["sp1"][29] = {"pic" => 16, "wait" => 3, "next" => 30}
@anime["sp1"][30] = {"pic" => 17, "wait" => 3, "next" => 31}
@anime["sp1"][31] = {"pic" => 18, "wait" => 3, "next" => 32}
@anime["sp1"][32] = {"pic" => 19, "wait" => 3, "next" => 14}

# 雷擊收尾
@anime["sp1"][34] = {"pic" => 272, "wait" => 3, "next" => 35, "ab_uncancel" => 80, "se"=> ["swing2", 76, 90]}
@anime["sp1"][35] = {"pic" => 273, "wait" => 3, "next" => 36}
@anime["sp1"][36] = {"pic" => 274, "wait" => 3, "next" => 37}
@anime["sp1"][37] = {"pic" => 275, "wait" => 3, "next" => 38}
@anime["sp1"][38] = {"pic" => 276, "wait" => 3, "next" => 39}
@anime["sp1"][39] = {"pic" => 277, "wait" => 3, "next" => 40}
@anime["sp1"][40] = {"pic" => 278, "wait" => 3, "next" => 41}
@anime["sp1"][41] = {"pic" => 279, "wait" => 3, "next" => 42, "uncancel" => true, "z_pos" => 3, "anime" => [1,0,0], "superstop" => 30}
@anime["sp1"][42] = {"pic" => 280, "wait" => 2, "next" => 43, "bullet" => [@me, "sp_thunder", 0, 150, 0, false, true]}
@anime["sp1"][43] = {"pic" => 281, "wait" => 3, "next" => 44}
@anime["sp1"][44] = {"pic" => 282, "wait" => 2, "next" => 45}
@anime["sp1"][45] = {"pic" => 281, "wait" => 2, "next" => 46}
@anime["sp1"][46] = {"pic" => 282, "wait" => 3, "next" => 47}
@anime["sp1"][47] = {"pic" => 281, "wait" => 3, "next" => 48}
@anime["sp1"][48] = {"pic" => 284, "wait" => 3, "next" => 49}
@anime["sp1"][49] = {"pic" => 285, "wait" => 3, "next" => 50}

# 看主角被扁
@anime["sp1"][50] = {"pic" => 1, "wait" => 3, "next" => 51, "ab_uncancel" => 80}
@anime["sp1"][51] = {"pic" => 2, "wait" => 3, "next" => 52}
@anime["sp1"][52] = {"pic" => 3, "wait" => 3, "next" => 53}
@anime["sp1"][53] = {"pic" => 4, "wait" => 3, "next" => 54}
@anime["sp1"][54] = {"pic" => 5, "wait" => 3, "next" => 55}
@anime["sp1"][55] = {"pic" => 6, "wait" => 3, "next" => 56}
@anime["sp1"][56] = {"pic" => 7, "wait" => 3, "next" => 57}
@anime["sp1"][57] = {"pic" => 8, "wait" => 3, "next" => 58}
@anime["sp1"][58] = {"pic" => 9, "wait" => 3, "next" => 59}
@anime["sp1"][59] = {"pic" => 10, "wait" => 3, "next" => 60}
@anime["sp1"][60] = {"pic" => 11, "wait" => 3, "next" => 61}
@anime["sp1"][61] = {"pic" => 12, "wait" => 3, "next" => 62}
@anime["sp1"][62] = {"pic" => 13, "wait" => 3, "next" => 63}
@anime["sp1"][63] = {"pic" => 14, "wait" => 3, "next" => 64}
@anime["sp1"][64] = {"pic" => 15, "wait" => 3, "next" => 65}
@anime["sp1"][65] = {"pic" => 16, "wait" => 3, "next" => 66}
@anime["sp1"][66] = {"pic" => 17, "wait" => 3, "next" => 67}
@anime["sp1"][67] = {"pic" => 18, "wait" => 3, "next" => 68}
@anime["sp1"][68] = {"pic" => 19, "wait" => 3, "next" => 50}




#-------------------------------------------------------------------------------
# ○ 超必殺魔法陣(主角前)
#-------------------------------------------------------------------------------
@anime["magic_circleB"][0] = {"pic" => 542, "wait" => 3, "next" => 1, "z_pos" => 3}
@anime["magic_circleB"][1] = {"pic" => 543, "wait" => 3, "next" => 2}
@anime["magic_circleB"][2] = {"pic" => 544, "wait" => 3, "next" => 3}
@anime["magic_circleB"][3] = {"pic" => 545, "wait" => 3, "next" => 4}
@anime["magic_circleB"][4] = {"pic" => 546, "wait" => 3, "next" => 5}
@anime["magic_circleB"][5] = {"pic" => 547, "wait" => 3, "next" => 0}

#-------------------------------------------------------------------------------
# ○ 超必殺魔法陣(主角後)
#-------------------------------------------------------------------------------
@anime["magic_circleC"][0] = {"pic" => 542, "wait" => 3, "next" => 1, "z_pos" => 3}
@anime["magic_circleC"][1] = {"pic" => 543, "wait" => 3, "next" => 2}
@anime["magic_circleC"][2] = {"pic" => 544, "wait" => 3, "next" => 3}
@anime["magic_circleC"][3] = {"pic" => 545, "wait" => 3, "next" => 4}
@anime["magic_circleC"][4] = {"pic" => 546, "wait" => 3, "next" => 5}
@anime["magic_circleC"][5] = {"pic" => 547, "wait" => 3, "next" => 0}


#-------------------------------------------------------------------------------
# ○ 閃電
#-------------------------------------------------------------------------------
@anime["sp_thunder"][0] = {"pic" => 531, "wait" => 3, "next" => 1, "z_pos" => 3, "se"=> ["123-Thunder01", 86, 90]}
@anime["sp_thunder"][1] = {"pic" => 532, "wait" => 3, "next" => 2}
@anime["sp_thunder"][2] = {"pic" => 533, "wait" => 2, "next" => 3, "se"=> ["124-Thunder02", 86, 90]}
@anime["sp_thunder"][3] = {"pic" => 534, "wait" => 2, "next" => 4, "atk" => [Rect.new(-75, -520, 150, 520)]}
@anime["sp_thunder"][4] = {"pic" => 535, "wait" => 2, "next" => 5, "hit_reset" => true}
@anime["sp_thunder"][5] = {"pic" => 536, "wait" => 2, "next" => 6, "hit_reset" => true}
@anime["sp_thunder"][6] = {"pic" => 535, "wait" => 2, "next" => 7, "hit_reset" => true}
@anime["sp_thunder"][7] = {"pic" => 536, "wait" => 2, "next" => 8, "hit_reset" => true}
@anime["sp_thunder"][8] = {"pic" => 535, "wait" => 2, "next" => 9, "hit_reset" => true}
@anime["sp_thunder"][9] = {"pic" => 0, "wait" => 8, "next" => 10, "atk" => 0}
@anime["sp_thunder"][10] = {"pic" => 532, "wait" => 3, "next" => 11}
@anime["sp_thunder"][11] = {"pic" => 531, "wait" => 3, "next" => 12}
@anime["sp_thunder"][12] = {"pic" => 0, "wait" => 3, "next" => ["dispose"]}


#-------------------------------------------------------------------------------
# ○ 虛弱(擊倒)
#-------------------------------------------------------------------------------
@anime["risk"][0] = {"pic" => 61, "wait" => 3, "next" => 1, "ab_uncancel" => 12, "uncancel" => true}
@anime["risk"][1] = {"pic" => 62, "wait" => 3, "next" => 2}
@anime["risk"][2] = {"pic" => 63, "wait" => 3, "next" => 3}
@anime["risk"][3] = {"pic" => 64, "wait" => 3, "next" => 4}
@anime["risk"][4] = {"pic" => 65, "wait" => 3, "next" => "transform_scene"}

#-------------------------------------------------------------------------------
# ○ 石卵輔助
#-------------------------------------------------------------------------------
@anime["egg_helper"][0] = {"pic" => 65, "wait" => 70, "next" => ["dispose"], "z_pos" => 0, "y_fixed" => true}

#-------------------------------------------------------------------------------
# ○ 石卵
#-------------------------------------------------------------------------------
@anime["stone_egg"][0] = {"pic" => 521, "wait" => 30, "next" => 1, "z_pos" => 3, "body" => Rect.new(-50 , -128, 100, 127), "shadow" => 2}
@anime["stone_egg"][1] = {"pic" => 522, "wait" => 30, "next" => 2}
@anime["stone_egg"][2] = {"pic" => 523, "wait" => 3, "next" => 3}
@anime["stone_egg"][3] = {"pic" => 524, "wait" => 3, "next" => 4}
@anime["stone_egg"][4] = {"pic" => 525, "wait" => 3, "next" => 5}
@anime["stone_egg"][5] = {"pic" => 526, "wait" => 3, "next" => 6, "z_pos" => 0}
@anime["stone_egg"][6] = {"pic" => 527, "wait" => -1, "next" => 6}


end




#==============================================================================
# ■ 主模組補強
#==============================================================================
  #--------------------------------------------------------------------------
  # ◇ 著地
  #--------------------------------------------------------------------------
  def do_landing_step
    @me.now_x_speed = 0
    @me.now_y_speed = 0
    if @me.hp == 0
      @me.z_pos = 0
      return
    elsif ["damage1", "damage2", "guard", "guard_shock"].include?(@state)
    elsif @state == "ball2"
      $game_screen.start_shake(4,2,8,1)
      change_anime("ball2_break")
    else
      change_anime("landing")
      @me.z_pos = 0
    end
    @blur_effect = false

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
  # ◇ 輕攻擊
  #--------------------------------------------------------------------------
  def z_skill?
    return ["atk1","atk2","skill1","skill2"].include?(@state)
  end  
  #--------------------------------------------------------------------------
  # ◇ 必殺
  #--------------------------------------------------------------------------
  def x_skill?
    return false
  end  

  #--------------------------------------------------------------------------
  # ◇ 受傷
  #      attacker：攻擊者(有可能是nil)
  #      dir：判定方向 
  #      scope：從攻擊等級變過來，目前沒作用，只是為了配合對應位置，確定用不到即刪除 
  #      blow_type：擊飛類型("N"：一般、"H"：重擊、"P"：平行、"V"：垂直、"None"：不擊飛)
  #      down_type：擊倒類型
  #      force_state：強制切換狀態
  #--------------------------------------------------------------------------
  def do_damage(dir, scope, blow_type, down_type, attacker = nil, force_state = nil)
    
     # 石頭狀態什麼事都不發生
    return if @state == "stone_egg"
    
    clear # まずはクリア
    release_catching_target 
    @me.z_pos = 0
    @blur_effect = false
    # AI 重新整理
    @me.ai.clear
    @me.ai.do_next
    
    # 不會被擊飛的敵人
    if @me.is_a?(Game_Enemy) and STILILA::NO_BLOW_ENEMY.include?(@me.id)                   #@me.name == "Leather"
      blow_type = "None"
    end  
    
    
    
     
    if force_state != nil #and can_lock and can_catch # 強制切換狀態
      change_anime(force_state[0],force_state[1])
    elsif blow_type != "None"  # 判定為可擊飛時
      case blow_type
      when "N"
         dir == 1 ? change_anime("f_blow") : change_anime("b_blow")
      when "H"
        @blur_effect = true
        appear_blow_voice(@me)
        dir == 1 ? change_anime("hf_blow") : change_anime("hb_blow")
      when "P"
        dir == 1 ? change_anime("parallel_f_blow") : change_anime("parallel_b_blow")
      when "V"
        change_anime("vertical_blow")
      end
    else  # 除外的情況切換到受傷
      appear_damage_voice(@me)
     # rand(2) == 1 ? change_anime("damage1") : change_anime("damage2")
      change_anime("damage1")
      @me.body_rect = @me.stand_body_rect
    end
    @down_type = down_type  # 記錄倒地方式
  end
  
  
  

  
#==============================================================================
# ■ 指令設置
#==============================================================================
  #-------------------------------------------------------------------------------
  # ○ Z
  #-------------------------------------------------------------------------------
  def z_action
    do_act("atk1", "z","Z")
  end
  #-------------------------------------------------------------------------------
  # ○ →Z
  #-------------------------------------------------------------------------------
  def fz_action
    do_act("atk2", "6z","Z", false, false, 30)
  end
  #-------------------------------------------------------------------------------
  # ○ ↓Z
  #-------------------------------------------------------------------------------
  def dz_action
    do_act("skill1", "2z","Z", false, false, 30)
  end
  
  #-------------------------------------------------------------------------------
  # ○ ↑Z
  #-------------------------------------------------------------------------------
  def uz_action
    do_act("skill2", "8z","Z")
  end
  #-------------------------------------------------------------------------------
  # ○ ←Z
  #-------------------------------------------------------------------------------
  def bz_action
    unless ["stand", "walk", "run", "f_flee", "b_flee"].include?(@state) 
      do_act("6z", "4z","Z", (@state == "5x")) 
    end
  end
  #-------------------------------------------------------------------------------
  # ○ X
  #-------------------------------------------------------------------------------
  def x_action
    do_act("sp1", "x","x") if !on_air?
  end
  #-------------------------------------------------------------------------------
  # ○ →X
  #-------------------------------------------------------------------------------
  def fx_action
  end
  #-------------------------------------------------------------------------------
  # ○ ↓X
  #-------------------------------------------------------------------------------
  def dx_action
  end
  #-------------------------------------------------------------------------------
  # ○ ↑X
  #-------------------------------------------------------------------------------
  def ux_action
  end
  #-------------------------------------------------------------------------------
  # ○ ←X
  #-------------------------------------------------------------------------------
  def bx_action
  end

  #-------------------------------------------------------------------------------
  # ○ C
  #-------------------------------------------------------------------------------
  def c_action
    return if !controllable?
    @timely_guard_time = 4
  end
  #-------------------------------------------------------------------------------
  # ○ →C
  #-------------------------------------------------------------------------------
  def fc_action
    if on_air?
      if ["jump_fall", "f_jump_fall", "b_jump_fall", "guard"].include?(@state)
        change_anime("af_flee")
      end
    else
    #  if ["stand", "walk", "dash", "dash_break", "guard", "landing"].include?(@state) or 
     #   (@state == "f_flee" and (4..5) === @frame_number)
        change_anime("dash")
   #   end
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↑C
  #-------------------------------------------------------------------------------
  def uc_action
    do_high_jump if ["guard", "landing"].include?(@state)
    
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
    if on_air?
      if ["jump_fall", "f_jump_fall", "b_jump_fall", "guard"].include?(@state)
        change_anime("ab_flee")
      end
    else
      if ["stand", "walk", "dash", "dash_break", "guard", "landing"].include?(@state) or 
        (@state == "b_flee" and @frame_number == 5) or (@state == "f_flee" and (4..5) === @frame_number)
         change_anime("b_flee")
      end  
    end
  end
  

  
  
  
  #-------------------------------------------------------------------------------
  # ○ 地柱術
  #-------------------------------------------------------------------------------
  def atk1
    @me.ai.set_ai_trigger("atk_cd1", 220-rand(20)) if @anime_time == 1
  end
  
  #-------------------------------------------------------------------------------
  # ○ 殞石術
  #-------------------------------------------------------------------------------
  def atk2
    @me.ai.set_ai_trigger("atk_cd2", 570-rand(40)) if @anime_time == 1 and !on_air?
  end
  
  #-------------------------------------------------------------------------------
  # ○ 閃電術
  #-------------------------------------------------------------------------------
  def skill1
    @me.ai.set_ai_trigger("skill_cd1", 510-rand(40)) if @anime_time == 1
    
   # case @anime_time
   # when 10
    #  $scene.create_battle_bullets([@me, "thunder_helper2", 0, 80, 0, false, true])
     # $scene.create_battle_bullets([@me, "thunder2", 0, 80, 0, false, true])
   # when 25
     # $scene.create_battle_bullets([@me, "thunder_helper2", 0, 220, 0, false, true])
     # $scene.create_battle_bullets([@me, "thunder2", 0, 220, 0, false, true])
   # when 40
    #  $scene.create_battle_bullets([@me, "thunder_helper2", 0, 360, 0, false, true])
     # $scene.create_battle_bullets([@me, "thunder2", 0, 360, 0, false, true])
    #end
    
    
  end
  
  #-------------------------------------------------------------------------------
  # ○ 水球術
  #-------------------------------------------------------------------------------
  def skill2
    @me.ai.set_ai_trigger("skill_cd2", 350-rand(40)) if @anime_time == 1
    
    if @anime_time == 12
      $scene.create_battle_bullets([@me, "skill2_waterpolo_up", 0, 20, 170, false, true])
      $scene.create_battle_bullets([@me, "skill2_waterpolo_mid", 0, 20, 80, false, true])
      $scene.create_battle_bullets([@me, "skill2_waterpolo_down", 0, 20, 2, false, true])
    end
    
    
  end
  
  #-------------------------------------------------------------------------------
  # ○ 瞬間移動
  #-------------------------------------------------------------------------------
  def dash
    case @anime_time
    when 1
      @me.battle_sprite.whiten
    when 6
      @me.now_x_speed = 24 * @me.direction
      Audio.se_play("Audio/SE/power36", 80 * $game_config.se_rate / 10, 60)
      @me.battle_sprite.visible = false
    when 21
      @me.now_x_speed = 2.3 * @me.direction
      @me.battle_sprite.whiten
      
      @penetrate = false
      @me.battle_sprite.visible = true
    end
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ 發射殞石
  #-------------------------------------------------------------------------------
  def ball2_helper
    case @anime_time
    when 1
      @me.y_pos = 443
      @me.now_y_speed = 0
      @y_fixed = true
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
    when 10
      
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
    when 20
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
      $scene.create_battle_bullets([@me, "ball2", 0, 0, 443, false, true])
    when 40
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
      $scene.create_battle_bullets([@me, "ball2", 0, 0, 443, false, true])
    when 50
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
      $scene.create_battle_bullets([@me, "ball2", 0, 0, 443, false, true])
    when 70
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
      $scene.create_battle_bullets([@me, "ball2", 0, 0, 443, false, true])
    when 120
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
      $scene.create_battle_bullets([@me, "ball2", 0, 0, 443, false, true])
    when 121
      do_dispose
    end
      

    
    # 困難追加
    if @anime_time == 30 and $game_variables[STILILA::GAME_LEVEL] > 1
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
      $scene.create_battle_bullets([@me, "ball2", 0, 0, 443, false, true])
    end
    
    # 鬼畜追加
    if @anime_time == 5 and $game_variables[STILILA::GAME_LEVEL] > 2
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
      $scene.create_battle_bullets([@me, "ball2", 0, 0, 443, false, true])
    end
    
    # 鬼畜追加
    if @anime_time == 90 and $game_variables[STILILA::GAME_LEVEL] > 2
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
      $scene.create_battle_bullets([@me, "ball2", 0, 0, 443, false, true])
    end
    
    
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ 閃電發射器(主體)
  #-------------------------------------------------------------------------------
  def thunder_helper_root
    
    if @anime_time == 1 
      $scene.create_battle_bullets([@me, "thunder_helper", 0, 0, 0, false, true])
    end
    
    # 困難追加
    if @anime_time == 50 and $game_variables[STILILA::GAME_LEVEL] > 1
      $scene.create_battle_bullets([@me, "thunder_helper", 0, 0, 0, false, true])
    end
    
    # 鬼畜追加
    if @anime_time == 95 and $game_variables[STILILA::GAME_LEVEL] > 2
      $scene.create_battle_bullets([@me, "thunder_helper", 0, 0, 0, false, true])
    end
    
  end
  
  #-------------------------------------------------------------------------------
  # ○ 閃電發射器
  #-------------------------------------------------------------------------------
  def thunder_helper
    
    if @anime_time == 1
      @me.y_pos = 0
      @me.battle_sprite.opacity = 0
      @me.battle_sprite.blend_type = 1
    end
    
    if @anime_time < 68 and @me.battle_sprite.opacity < 170
      @me.battle_sprite.opacity += 4
    end
    
    if @anime_time > 68
      @me.battle_sprite.opacity -= 12
    end
    
    if @anime_time == 40
      $scene.create_battle_bullets([@me, "thunder", 0, 0, 0, false, true])
    end

    # 打雷前追蹤
    if @anime_time < 59
      @me.x_pos = $game_party.actors[0].x_pos
    end
    
  end 
  #-------------------------------------------------------------------------------
  # ○ 閃電本體
  #-------------------------------------------------------------------------------
  def thunder
    if @anime_time == 1
      @me.y_pos = 0
      @me.battle_sprite.blend_type = 1
    end
    # 打雷前追蹤
    if @anime_time < 12
      @me.x_pos = $game_party.actors[0].x_pos
    end
  end 
  
  #-------------------------------------------------------------------------------
  # ○ 閃電發射器2
  #-------------------------------------------------------------------------------
  def thunder_helper2
    
    if @anime_time == 1
      @me.y_pos = 0
      @me.battle_sprite.opacity = 0
      @me.battle_sprite.blend_type = 1
    end
    
    if @anime_time < 68 and @me.battle_sprite.opacity < 170
      @me.battle_sprite.opacity += 4
    end
    
    if @anime_time > 68
      @me.battle_sprite.opacity -= 12
    end
    

  end 
  #-------------------------------------------------------------------------------
  # ○ 閃電本體2
  #-------------------------------------------------------------------------------
  def thunder2
    if @anime_time == 1
      @me.y_pos = 0
      @me.battle_sprite.blend_type = 1
    end
  end 
  
  #-------------------------------------------------------------------------------
  # ○ 地柱本體
  #-------------------------------------------------------------------------------
  def ball1
    if @anime_time == 1
      @me.y_pos = 0
      $game_screen.start_shake(8,3,6,1)
      @me.x_pos = $game_party.actors[0].x_pos #- (240*@me.direction)
    elsif @anime_time == 47
      $game_screen.start_shake(8,3,6,1)
    end
    
    $game_screen.start_shake(2,2,2,1) if @anime_time % 2 == 1
  end
  
  #-------------------------------------------------------------------------------
  # ○ 地柱本體(往左)
  #-------------------------------------------------------------------------------
  def ball1B
    if @anime_time == 1
      @me.y_pos = 0
      @me.direction = -1
      $game_screen.start_shake(8,3,6,1)

    #  @me.x_pos = $game_party.actors[0].x_pos #- (240*@me.direction)
    elsif @anime_time == 47
      $game_screen.start_shake(8,3,6,1)
    end
    
    $game_screen.start_shake(2,2,2,1) if @anime_time % 2 == 1
  end
  
  #-------------------------------------------------------------------------------
  # ○ 地柱本體(往右)
  #-------------------------------------------------------------------------------
  def ball1C
    if @anime_time == 1
      @me.y_pos = 0
      @me.direction = 1
      $game_screen.start_shake(8,3,6,1)
   #   @me.x_pos = $game_party.actors[0].x_pos #- (240*@me.direction)
    elsif @anime_time == 47
      $game_screen.start_shake(8,3,6,1)
    end
    
    $game_screen.start_shake(2,2,2,1) if @anime_time % 2 == 1
  end
  
  #-------------------------------------------------------------------------------
  # ○ 殞石本體
  #-------------------------------------------------------------------------------
  def ball2
    if @anime_time == 1
      @me.x_pos = $game_party.actors[0].x_pos + ((rand(50)*25-600)*@me.direction)
      @me.y_pos = 443
    end
    
    if @me.y_pos <= -1
      change_anime("ball2_break")
      @y_fixed = true
      @me.y_pos = 1 
    end
    
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ 魔法陣縱
  #-------------------------------------------------------------------------------
  def magic_circleA
    if @anime_time == 1
      @me.y_pos = 0
      @me.battle_sprite.opacity = 0
    end
    if @anime_time < 20
      @me.battle_sprite.opacity += (255 / 20)
    end
    if @anime_time > 30
      @me.battle_sprite.opacity -= (255 / 20)
    end 
    if @anime_time == 52
      do_dispose
    end 
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ 超必殺
  #-------------------------------------------------------------------------------
  def sp1
    if @anime_time == 1
      @me.awake_time = 0
    end
    
    
    if @frame_number < 34
      @me.awake_time = 0
      $game_temp.black_time = [20, 50]
      $scene.camera_feature =  [20,30,30]
    else
      $game_temp.black_time = [30, 110]
      $scene.camera_feature =  [30,50,50]
    end
    

    if @frame_number > 8 and @anime_time < 209
      do_catch(@sp1_target)
      @sp1_target.motion.knock_back_duration = 150
    end

    if @anime_time > 180 and @frame_number < 34
      change_anime("sp1", 34)
      @anime_time = 181
    end
    
    if @anime_time == 260
      change_anime("dash", 0)
      var_reset
    end

  end
    
  #-------------------------------------------------------------------------------
  # ○ 超必殺魔法陣(主角前)
  #-------------------------------------------------------------------------------
  def magic_circleB
    if @anime_time == 1
      @me.x_pos = @me.other_vars[0] + 90 * @me.other_vars[1]
      @me.y_pos = 0
      @me.battle_sprite.opacity = 0
    end
    if @anime_time < 20
      @me.battle_sprite.opacity += (255 / 20)
    end
    
    if (40..180) === @anime_time and @anime_time % 7 == 0
      case rand(3)
      when 0
        $scene.create_battle_bullets([@me, "skill2_waterpolo_up", 0, 0, 90 + rand(15), false, true])
      when 1
        $scene.create_battle_bullets([@me, "skill2_waterpolo_mid", 0, 0, 50 + rand(30), false, true])
      when 2
        $scene.create_battle_bullets([@me, "skill2_waterpolo_down", 0, 0, 20 + rand(45), false, true])
      end
    end
    
    if @anime_time > 230
      @me.battle_sprite.opacity -= (255 / 20)
    end 
    
    if @anime_time == 252
      do_dispose
    end 
  end
  #-------------------------------------------------------------------------------
  # ○ 超必殺魔法陣(主角後)
  #-------------------------------------------------------------------------------
  def magic_circleC
    
    if @anime_time == 1
      @me.direction *= -1
      @me.x_pos = @me.other_vars[0] - 90 * @me.other_vars[1]
      @me.y_pos = 0
      @me.battle_sprite.opacity = 0
    end
    
    if @anime_time < 20
      @me.battle_sprite.opacity += (255 / 20)
    end
    
    if (40..180) === @anime_time and @anime_time % 7 == 3
      case rand(3)
      when 0
        $scene.create_battle_bullets([@me, "skill2_waterpolo_up", 0, 0, 90 + rand(15), false, true])
      when 1
        $scene.create_battle_bullets([@me, "skill2_waterpolo_mid", 0, 0, 50 + rand(30), false, true])
      when 2
        $scene.create_battle_bullets([@me, "skill2_waterpolo_down", 0, 0, 20 + rand(45), false, true])
      end
    end
    
    if @anime_time > 230
      @me.battle_sprite.opacity -= (255 / 20)
    end 
    
    if @anime_time == 252
      do_dispose
    end 
    
  end
    
    
  #-------------------------------------------------------------------------------
  # ○ 中斷戰鬥，進入羽化場景
  #-------------------------------------------------------------------------------
  def transform_scene
     if !@scene_start
       common_event = $data_common_events[34]
       $game_system.battle_interpreter.setup(common_event.list, 0)
       @scene_start = true
     end
   end
   
   
  #-------------------------------------------------------------------------------
  # ○ 石卵閃爍開始
  #-------------------------------------------------------------------------------
   def egg_flash(time)
    return if @egg_flash_time > 0
    @egg_flash_time = @egg_flash_time_max = time
   end
   
  #-------------------------------------------------------------------------------
  # ○ 石卵狀態
  #-------------------------------------------------------------------------------
   def stone_egg
     
     # 變身中
     if @anime_time == 1
       Audio.se_play("Audio/SE/Earth5", 70 * $game_config.se_rate / 10, 100)
       $game_screen.start_shake(6,3,20,1)
     end
     if @anime_time == 31
       Audio.se_play("Audio/SE/Earth5", 70 * $game_config.se_rate / 10, 100)
       $game_screen.start_shake(6,3,20,1)
     end
     if @anime_time == 61
       Audio.se_play("Audio/SE/Earth5", 70 * $game_config.se_rate / 10, 100)
       $game_screen.start_shake(7,4,40,1)
     end
     
     

       
       
     @super_armor = 9999
     @me.combohit_clear
     
     # 第二型態倒數
     if $game_switches[STILILA::BREAK_EGG] and @hatch_time > 0 and @me.hp != 0
      @hatch_time -= 1
      
      
       # 不定時放彈幕
       if @anime_time % 40 == 0 and rand(5) <= 2 and @hatch_time > 90
         case rand(3)
         when 0
           $scene.create_battle_bullets([@me, "thunder_helper_root", 0, 0, 0, false, true])
         when 1
           $scene.create_battle_bullets([@me, "ball2_helper", 0, 0, 0, false, true])
         when 2
           $scene.create_battle_bullets([@me, "ball1B", 0, 240, 0, false, true])
           $scene.create_battle_bullets([@me, "ball1C", 0, -240, 0, false, true])
      #   $scene.create_battle_bullets([@me, "ball1", 0, 0, 0, false, true])
         end
       end
       
       # 不定時放彈幕(困難追加)
       if @anime_time % 197 == 0 and $game_variables[STILILA::GAME_LEVEL] > 1 and @hatch_time > 90
         case rand(3)
         when 0
           $scene.create_battle_bullets([@me, "ball2_helper", 0, 0, 0, false, true])
         when 1
           $scene.create_battle_bullets([@me, "ball1B", 0, 240, 0, false, true])
           $scene.create_battle_bullets([@me, "ball1C", 0, -240, 0, false, true])
      #   $scene.create_battle_bullets([@me, "ball1", 0, 0, 0, false, true])
         when 2
           $scene.create_battle_bullets([@me, "thunder_helper", 0, 0, 0, false, true])
         end
       end
      
       # 不定時放彈幕(鬼畜追加)
       if @anime_time % 121 == 0 and $game_variables[STILILA::GAME_LEVEL] == 3 and rand(2) == 0 and @hatch_time > 90
         case rand(2)
         when 0
           $scene.create_battle_bullets([@me, "ball2_helper", 0, 0, 0, false, true])
         when 1
           $scene.create_battle_bullets([@me, "thunder_helper", 0, 0, 0, false, true])
         end
       end
       
     end

     
     
     case @hatch_time
     when 1700..2500
       egg_flash(60)
     when 1000...1700
        egg_flash(40)
     when 500...1000
        egg_flash(30)
     when 200...500
        egg_flash(20)
     when 60...200
        egg_flash(10)
     when 0...60
        egg_flash(5)
     else
       egg_flash(60)
     end
     
     
     # 石蛋閃爍
     if @egg_flash_time > 0
       @egg_flash_time -= 1 
        if @egg_flash_time < (@egg_flash_time_max / 2)
          egg_alpha = ((@egg_flash_time_max / 2) - @egg_flash_time) * (255 / (@egg_flash_time_max / 2))
        else
          egg_alpha = (@egg_flash_time - (@egg_flash_time_max / 2)) * (255 / (@egg_flash_time_max / 2))
        end
        
       @me.battle_sprite.tone.set(50, 50, 0, egg_alpha)
     end
     
     
     # 擊破蛋
     if @me.hp == 0 and $game_switches[STILILA::BREAK_EGG]
       @me.combohit_clear
       $game_party.actors[0].motion.y_fixed = false
       common_event = $data_common_events[37]

       $game_system.battle_interpreter.setup(common_event.list, 0)
       return
     end
     
     # 時間到
     if (@hatch_time == 0 or $game_party.actors[0].hp == 0) and $game_switches[STILILA::BREAK_EGG] 
       @hatch_time = 0
       @me.combohit_clear
       $game_party.actors[0].motion.y_fixed = false
       common_event = $data_common_events[36]
       $game_system.battle_interpreter.setup(common_event.list, 0)
     end
     

     
   end
   
  #-------------------------------------------------------------------------------
  # ○ 石卵化
  #-------------------------------------------------------------------------------
  def do_transform1
    @start_transform1 = true
    @eva_invincible_duration = 0
  end
  
  #-------------------------------------------------------------------------------
  # ○ 石卵化完成
  #-------------------------------------------------------------------------------
  def do_transform1_finish
    @start_transform1 = false
    
    @blur_effect = false
    @now_jumps = 0
    @uncancel_flag = false
    @y_fixed = false
    
    @me.hp = (@me.maxhp * 0.7).abs
    $scene.create_battle_bullets([@me, "egg_helper", 0, 0, 0, false, true])
    change_anime("stone_egg")
    
     rate = $game_variables[STILILA::GAME_LEVEL] * 280
     
    @push_flag = false
    @hatch_time = 2180 - rate
  end
  
  #-------------------------------------------------------------------------------
  # ○ 變身
  #-------------------------------------------------------------------------------
  def do_transform2
    @start_transform1 = false
    @me.transform(31)
    @me.hp = @me.maxhp
    @me.sp = @me.maxsp
    @me.battle_sprite.tone.set(0, 0, 0, 0)
    var_reset
  end
  
  #-------------------------------------------------------------------------------
  # ○ 常時監視A (不受暫停、受傷定格效果影響)
  #-------------------------------------------------------------------------------
  def respective_updateA

    # 前哨站
    if $game_switches[STILILA::Corals_FIRST_BATTLE]
      @me.battle_sprite.zoom_x = 0.8 if @me.battle_sprite.zoom_x != 0.8
      @me.battle_sprite.zoom_y = 0.8 if @me.battle_sprite.zoom_y != 0.8
      @y_fixed = true
      @me.y_pos = 155
      @eva_invincible_duration = 5
      @penetrate = true
    end
    
   # 陣亡
    if @me.hp == 0 and @state != "risk" and @state != "stone_egg" and !$game_switches[STILILA::BREAK_EGG]#and !downing?
      @me.combohit_clear
      $game_system.se_play($data_system.enemy_collapse_se) 
      @eva_invincible_duration = 999
      change_anime("risk")
      @hit_stop_duration = 40
    end
    
    # 卵化震動
    if @start_transform1
      $game_screen.start_shake(4,2,6,1)
    end
    
    
  end
 
  
  #-------------------------------------------------------------------------------
  # ○ 常時監視 (通常用在調整受傷、倒地這種不確定何時恢復姿勢的情況)
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
        (@state == "f_down") ? change_anime("f_down_stand") : change_anime("b_down_stand")
      end
    end
    
    if @me.dead? and (["stand"].include?(@state) or (["damage1", "damage2"].include?(@state) and !@catched)) and @state != "stone_egg" and !$game_switches[STILILA::BREAK_EGG]
      @me.combohit_clear
      change_anime("risk")
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
    
    #p @me.y_pos if @me.is_a?(Game_Enemy)
  end
  #--------------------------------------------------------------------------
  # ◇ 碰撞行為
  # skill_name：招式名稱
  # target：目標
  # 構想：處刑演出(目標血量or自己血量小於定值)
  #--------------------------------------------------------------------------  
  def collision_action(action, target)
    
    if @state == "sp1" and !target.guarding?
      change_anime("sp1", 9)
      target.x_pos = @me.x_pos + 150 * @me.direction
      target.y_pos = 25
      target.direction = -@me.direction 
      @sp1_target = target
      do_catch(target)
      $scene.create_battle_bullets([@me, "magic_circleB", 0, 0, 0, false, true, [target.x_pos, target.direction]])
      $scene.create_battle_bullets([@me, "magic_circleC", 0, 0, 0, false, true, [target.x_pos, target.direction]])
      
    end
    
    
    
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
      
      if skill == "ball1"
        result["power"] = 45
        result["limit"] = 35
        result["blow_type"] = "None" if !target.motion.on_air? # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 0
        result["t_hitstop"] = 13 
        result["correction"] = 8
        result["t_knockback"] = 13
        result["x_speed"] = 13   
        result["hit_slide"] = 0
        result["d_se"] = ["Audio/SE/impact_se", 88, 100]     
        result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]
      elsif skill == "ball1B" or skill == "ball1C"
        result["power"] = 45
        result["limit"] = 35
        result["blow_type"] = "None" if !target.motion.on_air? # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 0
        result["t_hitstop"] = 13 
        result["correction"] = 8
        result["t_knockback"] = 13
        result["x_speed"] = 13   
        result["hit_slide"] = 0
        result["d_se"] = ["Audio/SE/impact_se", 88, 100]     
        result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]
      elsif skill == "ball2_break"
        result["power"] = 45
        result["limit"] = 35
        result["u_hitstop"] = 0
        result["t_hitstop"] = 6 
        result["correction"] = 8
        result["t_knockback"] = 17
        result["x_speed"] = 6    
        result["y_speed"] = 8.4     
        result["hit_slide"] = 0
        result["d_se"] = ["Audio/SE/impact_se2", 88, 100]     
        result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]
        
      elsif skill == "thunder" or skill == "thunder2"
        result["power"] = 80
        result["limit"] = 55
        result["u_hitstop"] = 2
        result["t_hitstop"] = 6 
        result["correction"] = 8
        result["t_knockback"] = 17
        result["x_speed"] = 6    
        result["y_speed"] = 8.4     
        result["hit_slide"] = 0
        result["d_se"] = ["Audio/SE/impact_se2", 88, 100]     
        result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]
        
     elsif skill == "skill2_waterpolo_up" or skill == "skill2_waterpolo_mid" or skill == "skill2_waterpolo_down" 
        result["power"] = 20
        result["limit"] = 8
        result["blow_type"] = "None" if !target.motion.on_air? # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 3
        result["t_hitstop"] = 12 
        result["correction"] = 3
        result["t_knockback"] = 17
        result["x_speed"] = 6    
        result["y_speed"] = 8.4     
        result["hit_slide"] = 0
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]  
        result["h_shake"] = [2,4,8,0]
        result["d_shake"] = [2,4,8,0]
        result["no_kill"] = true
        
      elsif skill == "sp1"
        result["power"] = 5
        result["limit"] = 5
        result["blow_type"] = "None" # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 0
        result["t_hitstop"] = 20 
        result["correction"] = 5
        result["t_knockback"] = 150
        result["x_speed"] = 0   
        result["hit_slide"] = 0
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]   
        
        
        
      elsif skill == "sp_thunder"
        result["power"] = 30
        result["limit"] = 15
        result["u_hitstop"] = 5
        result["t_hitstop"] = 10 
        result["correction"] = 0
        result["t_knockback"] = 60
        result["x_speed"] = -6.9  
        result["y_speed"] = 24.7  
        result["hit_slide"] = 0
        result["d_se"] = ["Audio/SE/impact_se2", 88, 100]     
        result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]
        result["h_shake"] = [5,2,12,1]
        result["d_shake"] = [5,2,12,1]
        
        result["spark"] = [0, rand(10) - 6, 9*(rand(20)+1)+30]
        
      else
      end #if end
      return result
  end #def end
end # class end
