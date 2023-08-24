# ▼▲▼ XRXS_BP 8. バトルバック・Full-View＋可動カメラ ver..05e ▼▲▼
# 元開發 ： 桜雅 在土

#==============================================================================
# ■ Spriteset_Battle
#==============================================================================
class Spriteset_Battle
  #--------------------------------------------------------------------------
  # ● 公開變量
  #--------------------------------------------------------------------------
  attr_reader :viewport2
  attr_reader :enemy_sprites     # 敵人Sprite
  attr_reader :actor_sprites        # 角色Sprite
  attr_accessor :bullet_sprites      # 飛行道具的Sprite
  attr_accessor :item_sprites       # 小道具的Sprite
  attr_accessor :field_object_sprites   # 場內物件的Sprite
  #--------------------------------------------------------------------------
  # ● 物件初始化
  #--------------------------------------------------------------------------
  def initialize
      # 初期化
    @now_bg_x = -1
    @now_bg_y = -1
    @now_bg_z = -1
    # 產生顯示連接埠
    @viewport1 = Viewport.new(0, 0, 640, 480)
    @viewport2 = Viewport.new(0, 0, 640, 480)
    @viewport3 = Viewport.new(0, 0, 640, 480)
    @viewport4 = Viewport.new(0, 0, 640, 480)
    @viewport2.z = 101
    @viewport3.z = 200
    @viewport4.z = 5000
    # 產生戰鬥背景活動區塊
    @battleback_sprite = Sprite.new(@viewport1)
    @battleback_sprite.z = 50
    @battleback_name = ""
    
    # 產生戰鬥背景天空活動區塊
    @battleback_sky_sprite = Sprite.new(@viewport1)
    @battleback_sky_sprite.z = 20
    # 裝飾背景1、2
    @battleback_bg1_sprite = Sprite.new(@viewport1)
    @battleback_bg1_sprite.z = 51
    @battleback_bg2_sprite = Sprite.new(@viewport1)
    @battleback_bg2_sprite.z = 51
    @battleback_bg3_sprite = Sprite.new(@viewport1)
    @battleback_bg3_sprite.z = 51
    # 裝飾前景1、2
    @battleback_pp1_sprite = Sprite.new(@viewport3)
    @battleback_pp2_sprite = Sprite.new(@viewport3)
    @battleback_pp1_sprite.z = 70
    @battleback_pp2_sprite.z = 70
    # 左右邊障礙物
    @battleback_left_obstacle = Sprite.new(@viewport1)
    @battleback_right_obstacle = Sprite.new(@viewport1)
    @battleback_left_obstacle.z = 52
    @battleback_right_obstacle.z = 52
    # 產生敵人活動區塊
    @enemy_sprites = []
 #   for enemy in $game_troop.enemies.reverse
   #   @enemy_sprites.push(Sprite_Battler.new(@viewport2, enemy))
