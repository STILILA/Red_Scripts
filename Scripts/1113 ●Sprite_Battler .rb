#==============================================================================
# ■ Sprite_Battler
#------------------------------------------------------------------------------
# 　バトラー表示用のスプライトです。Game_Battler クラスのインスタンスを監視し、
# スプライトの状態を自動的に変化させます。
#==============================================================================

class Sprite_Battler < RPG::Sprite
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_accessor :battler                  # 戰鬥者
  attr_accessor :battler_visible         # 戰鬥者可見狀態
  attr_accessor :blur_cold               # 殘影生成間格
  attr_accessor :actor_sprites
  attr_accessor :enemy_sprites
  attr_accessor :battler_shadow
  #--------------------------------------------------------------------------
  # ● 初始化物件
  #     viewport : 顯示連接埠
  #     battler  : 戰鬥者 (Game_Battler)
  #--------------------------------------------------------------------------
  def initialize(viewport, battler = nil)
    super(viewport)
    @battler = battler
    @battler_visible = false
    @battler_shadow = RPG::Sprite.superclass.new(self.viewport)
    @battler_shadow.visible = false
    
    if $game_temp.battleback_name == "stageEX"
      @battler_shadow.angle = 180
    end
    
    
   #  if @battler.is_a?(Game_Actor)
    #   case @battler.id
    #   when 1
    #      sname = "RedS"
    #   when 2
    #     sname = "RedH"
    #   when 3
    #     sname = "RedB"
   #    when 4
   #      sname = "RedB"
   #    end
  #     @shadow_name = "Graphics/Battlers/"+sname+"_battler/shadow01"
  #   else
   #    @shadow_name = "Graphics/Battlers/"+self.battler.name+"_battler/shadow01"
    # end
     
    #@battler_shadow.bitmap = Bitmap.new(@shadow_name)
    @shake_duration = 0
    @_shake = false
    @shake = 0
    @shake_power = 0.3 # 0.2
    @shake_speed = 79
    @shake_direction = 1
    @blur_cold = 0
    
    # 如果戰鬥者是敵人
=begin
    if @battler.is_a?(Game_Enemy)
      @enemy_hp_window = Window_Base.new(@battler.screen_x, @battler.screen_y - 5, 150, 60)
      @enemy_hp_window.contents = Bitmap.new(150 - 32, 60 - 32)
      @enemy_hp_window.draw_enemy_battle_hp(@battler, 4, 0,40)
      @enemy_hp_window.opacity = 0
      @enemy_hp_window.z  =  9999
      @enemy_hp_window.visible = false
    end
=end    
    
  end
  #--------------------------------------------------------------------------
  # ● 解放
  #--------------------------------------------------------------------------
  def dispose
    if @battler_shadow.bitmap != nil 
      # 不在戰鬥中時，釋放圖像
      # 註：影子圖是快取，不能即時釋放
      @battler_shadow.bitmap.dispose and !$scene.is_a?(Scene_Battle)
      # 釋放sprite
      @battler_shadow.dispose
    end
    if self.bitmap != nil and !$scene.is_a?(Scene_Battle)
      self.bitmap.dispose
    end
    # 敵人的情況
  #  if @battler.is_a?(Game_Enemy)
