#==============================================================================
# ■奶奶最終型態的模組
#==============================================================================
class CoralsFinal < Game_Motion
#--------------------------------------------------------------------------
# ○ 人物生成/初始化
#--------------------------------------------------------------------------
def initialize(me,frame=0,anime="stand")
  super
  
  
  # 宣告所有動畫
  @anime = {"stand" => [], "walk" => [], "dash" => [], "dash_break" => [],
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
  "atk1" => [], "atk2" => [], "atk3" => [], "atk3_2" => [], "atk4" => [],
  
  "break_away" => [],
  
  "ball1" => [],
  "ball2" => [], "ball2_break" => [], "ball2_helper" => [],
  "ball3" => [], "ball3_helper" => [],
  "thunder" => [], "thunder_helper" => [], "thunder_helper_root" => [],
  
  
  "sp1" => [], "magic_circle1" => [],
  
  "skill1" => [], "skill2" => [], "skill2_effect" => [], "skill2_effect2" => [], 
  
  # 爆炸
  "dead" => [], "dead2" => [],
  "dizzy1" => [], "dizzy2" => [], "catched" => []}
  
  
  # 設定動作的影格
  frame_set
  
  
  # 完全形態力場透明度轉換
  @full_power_ora_change = 1
  
  # 完全形態攻擊力1.5倍
  if $game_switches[STILILA::Corals_FullPower]
    @atk_rate = 1.5
  else
    @atk_rate = 1
  end
  
  
  
  @super_armor_cd = 0
  @full_limit = 11
  
  
end

#==============================================================================
# ■影格設置
#==============================================================================

def frame_set
#-------------------------------------------------------------------------------
# ○ 站立
#-------------------------------------------------------------------------------
@anime["stand"][0] = {"pic" => 1, "wait" => 5, "next" => 1, "body" => @me.stand_body_rect, "z_pos" =>  1}
@anime["stand"][1] = {"pic" => 2, "wait" => 5, "next" => 2}
@anime["stand"][2] = {"pic" => 3, "wait" => 5, "next" => 3}
@anime["stand"][3] = {"pic" => 4, "wait" => 5, "next" => 4}
@anime["stand"][4] = {"pic" => 5, "wait" => 5, "next" => 5}
@anime["stand"][5] = {"pic" => 6, "wait" => 5, "next" => 6}
@anime["stand"][6] = {"pic" => 7, "wait" => 5, "next" => 7}
@anime["stand"][7] = {"pic" => 8, "wait" => 5, "next" => 8}
@anime["stand"][8] = {"pic" => 9, "wait" => 5, "next" => 9}
@anime["stand"][9] = {"pic" => 1, "wait" => 5, "next" => 1}
#-------------------------------------------------------------------------------
# ○ 走路
#-------------------------------------------------------------------------------
@anime["walk"][0] = {"pic" => 12, "wait" => 3, "next" => 1, "z_pos" =>  1}
@anime["walk"][1] = {"pic" => 13, "wait" => 3, "next" => 2}
@anime["walk"][2] = {"pic" => 14, "wait" => 3, "next" => 3}
@anime["walk"][3] = {"pic" => 15, "wait" => 3, "next" => 4}
@anime["walk"][4] = {"pic" => 16, "wait" => 3, "next" => 5}
@anime["walk"][5] = {"pic" => 17, "wait" => 3, "next" => 6}
@anime["walk"][6] = {"pic" => 18, "wait" => 3, "next" => 7}
@anime["walk"][7] = {"pic" => 19, "wait" => 3, "next" => 0}
#-------------------------------------------------------------------------------
# ○ 跑步
#-------------------------------------------------------------------------------
@anime["dash"][0] = {"pic" => 16, "wait" => 4, "next" => 1, "anime" => [11,0,0], "z_pos" =>  1}
@anime["dash"][1] = {"pic" => 17, "wait" => 4, "next" => 2}
@anime["dash"][2] = {"pic" => 18, "wait" => 4, "next" => 3}
@anime["dash"][3] = { "pic" => 17, "wait" => 4, "next" => 0}
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
@anime["guard"][0] = {"pic" => 41, "wait" => 2, "next" => 0, "var_reset" => true}
@anime["guard_shock"][0] = {"pic" => 41, "wait" => -1, "next" => 0}

#-------------------------------------------------------------------------------
# ○ 受傷1
#-------------------------------------------------------------------------------
@anime["damage1"][0] = {"pic" => 21, "wait" => 3, "next" => 1}
@anime["damage1"][1] = {"pic" => 22, "wait" => 3, "next" => 2}
@anime["damage1"][2] = {"pic" => 23, "wait" => -1, "next" => 1}

#-------------------------------------------------------------------------------
# ○ 受傷2
#-------------------------------------------------------------------------------
@anime["damage2"][0] = {"pic" => 21, "wait" => 3, "next" => 1}
@anime["damage2"][1] = {"pic" => 22, "wait" => 3, "next" => 1}
@anime["damage2"][2] = {"pic" => 23, "wait" => -1, "next" => 1}

#-------------------------------------------------------------------------------
# ○ 正面擊飛
#-------------------------------------------------------------------------------
@anime["f_blow"][0] = {"pic" => 111, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect}
@anime["f_blow"][1] = {"pic" => 112, "wait" => 3, "next" => 2, "body" => Rect.new(-28 , -52, 46, 30)}
@anime["f_blow"][2] = {"pic" => 113, "wait" => 3, "next" => 3}
@anime["f_blow"][3] = {"pic" => 114, "wait" => -1, "next" => 3}
#-------------------------------------------------------------------------------
# ○ 背面擊飛
#-------------------------------------------------------------------------------
@anime["b_blow"][0] = {"pic" => 119, "wait" => 3, "next" => 1, "body" => @me.stand_body_rect}
@anime["b_blow"][1] = {"pic" => 118, "wait" => 5, "next" => 2}
@anime["b_blow"][2] = {"pic" => 117, "wait" => 6, "next" => 3, "body" => Rect.new(-32 , -59, 55, 30)}
@anime["b_blow"][3] = {"pic" => 116, "wait" => -1, "next" => 3, "body" => Rect.new(-15 , -70, 36, 41)}

#-------------------------------------------------------------------------------
# ○ 正面擊飛(重)
#-------------------------------------------------------------------------------
@anime["hf_blow"][0] = {"pic" => 111, "wait" => 2, "next" => 1, "body" => @me.stand_body_rect}
@anime["hf_blow"][1] = {"pic" => 112, "wait" => 2, "next" => 2}
@anime["hf_blow"][2] = {"pic" => 114, "wait" => 2, "next" => 3}
@anime["hf_blow"][3] = {"pic" => 115, "wait" => 2, "next" => 4}
@anime["hf_blow"][4] = {"pic" => 116, "wait" => 2, "next" => 5}
@anime["hf_blow"][5] = {"pic" => 117, "wait" => 2, "next" => 6}
@anime["hf_blow"][6] = {"pic" => 118, "wait" => 2, "next" => 7}
@anime["hf_blow"][7] = {"pic" => 119, "wait" => 2, "next" => 1}
#-------------------------------------------------------------------------------
# ○ 背面擊飛(重)
#-------------------------------------------------------------------------------
@anime["hb_blow"][0] = {"pic" => 119, "wait" => 2, "next" => 1, "body" => @me.stand_body_rect}
@anime["hb_blow"][1] = {"pic" => 118, "wait" => 2, "next" => 2}
@anime["hb_blow"][2] = {"pic" => 117, "wait" => 2, "next" => 3}
@anime["hb_blow"][3] = {"pic" => 116, "wait" => 2, "next" => 4}
@anime["hb_blow"][4] = {"pic" => 115, "wait" => 2, "next" => 5}
@anime["hb_blow"][5] = {"pic" => 114, "wait" => 2, "next" => 6}
@anime["hb_blow"][6] = {"pic" => 112, "wait" => 2, "next" => 1}

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
@anime["f_down"][0] = {"pic" => 121, "wait" => -1, "next" => 0, "ab_uncancel" => 22, "body" => @me.down_body_rect}
@anime["f_down_stand"][0] = {"pic" => 26, "wait" => 6, "next" => ["stand"], "ab_uncancel" => 8, "var_reset" => true, "body" => @me.sit_body_rect, "eva" => 10}
@anime["bounce_f_down"][0] = {"pic" => 122, "wait" => -1, "next" => 0, "body" => @me.down_body_rect}  # 反彈
#-------------------------------------------------------------------------------
# ○ 倒地－－面朝下/反彈/起身
#-------------------------------------------------------------------------------
@anime["b_down"][0] = {"pic" => 123, "wait" => -1, "next" => 0, "ab_uncancel" => 22, "body" => @me.down_body_rect}
@anime["b_down_stand"][0] = {"pic" => 26, "wait" => 6, "next" => ["stand"], "ab_uncancel" => 8, "var_reset" => true, "body" => @me.sit_body_rect, "eva" => 10}
@anime["bounce_b_down"][0] = {"pic" => 124, "wait" => -1, "next" => 0, "body" => @me.down_body_rect} # 反彈


