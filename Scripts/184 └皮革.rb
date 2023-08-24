#==============================================================================
# ■ 皮革的Motion


# 註：計算總動作時間時記得是每個wait
#==============================================================================
class LeatherB < Game_Motion
#--------------------------------------------------------------------------
# ○ 人物生成/初始化
#--------------------------------------------------------------------------
def initialize(me,frame=0,anime="stand")
  super
  
  
  # 宣告所有動畫
  @anime = {"stand" => [], "walk" => [], "dash" => [], "dash_break" => [], "story_wait" => [],
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
  "dizzy1" => [], "dizzy2" => [], "catched" => [], "dash2" => [], "skill" => [], "skill2" => [], "skill3" => [], "skill4" => [], "skill5" => [], "ball" => [], "skill4_effect" => [],
  "dead"=>[]}
  
  
  # 設定動作的影格
  frame_set
  
  @full_limit = 11
  @hard_skill_loop = 0
  @blow_time = 0
end

#==============================================================================
# ■影格設置
#==============================================================================

def frame_set
#-------------------------------------------------------------------------------
# ○ 站立
#-------------------------------------------------------------------------------
@anime["stand"][0] = {"pic" => 1, "wait" => 2, "next" => 1, "body" => @me.stand_body_rect, "z_pos" =>  1}
@anime["stand"][1] = {"pic" => 2, "wait" => 2, "next" => 2}
@anime["stand"][2] = {"pic" => 3, "wait" => 2, "next" => 3}
@anime["stand"][3] = {"pic" => 4, "wait" => 2, "next" => 4}
@anime["stand"][4] = {"pic" => 5, "wait" => 2, "next" => 5}
@anime["stand"][5] = {"pic" => 6, "wait" => 2, "next" => 6}
@anime["stand"][6] = {"pic" => 7, "wait" => 2, "next" => 7}
@anime["stand"][7] = {"pic" => 8, "wait" => 2, "next" => 8}
@anime["stand"][8] = {"pic" => 9, "wait" => 2, "next" => 9}
@anime["stand"][9] = {"pic" => 10, "wait" => 2, "next" => 10}
@anime["stand"][10] = {"pic" => 11, "wait" => 2, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 走路
#-------------------------------------------------------------------------------
@anime["walk"][0] = {"pic" => 21, "wait" => 5, "next" => 1, "z_pos" =>  1}
@anime["walk"][1] = {"pic" => 22, "wait" => 5, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 跑步
#-------------------------------------------------------------------------------
@anime["dash"][0] = {"pic" => 21, "wait" => 2, "next" => 1, "anime" => [11,0,0], "z_pos" => 1}
@anime["dash"][1] = {"pic" => 22, "wait" => 2, "next" => 2}
@anime["dash"][2] = {"pic" => 23, "wait" => 2, "next" => 3}
@anime["dash"][3] = {"pic" => 24, "wait" => 2, "next" => 4, "anime" => [11,0,0]}
@anime["dash"][4] = {"pic" => 25, "wait" => 2, "next" => 5}
@anime["dash"][5] = {"pic" => 26, "wait" => 2, "next" => 6}
@anime["dash"][6] = {"pic" => 27, "wait" => 2, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 剎車
#-------------------------------------------------------------------------------
@anime["dash_break"][0] = {"pic" => 86,  "wait" => 2, "next" => 1, "anime" => [12,0,0], "x_speed" => @me.dash_x_speed*2}
@anime["dash_break"][1] = {"pic" => 87,  "wait" => 2, "next" => 2}
@anime["dash_break"][2] = {"pic" => 88,  "wait" => 2, "next" => 3}
@anime["dash_break"][3] = {"pic" => 89,  "wait" => 2, "next" => 4}
@anime["dash_break"][4] = {"pic" => 90,  "wait" => 2, "next" => 5}
@anime["dash_break"][5] = {"pic" => 91,  "wait" => 2, "next" => 6}
@anime["dash_break"][6] = {"pic" => 92,  "wait" => 2, "next" => 7}
@anime["dash_break"][7] = {"pic" => 93,  "wait" => 2, "next" => 8}
@anime["dash_break"][8] = {"pic" => 94,  "wait" => 4, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 跑步(劇情用)
#-------------------------------------------------------------------------------
@anime["dash2"][0] = {"pic" => 21, "wait" => 2, "next" => 1, "anime" => [11,0,0], "z_pos" =>  1, "x_speed" => @me.dash_x_speed}
@anime["dash2"][1] = {"pic" => 22, "wait" => 2, "next" => 2, "x_speed" => @me.dash_x_speed}
@anime["dash2"][2] = {"pic" => 23, "wait" => 2, "next" => 3, "x_speed" => @me.dash_x_speed}
@anime["dash2"][3] = {"pic" => 24, "wait" => 2, "next" => 4, "x_speed" => @me.dash_x_speed, "anime" => [11,0,0]}
@anime["dash2"][4] = {"pic" => 25, "wait" => 2, "next" => 5, "x_speed" => @me.dash_x_speed}
@anime["dash2"][5] = {"pic" => 26, "wait" => 2, "next" => 6, "x_speed" => @me.dash_x_speed}
@anime["dash2"][6] = {"pic" => 27, "wait" => 2, "next" => 0, "x_speed" => @me.dash_x_speed}

#-------------------------------------------------------------------------------
# ○ 偽裝
#-------------------------------------------------------------------------------
@anime["story_wait"][0] = {"pic" => 31, "wait" => 2, "next" => 1, "body" => @me.stand_body_rect, "z_pos" =>  1}
@anime["story_wait"][1] = {"pic" => 32, "wait" => 2, "next" => 2}
@anime["story_wait"][2] = {"pic" => 33, "wait" => 2, "next" => 3}
@anime["story_wait"][3] = {"pic" => 34, "wait" => 2, "next" => 4}
@anime["story_wait"][4] = {"pic" => 35, "wait" => 2, "next" => 5}
@anime["story_wait"][5] = {"pic" => 36, "wait" => 2, "next" => 6}
@anime["story_wait"][6] = {"pic" => 37, "wait" => 2, "next" => 7}
@anime["story_wait"][7] = {"pic" => 38, "wait" => 2, "next" => 8}
@anime["story_wait"][8] = {"pic" => 39, "wait" => 2, "next" => 0}

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
@anime["guard"][0] = {"pic" => 111, "wait" => 2, "next" => 0, "var_reset" => true}
@anime["guard_shock"][0] = {"pic" => 112, "wait" => -1, "next" => 0}

#-------------------------------------------------------------------------------
# ○ 受傷1
#-------------------------------------------------------------------------------
@anime["damage1"][0] = {"pic" => 42, "wait" => 4, "next" => 1}
@anime["damage1"][1] = {"pic" => 42, "wait" => 4, "next" => 2}
@anime["damage1"][2] = {"pic" => 43, "wait" => 4, "next" => 3}
@anime["damage1"][3] = {"pic" => 44, "wait" => -1, "next" => 3}

#-------------------------------------------------------------------------------
# ○ 受傷2
#-------------------------------------------------------------------------------
@anime["damage2"][0] = {"pic" => 1, "wait" => 3, "next" => 1}
@anime["damage2"][1] = {"pic" => 1, "wait" => -1, "next" => 1}

#-------------------------------------------------------------------------------
# ○ 正面擊飛
#-------------------------------------------------------------------------------
@anime["f_blow"][0] = {"pic" => 101, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect}
@anime["f_blow"][1] = {"pic" => 101, "wait" => 3, "next" => 2}
@anime["f_blow"][2] = {"pic" => 102, "wait" => 3, "next" => 3}
@anime["f_blow"][3] = {"pic" => 102, "wait" => -1, "next" => 3}
#-------------------------------------------------------------------------------
# ○ 背面擊飛
#-------------------------------------------------------------------------------
@anime["b_blow"][0] = {"pic" => 43, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect}
@anime["b_blow"][1] = {"pic" => 44, "wait" => 5, "next" => 2}
@anime["b_blow"][2] = {"pic" => 44, "wait" => 6, "next" => 3}
@anime["b_blow"][3] = {"pic" => 44, "wait" => -1, "next" => 3}

#-------------------------------------------------------------------------------
# ○ 正面擊飛(重)
#-------------------------------------------------------------------------------
@anime["hf_blow"][0] = {"pic" => 44, "wait" => 2, "next" => 1, "body" => @me.stand_body_rect}
@anime["hf_blow"][1] = {"pic" => 101, "wait" => 4, "next" => 1}
@anime["hf_blow"][1] = {"pic" => 102, "wait" => 4, "next" => 1}
#-------------------------------------------------------------------------------
# ○ 背面擊飛(重)
#-------------------------------------------------------------------------------
@anime["hb_blow"][0] = {"pic" => 43, "wait" => 2, "next" => 1, "body" => @me.stand_body_rect}
@anime["hb_blow"][1] = {"pic" => 44, "wait" => 50, "next" => 1}

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
@anime["f_down"][0] = {"pic" => 103, "wait" => 4, "next" => 1, "ab_uncancel" => 32, "body" => @me.down_body_rect}
@anime["f_down"][1] = {"pic" => 104, "wait" => 4, "next" => 2}
@anime["f_down"][2] = {"pic" => 103, "wait" => 4, "next" => 1}

@anime["f_down_stand"][0] = {"pic" => 101, "wait" => 6, "next" => ["stand"], "ab_uncancel" => 8, "var_reset" => true, "body" => @me.sit_body_rect, "eva" => 10}
@anime["bounce_f_down"][0] = {"pic" => 104, "wait" => -1, "next" => 0}  # 反彈
#-------------------------------------------------------------------------------
# ○ 倒地－－面朝下/反彈/起身
#-------------------------------------------------------------------------------
@anime["b_down"][0] = {"pic" => 64, "wait" => -1, "next" => 0, "ab_uncancel" => 32, "body" => @me.down_body_rect}
@anime["b_down_stand"][0] = {"pic" => 63, "wait" => 6, "next" => ["stand"], "ab_uncancel" => 8, "var_reset" => true, "body" => @me.sit_body_rect, "eva" => 10}
@anime["bounce_b_down"][0] = {"pic" => 64, "wait" => -1, "next" => 0} # 反彈


#-------------------------------------------------------------------------------
# ○ 倒地－－壓制攻擊
#-------------------------------------------------------------------------------
@anime["pressure_f_down"][0] = {"pic" => 64, "wait" => 3, "next" => 0, "ab_uncancel" => 14, "body" => @me.down_body_rect}
@anime["pressure_b_down"][0] = {"pic" => 64, "wait" => 3, "next" => 0, "ab_uncancel" => 14, "body" => @me.down_body_rect}

#-------------------------------------------------------------------------------
# ○ 受身
#-------------------------------------------------------------------------------
@anime["ukemi"][0] = {"pic" => 36, "wait" => 7, "next" => ["jump_fall"]}


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
@anime["f_flee"][0] = {"pic" => 26, "wait" => 4, "next" => 1, "x_speed" => 0, "ab_uncancel" => 8, "blur" => true, "eva" => 18, "penetrate" => true}
@anime["f_flee"][1] = {"pic" => 131, "wait" => 3, "next" => 2, "x_speed" => (@me.dash_x_speed*1.8)}
@anime["f_flee"][2] = {"pic" => 132, "wait" => 3, "next" => 3}
@anime["f_flee"][3] = {"pic" => 133, "wait" => 3, "next" => 4}
@anime["f_flee"][4] = {"pic" => 26, "wait" => 2, "next" => 5}
@anime["f_flee"][5] = {"pic" => 26, "wait" => 1, "next" => ["stand"], "var_reset" => true, "penetrate" => false}
#-------------------------------------------------------------------------------
# ○ 後迴避
#-------------------------------------------------------------------------------
@anime["b_flee"][0] = {"pic" => 26, "wait" => 2, "next" => 1, "x_speed" => 0, "ab_uncancel" => 24, "eva" => 26, "penetrate" => true}
@anime["b_flee"][1] = {"pic" => 51, "wait" => 3, "next" => 2, "x_speed" => ((@me.dash_x_speed+3.2) * -1), "y_speed" => (@me.jump_y_init_velocity/2), "blur" => true}
@anime["b_flee"][2] = {"pic" => 51, "wait" => 3, "next" => 3}
@anime["b_flee"][3] = {"pic" => 51, "wait" => 3, "next" => 4}
@anime["b_flee"][4] = {"pic" => 56, "wait" => 9, "next" => 5, "x_speed" => ((@me.dash_x_speed) * -1)}
@anime["b_flee"][5] = {"pic" => 26, "wait" => 8, "next" => ["stand"], "var_reset" => true, "penetrate" => false}
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


#-------------------------------------------------------------------------------
# ○ 掛掉
#-------------------------------------------------------------------------------
@anime["dead"][0] = {"pic" => 42, "wait" => 2, "next" => 1, "ab_uncancel" => 22, "body" => @me.down_body_rect, "z_pos"=>-1}
@anime["dead"][1] = {"pic" => 52, "wait" => 2, "next" => 2, "x_speed" => - 7}
@anime["dead"][2] = {"pic" => 53, "wait" => 2, "next" => 3}
@anime["dead"][3] = {"pic" => 54, "wait" => 2, "next" => 4}
@anime["dead"][4] = {"pic" => 55, "wait" => 2, "next" => 5}
@anime["dead"][5] = {"pic" => 56, "wait" => 2, "next" => 6}
@anime["dead"][6] = {"pic" => 57, "wait" => 2, "next" => 7}
@anime["dead"][7] = {"pic" => 58, "wait" => 2, "next" => 8}
@anime["dead"][8] = {"pic" => 59, "wait" => 2, "next" => 9}
@anime["dead"][9] = {"pic" => 60, "wait" => 2, "next" => 10}
@anime["dead"][10] = {"pic" => 61, "wait" => 2, "next" => 11}
@anime["dead"][11] = {"pic" => 62, "wait" => 2, "next" => 12}
@anime["dead"][12] = {"pic" => 63, "wait" => 2, "next" => 13}
@anime["dead"][13] = {"pic" => 64, "wait" => 2, "next" => 14}
@anime["dead"][14] = {"pic" => 65, "wait" => 2, "next" => 15}
@anime["dead"][15] = {"pic" => 66, "wait" => 2, "next" => 16}
@anime["dead"][16] = {"pic" => 67, "wait" => 2, "next" => 17}
@anime["dead"][17] = {"pic" => 68, "wait" => 2, "next" => 18}
@anime["dead"][18] = {"pic" => 69, "wait" => 20, "next" => "go_dead_disappear"}
@anime["dead"][19] = {"pic" => 69, "wait" => -1, "next" => 19}

#-------------------------------------------------------------------------------
# ○ 葉豬衝撞(普通以下)
#-------------------------------------------------------------------------------
@anime["skill"][0] = {"pic" => 71, "wait" => 2, "next" => 1, "ab_uncancel" => 18, "uncancel" => true, "anime" => [1,0,0], "superstop" => 16, "camera" => [25,30,30], "black" => [28,50], "fps"=> [23,37], "super_armor" => 5, "supermove" => 0, "atk_phase" => 1, "z_pos" => 3, "penetrate" => true}
@anime["skill"][1] = {"pic" => 72, "wait" => 2, "next" => 2}
@anime["skill"][2] = {"pic" => 73, "wait" => 2, "next" => 3, "x_speed" => @me.dash_x_speed*5.4}
@anime["skill"][3] = {"pic" => 74, "wait" => 2, "next" => 4, "x_speed" => @me.dash_x_speed*5.4, "atk" => [@me.stand_body_rect]}
@anime["skill"][4] = {"pic" => 75, "wait" => 2, "next" => 5, "x_speed" => @me.dash_x_speed*3.4}
@anime["skill"][5] = {"pic" => 76, "wait" => 2, "next" => 6, "x_speed" => @me.dash_x_speed*2.4}
@anime["skill"][6] = {"pic" => 77, "wait" => 2, "next" => 7}
@anime["skill"][7] = {"pic" => 78, "wait" => 2, "next" => 8}
@anime["skill"][8] = {"pic" => 79, "wait" => 2, "next" => 9}
@anime["skill"][9] = {"pic" => 80, "wait" => 2, "next" => 10}
@anime["skill"][10] = {"pic" => 81, "wait" => 2, "next" => 11}
@anime["skill"][11] = {"pic" => 82, "wait" => 2, "next" => 12}
@anime["skill"][12] = {"pic" => 83, "wait" => 2, "next" => 13, "atk"=> 0}
@anime["skill"][13] = {"pic" => 84, "wait" => 2, "next" => 14, "x_speed" => @me.dash_x_speed*1.5}
@anime["skill"][14] = {"pic" => 85, "wait" => 2, "next" => ["dash_break"], "x_speed" => @me.dash_x_speed}

#-------------------------------------------------------------------------------
# ○ 葉豬衝撞(難以上)
#-------------------------------------------------------------------------------
@anime["skill2"][0] = {"pic" => 71, "wait" => 2, "next" => 1, "ab_uncancel" => 18, "uncancel" => true, "anime" => [1,0,0], "superstop" => 16, "camera" => [25,30,30], "black" => [28,50], "fps"=> [23,37], "super_armor" => 5, "supermove" => 0, "atk_phase" => 1, "z_pos" => 3, "eva" => 2}
@anime["skill2"][1] = {"pic" => 72, "wait" => 2, "next" => 2, "eva" => 7, "black" => [28,50]}
@anime["skill2"][2] = {"pic" => 73, "wait" => 2, "next" => 3, "x_speed" => @me.dash_x_speed*5.4}
@anime["skill2"][3] = {"pic" => 74, "wait" => 2, "next" => 4, "x_speed" => @me.dash_x_speed*5.4, "atk" => [Rect.new(-80 , -170, 190, 140)]}
@anime["skill2"][4] = {"pic" => 75, "wait" => 2, "next" => 5, "x_speed" => @me.dash_x_speed*3.4}
@anime["skill2"][5] = {"pic" => 76, "wait" => 2, "next" => 6, "x_speed" => @me.dash_x_speed*2.4}
@anime["skill2"][6] = {"pic" => 77, "wait" => 2, "next" => 7}
@anime["skill2"][7] = {"pic" => 78, "wait" => 2, "next" => 8, "penetrate" => true}
@anime["skill2"][8] = {"pic" => 79, "wait" => 2, "next" => 9}
@anime["skill2"][9] = {"pic" => 80, "wait" => 2, "next" => 10}
@anime["skill2"][10] = {"pic" => 81, "wait" => 2, "next" => 11}
@anime["skill2"][11] = {"pic" => 82, "wait" => 2, "next" => 12}
@anime["skill2"][12] = {"pic" => 83, "wait" => 2, "next" => 13, "atk"=> 0}
@anime["skill2"][13] = {"pic" => 84, "wait" => 4, "next" => 14, "x_speed" => @me.dash_x_speed*1.5}
@anime["skill2"][14] = {"pic" => 85, "wait" => 2, "next" => 15, "x_speed" => @me.dash_x_speed}
@anime["skill2"][15] = {"pic" => 86,  "wait" => 2, "next" => 16, "anime" => [12,0,0], "x_speed" => @me.dash_x_speed*2}
@anime["skill2"][16] = {"pic" => 87,  "wait" => 2, "next" => 17}
@anime["skill2"][17] = {"pic" => 88,  "wait" => 2, "next" => 18}
@anime["skill2"][18] = {"pic" => 89,  "wait" => 2, "next" => 19}
@anime["skill2"][19] = {"pic" => 90,  "wait" => 2, "next" => 20}
@anime["skill2"][20] = {"pic" => 91,  "wait" => 2, "next" => 21}
@anime["skill2"][21] = {"pic" => 92,  "wait" => 2, "next" => 22}
@anime["skill2"][22] = {"pic" => 93,  "wait" => 2, "next" => 23}
@anime["skill2"][23] = {"pic" => 94,  "wait" => 4, "next" => ["stand"], "var_reset" => true}
#-------------------------------------------------------------------------------
# ○ 葉豬狂奔(難以上)
#-------------------------------------------------------------------------------
@anime["skill3"][0] = {"pic" => 21, "wait" => 2, "next" => 1, "anime" => [11,0,0], "z_pos" =>  1, "ab_uncancel" => 18, "uncancel" => true, "super_armor" => 5}
@anime["skill3"][1] = {"pic" => 22, "wait" => 2, "next" => 2, "atk" => [@me.stand_body_rect]}
@anime["skill3"][2] = {"pic" => 23, "wait" => 2, "next" => 3}
@anime["skill3"][3] = {"pic" => 24, "wait" => 2, "next" => 4}
@anime["skill3"][4] = {"pic" => 25, "wait" => 2, "next" => 5, "anime" => [11,0,0]}
@anime["skill3"][5] = {"pic" => 26, "wait" => 2, "next" => 6}
@anime["skill3"][6] = {"pic" => 27, "wait" => 2, "next" => 7, "hit_reset" => true}
@anime["skill3"][7] = {"pic" => 21, "wait" => 2, "next" => 8}
@anime["skill3"][8] = {"pic" => 22, "wait" => 2, "next" => 9}
@anime["skill3"][9] = {"pic" => 23, "wait" => 2, "next" => 10, "anime" => [11,0,0]}
@anime["skill3"][10] = {"pic" => 24, "wait" => 2, "next" => 11}
@anime["skill3"][11] = {"pic" => 25, "wait" => 2, "next" => 12, "hit_reset" => true}
@anime["skill3"][12] = {"pic" => 26, "wait" => 2, "next" => 13}
@anime["skill3"][13] = {"pic" => 27, "wait" => 2, "next" => 14, "anime" => [11,0,0]}
@anime["skill3"][14] = {"pic" => 21, "wait" => 2, "next" => 15}
@anime["skill3"][15] = {"pic" => 22, "wait" => 2, "next" => 16}
@anime["skill3"][16] = {"pic" => 23, "wait" => 2, "next" => 17, "hit_reset" => true, "penetrate" => true}
@anime["skill3"][17] = {"pic" => 24, "wait" => 2, "next" => 18, "anime" => [11,0,0]}
@anime["skill3"][18] = {"pic" => 25, "wait" => 2, "next" => 19}
@anime["skill3"][19] = {"pic" => 26, "wait" => 2, "next" => 20}
@anime["skill3"][20] = {"pic" => 27, "wait" => 2, "next" => ["dash"]}

#-------------------------------------------------------------------------------
# ○ 泰山壓頂
#-------------------------------------------------------------------------------
@anime["skill4"][0] = {"pic" => 121, "wait" => 3, "next" => 1, "z_pos" =>  1, "ab_uncancel" => 18, "uncancel" => true, "super_armor" => 22}
@anime["skill4"][1] = {"pic" => 122, "wait" => 3, "next" => 2}
@anime["skill4"][2] = {"pic" => 123, "wait" => 12, "next" => 3}
# 飛起
@anime["skill4"][3] = {"pic" => 126, "wait" => 12, "next" => 4, "anime" => [11,0,0], "y_speed" => 34.8, "physical" => false, "se"=> ["swing", 80, 100]}
# 鎖定位置
@anime["skill4"][4] = {"pic" => 126, "wait" => 55, "next" => 5}
# 下墜
@anime["skill4"][5] = {"pic" => 124, "wait" => 99, "next" => 6, "se"=> ["fall2", 80, 80], "y_speed" => -5.7, "y_fixed" => false, "atk" => [@me.stand_body_rect]}
# 著地
@anime["skill4"][6] = {"pic" => 124, "wait" => 8, "next" => 7, "atk" => [@me.stand_body_rect, Rect.new(-15000, -1, 30000, 1)], "se"=> ["shoot3", 80, 100], "physical" => true, "hit_reset" => true, "bullet" => [@me, "skill4_effect", 0, 0, 1, false, true]}
@anime["skill4"][7] = {"pic" => 124, "wait" => 24, "next" => 8, "atk" => 0}
@anime["skill4"][8] = {"pic" => 126, "wait" => 3, "next" => 9}
@anime["skill4"][9] = {"pic" => 125, "wait" => 3, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 碎石特效
#-------------------------------------------------------------------------------
@anime["skill4_effect"][0] = {"pic" => 511, "wait" => 5, "next" => 1, "z_pos" => 3}
@anime["skill4_effect"][1] = {"pic" => 512, "wait" => 5, "next" => 2}
@anime["skill4_effect"][2] = {"pic" => 513, "wait" => 5, "next" => 3}
@anime["skill4_effect"][3] = {"pic" => 514, "wait" => 5, "next" => 4}
@anime["skill4_effect"][4] = {"pic" => 515, "wait" => 5, "next" => 5}
@anime["skill4_effect"][5] = {"pic" => 516, "wait" => 5, "next" => ["dispose"]}

#-------------------------------------------------------------------------------
# ○ 飛葉
#-------------------------------------------------------------------------------
@anime["skill5"][0] = {"pic" => 131, "wait" => 4, "next" => 1, "z_pos" =>  1, "ab_uncancel" => 18, "uncancel" => true, "super_armor" => 5, "se"=> ["swing2", 70, 105]}
@anime["skill5"][1] = {"pic" => 132, "wait" => 4, "next" => 2}
@anime["skill5"][2] = {"pic" => 133, "wait" => 4, "next" => 3}
@anime["skill5"][3] = {"pic" => 134, "wait" => 4, "next" => 4}
@anime["skill5"][4] = {"pic" => 135, "wait" => 4, "next" => 5, "bullet" => [@me, "ball", 0, 159, 50, false, true], "se"=> ["swing3", 80, 80]}
@anime["skill5"][5] = {"pic" => 136, "wait" => 4, "next" => 6}
@anime["skill5"][6] = {"pic" => 137, "wait" => 4,  "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 葉子
#-------------------------------------------------------------------------------
@anime["ball"][0] = {"pic" => 501, "wait" => 2, "next" => 1, "z_pos" =>  3, "atk" => [Rect.new(-150, -58, 270, 50)], "x_speed" => 24.5}
@anime["ball"][1] = {"pic" => 502, "wait" => 2, "next" => 2}
@anime["ball"][2] = {"pic" => 501, "wait" => 2, "next" => 1}
@anime["ball"][3] = {"pic" => 999, "wait" => 2, "next" => ["dispose"], "atk" => 0}


# 技

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
    if ["damage1", "damage2", "guard", "guard_shock"].include?(@state)
    elsif @me.hp == 0
      return
    elsif @state == "b_flee" and @frame_number == 4
      change_anime("b_flee", 5)
      @me.z_pos = 0
    else
      change_anime("landing")
      @me.z_pos = 0
    end
    Audio.se_play("Audio/SE/" + CROUCH_SE, 75 * $game_config.se_rate / 10, 90)
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
  # ◇ 倒地(？
  #      ("N"：一般、"H"：重擊(摩擦地面)、"P"：壓制、"B"：反彈)
  #--------------------------------------------------------------------------
  def do_down
    super
    @down_count = 32
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
    return ["skill5"].include?(@state)
  end  
  #--------------------------------------------------------------------------
  # ◇ 必殺
  #--------------------------------------------------------------------------
  def x_skill?
    return ["skill", "skill2", "skill3", "skill4"].include?(@state)
  end  

#==============================================================================
# ■ 指令設置
#==============================================================================

  #-------------------------------------------------------------------------------
  # ○ 無按鍵
  #-------------------------------------------------------------------------------
  def no_press_action
    change_anime("stand") if @state == "walk"
    do_dashbreak if @state == "dash"
    change_anime("crouch_end") if @state == "crouch" 
    if @state == "guard"
      on_air? ? change_anime("jump_fall") : change_anime("stand")
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 按住→
  #      hold_time：按住時間
  #-------------------------------------------------------------------------------
  def hold_right
  end
  #-------------------------------------------------------------------------------
  # ○ 按住 ←
  #      hold_time：按住時間
  #-------------------------------------------------------------------------------
  def hold_left
  end
  #-------------------------------------------------------------------------------
  # ○ 按住↑
  #      dir：左右方向
  #-------------------------------------------------------------------------------
  def hold_up(dir)
  end
  #-------------------------------------------------------------------------------
  # ○ 按住↓
  #-------------------------------------------------------------------------------
  def hold_down
  end
  #-------------------------------------------------------------------------------
  # ○ 按住Z
  #-------------------------------------------------------------------------------
  def hold_z
  end
  #-------------------------------------------------------------------------------
  # ○ 按住X
  #-------------------------------------------------------------------------------
  def hold_x
  end
  #-------------------------------------------------------------------------------
  # ○ 按住S
  #-------------------------------------------------------------------------------
  def hold_s
  end 
  #-------------------------------------------------------------------------------
  # ○ 按住C
  #-------------------------------------------------------------------------------
  def hold_c
  end
  #-------------------------------------------------------------------------------
  # ○ 上
  #-------------------------------------------------------------------------------
  def up_action(dir)
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
  end
  #--------------------------------------------------------------------------
  # ◇ ←←
  #--------------------------------------------------------------------------
  def do_44
  end

  #--------------------------------------------------------------------------
  # ◇ ↑↑
  #--------------------------------------------------------------------------
  def do_88 
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
  end
  #-------------------------------------------------------------------------------
  # ○ →Z
  #-------------------------------------------------------------------------------
  def fz_action
    change_anime("dash2")
  end
  #-------------------------------------------------------------------------------
  # ○ ↓Z
  #-------------------------------------------------------------------------------
  def dz_action
    z_action
  end
  
  #-------------------------------------------------------------------------------
  # ○ ↑Z
  #-------------------------------------------------------------------------------
  def uz_action
  end
  #-------------------------------------------------------------------------------
  # ○ ←Z
  #-------------------------------------------------------------------------------
  def bz_action
  end
  #-------------------------------------------------------------------------------
  # ○ X
  #-------------------------------------------------------------------------------
  def x_action
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
  # ○ S
  #-------------------------------------------------------------------------------
  def s_action
  end
  #-------------------------------------------------------------------------------
  # ○ →S
  #-------------------------------------------------------------------------------
  def fs_action
    change_anime("skill")
    @me.awake_time = 0
  end
  #-------------------------------------------------------------------------------
  # ○ ↓S
  #-------------------------------------------------------------------------------
  def ds_action
  end
  #-------------------------------------------------------------------------------
  # ○ ↑S
  #-------------------------------------------------------------------------------
  def us_action
  end
  #-------------------------------------------------------------------------------
  # ○ ←S
  #-------------------------------------------------------------------------------
  def bs_action
  end
  #-------------------------------------------------------------------------------
  # ○ C
  #-------------------------------------------------------------------------------
  def c_action
    return if !controllable?
    @timely_guard_time = 3
  end
  #-------------------------------------------------------------------------------
  # ○ →C
  #-------------------------------------------------------------------------------
  def fc_action
  end
  #-------------------------------------------------------------------------------
  # ○ ↑C
  #-------------------------------------------------------------------------------
  def uc_action
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
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ 葉子
  #-------------------------------------------------------------------------------
  def ball
    @me.now_x_speed += 1.6 * @me.direction
    
    if @anime_time > 200
      change_anime("ball", 3)
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 泰山壓頂
  #-------------------------------------------------------------------------------
  def skill4
    
    # 跳
    if @frame_number == 3 and @anime_time < 24
      @me.now_y_speed += 14.2
    end
    
     if @anime_time == 24
       @y_fixed = true
     end
     
    # 鎖定主角 
    if @frame_number == 4
      @me.x_pos = $game_party.actors[0].x_pos
      @me.y_pos = 2400
    end
    
    # 下墜
    if @frame_number == 5
      @me.now_y_speed -= 3.2
      if @me.y_pos <= 0
        change_anime("skill4", 6)
        $game_screen.start_shake(12,8,40,1)
      end
    end
    
    
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ 常時監視A (不受暫停、受傷定格效果影響)
  #      通常用在調整受傷、倒地這種不確定何時恢復姿勢的情況
  #-------------------------------------------------------------------------------
  def respective_updateA
    
    @hard_skill_loop = 0 if ["damage1", "damage2"].include?(@state)
    
    if @me.dead?  and @state != "dead" and !downing?  #and (["stand"].include?(@state) or (["damage1", "damage2"].include?(@state) and !@catched))
      change_anime("dead")
      @hit_stop_duration = 20
    end
    
    # 成就解除：葉豬飛翔
    if @me.combohit >= 30 and $game_temp.battle_troop_id != 34
      $game_config.get_achievement(0)
    end
    
  end
  

  
  #-------------------------------------------------------------------------------
  # ○ 常時監視B (受暫停、受傷定格效果影響)
  #-------------------------------------------------------------------------------
  def respective_updateB
    
  #  @super_armor = 9999
    
    # 計算擊飛時間
    blowning? ? @blow_time += 1 : @blow_time = 0
    # 成就解除：葉豬飛翔
    if @blow_time >= $fps_set * 7 and $game_temp.battle_troop_id != 34
      $game_config.get_achievement(0)
    end
  
    if ["damage1", "damage2"].include?(@state) and @frame_number == 3  and !@catched #and @knock_back_duration <= 0
      var_reset
      change_anime("stand")
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
    
    if @state == "skill2" and @frame_number == 18
      if @hard_skill_loop < 2
       @hard_skill_loop += 1
       @me.direction *= -1
       # 最後一下
       if @hard_skill_loop == 2
         change_anime("skill2")
       else
      #   $game_temp.superstop_time = 10
         change_anime("skill2", 1)
       end
      end
    end
    
    if @state == "skill2" and @hard_skill_loop == 2 and (2..4) === @frame_number
      @me.now_x_speed += 2 * @me.direction
    end
    
    if @state == "skill2" and @frame_number == 23
      @hard_skill_loop = 0
    end
    
    if @state == "skill3"
      @me.now_x_speed = @me.dash_x_speed * @me.direction * 2
    end
    

    
  end
  
  
#==============================================================================
# ■ 其他
#==============================================================================
  #--------------------------------------------------------------------------
  # ◇ 去薯
  #--------------------------------------------------------------------------
  def go_dead_disappear
    @blur_effect = false
 #   @me.battle_sprite.collapse
#    @me.battle_sprite.battler_shadow.visible = false
    @me.dead_disappear = true
    @frame_duration = -1
    @me.combohit_clear
    @me.z_pos = -1
 #   common_event = $data_common_events[7]
    #$game_system.battle_interpreter.setup(common_event.list, 0)
    change_anime("dead", 19)
  end 
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
      
      if skill == "skill"
        result["power"] = 350
        result["limit"] = 280
        result["u_hitstop"] = 16
        result["t_hitstop"] = 16
        result["correction"] = 5
        result["t_knockback"] = 55
        result["x_speed"] = 9.2
        result["y_speed"] = 11.5
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se4", 85, 95]   
        result["h_zoom"] =  [4,9,9]
        result["d_zoom"] =  [4,11,11]
        result["h_shake"] = [6,8,8,1]
        result["d_shake"] = [6,9,8,1]
      elsif skill == "skill2" and @hard_skill_loop == 2
        result["power"] = 350
        result["limit"] = 210
        result["scope"].push("Down") # 倒地狀態可追打
        result["u_hitstop"] = 10
        result["t_hitstop"] = 10
        result["correction"] = 5
        result["t_knockback"] = 96
        result["x_speed"] = 5.2
        result["y_speed"] = 22.5
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se4", 85, 95]   
        result["h_zoom"] =  [4,9,9]
        result["d_zoom"] =  [4,11,11]
        result["h_shake"] = [8,10,8,1]
        result["d_shake"] = [8,12,8,1]
       elsif skill == "skill2"
        result["power"] = 150
        result["limit"] = 100
        result["scope"].push("Down") # 倒地狀態可追打
        result["u_hitstop"] = 10
        result["t_hitstop"] = 10
        result["correction"] = 5
        result["t_knockback"] = 75
        result["x_speed"] = 3.2
        result["y_speed"] = 18.8
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se4", 85, 95]   
        result["h_zoom"] =  [4,9,9]
        result["d_zoom"] =  [4,11,11]
        result["h_shake"] = [6,8,8,1]
        result["d_shake"] = [6,9,8,1]
       elsif skill == "skill3"
        result["power"] = 107
        result["limit"] = 68
        result["scope"].push("Down") # 倒地狀態可追打
        result["u_hitstop"] = 8
        result["t_hitstop"] = 8
        result["correction"] = 5
        result["t_knockback"] = 55
        result["x_speed"] = 7.2
        result["y_speed"] = 7.2
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]  
        result["h_zoom"] =  [4,9,9]
        result["d_zoom"] =  [4,11,11]
        result["h_shake"] = [6,8,8,1]
        result["d_shake"] = [6,9,8,1]
       elsif skill == "skill4" and @frame_number < 6
        result["power"] = 250
        result["limit"] = 150
        result["u_hitstop"] = 5
        result["t_hitstop"] = 5
        result["correction"] = 5
        result["t_knockback"] = 55
        result["y_speed"] = -12.2
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]  
        result["h_zoom"] =  [4,9,9]
        result["d_zoom"] =  [4,11,11]
        result["no_guard"] = true
       elsif skill == "skill4"
        result["power"] = 450
        result["limit"] = 350
        result["scope"].push("Down") # 倒地狀態可追打
        result["u_hitstop"] = 5
        result["t_hitstop"] = 5
        result["correction"] = 5
        result["t_knockback"] = 55
        result["y_speed"] = 24.2
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]  
        result["h_zoom"] =  [4,9,9]
        result["d_zoom"] =  [4,11,11]
        result["no_guard"] = true
       elsif skill == "ball"
        result["power"] = 120
        result["limit"] = 70
        result["u_hitstop"] = 12
        result["t_hitstop"] = 12
        result["correction"] = 5
        result["t_knockback"] = 32
        result["x_speed"] = [(@me.now_x_speed * 0.55).abs, 17.8].min
        result["y_speed"] = 7.6
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se1", 80, 95]  
        result["h_zoom"] =  [4,9,9]
        result["d_zoom"] =  [4,11,11]
        result["spark"] = [1, 5*rand(10), 9*(rand(6)+1)+30]
      else
      end #if end
      return result
  end #def end
end # class end