#     @enemy_hp_window.dispose
  #  end
    super
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    return if @stop_animation
    # バトラーが nil の場合戻る
    return if @battler == nil
    # ズーム率
    $xcam_z = 185 if $xcam_z.nil?
    @battler.z_pos = 0 if @battler.z_pos.nil?
    zoom = 185.0 / $xcam_z
    #super
    # バトラーが nil の場合
    if @battler == nil
      self.bitmap = nil
      loop_animation(nil)
      return
    end

    # ファイル名か色相が現在のものと異なる場合
    if @battler.battler_name != @battler_name or
       @battler.battler_hue != @battler_hue
      # ビットマップを取得、設定
      @battler_name = @battler.battler_name
      @battler_hue = @battler.battler_hue
      if @battler_name != nil
        self.bitmap = RPG::Cache.battler(@battler_name, @battler_hue)
      
       @width = bitmap.width
       @height = bitmap.height
      
    #  self.ox = @width / 2
    #  self.oy = @height
        self.ox = get_ox(@battler, @battler.now_form_id, @width)
        self.oy = get_oy(@battler, @battler.now_form_id, @height)
      end
    
      # 更新影子
      if $game_temp.battleback_name == "stageEX"
        shadow_refresh2
      else
        shadow_refresh
      end
      
      
      
      # 戦闘不能または隠れ状態なら不透明度を 0 にする
      if (@battler.dead? and @battler.dead_disappear) or @battler.hidden
        self.opacity = 0
      end
    end  # if @battler.battler_name != @battler_name or
    
    # アニメーション ID が現在のものと異なる場合
    if @battler.damage == nil and
       @battler.state_animation_id != @state_animation_id
      @state_animation_id = @battler.state_animation_id
      loop_animation($data_animations[@state_animation_id])
    end
    # 表示されるべきアクターの場合
  #  if @battler.is_a?(Game_Actor) and @battler_visible
      # メインフェーズでないときは不透明度をやや下げる
     # if $game_temp.battle_main_phase
     #   self.opacity += 3 if self.opacity < 255
     # else
     #   self.opacity -= 3 if self.opacity > 207
     # end
   # end
    # 明滅
    if @battler.blink
      blink_on
    else
      blink_off
    end
    
  #  if (!@battler.hidden and self.visible)
   #   @battler_shadow.visible = true
   # else
   #   @battler_shadow.visible = false
   # end

    # 不可視の場合
    unless @battler_visible
      # 出現
      if not @battler.hidden and not @battler.dead? and
         (@battler.damage == nil or @battler.damage_pop)
         self.opacity = 255
        #appear
        @battler_visible = true
        @battler_shadow.visible = true if @battler.battle_shadow_id != 0
      end
    end

    # 戰鬥動畫
    unless @battler.animation.empty? and !@stop_animation
      for animation in @battler.animation.reverse
        animation($data_animations[animation[0]], animation[1], @battler.x_pos+animation[2], @battler.y_pos+animation[3], ((animation[4] != nil) ? animation[4] : @battler.direction))
        @battler.animation.delete(animation)
      end
    end
      
    # 受傷
    if @battler.damage_pop and !@stop_animation
#      appear_damage_spark(@battler.motion.spark_rect)
     # damage(@battler.damage, @battler.critical, @battler.x_pos, @battler.y_pos)
    #  @battler.damage = nil
    #  @battler.critical = false
   #   @battler.damage_pop = false
    end

    # 可視の場合
    if @battler_visible
      # 逃走
      if @battler.hidden
        $game_system.se_play($data_system.escape_se)
        escape
        @battler_visible = false
        @battler_shadow.visible = false
      end
      # 白閃爍
      if @battler.white_flash
        whiten
        @battler.white_flash = false
      end  
      
      # 陣亡
      if @battler.dead?# and @battler.damage == nil 
        if @battler.is_a?(Game_Enemy)
          $game_system.se_play($data_system.enemy_collapse_se) 
          @battler_visible = false
          #@battler_shadow.visible = false
        else
          $game_system.se_play($data_system.actor_collapse_se)
          @battler_visible = false
        #  @battler_shadow.visible = false
        end
      end
      
      
      
      # 陣亡
     # if @battler.dead?# and @battler.damage == nil 
       # if @battler.is_a?(Game_Enemy)
       #   $game_system.se_play($data_system.enemy_collapse_se) 
      #    collapse
    #    else
    #      $game_system.se_play($data_system.actor_collapse_se)
    #    end
    #      @battler_visible = false
    #      @battler_shadow.visible = false
  #    end
      
      
    end  # if @battler_visible
    
    
    return if self.disposed?
    
    # 向きに応じて反転･w･この機能マジ燃え(素
    if @battler.direction == 1   
      self.mirror = false 
    else
      self.mirror = true 
    end
    
    

    
    # スプライトの座標を設定
    
    self.zoom_x = zoom
    self.zoom_y = zoom
    @battler.zoom = zoom
    
    # スプライトの座標を設定
    self.x = @battler.screen_x
    self.y = @battler.screen_y
    self.z = @battler.screen_z
    
    self.ox = get_ox(@battler, @battler.now_form_id, @width) + @shake
    self.oy = get_oy(@battler, @battler.now_form_id, @height)
    