#    end
    for enemy in $game_troop.enemies.reverse
      enemy.battle_sprite = Sprite_Battler.new(@viewport2, enemy)
    end
    # 產生角色活動區塊
  #  @actor_sprites = []
   # @actor_sprites.push(Sprite_Battler.new(@viewport2))
    #@actor_sprites.push(Sprite_Battler.new(@viewport2))
   # @actor_sprites.push(Sprite_Battler.new(@viewport2))
  #  @actor_sprites.push(Sprite_Battler.new(@viewport2))
    
    for actor in $game_party.actors
      actor.battle_sprite = Sprite_Battler.new(@viewport2, actor)
    end
    
    
    # 產生飛行道具活動區塊
    @bullet_sprites = []
    # 產生小道具的活動區塊
    @item_sprites = []
    # 產生場內物件的活動區塊
    @field_object_sprites = []
    # 動畫停止flag
    @stop_animation = false
    # 產生天氣
    @weather = RPG::Weather.new(@viewport3)
    # 產生圖片活動區塊
    @picture_sprites = []
    for i in 51..100
      @picture_sprites.push(Sprite_Picture.new(@viewport3,
      $game_screen.pictures[i]))
    end
    # 產生計時器區塊
    @timer_sprite = Sprite_Timer.new
    @viewport1.tone = $game_screen.tone 
    @viewport3.tone = $game_screen.tone 
    # 更新畫面
    update
  end
  
  #--------------------------------------------------------------------------
  # ● 設定戰鬥場地
  #--------------------------------------------------------------------------
  def set_batte_field(name)
    case name
    when "lf"
      # 設定戰鬥場景高 / 底 (超出範圍會扣1/10血並強制移回場內)
      $game_temp.battle_field_h = 780#480
      $game_temp.battle_field_b = -680
      # 設定鏡頭上下捲動的最大極限
      $game_temp.battle_field_top_limit = 460
      $game_temp.battle_field_bot_limit = -300 
      # 設定其他背景圖
      @battleback_sky_sprite.bitmap = RPG::Cache.battleback(name + "_sky")
      @battleback_sky_sprite.src_rect.set(0, 0, @battleback_sky_sprite.bitmap.width, @battleback_sky_sprite.bitmap.height)
      @battleback_bg1_sprite.bitmap = RPG::Cache.battleback(name + "_bg1")
      @battleback_bg1_sprite.src_rect.set(0, 0, @battleback_bg1_sprite.bitmap.width, @battleback_bg1_sprite.bitmap.height)
    when "stage1"
      # 設定戰鬥場景高 / 底 (超出範圍會扣1/10血並強制移回場內)
      $game_temp.battle_field_h = 4280#480
      $game_temp.battle_field_b = -1580
      # 設定鏡頭上下捲動的最大極限
      $game_temp.battle_field_top_limit = 340
      $game_temp.battle_field_bot_limit = -36 #-24
      # 設定其他背景圖
      @battleback_sky_sprite.bitmap = RPG::Cache.battleback(name + "_sky")
      @battleback_sky_sprite.src_rect.set(0, 0, @battleback_sky_sprite.bitmap.width, @battleback_sky_sprite.bitmap.height)
      @battleback_bg1_sprite.bitmap = RPG::Cache.battleback(name + "_bg1")
      @battleback_bg1_sprite.src_rect.set(0, 0, @battleback_bg1_sprite.bitmap.width, @battleback_bg1_sprite.bitmap.height)
      @battleback_pp1_sprite.bitmap = RPG::Cache.battleback(name + "_pp1")
      @battleback_pp1_sprite.src_rect.set(0, 0, @battleback_pp1_sprite.bitmap.width, @battleback_pp1_sprite.bitmap.height)
    when "stage2"
      # 設定戰鬥場景高 / 底 (超出範圍會扣1/10血並強制移回場內)
      $game_temp.battle_field_h = 780#480
      $game_temp.battle_field_b = -1580
      # 設定鏡頭上下捲動的最大極限
      $game_temp.battle_field_top_limit = 340
      $game_temp.battle_field_bot_limit = 0 
      # 設定其他背景圖
      @battleback_sky_sprite.bitmap = RPG::Cache.battleback(name + "_sky")
      @battleback_sky_sprite.src_rect.set(0, 0, @battleback_sky_sprite.bitmap.width, @battleback_sky_sprite.bitmap.height)
      @battleback_bg1_sprite.bitmap = RPG::Cache.battleback(name + "_bg1")
      @battleback_bg1_sprite.src_rect.set(0, 0, @battleback_bg1_sprite.bitmap.width, @battleback_bg1_sprite.bitmap.height)
      @battleback_pp1_sprite.bitmap = RPG::Cache.battleback(name + "_pp1")
      @battleback_pp1_sprite.src_rect.set(0, 0, @battleback_pp1_sprite.bitmap.width, @battleback_pp1_sprite.bitmap.height)
    when "stage22"
      # 設定戰鬥場景高 / 底 (超出範圍會扣1/10血並強制移回場內)
      $game_temp.battle_field_h = 780#480
      $game_temp.battle_field_b = -1580
      # 設定鏡頭上下捲動的最大極限
      $game_temp.battle_field_top_limit = 680
      $game_temp.battle_field_bot_limit = -1590 
      
      $game_temp.battle_field_w = 4520
      # 設定其他背景圖
     # @battleback_sky_sprite.bitmap = RPG::Cache.battleback(name + "_sky")
   #   @battleback_sky_sprite.src_rect.set(0, 0, @battleback_sky_sprite.bitmap.width, @battleback_sky_sprite.bitmap.height)
      # 背景
      @battleback_bg1_sprite.bitmap = RPG::Cache.battleback(name + "_bg1")
      @battleback_bg1_sprite.src_rect.set(0, 0, @battleback_bg1_sprite.bitmap.width, @battleback_bg1_sprite.bitmap.height)
      @battleback_bg1_sprite.z = -2
      # 階梯菇
      @battleback_bg2_sprite.bitmap = RPG::Cache.battleback(name + "_bg2")
      @battleback_bg2_sprite.src_rect.set(0, 0, @battleback_bg2_sprite.bitmap.width, @battleback_bg2_sprite.bitmap.height)
      # 光
      @battleback_pp1_sprite.bitmap = RPG::Cache.battleback(name + "_pp1")
      @battleback_pp1_sprite.src_rect.set(0, 0, @battleback_pp1_sprite.bitmap.width, @battleback_pp1_sprite.bitmap.height)
      # 前景裝飾
      @battleback_pp2_sprite.bitmap = RPG::Cache.battleback(name + "_pp2")
      @battleback_pp2_sprite.src_rect.set(0, 0, @battleback_pp2_sprite.bitmap.width, @battleback_pp2_sprite.bitmap.height)
    when "stage23"
      # 設定戰鬥場景高 / 底 (超出範圍會扣1/10血並強制移回場內)
      $game_temp.battle_field_h = 780#480
      $game_temp.battle_field_b = -680
      # 設定鏡頭上下捲動的最大極限
      $game_temp.battle_field_top_limit = 150
      $game_temp.battle_field_bot_limit = -200 
      $game_temp.battle_field_w = 911
      # 設定其他背景圖
      @battleback_sky_sprite.bitmap = RPG::Cache.battleback(name + "_sky")
      @battleback_sky_sprite.src_rect.set(0, 0, @battleback_sky_sprite.bitmap.width, @battleback_sky_sprite.bitmap.height)
      @battleback_pp1_sprite.bitmap = RPG::Cache.battleback(name + "_pp1")
      @battleback_pp1_sprite.src_rect.set(0, 0, @battleback_pp1_sprite.bitmap.width, @battleback_pp1_sprite.bitmap.height)
      @battleback_pp2_sprite.bitmap = RPG::Cache.battleback(name + "_pp2")
      @battleback_pp2_sprite.src_rect.set(0, 0, @battleback_pp2_sprite.bitmap.width, @battleback_pp2_sprite.bitmap.height)
    when "stage31"
      # 設定戰鬥場景高 / 底 (超出範圍會扣1/10血並強制移回場內)
      $game_temp.battle_field_h = 780#480
      $game_temp.battle_field_b = -1580
      # 設定鏡頭上下捲動的最大極限
      $game_temp.battle_field_top_limit = 340
      $game_temp.battle_field_bot_limit = -36 #-24
      # 設定其他背景圖
      @battleback_sky_sprite.bitmap = RPG::Cache.battleback(name + "_sky")
      @battleback_sky_sprite.src_rect.set(0, 0, @battleback_sky_sprite.bitmap.width, @battleback_sky_sprite.bitmap.height)
      @battleback_pp1_sprite.bitmap = RPG::Cache.battleback(name + "_pp1")
      @battleback_pp1_sprite.src_rect.set(0, 0, @battleback_pp1_sprite.bitmap.width, @battleback_pp1_sprite.bitmap.height)
      
    when "stage32"
      # 設定戰鬥場景高 / 底 (超出範圍會扣1/10血並強制移回場內)
      $game_temp.battle_field_h = 780#480
      $game_temp.battle_field_b = -680
      # 設定鏡頭上下捲動的最大極限
      $game_temp.battle_field_top_limit = 326
      $game_temp.battle_field_bot_limit = -40 
      $game_temp.battle_field_w = 1960
      # 設定其他背景圖
      @battleback_sky_sprite.bitmap = RPG::Cache.battleback(name + "_sky")
      @battleback_sky_sprite.src_rect.set(0, 0, @battleback_sky_sprite.bitmap.width, @battleback_sky_sprite.bitmap.height)
      @battleback_pp1_sprite.bitmap = RPG::Cache.battleback(name + "_pp1")
      @battleback_pp1_sprite.src_rect.set(0, 0, @battleback_pp1_sprite.bitmap.width, @battleback_pp1_sprite.bitmap.height)
    when "stage33"
      # 設定戰鬥場景高 / 底 (超出範圍會扣1/10血並強制移回場內)
      $game_temp.battle_field_h = 780#480
      $game_temp.battle_field_b = -680
      # 設定鏡頭上下捲動的最大極限
      $game_temp.battle_field_top_limit = 326
      $game_temp.battle_field_bot_limit = -40 
      $game_temp.battle_field_w = 1680
      # 設定其他背景圖
      @battleback_bg1_sprite.bitmap = RPG::Cache.battleback(name + "_bg1")
      @battleback_bg1_sprite.src_rect.set(0, 0, @battleback_bg1_sprite.bitmap.width, @battleback_bg1_sprite.bitmap.height)
      @battleback_bg1_sprite.z = 49
      @battleback_pp1_sprite.bitmap = RPG::Cache.battleback(name + "_pp1")
      @battleback_pp1_sprite.src_rect.set(0, 0, @battleback_pp1_sprite.bitmap.width, @battleback_pp1_sprite.bitmap.height)
    
    when "stageEX"
      # 設定戰鬥場景高 / 底 (超出範圍會扣1/10血並強制移回場內)
      $game_temp.battle_field_h = 780#480
      $game_temp.battle_field_b = -680
      # 設定鏡頭上下捲動的最大極限
      $game_temp.battle_field_top_limit = 150
      $game_temp.battle_field_bot_limit = -200 
      $game_temp.battle_field_w = 911
      # 設定其他背景圖
      @battleback_sky_sprite.bitmap = RPG::Cache.battleback(name + "_sky")
      @battleback_sky_sprite.src_rect.set(0, 0, @battleback_sky_sprite.bitmap.width, @battleback_sky_sprite.bitmap.height)
    #  @battleback_pp1_sprite.bitmap = RPG::Cache.battleback(name + "_pp1")
    #  @battleback_pp1_sprite.src_rect.set(0, 0, @battleback_pp1_sprite.bitmap.width, @battleback_pp1_sprite.bitmap.height)
   #   @battleback_pp2_sprite.bitmap = RPG::Cache.battleback(name + "_pp2")
   #   @battleback_pp2_sprite.src_rect.set(0, 0, @battleback_pp2_sprite.bitmap.width, @battleback_pp2_sprite.bitmap.height)
      
      
    else
      # 設定戰鬥場景高 / 底 (超出範圍會扣1/10血並強制移回場內)
      $game_temp.battle_field_h = 780#480
      $game_temp.battle_field_b = -680
      # 設定鏡頭上下捲動的最大極限
      $game_temp.battle_field_top_limit = 460
      $game_temp.battle_field_bot_limit = -300 
      # －－－其他待補完－－－
    end # case @battleback_name
  end
  #--------------------------------------------------------------------------
  # ● 定期更新
  #      only_bullet：新增飛道時刷新的判定，為了能即時顯示飛道圖像用
  #--------------------------------------------------------------------------
  def update(only_bullet = false)
    # 更新飛行道具Sprite
    for sprite in @bullet_sprites
      next if sprite.nil?
      sprite.update
    end
    # 只是為了更新飛道的話以下中斷
    return if only_bullet 
    # 更新小道具Sprite
    for item in @item_sprites
      next if item.nil?
      item.update
    end
  
    # 更新場內物件
    for field_object in @field_object_sprites
      next if field_object.nil?
      
      field_object.update
    end
      
    # 更新戰鬥者圖像
    for battler in $game_troop.enemies + $game_party.actors
      battler.battle_sprite.update
    end
    # 更新戰鬥者的動畫
    for battler in $game_troop.enemies + $game_party.actors
      if @stop_animation
        battler.battle_sprite.stop_update_animation
      else
        battler.battle_sprite.start_update_animation
      end
    end 
    # 戰鬥背景檔名與現在不同的情況
    if @battleback_name != $game_temp.battleback_name
      @battleback_name = $game_temp.battleback_name
      if @battleback_sprite.bitmap != nil
        @battleback_sprite.bitmap.dispose
      end
      @battleback_sprite.bitmap = RPG::Cache.battleback(@battleback_name)
      @battleback_sprite.src_rect.set(0, 0, @battleback_sprite.bitmap.width, @battleback_sprite.bitmap.height)
      # 設定戰鬥場景預設寬、高
      $game_temp.battle_field_w = (@battleback_sprite.bitmap.width - 520)#/2
      $game_temp.battle_field_h = 480
      # 設定其他內容
      set_batte_field(@battleback_name)
       
    end

    
    # 鏡頭移動的情形
    if @now_bg_x != $xcam_x or @now_bg_y != $xcam_y or @now_bg_z != $xcam_z
      # ズーム率
      zoom =  185.0 / $xcam_z
      @battleback_sprite.zoom_x =  zoom
      @battleback_sprite.zoom_y =  zoom
      @battleback_sky_sprite.zoom_x =  zoom
      @battleback_sky_sprite.zoom_y =  zoom
      @battleback_bg1_sprite.zoom_x =  zoom
      @battleback_bg1_sprite.zoom_y =  zoom
      @battleback_bg2_sprite.zoom_x =  zoom
      @battleback_bg2_sprite.zoom_y =  zoom
      @battleback_pp1_sprite.zoom_x =  zoom
      @battleback_pp1_sprite.zoom_y =  zoom
      @battleback_pp2_sprite.zoom_x =  zoom
      @battleback_pp2_sprite.zoom_y =  zoom
      case @battleback_name 
      when "lf"
        # 背景位置更新
        #@battleback_sprite.x =  get_zoom_in_out_x(-@battleback_sprite.bitmap.width/2, zoom)
        @battleback_sprite.x =  get_zoom_in_out_x(-350, zoom)
        @battleback_sprite.y =  get_zoom_in_out_y(@battleback_sprite.bitmap.height/2-20, zoom) 
        if @battleback_sky_sprite.bitmap != nil
         # @battleback_sky_sprite.x = get_bg_zoom_in_out_x(-(@battleback_sky_sprite.bitmap.width), zoom)
          @battleback_sky_sprite.x = get_bg_zoom_in_out_x(-720, zoom)
          @battleback_sky_sprite.y = get_zoom_in_out_y(590, zoom)
        end
        if @battleback_bg1_sprite.bitmap != nil
         # @battleback_bg1_sprite.x = get_zoom_in_out_x(-@battleback_bg1_sprite.bitmap.width/2, zoom)
          @battleback_bg1_sprite.x = get_zoom_in_out_x(-350, zoom)
          @battleback_bg1_sprite.y = get_zoom_in_out_y(240, zoom)
        end
      when "stage1"
        # 背景位置更新
        @battleback_sprite.x =  get_zoom_in_out_x(-350, zoom)
        @battleback_sprite.y =  get_zoom_in_out_y(@battleback_sprite.bitmap.height/2+30, zoom) #(@battleback_sprite.bitmap.height/2-15, zoom) 
        if @battleback_sky_sprite.bitmap != nil
          @battleback_sky_sprite.x = get_bg_zoom_in_out_x(-720, zoom)
          @battleback_sky_sprite.y = get_zoom_in_out_y(464, zoom)
        end
        if @battleback_bg1_sprite.bitmap != nil
          @battleback_bg1_sprite.x = get_zoom_in_out_x(-350, zoom)
          @battleback_bg1_sprite.y = get_zoom_in_out_y(482, zoom)
        end
        if @battleback_pp1_sprite.bitmap != nil
          @battleback_pp1_sprite.x = get_pp_zoom_in_out_x(-215, zoom)
          @battleback_pp1_sprite.y = get_zoom_in_out_y(@battleback_pp1_sprite.bitmap.height-45, zoom)
        end
      when "stage2"
        # 背景位置更新
        @battleback_sprite.x =  get_zoom_in_out_x(-350, zoom)
        @battleback_sprite.y =  get_zoom_in_out_y(@battleback_sprite.bitmap.height/2+30, zoom) #(@battleback_sprite.bitmap.height/2-15, zoom) 
        if @battleback_sky_sprite.bitmap != nil
          @battleback_sky_sprite.x = get_bg_zoom_in_out_x(-720, zoom)
          @battleback_sky_sprite.y = get_zoom_in_out_y(464, zoom)
        end
        if @battleback_bg1_sprite.bitmap != nil
          @battleback_bg1_sprite.x = get_zoom_in_out_x(-350, zoom)
          @battleback_bg1_sprite.y = get_zoom_in_out_y(482, zoom)
        end
        if @battleback_pp1_sprite.bitmap != nil
          @battleback_pp1_sprite.x = get_pp_zoom_in_out_x(-215, zoom)
          @battleback_pp1_sprite.y = get_zoom_in_out_y(@battleback_pp1_sprite.bitmap.height-45, zoom)
        end
      when "stage22"
        # 背景位置更新
        @battleback_sprite.x =  get_zoom_in_out_x(-350, zoom)
        @battleback_sprite.y =  get_zoom_in_out_y(@battleback_sprite.bitmap.height/2+30, zoom) #(@battleback_sprite.bitmap.height/2-15, zoom) 
        if @battleback_sky_sprite.bitmap != nil
          @battleback_sky_sprite.x = get_bg_zoom_in_out_x(-720, zoom)
          @battleback_sky_sprite.y = get_zoom_in_out_y(464, zoom)
        end
        # 背景
        if @battleback_bg1_sprite.bitmap != nil
          @battleback_bg1_sprite.x = get_zoom_in_out_x(-350, zoom)
          @battleback_bg1_sprite.y = get_zoom_in_out_y(@battleback_bg1_sprite.bitmap.height/2+30, zoom)
        end
        # 菇
        if @battleback_bg2_sprite.bitmap != nil
          @battleback_bg2_sprite.x = get_zoom_in_out_x(3060, zoom)
          @battleback_bg2_sprite.y = get_zoom_in_out_y(432, zoom)
        end
        # 打光
        if @battleback_pp1_sprite.bitmap != nil
          @battleback_pp1_sprite.x = get_pp_zoom_in_out_x(550, zoom)
          @battleback_pp1_sprite.y = get_zoom_in_out_y(@battleback_pp1_sprite.bitmap.height/2+34, zoom)
        end
        # 花草
        if @battleback_pp2_sprite.bitmap != nil
          @battleback_pp2_sprite.x = get_zoom_in_out_x(-350, zoom)
          @battleback_pp2_sprite.y = get_zoom_in_out_y(@battleback_pp2_sprite.bitmap.height/2+30, zoom)
        end
      when "stage23"
        # 背景位置更新
        @battleback_sprite.x =  get_zoom_in_out_x(-320, zoom)
        @battleback_sprite.y =  get_zoom_in_out_y(@battleback_sprite.bitmap.height/2+30, zoom) #(@battleback_sprite.bitmap.height/2-15, zoom) 
        if @battleback_sky_sprite.bitmap != nil
          @battleback_sky_sprite.x = get_bg_zoom_in_out_x(-680, zoom)
          @battleback_sky_sprite.y = get_zoom_in_out_y(264, zoom)
        end
        if @battleback_pp1_sprite.bitmap != nil
          @battleback_pp1_sprite.x = get_pp_zoom_in_out_x(-250, zoom)
          @battleback_pp1_sprite.y = get_zoom_in_out_y(@battleback_pp1_sprite.bitmap.height/2+34, zoom)
        end
        if @battleback_pp2_sprite.bitmap != nil
          @battleback_pp2_sprite.x = get_zoom_in_out_x(-320, zoom)
          @battleback_pp2_sprite.y = get_zoom_in_out_y(@battleback_pp2_sprite.bitmap.height/2+30, zoom)
        end
      when "stage31"
        # 背景位置更新
        @battleback_sprite.x =  get_zoom_in_out_x(-350, zoom)
        @battleback_sprite.y =  get_zoom_in_out_y(@battleback_sprite.bitmap.height/2+230, zoom) #(@battleback_sprite.bitmap.height/2-15, zoom) 
        if @battleback_sky_sprite.bitmap != nil
          @battleback_sky_sprite.x = get_bg_zoom_in_out_x(-720, zoom)
          @battleback_sky_sprite.y = get_zoom_in_out_y(476, zoom)
        end
        if @battleback_pp1_sprite.bitmap != nil
          @battleback_pp1_sprite.x = get_zoom_in_out_x(-375, zoom)
          @battleback_pp1_sprite.y = get_zoom_in_out_y(@battleback_pp1_sprite.bitmap.height-45, zoom)
        end
      when "stage32"
        # 背景位置更新
        @battleback_sprite.x =  get_zoom_in_out_x(-320, zoom)
        @battleback_sprite.y =  get_zoom_in_out_y(@battleback_sprite.bitmap.height/2+190+30, zoom) #(@battleback_sprite.bitmap.height/2-15, zoom) 
        if @battleback_sky_sprite.bitmap != nil
          @battleback_sky_sprite.x = get_bg_zoom_in_out_x(-680, zoom)
          @battleback_sky_sprite.y = get_zoom_in_out_y(454+30, zoom)
        end
        if @battleback_pp1_sprite.bitmap != nil
          @battleback_pp1_sprite.x = get_pp_zoom_in_out_x(450, zoom)
          @battleback_pp1_sprite.y = get_zoom_in_out_y(@battleback_pp1_sprite.bitmap.height/2+190+30, zoom)
        end
      when "stage33"
        # 背景位置更新
        @battleback_sprite.x =  get_zoom_in_out_x(-320, zoom)
        @battleback_sprite.y =  get_zoom_in_out_y(@battleback_sprite.bitmap.height/2+190+30, zoom) #(@battleback_sprite.bitmap.height/2-15, zoom) 
        if @battleback_bg1_sprite.bitmap != nil
          @battleback_bg1_sprite.x = get_zoom_in_out_x(-320, zoom)
          @battleback_bg1_sprite.y = get_zoom_in_out_y(454+30, zoom)
          
        end
        if @battleback_pp1_sprite.bitmap != nil
          @battleback_pp1_sprite.x = get_zoom_in_out_x(-320, zoom)
          @battleback_pp1_sprite.y = get_zoom_in_out_y(@battleback_pp1_sprite.bitmap.height/2+190+30, zoom)
        end
      when "stageEX"
        # 背景位置更新
        @battleback_sprite.x =  get_zoom_in_out_x(-320, zoom)
        @battleback_sprite.y =  get_zoom_in_out_y(@battleback_sprite.bitmap.height/2+30, zoom) #(@battleback_sprite.bitmap.height/2-15, zoom) 
        if @battleback_sky_sprite.bitmap != nil
          @battleback_sky_sprite.x = get_bg_zoom_in_out_x(-680, zoom)
          @battleback_sky_sprite.y = get_zoom_in_out_y(284, zoom)
        end
      #  if @battleback_pp1_sprite.bitmap != nil
      #    @battleback_pp1_sprite.x = get_pp_zoom_in_out_x(-250, zoom)
    #      @battleback_pp1_sprite.y = get_zoom_in_out_y(@battleback_pp1_sprite.bitmap.height/2+34, zoom)
     #   end
     #   if @battleback_pp2_sprite.bitmap != nil
    #      @battleback_pp2_sprite.x = get_zoom_in_out_x(-320, zoom)
    #      @battleback_pp2_sprite.y = get_zoom_in_out_y(@battleback_pp2_sprite.bitmap.height/2+30, zoom)
     #   end
      else 
      end
      
      # 値更新
      @now_bg_x = $xcam_x
      @now_bg_y = $xcam_y
      @now_bg_z = $xcam_z
    end  # if @now_bg_x != $xcam_x or @now_bg_y != $xcam_y or @now_bg_z != $xcam_z
    
    # 天候グラフィックを更新
    @weather.type = $game_screen.weather_type
    @weather.max = $game_screen.weather_max
    @weather.update
    # ピクチャスプライトを更新
    for sprite in @picture_sprites
      sprite.update
    end
    # タイマースプライトを更新
    @timer_sprite.update
    # 畫面色調和搖晃設定
  #  @viewport1.tone = $game_screen.tone 
    @viewport3.tone = $game_screen.tone   
    #  搖晃設定
    @viewport1.ox =  $game_screen.shake_x#.round
    @viewport1.oy =  $game_screen.shake_y#.round
    @viewport2.ox =  $game_screen.shake_x#.round    
    @viewport2.oy =  $game_screen.shake_y#.round
    @viewport3.ox =  $game_screen.shake_x#.round
    @viewport3.oy =  $game_screen.shake_y#.round
    
    # 画面のフラッシュ色を設定
    @viewport4.color = $game_screen.flash_color
    # ビューポートを更新
    @viewport1.update
    @viewport2.update
    @viewport3.update
    @viewport4.update

  end
  
  
  #--------------------------------------------------------------------------
  # ● 釋放
  #--------------------------------------------------------------------------
  def dispose
    # 如果戰鬥背景點陣圖存在的情況下就釋放
    if @battleback_sprite.bitmap != nil
      @battleback_sprite.bitmap.dispose
    end
    # 釋放戰鬥背景活動區塊
    @battleback_sprite.dispose
    
    # 釋放戰鬥背景天空
    @battleback_sky_sprite.bitmap.dispose if @battleback_sky_sprite.bitmap != nil
    @battleback_sky_sprite.dispose
    # 釋放裝飾背景1、2
    @battleback_bg1_sprite.bitmap.dispose if @battleback_bg1_sprite.bitmap != nil
    @battleback_bg2_sprite.bitmap.dispose if @battleback_bg2_sprite.bitmap != nil
    @battleback_bg3_sprite.bitmap.dispose  if @battleback_bg3_sprite.bitmap != nil
    @battleback_bg1_sprite.dispose
    @battleback_bg2_sprite.dispose
    @battleback_bg3_sprite.dispose
    # 釋放裝飾前景1、2
    @battleback_pp1_sprite.bitmap.dispose  if @battleback_pp1_sprite.bitmap != nil
    @battleback_pp2_sprite.bitmap.dispose  if @battleback_pp2_sprite.bitmap != nil

    @battleback_pp1_sprite.dispose
    @battleback_pp2_sprite.dispose
    # 釋放左右邊障礙物
    @battleback_left_obstacle.bitmap.dispose  if @battleback_left_obstacle.bitmap != nil
    @battleback_right_obstacle.bitmap.dispose if @battleback_right_obstacle.bitmap != nil
    @battleback_left_obstacle.dispose
    @battleback_right_obstacle.dispose

    # 釋放敵人活動區塊、角色活動區塊
    for battler in $game_troop.enemies + $game_party.actors
      battler.battle_sprite.dispose
      battler.battle_sprite = nil
    end

    # 釋放飛行道具Sprite
    for sprite in @bullet_sprites
      sprite.dispose
    end
    # 清空數組
    @bullet_sprites.clear
    
    # 釋放小道具Sprite
    for item in @item_sprites
      item.dispose
    end
    # 數組清空
    item_sprites.clear
    
    # 釋放場內物件Sprite
    for field_object in @field_object_sprites
      field_object.dispose
    end
    # 數組清空
    @field_object_sprites.clear
    
    # 清除敵人 (Scene_Battle移植過來)
     $game_troop.enemies.clear
    # 釋放天氣
    @weather.dispose
    # 釋放圖片活動區塊
    for sprite in @picture_sprites
      sprite.dispose
    end
    # 釋放計時器活動區塊
    @timer_sprite.dispose
    # 釋放顯示連接埠
    @viewport1.dispose
    @viewport2.dispose
    @viewport3.dispose
    @viewport4.dispose
    
  end
  
  #--------------------------------------------------------------------------
  # ○ 追加飛行道具
  #--------------------------------------------------------------------------
  def battle_bullet_add(bullet)
    # 產生Sprite
    bullet.battle_sprite = Sprite_Battler.new(@viewport2,bullet)
    # 置入數組
    @bullet_sprites.push(bullet.battle_sprite)
    self.update(true)
  end
  #--------------------------------------------------------------------------
  # ○ 移除飛行道具
  #--------------------------------------------------------------------------
  def battle_bullet_minus(bullet)
    #@bullet_sprites[index].dispose
    bullet.battle_sprite.dispose
    @bullet_sprites.delete(bullet.battle_sprite)
    
   # @bullet_sprites[index] = nil
    #@bullet_sprites.delete(bullet)
  end
  #--------------------------------------------------------------------------
  # ○ 移除全部飛行道具(戰鬥結束用)
  #--------------------------------------------------------------------------
  def battle_bullet_allremove
    for sprite in @bullet_sprites
      sprite.dispose
    end
    @bullet_sprites.clear  ########
  end
  #--------------------------------------------------------------------------
  # ○ 追加小道具
  #--------------------------------------------------------------------------
  def battle_item_add(item)
     item.battle_sprite = Sprite_Item.new(@viewport2,item)
    # 置入數組
    @item_sprites.push(item.battle_sprite)
  end
  #--------------------------------------------------------------------------
  # ○ 移除小道具
  #--------------------------------------------------------------------------
  def battle_item_minus(item)
    item.battle_sprite.dispose
    @item_sprites.delete(item.battle_sprite)
  end
  
  #--------------------------------------------------------------------------
  # ○ 追加場內物件
  #--------------------------------------------------------------------------
  def battle_field_object_add(field_object)
     field_object.battle_sprite = Sprite_Battler.new(@viewport2,field_object)
    # 置入數組
    @field_object_sprites.push(field_object.battle_sprite)
  end
  #--------------------------------------------------------------------------
  # ○ 移除場內物件
  #--------------------------------------------------------------------------
  def battle_field_object_minus(field_object)
    field_object.battle_sprite.dispose
    @field_object_sprites.delete(field_object.battle_sprite)
  end
  #--------------------------------------------------------------------------
  # ○ 移除全部場內物件(戰鬥結束用)
  #--------------------------------------------------------------------------
  def battle_field_object_allremove
    for sprite in @field_object_sprites
      sprite.dispose
    end
  end

  #--------------------------------------------------------------------------
  # ○ 動畫一時停止
  #--------------------------------------------------------------------------  
  def stop_update_animation
    @stop_animation = true
  end
  #--------------------------------------------------------------------------
  # ○ 動畫再開
  #--------------------------------------------------------------------------  
  def start_update_animation
    @stop_animation = false
  end
  #--------------------------------------------------------------------------
  # ● 特效表示中判定 → 常に false に
  #--------------------------------------------------------------------------
  def effect?
    for battler in $game_troop.enemies + $game_party.actors
      return true if battler.battle_sprite.effect? 
    end 
    return false
  end
  
  