#-------------------------------------------------------------------------------
# ○ 倒地－－壓制攻擊
#-------------------------------------------------------------------------------
@anime["pressure_f_down"][0] = {"pic" => 122, "wait" => 3, "next" => 0, "ab_uncancel" => 14, "body" => @me.down_body_rect}
@anime["pressure_b_down"][0] = {"pic" => 124, "wait" => 3, "next" => 0, "ab_uncancel" => 14, "body" => @me.down_body_rect}

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



# 技

#-------------------------------------------------------------------------------
# ○ 踩踏(舊)
#-------------------------------------------------------------------------------
@anime["atk1"][0] = {"pic" => 101, "wait" => 3, "next" => 1, "ab_uncancel" => 59, "uncancel" => true, "z_pos" => 3}
@anime["atk1"][1] = {"pic" => 102, "wait" => 3, "next" => 2}
@anime["atk1"][2] = {"pic" => 103, "wait" => 4, "next" => 3}
@anime["atk1"][3] = {"pic" => 104, "wait" => 7, "next" => 4}
@anime["atk1"][4] = {"pic" => 105, "wait" => 3, "next" => 5, "atk" => [Rect.new(20, -80, 110, 80)], "x_speed" => 8.4}
@anime["atk1"][5] = {"pic" => 106, "wait" => 7, "next" => 6, "x_speed" => 0}
@anime["atk1"][6] = {"pic" => 107, "wait" => 3, "next" => 7, "atk" => 0}
@anime["atk1"][7] = {"pic" => 108, "wait" => 3, "next" => 8}
@anime["atk1"][8] = {"pic" => 109, "wait" => 3, "next" => 9}
@anime["atk1"][9] = {"pic" => 110, "wait" => 3, "next" => 10, "x_speed" => 8.4}
@anime["atk1"][10] = {"pic" => 111, "wait" => 4, "next" => 11}
@anime["atk1"][11] = {"pic" => 112, "wait" => 7, "next" => 12}
@anime["atk1"][12] = {"pic" => 113, "wait" => 3, "next" => 13, "atk" => [Rect.new(20, -80, 150, 80)], "hit_reset" => true}
@anime["atk1"][13] = {"pic" => 114, "wait" => 7, "next" => 14, "x_speed" => 0}
@anime["atk1"][14] = {"pic" => 115, "wait" => 6, "next" => ["stand"], "atk" => 0, "var_reset" => true}


#-------------------------------------------------------------------------------
# ○ 踩踏
#-------------------------------------------------------------------------------
@anime["atk1"][0] = {"pic" => 101, "wait" => 6, "next" => 1, "ab_uncancel" => 70, "uncancel" => true, "z_pos" => 3, "super_armor" => 45}
@anime["atk1"][1] = {"pic" => 102, "wait" => 6, "next" => 2}
@anime["atk1"][2] = {"pic" => 103, "wait" => 7, "next" => 3}
@anime["atk1"][3] = {"pic" => 104, "wait" => 26, "next" => 4}
@anime["atk1"][4] = {"pic" => 107, "wait" => 1, "next" => 5, "atk" => [Rect.new(20, -140, 110, 140)], "x_speed" => 12.6, "se"=> ["Earth5", 70, 130]}
@anime["atk1"][5] = {"pic" => 108, "wait" => 1, "next" => 6, "x_speed" => 12.6}
@anime["atk1"][6] = {"pic" => 109, "wait" => 1, "next" => 7, "x_speed" => 12.6}
@anime["atk1"][7] = {"pic" => 111, "wait" => 1, "next" => 8, "x_speed" => 12.6}
@anime["atk1"][8] = {"pic" => 112, "wait" => 1, "next" => 9, "x_speed" => 12.6}
@anime["atk1"][9] = {"pic" => 115, "wait" => 1, "next" => 10, "atk" => [Rect.new(20, -140, 150, 140)], "hit_reset" => true, "x_speed" => 12.6, "se"=> ["Earth5", 70, 130]}

@anime["atk1"][10] = {"pic" => 102, "wait" => 1, "next" => 11, "x_speed" => 12.6}
@anime["atk1"][11] = {"pic" => 103, "wait" => 1, "next" => 12, "x_speed" => 12.6}
@anime["atk1"][12] = {"pic" => 104, "wait" => 1, "next" => 13, "x_speed" => 12.6}
@anime["atk1"][13] = {"pic" => 107, "wait" => 1, "next" => 14, "atk" => [Rect.new(20, -140, 110, 140)], "hit_reset" => true, "x_speed" => 12.6, "se"=> ["Earth5", 70, 130]}
@anime["atk1"][14] = {"pic" => 108, "wait" => 1, "next" => 15, "x_speed" => 12.6}
@anime["atk1"][15] = {"pic" => 109, "wait" => 1, "next" => 16, "x_speed" => 12.6}
@anime["atk1"][16] = {"pic" => 111, "wait" => 1, "next" => 17, "x_speed" => 12.6}
@anime["atk1"][17] = {"pic" => 112, "wait" => 1, "next" => 18, "x_speed" => 12.6}
@anime["atk1"][18] = {"pic" => 115, "wait" => 1, "next" => 19, "atk" => [Rect.new(20, -140, 150, 140)], "hit_reset" => true, "se"=> ["Earth5", 70, 130]}

@anime["atk1"][19] = {"pic" => 102, "wait" => 1, "next" => 20, "x_speed" => 12.6}
@anime["atk1"][20] = {"pic" => 103, "wait" => 1, "next" => 21, "x_speed" => 12.6}
@anime["atk1"][21] = {"pic" => 104, "wait" => 1, "next" => 22, "x_speed" => 12.6}
@anime["atk1"][22] = {"pic" => 107, "wait" => 1, "next" => 23, "atk" => [Rect.new(20, -140, 110, 140)], "hit_reset" => true, "x_speed" => 12.6, "se"=> ["Earth5", 70, 130]}
@anime["atk1"][23] = {"pic" => 108, "wait" => 1, "next" => 24, "x_speed" => 12.6}
@anime["atk1"][24] = {"pic" => 109, "wait" => 1, "next" => 25, "x_speed" => 12.6}
@anime["atk1"][25] = {"pic" => 111, "wait" => 1, "next" => 26, "x_speed" => 12.6}
@anime["atk1"][26] = {"pic" => 112, "wait" => 1, "next" => 27, "x_speed" => 12.6}
@anime["atk1"][27] = {"pic" => 115, "wait" => 4, "next" => 28, "atk" => [Rect.new(20, -140, 150, 140)], "hit_reset" => true, "se"=> ["Earth5", 70, 130]}

@anime["atk1"][28] = {"pic" => 101, "wait" => 6, "next" => ["stand"], "atk" => 0, "var_reset" => true, "x_speed" => 0}