=begin    
    # 更新敵人HP / SP槽
    if @battler.is_a?(Game_Enemy)
      if @battler.exist?
        @enemy_hp_window.visible = true
        @enemy_hp_window.x, @enemy_hp_window.y = @battler.screen_x - @width/2 - 15, @battler.screen_y - 20
        @enemy_hp_window.contents.clear
        @enemy_hp_window.draw_enemy_battle_hp(@battler, 4, 0, 60)
      else
        @enemy_hp_window.visible = false
      end
    end
=end    


    # 設定影子座標
    @battler_shadow.x = self.x
 #   p @battler.name if @battler.y_min == nil
    
    @battler_shadow.y = get_zoom_in_out_y(@battler.y_min+2, 185.0 / $xcam_z)
    @battler_shadow.visible = (@battler_visible and @battler.battle_shadow_id != 0 and !@battler.hidden and self.visible) 
    # p @battler.y_min if @battler.is_a?(Game_Actor)
    
     if $game_temp.battleback_name == "stageEX"
      @battler_shadow.mirror = !self.mirror
      @battler_shadow.ox = get_ox_shadow(@battler, @battler.now_form_id, @width, @battler_shadow.mirror)
     end
    
  #  @battler_shadow.ox = get_ox(@battler, @battler.now_form_id, @width) 
 #   @battler_shadow.x = self.x#get_zoom_in_out_x(@battler.x_pos, @battler.zoom)
 #   @battler_shadow.y = get_zoom_in_out_y(0, @battler.zoom)
    @battler_shadow.z = self.z - 1000
    
 #   @battler_shadow.ox =  @battler_shadow.src_rect.width - get_ox(@battler, @battler.now_form_id, @width) 
 #   p $game_screen.shake_x, @battler_shadow.ox if @battler.is_a?(Game_Actor)
    
  #  @battler_shadow.oy = get_oy(@battler, @battler.now_form_id, @height) 
    @battler_shadow.opacity = [(120+@battler.y_min - @battler.y_pos), 0].max
    @battler_shadow.zoom_x = self.zoom_x
    @battler_shadow.zoom_y = self.zoom_y - 0.6
  #  @battler_shadow.mirror = !self.mirror

    if @battler.motion != nil
      # 無敵狀態中閃爍
      if @battler.motion.hit_invincible_duration > 0
        @battler.blink = true
      elsif @battler.motion.hit_invincible_duration == 0
        @battler.blink = false
      end
      # 震動/反作用力
      #  if @battler.motion.shaking
      if @battler.motion.knock_back_duration > 0 and @battler.motion.hit_stop_duration > 0#or @battler.motion.static?
        delta = (@shake_power * @shake_speed * @shake_direction) / 12.0
        if delta == 0
          @shake = 0
        else
          @shake += delta
        end
        if @shake > @shake_power * 1.2
          @shake_direction = -1
        end
        if @shake < - @shake_power * 1.2
          @shake_direction = 1
        end
      else
        @shake = 0
      end 
      # 殘影效果
     @blur_cold -= 1 if @blur_cold > 0 and !@stop_animation
      if @battler.is_a?(Game_Actor) or @battler.is_a?(Game_Enemy) or @battler.is_a?(Game_BattleBullet)
        if @battler.motion.blur_effect
          if @blur_cold == 0  and  !@stop_animation
            make_blur(@battler.x_pos, @battler.y_pos) 
           @blur_cold = 4
          end
        end
      end
    end  # if @battler.motion != nil

    super
     
  end
  

  #--------------------------------------------------------------------------
  # ○ アニメーション一時停止
  #--------------------------------------------------------------------------  
  def stop_update_animation
    @stop_animation = true
  end
  #--------------------------------------------------------------------------
  # ○ アニメーション再開
  #--------------------------------------------------------------------------  
  def start_update_animation
    @stop_animation = false
  end
  
  #--------------------------------------------------------------------------
  # ○ 顯示命中特效
  #--------------------------------------------------------------------------  
  def appear_damage_spark(spark_rect)
    
    if !spark_rect.is_a?(Rect)
      spark_rect = @battler.body_rect.dup
    end

    y_max = @battler.y_pos - @battler.body_rect.y
    
    spark_rect.y+35
    
    if spark_rect.y < y_max
      
      minus = (spark_rect.y-y_max).abs
      spark_rect.y = y_max 
     # spark_rect.height -= (minus)
    end
    
    damage(@battler.damage, @battler.critical, spark_rect.x, spark_rect.y, spark_rect.width, spark_rect.height)
    @battler.damage = nil
    @battler.critical = false
    @battler.damage_pop = false
    @battler.motion.spark_rect = nil
  end
  
  
  #--------------------------------------------------------------------------
  # ● 更新影子
  #--------------------------------------------------------------------------
  def shadow_refresh
    # 影子編號不為 0 的時候才更新
    return if @battler.battle_shadow_id == 0

     if @battler.is_a?(Game_Actor) #and @battler.id < 5
       sname = self.battler.name
       case @battler.id
       when 1,6
          sname = "RedS"
       when 2,7
         sname = "RedH"
       when 3,8
         sname = "RedB"
       when 4
         sname = "RedB"
       end
       @shadow_name = sname+"_battler/shadow" + @battler.battle_shadow_id.to_s
     elsif @battler.is_a?(Game_Enemy) and (11..13) === @battler.id
       case @battler.id
       when 11
          sname = "RedS"
       when 12
         sname = "RedH"
       when 13
         sname = "RedB"
       end
       @shadow_name = sname+"_battler/shadow" + @battler.battle_shadow_id.to_s
     elsif @battler.is_a?(Game_Enemy) and (39..44) === @battler.id
       case @battler.id
       when 39
          sname = "Leather"
       when 40
          sname = "RedS"
       when 41
         sname = "RedH"
       when 42
         sname = "RedB"
       when 43
          sname = "Corals"
       when 44
          sname = "CoralsFinal"
       end
       @shadow_name = sname+"_battler/shadow" + @battler.battle_shadow_id.to_s
       
     else  
       @shadow_name = self.battler.name+"_battler/shadow" + @battler.battle_shadow_id.to_s
     end
     
    @battler_shadow.bitmap = RPG::Cache.battler(@shadow_name, 0)
    
   # name = @shadow_name
  #  @battler_shadow.bitmap = RPG::Cache.battler(name, 0)
    @battler_shadow.ox = @battler_shadow.bitmap.width / 2
    @battler_shadow.oy = @battler_shadow.bitmap.height / 2
    
  end
  
  
  
  #--------------------------------------------------------------------------
  # ● 更新影子
  #--------------------------------------------------------------------------
  def shadow_refresh2 
    
    # 影子編號不為 0 的時候才更新
    return if @battler.battle_shadow_id == 0
    
    @battler_shadow.bitmap = self.bitmap
    @battler_shadow.ox = self.ox
    @battler_shadow.oy = self.oy
    @battler_shadow.tone = self.tone
  end
  
  
end


#==============================================================================
# ■ Interpreter 
#------------------------------------------------------------------------------
# 　執行事件指令的解釋器。本類別在 Game_System 類別
#     和 Game_Event 類別的內部使用。
#==============================================================================
class Interpreter


end