end
#==============================================================================
# ■ Scene_Battle
#==============================================================================
class Scene_Battle
  attr_accessor :xcam_watch_battler   # 鏡頭追隨的對象
  attr_accessor :xcam_x_destination  # 鏡頭x
  attr_accessor :xcam_z_destination  # 鏡頭z
  attr_accessor :wait_count_xcam
  #--------------------------------------------------------------------------
  # ● メイン処理
  #--------------------------------------------------------------------------
  alias xrxs_bp8_main main
  def main
    # カメラ初期位置決定
    $xcam_x = 5
    $xcam_y  = 154#0
    $xcam_z  = 185           #185
    # カメラの最初の目的値
    @xcam_x_destination = 0
    @xcam_y_destination = 120 #0
    @xcam_z_destination = 185                  #185
    # 今、注目バトラーは無し。
    @xcam_watch_battler = nil
    # 初期化
    @wait_count_xcam = 0
    # 戻す
    xrxs_bp8_main
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  alias xrxs_bp8_update update
  def update
    
   if  $crash_box  
      @camera_feature = [0,0,0] 
    end
    
      
    # 更新鏡頭位置。
    if @wait_count_xcam > 0 
      # 減少鏡頭定格時間
      @wait_count_xcam -= 1
    elsif @phase == 3 #or @all_stop_time > 0
    else
      # 鏡頭 Z 軸
      if $xcam_z  != @xcam_z_destination - @camera_feature[2] 
        if $xcam_z  < (@xcam_z_destination - @camera_feature[2])
          distance = [(@xcam_z_destination - @camera_feature[2] - $xcam_z)/10, 1].max
        else  # $xcam_z  > (@xcam_z_destination - @camera_feature[2])
          distance = [(@xcam_z_destination - @camera_feature[2] - $xcam_z)/10, -1].min
        end
        $xcam_z = [[$xcam_z + distance, 74].max, 9999].min
        
     #  p $xcam_z, @xcam_z_destination
        
        # 185 = 放大率1倍
      end
      # 鏡頭 X 軸
      if @xcam_watch_battler != nil # 有鏡頭主角時
        if $xcam_x != @xcam_watch_battler.x_pos #and (($game_temp.battle_field_w - 100 < @xcam_watch_battler.x_pos) or @xcam_watch_battler.x_pos > 100) # or $xcam_x.abs > STILILA::ZOOM_LIMIT_X
          if ($xcam_x - @xcam_watch_battler.x_pos).abs < 10
            distance = @xcam_watch_battler.x_pos - $xcam_x
          elsif $xcam_x < @xcam_watch_battler.x_pos
            distance = [(@xcam_watch_battler.x_pos - $xcam_x)/10, 10].max
          else
            distance = [(@xcam_watch_battler.x_pos - $xcam_x)/10, -10].min
          end
          maximum =  $game_temp.battle_field_w # 延伸範圍 = 場地大小
         # $xcam_x = [[$xcam_x + distance, -maximum].max, maximum].min
          $xcam_x = [[$xcam_x + distance, 0].max, maximum].min
       #   p $xcam_x
        end
      elsif $xcam_x != @xcam_x_destination # 沒有時
        if ($xcam_x - @xcam_x_destination).abs < 8
          distance = @xcam_x_destination - $xcam_x
        elsif $xcam_x < @xcam_x_destination
          distance = [(@xcam_x_destination - $xcam_x)/8, 8].max
        else
          distance = [(@xcam_x_destination - $xcam_x)/8, -8].min
        end
        maximum =  $game_temp.battle_field_w   # 延伸範圍 = 場地大小
        $xcam_x = [[$xcam_x + distance, -maximum].max, maximum].min
      end
      # 鏡頭 Y 軸