#-------------------------------------------------------------------------------
# ○ 地柱術
#-------------------------------------------------------------------------------
@anime["atk2"][0] = {"pic" => 141, "wait" => 3, "next" => 1, "ab_uncancel" => 36, "uncancel" => true, "z_pos" => 3, "super_armor" => 24}
@anime["atk2"][1] = {"pic" => 142, "wait" => 3, "next" => 2}
@anime["atk2"][2] = {"pic" => 143, "wait" => 3, "next" => 3}
@anime["atk2"][3] = {"pic" => 144, "wait" => 3, "next" => 4}
@anime["atk2"][4] = {"pic" => 145, "wait" => 3, "next" => 5}
@anime["atk2"][5] = {"pic" => 146, "wait" => 3, "next" => 6}
@anime["atk2"][6] = {"pic" => 147, "wait" => 3, "next" => 7}
@anime["atk2"][7] = {"pic" => 148, "wait" => 5, "next" => 8}
@anime["atk2"][8] = {"pic" => 149, "wait" => 4, "next" => 9, "atk" => [Rect.new(30, -90, 140, 90)], "bullet" => [@me, "ball1", 0, 295, 0, false, true]}
@anime["atk2"][9] = {"pic" => 150, "wait" => 6, "next" => 10, "atk" => 0, "x_speed" => 0}
@anime["atk2"][10] = {"pic" => 151, "wait" => 3, "next" => 11}
@anime["atk2"][11] = {"pic" => 152, "wait" => 3, "next" => 12}
@anime["atk2"][12] = {"pic" => 153, "wait" => 3, "next" => 13}
@anime["atk2"][13] = {"pic" => 154, "wait" => 3, "next" => 14}
@anime["atk2"][14] = {"pic" => 155, "wait" => 3, "next" => 15}
@anime["atk2"][15] = {"pic" => 156, "wait" => 3, "next" => 16}
@anime["atk2"][16] = {"pic" => 157, "wait" => 3, "next" => 17}
@anime["atk2"][17] = {"pic" => 158, "wait" => 4, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 毒尾
#-------------------------------------------------------------------------------
@anime["atk4"][0] = {"pic" => 161, "wait" => 4, "next" => 1, "ab_uncancel" => 32, "uncancel" => true, "z_pos" => 3}
@anime["atk4"][1] = {"pic" => 162, "wait" => 4, "next" => 2}
@anime["atk4"][2] = {"pic" => 163, "wait" => 5, "next" => 3}
@anime["atk4"][3] = {"pic" => 164, "wait" => 4, "next" => 4}
@anime["atk4"][4] = {"pic" => 165, "wait" => 3, "next" => 5, "atk" => [Rect.new(170, -150, 130, 150)]}
@anime["atk4"][5] = {"pic" => 166, "wait" => 3, "next" => 6}
@anime["atk4"][6] = {"pic" => 167, "wait" => 3, "next" => 7, "atk" => 0}
@anime["atk4"][7] = {"pic" => 168, "wait" => 3, "next" => 8}
@anime["atk4"][8] = {"pic" => 169, "wait" => 3, "next" => 9}
@anime["atk4"][9] = {"pic" => 168, "wait" => 3, "next" => 10}
@anime["atk4"][10] = {"pic" => 169, "wait" => 3, "next" => 11}
@anime["atk4"][11] = {"pic" => 168, "wait" => 3, "next" => 12}
@anime["atk4"][12] = {"pic" => 169, "wait" => 6, "next" => 13}
@anime["atk4"][13] = {"pic" => 170, "wait" => 3, "next" => 14}
@anime["atk4"][14] = {"pic" => 171, "wait" => 3, "next" => 15}
@anime["atk4"][15] = {"pic" => 172, "wait" => 3, "next" => 16}
@anime["atk4"][16] = {"pic" => 173, "wait" => 3, "next" => 17}
@anime["atk4"][17] = {"pic" => 174, "wait" => 4, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 丟隕石
#-------------------------------------------------------------------------------
@anime["atk3"][0] = {"pic" => 121, "wait" => 3, "next" => 1, "ab_uncancel" => 5, "uncancel" => true, "z_pos" => 3, "se"=> ["108-Heal04", 90, 50]}
@anime["atk3"][1] = {"pic" => 122, "wait" => 3, "next" => 2}
@anime["atk3"][2] = {"pic" => 123, "wait" => 3, "next" => 3}
@anime["atk3"][3] = {"pic" => 124, "wait" => 3, "next" => 4}
@anime["atk3"][4] = {"pic" => 125, "wait" => 3, "next" => 5}
@anime["atk3"][5] = {"pic" => 126, "wait" => 3, "next" => 6}
@anime["atk3"][6] = {"pic" => 127, "wait" => 3, "next" => 7, "se"=> ["swing2", 96, 100], "bullet" => [@me, "ball2_helper", 0, 109, 443, false, true]}
@anime["atk3"][7] = {"pic" => 128, "wait" => 7, "next" => 8}
@anime["atk3"][8] = {"pic" => 129, "wait" => 4, "next" => 9}
@anime["atk3"][9] = {"pic" => 130, "wait" => 4, "next" => 10}
@anime["atk3"][10] = {"pic" => 131, "wait" => 3, "next" => 11}
@anime["atk3"][11] = {"pic" => 132, "wait" => 3, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 閃電術 (困難以上取代原定義)
#-------------------------------------------------------------------------------
#if  $game_variables[STILILA::GAME_LEVEL] >= 2
@anime["atk3_2"][0] = {"pic" => 121, "wait" => 3, "next" => 1, "ab_uncancel" => 5, "uncancel" => true, "z_pos" => 3, "se"=> ["108-Heal04", 90, 50]}
@anime["atk3_2"][1] = {"pic" => 122, "wait" => 3, "next" => 2}
@anime["atk3_2"][2] = {"pic" => 123, "wait" => 3, "next" => 3}
@anime["atk3_2"][3] = {"pic" => 124, "wait" => 3, "next" => 4}
@anime["atk3_2"][4] = {"pic" => 125, "wait" => 3, "next" => 5}
@anime["atk3_2"][5] = {"pic" => 126, "wait" => 3, "next" => 6}
@anime["atk3_2"][6] = {"pic" => 127, "wait" => 3, "next" => 7, "se"=> ["swing2", 96, 100], "bullet" => [@me, "thunder_helper_root", 0, 0, 0, false, true]}
@anime["atk3_2"][7] = {"pic" => 128, "wait" => 7, "next" => 8}
@anime["atk3_2"][8] = {"pic" => 129, "wait" => 4, "next" => 9}
@anime["atk3_2"][9] = {"pic" => 130, "wait" => 4, "next" => 10}
@anime["atk3_2"][10] = {"pic" => 131, "wait" => 3, "next" => 11}
@anime["atk3_2"][11] = {"pic" => 132, "wait" => 3, "next" => ["stand"], "var_reset" => true}
#end

#-------------------------------------------------------------------------------
# ○ 毒尾連刺
#-------------------------------------------------------------------------------
@anime["skill1"][0] = {"pic" => 161, "wait" => 4, "next" => 1, "ab_uncancel" => 88, "uncancel" => true, "z_pos" => 3, "anime" => [1,0,0], "superstop" => 20, "camera" => [48,30,30], "black" => [48,50], "fps" => [23, 55], "blur" => true, "eva" => 14}
@anime["skill1"][1] = {"pic" => 162, "wait" => 4, "next" => 2}
@anime["skill1"][2] = {"pic" => 163, "wait" => 5, "next" => 3}
@anime["skill1"][3] = {"pic" => 164, "wait" => 2, "next" => 4}
@anime["skill1"][4] = {"pic" => 233, "wait" => 2, "next" => 5, "atk" => [Rect.new(50, -250, 250, 250)], "hit_reset" => true, "x_speed" => 3.3, "bullet" => [@me, "skill2_effect2", 0, 90, 0, false, true]}
@anime["skill1"][5] = {"pic" => 234, "wait" => 2, "next" => 6}
@anime["skill1"][6] = {"pic" => 232, "wait" => 2, "next" => 7, "atk" => [Rect.new(50, -250, 250, 250)], "hit_reset" => true, "x_speed" => 3.3}
@anime["skill1"][7] = {"pic" => 234, "wait" => 2, "next" => 8}
@anime["skill1"][8] = {"pic" => 231, "wait" => 2, "next" => 9, "atk" => [Rect.new(50, -250, 250, 250)], "hit_reset" => true, "x_speed" => 3.3}
@anime["skill1"][9] = {"pic" => 234, "wait" => 2, "next" => 10}
@anime["skill1"][10] = {"pic" => 233, "wait" => 2, "next" => 11, "atk" => [Rect.new(50, -250, 250, 250)], "hit_reset" => true, "x_speed" => 3.3, "bullet" => [@me, "skill2_effect2", 0, 90, 0, false, true]}
@anime["skill1"][11] = {"pic" => 234, "wait" => 2, "next" => 12}
@anime["skill1"][12] = {"pic" => 232, "wait" => 2, "next" => 13, "atk" => [Rect.new(50, -250, 250, 250)], "hit_reset" => true, "x_speed" => 3.3}
@anime["skill1"][13] = {"pic" => 234, "wait" => 2, "next" => 14}
@anime["skill1"][14] = {"pic" => 233, "wait" => 2, "next" => 15, "atk" => [Rect.new(50, -250, 250, 250)], "hit_reset" => true, "x_speed" => 3.3}
@anime["skill1"][15] = {"pic" => 234, "wait" => 2, "next" => 16}
@anime["skill1"][16] = {"pic" => 231, "wait" => 2, "next" => 17, "atk" => [Rect.new(50, -250, 250, 250)], "hit_reset" => true, "x_speed" => 3.3, "bullet" => [@me, "skill2_effect2", 0, 90, 0, false, true]}
@anime["skill1"][17] = {"pic" => 234, "wait" => 2, "next" => 18}
@anime["skill1"][18] = {"pic" => 233, "wait" => 2, "next" => 19, "atk" => [Rect.new(50, -250, 250, 250)], "hit_reset" => true, "x_speed" => 3.3}
@anime["skill1"][19] = {"pic" => 234, "wait" => 2, "next" => 20}
@anime["skill1"][20] = {"pic" => 231, "wait" => 2, "next" => 21, "atk" => [Rect.new(50, -250, 250, 250)], "hit_reset" => true, "x_speed" => 3.3}
@anime["skill1"][21] = {"pic" => 234, "wait" => 2, "next" => 22}
@anime["skill1"][22] = {"pic" => 232, "wait" => 2, "next" => 23, "atk" => [Rect.new(50, -250, 250, 250)], "hit_reset" => true, "x_speed" => 3.3, "bullet" => [@me, "skill2_effect2", 0, 90, 0, false, true]}
@anime["skill1"][23] = {"pic" => 234, "wait" => 2, "next" => 24}
@anime["skill1"][24] = {"pic" => 233, "wait" => 2, "next" => 25, "atk" => [Rect.new(50, -250, 250, 250)], "hit_reset" => true, "x_speed" => 3.3}
@anime["skill1"][25] = {"pic" => 234, "wait" => 2, "next" => 26}
@anime["skill1"][26] = {"pic" => 232, "wait" => 2, "next" => 27, "atk" => [Rect.new(50, -250, 250, 250)], "hit_reset" => true, "x_speed" => 3.3}
@anime["skill1"][27] = {"pic" => 234, "wait" => 2, "next" => 28}
@anime["skill1"][28] = {"pic" => 233, "wait" => 2, "next" => 29, "atk" => [Rect.new(50, -250, 250, 250)], "hit_reset" => true, "x_speed" => 3.3, "bullet" => [@me, "skill2_effect2", 0, 90, 0, false, true]}
@anime["skill1"][29] = {"pic" => 161, "wait" => 3, "next" => 30}
@anime["skill1"][30] = {"pic" => 162, "wait" => 3, "next" => 31, "atk" => 0}
@anime["skill1"][31] = {"pic" => 163, "wait" => 4, "next" => 32}
@anime["skill1"][32] = {"pic" => 164, "wait" => 3, "next" => 33, "superstop" => 16}
@anime["skill1"][33] = {"pic" => 165, "wait" => 2, "next" => 34, "atk" => [Rect.new(50, -250, 300, 250)], "hit_reset" => true, "x_speed" => 3.3, "bullet" => [@me, "skill2_effect2", 0, 90, 0, false, true]}
@anime["skill1"][34] = {"pic" => 166, "wait" => 3, "next" => 35}
@anime["skill1"][35] = {"pic" => 167, "wait" => 3, "next" => 36, "atk" => 0}
@anime["skill1"][36] = {"pic" => 168, "wait" => 3, "next" => 37}
@anime["skill1"][37] = {"pic" => 169, "wait" => 3, "next" => 38}
@anime["skill1"][38] = {"pic" => 168, "wait" => 3, "next" => 39}
@anime["skill1"][39] = {"pic" => 169, "wait" => 3, "next" => 40}
@anime["skill1"][40] = {"pic" => 168, "wait" => 3, "next" => 41}
@anime["skill1"][41] = {"pic" => 169, "wait" => 6, "next" => 42}
@anime["skill1"][42] = {"pic" => 170, "wait" => 3, "next" => 43}
@anime["skill1"][43] = {"pic" => 171, "wait" => 3, "next" => 44}
@anime["skill1"][44] = {"pic" => 172, "wait" => 3, "next" => 45}
@anime["skill1"][45] = {"pic" => 173, "wait" => 3, "next" => 46}
@anime["skill1"][46] = {"pic" => 174, "wait" => 4, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 掙脫
#-------------------------------------------------------------------------------
@anime["break_away"][0] = {"pic" => 125, "wait" => 3, "next" => 1, "ab_uncancel" => 32, "uncancel" => true, "z_pos" => 3, "eva" => 26, "super_armor" => 1, "anime" => [9,0,0]}
@anime["break_away"][1] = {"pic" => 126, "wait" => 7, "next" => 2}
@anime["break_away"][2] = {"pic" => 128, "wait" => 4, "next" => 3, "atk" => [Rect.new(-220, -310, 440, 310)]}
@anime["break_away"][3] = {"pic" => 128, "wait" => 8, "next" => 4, "atk" => 0}
@anime["break_away"][4] = {"pic" => 129, "wait" => 3, "next" => 5}
@anime["break_away"][5] = {"pic" => 130, "wait" => 3, "next" => 6}
@anime["break_away"][6] = {"pic" => 131, "wait" => 3, "next" => 7}
@anime["break_away"][7] = {"pic" => 132, "wait" => 3, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 地柱本體
#-------------------------------------------------------------------------------
@anime["ball1"][0] = {"pic" => 501, "wait" => 35, "next" => 1, "z_pos" => 3, "se"=> ["Earth10", 86, 90]}
@anime["ball1"][1] = {"pic" => 502, "wait" => 3, "next" => 2}
@anime["ball1"][2] = {"pic" => 503, "wait" => 3, "next" => 3, "atk" => [Rect.new(-70, -100, 230, 90)], "se"=> ["Earth5", 86, 90]}
@anime["ball1"][3] = {"pic" => 504, "wait" => 3, "next" => 4}
@anime["ball1"][4] = {"pic" => 505, "wait" => 20, "next" => 5, "atk" => 0}
@anime["ball1"][5] = {"pic" => 506, "wait" => 3, "next" => ["dispose"]}

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
@anime["thunder_helper"][0] = {"pic" => 638, "wait" => 122, "next" => ["dispose"], "z_pos" => -1}

#-------------------------------------------------------------------------------
# ○ 閃電發射器(母體)
#-------------------------------------------------------------------------------
@anime["thunder_helper_root"][0] = {"pic" => 0, "wait" => 100, "next" => ["dispose"], "z_pos" => -1}

#-------------------------------------------------------------------------------
# ○ 閃電
#-------------------------------------------------------------------------------
@anime["thunder"][0] = {"pic" => 631, "wait" => 3, "next" => 1, "z_pos" => 3, "se"=> ["123-Thunder01", 86, 90]}
@anime["thunder"][1] = {"pic" => 632, "wait" => 3, "next" => 2}
@anime["thunder"][2] = {"pic" => 0, "wait" => 30, "next" => 3}
@anime["thunder"][3] = {"pic" => 632, "wait" => 3, "next" => 4}
@anime["thunder"][4] = {"pic" => 633, "wait" => 2, "next" => 5, "se"=> ["124-Thunder02", 86, 90]}
@anime["thunder"][5] = {"pic" => 634, "wait" => 2, "next" => 6, "atk" => [Rect.new(-75, -520, 150, 520)]}
@anime["thunder"][6] = {"pic" => 635, "wait" => 2, "next" => 7}
@anime["thunder"][7] = {"pic" => 636, "wait" => 2, "next" => 8}
@anime["thunder"][8] = {"pic" => 635, "wait" => 2, "next" => 9}
@anime["thunder"][9] = {"pic" => 0, "wait" => 8, "next" => 10, "atk" => 0}
@anime["thunder"][10] = {"pic" => 632, "wait" => 3, "next" => 11}
@anime["thunder"][11] = {"pic" => 631, "wait" => 3, "next" => 12}
@anime["thunder"][12] = {"pic" => 0, "wait" => 3, "next" => ["dispose"]}




#-------------------------------------------------------------------------------
# ○ 用力下踩
#-------------------------------------------------------------------------------
@anime["skill2"][0] = {"pic" => 142, "wait" => 2, "next" => 1, "ab_uncancel" => 98, "uncancel" => true, "z_pos" => 3, "super_armor" => 20}
@anime["skill2"][1] = {"pic" => 143, "wait" => 2, "next" => 2}
@anime["skill2"][2] = {"pic" => 144, "wait" => 2, "next" => 3}
@anime["skill2"][3] = {"pic" => 145, "wait" => 2, "next" => 4}
@anime["skill2"][4] = {"pic" => 146, "wait" => 2, "next" => 5}
@anime["skill2"][5] = {"pic" => 147, "wait" => 2, "next" => 6}
@anime["skill2"][6] = {"pic" => 148, "wait" => 20, "next" => 7, "anime" => [1,0,0], "superstop" => 60, "supermove" => 60, "camera" => [48,30,30], "black" => [48,50], "fps" => [23, 55]}
@anime["skill2"][7] = {"pic" => 235, "wait" => 2, "next" => 8, "se"=> ["eco00", 70, 116], "super_armor" => 49} #, "superstop" => 40, "supermove" => 40
@anime["skill2"][8] = {"pic" => 148, "wait" => 2, "next" => 9}
@anime["skill2"][9] = {"pic" => 235, "wait" => 2, "next" => 10}
@anime["skill2"][10] = {"pic" => 148, "wait" => 2, "next" => 11}
@anime["skill2"][11] = {"pic" => 235, "wait" => 2, "next" => 12}
@anime["skill2"][12] = {"pic" => 148, "wait" => 2, "next" => 13}
@anime["skill2"][13] = {"pic" => 235, "wait" => 2, "next" => 14}
@anime["skill2"][14] = {"pic" => 148, "wait" => 2, "next" => 15}
@anime["skill2"][15] = {"pic" => 235, "wait" => 2, "next" => 16}
@anime["skill2"][16] = {"pic" => 148, "wait" => 2, "next" => 17}
@anime["skill2"][17] = {"pic" => 235, "wait" => 2, "next" => 18}
@anime["skill2"][18] = {"pic" => 148, "wait" => 2, "next" => 19}
@anime["skill2"][19] = {"pic" => 235, "wait" => 2, "next" => 20}
@anime["skill2"][20] = {"pic" => 148, "wait" => 2, "next" => 21}
@anime["skill2"][21] = {"pic" => 235, "wait" => 2, "next" => 22}
@anime["skill2"][22] = {"pic" => 148, "wait" => 2, "next" => 23}
@anime["skill2"][23] = {"pic" => 235, "wait" => 2, "next" => 24}
@anime["skill2"][24] = {"pic" => 148, "wait" => 2, "next" => 25}
@anime["skill2"][25] = {"pic" => 235, "wait" => 2, "next" => 26}
@anime["skill2"][26] = {"pic" => 148, "wait" => 2, "next" => 27}
@anime["skill2"][27] = {"pic" => 235, "wait" => 2, "next" => 28}
@anime["skill2"][28] = {"pic" => 148, "wait" => 2, "next" => 29}
@anime["skill2"][29] = {"pic" => 235, "wait" => 2, "next" => 30}
@anime["skill2"][30] = {"pic" => 148, "wait" => 2, "next" => 31}
@anime["skill2"][31] = {"pic" => 235, "wait" => 2, "next" => 32}
@anime["skill2"][32] = {"pic" => 235, "wait" => 5, "next" => 33, "x_speed" => 19.8, "bullet" => [@me, "skill2_effect2", 0, 90, 0, false, true]}
@anime["skill2"][33] = {"pic" => 149, "wait" => 5, "next" => 34, "atk" => [Rect.new(0, -140, 170, 140)], "bullet" => [@me, "skill2_effect", 0, 105, 50, false, true], "se"=> ["shoot3", 76, 100]}
@anime["skill2"][34] = {"pic" => 150, "wait" => 6, "next" => 35, "atk" => 0, "uncancel" => true, "x_speed" => 5.7}
@anime["skill2"][35] = {"pic" => 151, "wait" => 3, "next" => 36}
@anime["skill2"][36] = {"pic" => 152, "wait" => 3, "next" => 37}
@anime["skill2"][37] = {"pic" => 153, "wait" => 3, "next" => 38}
@anime["skill2"][38] = {"pic" => 154, "wait" => 3, "next" => 39}
@anime["skill2"][39] = {"pic" => 155, "wait" => 3, "next" => 40}
@anime["skill2"][40] = {"pic" => 156, "wait" => 3, "next" => 41}
@anime["skill2"][41] = {"pic" => 157, "wait" => 3, "next" => 42}
@anime["skill2"][42] = {"pic" => 158, "wait" => 4, "next" => ["stand"], "var_reset" => true}

#-------------------------------------------------------------------------------
# ○ 火花
#-------------------------------------------------------------------------------
@anime["skill2_effect"][0] = {"pic" => 521, "wait" => 3, "next" => 1, "z_pos" =>  3}
@anime["skill2_effect"][1] = {"pic" => 522, "wait" => 3, "next" => 2}
@anime["skill2_effect"][2] = {"pic" => 523, "wait" => 3, "next" => ["dispose"]}
#-------------------------------------------------------------------------------
# ○ 煙塵
#-------------------------------------------------------------------------------
@anime["skill2_effect2"][0] = {"pic" => 524, "wait" => 3, "next" => 1, "z_pos" =>  3}
@anime["skill2_effect2"][1] = {"pic" => 525, "wait" => 3, "next" => 2}
@anime["skill2_effect2"][2] = {"pic" => 524, "wait" => 3, "next" => 3}
@anime["skill2_effect2"][3] = {"pic" => 525, "wait" => 3, "next" => 4}
@anime["skill2_effect2"][4] = {"pic" => 524, "wait" => 3, "next" => 5}
@anime["skill2_effect2"][5] = {"pic" => 525, "wait" => 3, "next" => 6}
@anime["skill2_effect2"][6] = {"pic" => 526, "wait" => 3, "next" => ["dispose"]}


#-------------------------------------------------------------------------------
# ○ 怒技
#-------------------------------------------------------------------------------
@anime["sp1"][0] = {"pic" => 24, "wait" => 6, "next" => 1, "ab_uncancel" => 80, "uncancel" => true, "z_pos" => 3, "se"=> ["eco00", 70, 85], "anime" => [2,0,0], "bullet" => [@me, "magic_circle1", 0, 0, 0, false, true], "eva" => 13}
@anime["sp1"][1] = {"pic" => 41, "wait" => 6, "next" => 2}

@anime["sp1"][2] = {"pic" => 41, "wait" => 15, "next" => 3, "bullet" => [@me, "ball3_helper", 0, 0, 25, false, true]}#, "bullet" => [@me, "ball3", 0, 130, 253, false, true]}
@anime["sp1"][3] = {"pic" => 41, "wait" => 15, "next" => 4}#, "bullet" => [@me, "ball3", 0, -80, 223, false, true]}
@anime["sp1"][4] = {"pic" => 41, "wait" => 15, "next" => 5}#, "bullet" => [@me, "ball3", 0, 160, 323, false, true]}
@anime["sp1"][5] = {"pic" => 41, "wait" => 15, "next" => 6}#, "bullet" => [@me, "ball3", 0, -180, 283, false, true]}
@anime["sp1"][6] = {"pic" => 41, "wait" => 15, "next" => 7}#, "bullet" => [@me, "ball3", 0, 20, 203, false, true]}
@anime["sp1"][7] = {"pic" => 41, "wait" => 15, "next" => 8}#, "bullet" => [@me, "ball3", 0, -110, 363, false, true]}
@anime["sp1"][8] = {"pic" => 41, "wait" => 15, "next" => 9}#, "bullet" => [@me, "ball3", 0, 50, 173, false, true]}
@anime["sp1"][9] = {"pic" => 41, "wait" => 15, "next" => 10}#, "bullet" => [@me, "ball3", 0, -220, 353, false, true]}


@anime["sp1"][10] = {"pic" => 1, "wait" => 5, "next" => 11, "ab_uncancel" => 60}
@anime["sp1"][11] = {"pic" => 2, "wait" => 5, "next" => 12}
@anime["sp1"][12] = {"pic" => 3, "wait" => 5, "next" => 13}
@anime["sp1"][13] = {"pic" => 4, "wait" => 5, "next" => 14}
@anime["sp1"][14] = {"pic" => 5, "wait" => 5, "next" => 15}
@anime["sp1"][15] = {"pic" => 6, "wait" => 5, "next" => 16}
@anime["sp1"][16] = {"pic" => 7, "wait" => 5, "next" => 17}
@anime["sp1"][17] = {"pic" => 8, "wait" => 5, "next" => 18}
@anime["sp1"][18] = {"pic" => 9, "wait" => 5, "next" => 19}
@anime["sp1"][19] = {"pic" => 1, "wait" => 5, "next" => 10}

#-------------------------------------------------------------------------------
# ○ 狙擊彈
#-------------------------------------------------------------------------------
@anime["ball3"][0] = {"pic" => 531, "wait" => 4, "next" => 1, "z_pos" => 3}
@anime["ball3"][1] = {"pic" => 532, "wait" => 4, "next" => 2, "se"=> ["123-Thunder01", 60, 120]}
@anime["ball3"][2] = {"pic" => 533, "wait" => 4, "next" => 3}
@anime["ball3"][3] = {"pic" => 532, "wait" => 4, "next" => 4}
@anime["ball3"][4] = {"pic" => 531, "wait" => 4, "next" => 1}
#@anime["ball3"][5] = {"pic" => 536, "wait" => 999, "next" => 5}
# 著彈
@anime["ball3"][6] = {"pic" => 537, "wait" => 4, "next" => 7, "se"=> ["shoot3", 70, 90], "x_speed" => 0, "y_speed" => 0}
@anime["ball3"][7] = {"pic" => 538, "wait" => 4, "next" => 8}
@anime["ball3"][8] = {"pic" => 539, "wait" => 4, "next" => 9}
@anime["ball3"][9] = {"pic" => 540, "wait" => 4, "next" => ["dispose"]}


@anime["ball3_helper"][0] = {"pic" => 0, "wait" => 22, "next" => 1, "bullet" => [@me, "ball3", 0, 130, 253, false, true]}
@anime["ball3_helper"][1] = {"pic" => 0, "wait" => 22, "next" => 2, "bullet" => [@me, "ball3", 0, -80, 223, false, true]}
@anime["ball3_helper"][2] = {"pic" => 0, "wait" => 22, "next" => 3, "bullet" => [@me, "ball3", 0, 150, 113, false, true]}
@anime["ball3_helper"][3] = {"pic" => 0, "wait" => 22, "next" => 4, "bullet" => [@me, "ball3", 0, -180, 283, false, true]}
@anime["ball3_helper"][4] = {"pic" => 0, "wait" => 22, "next" => 5, "bullet" => [@me, "ball3", 0, 50, 323, false, true]}
@anime["ball3_helper"][5] = {"pic" => 0, "wait" => 22, "next" => 6, "bullet" => [@me, "ball3", 0, -110, 383, false, true]}
@anime["ball3_helper"][6] = {"pic" => 0, "wait" => 22, "next" => ["dispose"]}

#-------------------------------------------------------------------------------
# ○ 超必殺魔法陣
#-------------------------------------------------------------------------------
@anime["magic_circle1"][0] = {"pic" => 541, "wait" => 3, "next" => 1, "z_pos" => 0}
@anime["magic_circle1"][1] = {"pic" => 542, "wait" => 3, "next" => 2}
@anime["magic_circle1"][2] = {"pic" => 543, "wait" => 3, "next" => 3}
@anime["magic_circle1"][3] = {"pic" => 544, "wait" => 3, "next" => 4}
@anime["magic_circle1"][4] = {"pic" => 545, "wait" => 3, "next" => 5}
@anime["magic_circle1"][5] = {"pic" => 546, "wait" => 3, "next" => 6}
@anime["magic_circle1"][6] = {"pic" => 547, "wait" => 3, "next" => 7}
@anime["magic_circle1"][7] = {"pic" => 548, "wait" => 3, "next" => 8}
@anime["magic_circle1"][8] = {"pic" => 549, "wait" => 3, "next" => 9}
@anime["magic_circle1"][9] = {"pic" => 550, "wait" => 3, "next" => 0}

#-------------------------------------------------------------------------------
# ○ 掛掉
#-------------------------------------------------------------------------------
@anime["dead"][0] = {"pic" => 201, "wait" => 3, "next" => 1, "ab_uncancel" => 88, "body" => @me.down_body_rect, "z_pos" => 0}
@anime["dead"][1] = {"pic" => 202, "wait" => 3, "next" => 2}
@anime["dead"][2] = {"pic" => 203, "wait" => 3, "next" => 3}
@anime["dead"][3] = {"pic" => 204, "wait" => 3, "next" => 4}
@anime["dead"][4] = {"pic" => 205, "wait" => 3, "next" => 5}
@anime["dead"][5] = {"pic" => 206, "wait" => 3, "next" => 6}
@anime["dead"][6] = {"pic" => 207, "wait" => 3, "next" => 7}
@anime["dead"][7] = {"pic" => 208, "wait" => 3, "next" => 8}
@anime["dead"][8] = {"pic" => 209, "wait" => 3, "next" => 8}

#-------------------------------------------------------------------------------
# ○ 死透透
#-------------------------------------------------------------------------------
@anime["dead2"][0] = {"pic" => 211, "wait" => 5, "next" => 1, "ab_uncancel" => 88, "body" => @me.down_body_rect, "z_pos" => 0}
@anime["dead2"][1] = {"pic" => 212, "wait" => 5, "next" => 2}
@anime["dead2"][2] = {"pic" => 213, "wait" => 5, "next" => 3}
@anime["dead2"][3] = {"pic" => 214, "wait" => 5, "next" => 4}
@anime["dead2"][4] = {"pic" => 215, "wait" => 5, "next" => 5}
@anime["dead2"][5] = {"pic" => 216, "wait" => 5, "next" => 6}
@anime["dead2"][6] = {"pic" => 217, "wait" => 60, "next" => 7}
@anime["dead2"][7] = {"pic" => 218, "wait" => 5, "next" => 8}
@anime["dead2"][8] = {"pic" => 219, "wait" => 5, "next" => 9}
@anime["dead2"][9] = {"pic" => 220, "wait" => 5, "next" => 10}
@anime["dead2"][10] = {"pic" => 221, "wait" => 5, "next" => 11}
@anime["dead2"][11] = {"pic" => 222, "wait" => 5, "next" => 12}
@anime["dead2"][12] = {"pic" => 223, "wait" => 5, "next" => "go_dead_disappear"}

end




#==============================================================================
# ■ 主模組補強
#==============================================================================
 
  #--------------------------------------------------------------------------
  # ○ 解放
  #--------------------------------------------------------------------------
  def dispose
    if @full_power_ora != nil
      @full_power_ora.dispose
    end
    
  end
  #--------------------------------------------------------------------------
  # ◇ 去薯
  #--------------------------------------------------------------------------
  def go_dead_disappear
    @me.battle_sprite.visible = false
  end
  #--------------------------------------------------------------------------
  # ◇ 受傷額外處理
  #--------------------------------------------------------------------------
  def extra_damage_process
    super
    # 霸體CD
    @super_armor_cd = 50
  end

  #--------------------------------------------------------------------------
  # ◇ 執行其他預約指令
  #      處理5ZZ、5XX這種角色間不一定有的指令
  #--------------------------------------------------------------------------
  def do_other_plancommand
    
    p "這角色是敵人" if @me.is_a?(Game_Enemy)
    
    case @command_plan
    when 999999
      return
    end
    
    p "#{@command_plan} 沒設定到 do_other_plancommand"
  end
  
  #--------------------------------------------------------------------------
  # ◇ 著地
  #--------------------------------------------------------------------------
  def do_landing_step
    @me.now_x_speed = 0
    @me.now_y_speed = 0
    if ["damage1", "damage2", "guard", "guard_shock"].include?(@state)
    elsif @state == "b_flee" and @frame_number == 4
      change_anime("b_flee", 5)
      @me.z_pos = 0
    elsif @state == "ball2"
      $game_screen.start_shake(4,2,8,1)
      change_anime("ball2_break")
    elsif @state == "ball3"
     change_anime("ball3", 6)
     @me.now_x_speed = 0
     @me.now_y_speed = 0
    @now_jumps = 0
      return
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
    return ["atk1", "atk2", "atk3", "atk4"].include?(@state)
  end  
  #--------------------------------------------------------------------------
  # ◇ 必殺
  #--------------------------------------------------------------------------
  def x_skill?
    return ["skill1", "skill2", "sp1"].include?(@state)
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
    if ["stand", "walk"].include?(@state) or (@state == "guard" and @hold_key_c == 0)
      do_walk(1)
    elsif @state == "crouch" 
      change_anime("crouch_end")
    elsif @state == "dash"
      do_dash(1)
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 按住 ←
  #      hold_time：按住時間
  #-------------------------------------------------------------------------------
  def hold_left
    if  ["stand", "walk"].include?(@state) or (@state == "guard" and @hold_key_c == 0)
      do_walk(-1)
    elsif @state == "crouch" 
      change_anime("crouch_end")
    elsif @state == "dash"
      do_dash(-1)
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 按住↑
  #      dir：左右方向
  #-------------------------------------------------------------------------------
  def hold_up(dir)
    if ["stand", "walk", "dash","f_chase"].include?(@state)
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
  # ○ 按住↓
  #-------------------------------------------------------------------------------
  def hold_down
    if ["stand", "walk", "dash"].include?(@state) or (@state == "guard" and @hold_key_c == 0)
      change_anime("crouch_start")
    elsif @state == "crouch_start"
      change_anime("crouch")
    end
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
    if  ["stand", "walk", "dash", "dash_break", "jump_fall", "f_jump_fall", "b_jump_fall", "crouch"].include?(@state)
      @command_plan = "" # 指令預約移除
      @blur_effect = false
      change_anime("guard")
    end
    if @knock_back_duration <= 0 and blowning?
      do_ukemi
    end
  end
  #-------------------------------------------------------------------------------
  # ○ 上
  #-------------------------------------------------------------------------------
  def up_action(dir)
    if ["jump_fall", "f_jump_fall", "b_jump_fall", "hf_jump_fall", "hb_jump_fall", "h_jump_fall"].include?(@state) and @now_jumps  < 2
      @me.direction = dir if dir != 0
       change_anime("double_jump")
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
     if ["stand", "walk"].include?(@state)
       do_dash(1)
     end    
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
    if ["stand", "walk"].include?(@state)
       do_dash(-1)
     end
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
     # do_act("jz", "z","Z")
    else
      do_act("atk1", "z","Z")
    end
  end
  #-------------------------------------------------------------------------------
  # ○ →Z
  #-------------------------------------------------------------------------------
  def fz_action
 
    if on_air?
   #   do_act("jz", "j6z","Z")
    else
      do_act("atk2", "6z","Z")
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ↓Z
  #-------------------------------------------------------------------------------
  def dz_action

    if on_air?
   #   do_act("jz", "j6z","Z")
    else
      if  $game_variables[STILILA::GAME_LEVEL] >= 2
        do_act("atk3_2", "2z","Z")
      else
        do_act("atk3", "2z","Z")
      end
    end
  end
  
  #-------------------------------------------------------------------------------
  # ○ ↑Z
  #-------------------------------------------------------------------------------
  def uz_action

    if on_air?
   #   do_act("jz", "j6z","Z")
    else
      do_act("atk4", "8z","Z")
    end
  end
  #-------------------------------------------------------------------------------
  # ○ ←Z
  #-------------------------------------------------------------------------------
  def bz_action
     return
    if on_air?
       do_act("jz", "4z","Z")
    else
      unless ["stand", "walk", "run", "f_flee", "b_flee"].include?(@state) 
        do_act("atk2", "4z","Z") 
      end
    end
  end
  #-------------------------------------------------------------------------------
  # ○ X
  #-------------------------------------------------------------------------------
  def x_action
    do_act("skill1", "5x","X", false, false, 60) 
  end
  #-------------------------------------------------------------------------------
  # ○ →X
  #-------------------------------------------------------------------------------
  def fx_action
    do_act("skill2", "6x","X", false, false, 60) 
  end
  #-------------------------------------------------------------------------------
  # ○ ↓X
  #-------------------------------------------------------------------------------
  def dx_action
     do_act("sp1", "2x","X")
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
      if ["stand", "walk", "dash", "dash_break", "guard", "landing"].include?(@state) or 
        (@state == "f_flee" and (4..5) === @frame_number)
        change_anime("f_flee")
      end
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
  # ○ 地柱本體
  #-------------------------------------------------------------------------------
  def break_away
    @knock_back_duration = 0
  end
  #-------------------------------------------------------------------------------
  # ○ 地柱本體
  #-------------------------------------------------------------------------------
  def ball1
    if @anime_time == 1
 #     @me.y_pos = 0
      $game_screen.start_shake(8,3,6,1)
 #     @me.x_pos = $game_party.actors[0].x_pos #- (240*@me.direction)
    elsif @anime_time == 42
      $game_screen.start_shake(8,3,6,1)
    end
    
    $game_screen.start_shake(2,2,2,1) if @anime_time % 2 == 1
  end
  
  #-------------------------------------------------------------------------------
  # ○ 殞石術
  #-------------------------------------------------------------------------------
  def atk3
    if $game_variables[STILILA::GAME_LEVEL] < 2
      @me.ai.set_ai_trigger("atk_cd1", 220-rand(40)) if @anime_time == 1
    else
      @me.ai.set_ai_trigger("atk_cd1", 180-rand(40)) if @anime_time == 1
    end
     
  end
  #-------------------------------------------------------------------------------
  # ○ 閃電術
  #-------------------------------------------------------------------------------
  def atk3_2
    if $game_variables[STILILA::GAME_LEVEL] < 2
      @me.ai.set_ai_trigger("atk_cd1", 220-rand(40)) if @anime_time == 1
    else
      @me.ai.set_ai_trigger("atk_cd1", 180-rand(40)) if @anime_time == 1
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
      $scene.create_battle_bullets([@me.root, "ball2", 0, 0, 443, false, true])
  #  when 40
   #   Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
   #   $scene.create_battle_bullets([@me.root, "ball2", 0, 0, 443, false, true])
    when 50
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
      $scene.create_battle_bullets([@me.root, "ball2", 0, 0, 443, false, true])
    when 70
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
      $scene.create_battle_bullets([@me.root, "ball2", 0, 0, 443, false, true])
    when 120
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
      $scene.create_battle_bullets([@me.root, "ball2", 0, 0, 443, false, true])
    when 121
      do_dispose
    end
      

    
    # 困難追加
    if @anime_time == 30 and $game_variables[STILILA::GAME_LEVEL] > 1
      Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
      $scene.create_battle_bullets([@me.root, "ball2", 0, 0, 443, false, true])
    end
    
    # 鬼畜追加
 #   if @anime_time == 5 and $game_variables[STILILA::GAME_LEVEL] > 2
   #   Audio.se_play("Audio/SE/fire02", 80 * $game_config.se_rate / 10, 90)
   #   $scene.create_battle_bullets([@me.root, "ball2", 0, 0, 443, false, true])
   # end
    
    
    
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
  # ○ 怒技
  #-------------------------------------------------------------------------------
  def sp1
   @me.awake_time = 0 if @anime_time == 1
      
    if @anime_time == 180
      var_reset
      change_anime("stand", 0)
    end
    
  end
  
  #-------------------------------------------------------------------------------
  # ○ 狙擊彈
  #-------------------------------------------------------------------------------
  def ball3
    if @anime_time == 36
      target = $game_party.actors[0]
      @me.direction =  ((target.x_pos - @me.x_pos) > 0 ? 1 : -1)
    #  @me.now_x_speed = [((target.x_pos - @me.x_pos).abs / 50.0), 5.9].max * @me.direction
    #  @me.now_y_speed = ((target.y_pos + 30 - @me.y_pos) / 55.0)
    
      angle = Math.atan2(target.y_pos + 50 - @me.y_pos, target.x_pos - @me.x_pos)
      @me.now_x_speed = Math.cos(angle) * 8.8 + rand(5) * 0.5
      @me.now_y_speed = Math.sin(angle) * 8.8 + rand(5) * 0.5
      @attack_rect = [Rect.new(-36, -36, 72, 72)]
    end
    
 #   if @frame_number < 2 and @anime_time > 36 and @anime_time % 3 == 0
  #    @me.now_x_speed *= 1.02
 #     @me.now_y_speed *= 1.02
 #   end
    
    if (@me.y_pos > 1200 or @me.y_pos < 0 or @anime_time > 350) and @frame_number < 6
      change_anime("ball3", 6)
    end
    
  end
  
  
  #-------------------------------------------------------------------------------
  # ○ 閃電發射器(主體)
  #-------------------------------------------------------------------------------
  def thunder_helper_root

    if @anime_time == 1 
      $scene.create_battle_bullets([@me, "thunder_helper", 0, 0, 0, false, true])
    end

    # 鬼畜追加
    if @anime_time == 50 and $game_variables[STILILA::GAME_LEVEL] > 2
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
  # ○ 魔法陣
  #-------------------------------------------------------------------------------
  def magic_circle1
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
  # ○ 爆炸後進入劇情
  #-------------------------------------------------------------------------------
  def dead
    if @anime_time == 47
      @me.dead_disappear = true
      
      # 成就解除：這才是我的完全體
      $game_config.get_achievement(5) if $game_switches[STILILA::Corals_FullPower]
      
   #  common_event = $data_common_events[39]
     # $game_system.battle_interpreter.setup(common_event.list, 0)
    end    
  end

  
  
  #-------------------------------------------------------------------------------
  # ○ 用力戳
  #-------------------------------------------------------------------------------
  def skill2
    $game_screen.start_shake(8,5,20,1) if @anime_time == 89
  end
  

  
  #-------------------------------------------------------------------------------
  # ○ 常時監視A (不受暫停、受傷定格效果影響)
  #      通常用在調整受傷、倒地這種不確定何時恢復姿勢的情況
  #-------------------------------------------------------------------------------
  def respective_updateA
    
    # 大絕1當中
    if @state == "skill1"
      $game_temp.black_time = [12, 50]
      if @frame_number < 29
        $scene.camera_feature =  [12,15,15]
      else
        $scene.camera_feature =  [12,35,35]
      end
    end
    
    # 大絕2當中
    if @state == "skill2"
      $game_temp.black_time = [12, 50]
      $scene.camera_feature =  [12,20,20]
    end
    
    
    # 完全形態的特效
    if $game_switches[STILILA::Corals_FullPower] and @full_power_ora == nil and @me.is_a?(Game_Enemy)
      @full_power_ora = Sprite.new(@me.battle_sprite.viewport)
      @full_power_ora.z = 0
      @full_power_ora.opacity = 0
      @full_power_ora.blend_type = 1
      @full_power_ora.tone = Tone.new(205,205,0)
    end
    
    if @full_power_ora != nil

      if @full_power_ora.opacity > 60
        @full_power_ora_change = -1
      elsif @full_power_ora.opacity <= 0
        @full_power_ora_change = 1
      end
      
      if @me.hp == 0 or ["dead", "dead2"].include?(@state)
        @full_power_ora.opacity = 0
      else
        @full_power_ora.opacity += 2 * @full_power_ora_change
      end

      @full_power_ora.mirror = (@me.direction == -1)
      @full_power_ora.bitmap = @me.battle_sprite.bitmap
      # スプライトの座標を設定
      @full_power_ora.zoom_x = @me.battle_sprite.zoom_x + (@state_time % 2 * 0.1)
      @full_power_ora.zoom_y = @me.battle_sprite.zoom_y
      # スプライトの座標を設定
      @full_power_ora.x = @me.screen_x
      @full_power_ora.y = @me.screen_y
      @full_power_ora.z = @me.screen_z
      @full_power_ora.ox = @me.battle_sprite.ox
      @full_power_ora.oy = @me.battle_sprite.oy
    end
    
    
    
   # 陣亡
    if @me.hp == 0 and @state != "dead"
      @me.combohit_clear
      $game_system.se_play($data_system.enemy_collapse_se) 
      @eva_invincible_duration = 999
      change_anime("dead")
      @hit_stop_duration = 40
    end
    
  end
  
  #-------------------------------------------------------------------------------
  # ○ 常時監視B (受暫停、受傷定格效果影響)
  #-------------------------------------------------------------------------------
  def respective_updateB
    
    if ["damage1", "damage2"].include?(@state) and @knock_back_duration <= 0 and !@catched
      var_reset
      on_air? ? change_anime("jump_fall") : change_anime("stand")
    end
    
    # 霸體處理
    if  $game_variables[STILILA::GAME_LEVEL] > 1
      @super_armor = 1 if @super_armor < 1 and @super_armor_cd <= 0
      @super_armor_cd -= 1 if @super_armor_cd > 0
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
    
    if action == "skill1" and @frame_number <= 5 and !target.guarding?
      target.x_pos = @me.x_pos + 235 * @me.direction if ((target.x_pos - @me.x_pos).abs < 215) or ((target.x_pos - @me.x_pos).abs > 255)
      target.y_pos = 20 if target.y_pos > 60 or target.y_pos < 15
    end
    
    if action == "ball3"
      change_anime("ball3", 6)
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
       # ================================== 走路戳
      if skill == "atk1" and @frame_number < 27 
        result["power"] = 25 * @atk_rate
        result["limit"] = 10 * @atk_rate
        result["scope"].push("Down") # 倒地狀態可追打
        result["u_hitstop"] = 5
        result["t_hitstop"] = 9                  
        result["t_knockback"] = 28
        result["x_speed"] = 2.9   
        if target.motion.on_air?
          result["y_speed"] = 11.3
        else
          result["y_speed"] = 15.3
        end
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 70, 90]                      
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 11
        result["spark"] = [1, 5*rand(10), 9*(rand(6)+1)+30]
      # ================================== 走路戳最後  
      elsif skill == "atk1" and @frame_number >= 27
        result["power"] = 35 * @atk_rate
        result["limit"] = 15 * @atk_rate
        result["scope"].push("Down") # 倒地狀態可追打
        result["u_hitstop"] = 30
        result["t_hitstop"] = 33                  
        result["t_knockback"] = 48
        result["x_speed"] = 3.1   
        result["y_speed"] = 15.3
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se4", 80, 110]                   
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 11
        result["spark"] = [1, 5*rand(10), 9*(rand(6)+1)+30]
        result["h_shake"] = [6,8,30,1]
        result["d_shake"] = [6,8,30,1]
        
      elsif skill == "atk2" # 掀地板戳
        result["power"] = 110 * @atk_rate
        result["limit"] = 50 * @atk_rate
        result["u_hitstop"] = 5
        result["t_hitstop"] = 15                 
        result["t_knockback"] = 32
        result["x_speed"] = 5.9   
        result["y_speed"] = 12.3
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 70, 90]                      
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 11
        
        result["spark"] = [1, 5*rand(10), 9*(rand(6)+1)+30]
        
      elsif skill == "atk4"  # 戳
        result["power"] = 150 * @atk_rate
        result["limit"] = 60 * @atk_rate
        result["scope"].push("Down") # 倒地狀態可追打
        result["u_hitstop"] = 5
        result["t_hitstop"] = 16                
        result["t_knockback"] = 35
        result["x_speed"] = 5.3   
        result["y_speed"] = 13.3
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 70, 90]                      
        result["sp_recover"] = 3
        result["full_count"] = 2
        result["hit_slide"] = 11
        result["spark"] = [1, 5*rand(10), 9*(rand(6)+1)+30]
        
      elsif skill == "ball1"
        result["power"] = 66 * @atk_rate
        result["limit"] = 54 * @atk_rate
        result["blow_type"] = "None" if !target.motion.on_air? # 擊中變受傷狀態，不擊飛
        result["u_hitstop"] = 0
        result["t_hitstop"] = 8
        result["correction"] = 8
        result["t_knockback"] = 13
        result["x_speed"] = -5.7   
        result["y_speed"] = 8.9  
        result["hit_slide"] = 0
        result["d_se"] = ["Audio/SE/impact_se", 88, 100]     
        result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]
        
      elsif skill == "ball2_break"
        result["power"] = 45 * @atk_rate
        result["limit"] = 35 * @atk_rate
        result["u_hitstop"] = 0
        result["t_hitstop"] = 6 
        result["correction"] = 8
        result["t_knockback"] = 17
        result["x_speed"] = 6    
        result["y_speed"] = 8.4     
        result["hit_slide"] = 0
        result["d_se"] = ["Audio/SE/impact_se2", 88, 100]     
        result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]
        
      elsif skill == "break_away"
        result["power"] = 0
        result["limit"] = 0
        result["u_hitstop"] = 7
        result["t_hitstop"] = 7                
        result["t_knockback"] = 33  
        result["x_speed"] = 21.6  
        result["y_speed"] = 7.3          
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 80, 135]    
        result["sp_recover"] = 0
        
      # 大絕連戳  
      elsif skill == "skill1" and @frame_number < 31
        result["power"] = 20 * @atk_rate
        result["limit"] = 5 * @atk_rate
        result["scope"].push("Down") # 倒地狀態可追打
        result["u_hitstop"] = 2
        result["t_hitstop"] = 3              
        result["t_knockback"] = 30
        result["x_speed"] = 1.9   
        result["y_speed"] = 3.9
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se3", 70, 90]                      
        result["sp_recover"] = 0
        result["no_kill"] = true
        result["full_count"] = 2
        result["hit_slide"] = 3
        result["spark"] = [1, 5*rand(10), 9*(rand(6)+1)+30]
        result["correction"] = 0.5
      # 大絕連戳  
      elsif skill == "skill1" and @frame_number >= 31
        result["power"] = 220 * @atk_rate
        result["limit"] = 180 * @atk_rate
        result["scope"].push("Down") # 倒地狀態可追打
        result["u_hitstop"] = 32
        result["t_hitstop"] = 32               
        result["t_knockback"] = 30
        result["x_speed"] = 9.9   
        result["y_speed"] = 16.3              
        result["full_count"] = 2
        result["hit_slide"] = 11
        result["spark"] = [1, 5*rand(10), 9*(rand(6)+1)+30]
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se4", 80, 110]      
        result["sp_recover"] = 3
        result["h_shake"] = [14,11,30,1]
        result["d_shake"] = [14,11,30,1]
        
       # result["h_zoom"] = [3,5,20,1]
      #  result["d_zoom"] = [3,5,20,1]
      elsif skill == "skill2" # 大絕用力戳
        result["power"] = 666 * @atk_rate
        result["limit"] = 444 * @atk_rate
        result["u_hitstop"] = 40
        result["t_hitstop"] = 40                
        result["t_knockback"] = 60
        result["x_speed"] = 8.9   
        result["y_speed"] = 16.3
        result["d_se"] = result["ko_se"] = ["Audio/SE/slash_se4", 80, 110]                         
        result["sp_recover"] = 10
        result["full_count"] = 2
        result["hit_slide"] = 11
        result["h_shake"] = [14,11,30,1]
        result["d_shake"] = [14,11,30,1]
        result["no_guard"] = true
        result["spark"] = [1, 5*rand(10), 9*(rand(6)+1)+30]
        
      elsif skill == "ball3"
        result["power"] = 55 * @atk_rate
        result["limit"] = 35 * @atk_rate
        result["u_hitstop"] = 0
        result["t_hitstop"] = 8
        result["correction"] = 8
        result["t_knockback"] = 35
        result["x_speed"] = 5.7   
        result["y_speed"] = 11.9  
        result["hit_slide"] = 0
        result["d_se"] = result["ko_se"] = ["Audio/SE/impact_se2", 0, 135]
        
        result["spark"] = [0, rand(10) - 6, 9*(rand(7)+1)+15]
        
      elsif skill == "thunder" 
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
      else
      end #if end
      return result
  end #def end
end # class end