#=begin
      if @xcam_watch_battler != nil   # 有鏡頭主角時
        #y = @xcam_watch_battler.y_pos/2
        
       y = @xcam_watch_battler.y_pos - @camera_feature[1] + 140#+ 50 
        
        #基本鏡頭高度
        if $xcam_y != y#  or y.abs > STILILA::ZOOM_LIMIT_Y
          if ($xcam_y - y).abs < 10
            distance = y - $xcam_y
          elsif $xcam_y < y
            distance = [(y - $xcam_y)/10, 10].max
          else
            distance = [(y - $xcam_y)/10, -10].min
          end
          maximum =  $game_temp.battle_field_top_limit - $xcam_z #$game_temp.battle_field_h - 320- $xcam_z# - $xcam_z
          minimum = $game_temp.battle_field_bot_limit + $xcam_z
          $xcam_y = [[$xcam_y + distance, minimum].max, maximum].min  
        end
      
        
#=end
      elsif $xcam_y !=  $game_party.actors[0].y_pos #@xcam_y_destination  # 沒有時
        if $xcam_y < @xcam_y_destination
          distance = [(@xcam_y_destination - $xcam_y)/8, 1].max
        else
          distance = [(@xcam_y_destination - $xcam_y)/8, -1].min
        end
        maximum =  $game_temp.battle_field_top_limit - $xcam_z
        minimum = $game_temp.battle_field_bot_limit + $xcam_z
        $xcam_y = [[$xcam_y + distance, minimum].max, maximum].min
      end
    end
    
    
    
    
    # 調用原方法
    xrxs_bp8_update
  end
  
  
  #--------------------------------------------------------------------------
  # ● 直接指定鏡頭位置(x, y)
  #--------------------------------------------------------------------------
  def focus_zoom_inout(x, y)
     # 捲動限制
     x_limit =  $game_temp.battle_field_w
     y_limit =  $game_temp.battle_field_h
     # 設定鏡頭位置
    # $xcam_x = [[x, -x_limit].max, x_limit].min
     $xcam_x = [[x, 0].max, x_limit].min
     $xcam_y = [[y, $game_temp.battle_field_bot_limit + $xcam_z].max, $game_temp.battle_field_top_limit - $xcam_z].min
  end
end

