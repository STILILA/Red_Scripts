# ▽△▽ XRXS_BS 1. AX.「レクトラインウィンドウ」 ▽△▽
# by 桜雅 在土

#==============================================================================
# □ カスタマイズポイント
#==============================================================================

  # 「レクトラインウィンドウを稼動」
  $crash_box = false
  
  
  
  #觀察判定的時候記得將XCAM_DISTANCE_MIN和XCAM_DISTANCE_MAX調成185，
  #位置才準確
#------------------------------------------------------------------------------

#==============================================================================
# ■ Scene_Battle
#==============================================================================
class Scene_Battle
  XCAM_DISTANCE_MIN_B = 185 #165
  XCAM_DISTANCE_MAX_B = 185 #165
  #--------------------------------------------------------------------------
  # ● メイン処理
  #--------------------------------------------------------------------------
  alias xrxs_bs1_ax_main main
  def main
    # 呼び戻す
    xrxs_bs1_ax_main
    # レクトラインウィンドウの開放
  # @window_rectline.dispose
    if @windowrect_block != nil
      @windowrect_body.bitmap.dispose
      @windowrect_body.dispose
      @windowrect_atk.bitmap.dispose
      @windowrect_atk.dispose
      @windowrect_block.bitmap.dispose
      @windowrect_block.dispose
      @windowrect_item.bitmap.dispose
      @windowrect_item.dispose
    end
  end
  #--------------------------------------------------------------------------
  # ● プレバトルフェーズ開始
  #--------------------------------------------------------------------------
  alias xrxs_bs1_ax_start_phase1 start_phase1
  def start_phase1
    # 呼び戻す
    xrxs_bs1_ax_start_phase1
    # レクトライン表示ON
    #@window_rectline = Window_RectLine.new
    @windowrect_block = Sprite.new
    @windowrect_block.bitmap = Bitmap.new(640, 480)
    @windowrect_block.z = 4999
    @windowrect_body = Sprite.new
    @windowrect_body.bitmap = Bitmap.new(640, 480)
    @windowrect_body.z = 5000
    @windowrect_atk = Sprite.new
    @windowrect_atk.bitmap = Bitmap.new(640, 480)
    @windowrect_atk.z = 5001
    @windowrect_item = Sprite.new
    @windowrect_item.bitmap = Bitmap.new(640, 480)
    @windowrect_item.z = 5002
  end
  #--------------------------------------------------------------------------
  # ○ フレーム更新 (座標系更新) 
  #--------------------------------------------------------------------------
  alias xrxs_bs1_ax_update_coordinates update#_coordinates
  def update#_coordinates
    # 呼び戻す
    xrxs_bs1_ax_update_coordinates
    # レクトライン描写
    if $crash_box
      if @windowrect_block == nil
        @windowrect_block = Sprite.new  
        @windowrect_block.bitmap = Bitmap.new(640, 480)
        @windowrect_block.z = 4999
      end
      if @windowrect_body == nil
        @windowrect_body = Sprite.new 
        @windowrect_body.bitmap = Bitmap.new(640, 480)
        @windowrect_body.z = 5000
      end
      if @windowrect_atk == nil
        @windowrect_atk = Sprite.new 
        @windowrect_atk.bitmap = Bitmap.new(640, 480)
        @windowrect_atk.z = 5001
      end
      if @windowrect_item == nil
        @windowrect_item = Sprite.new 
        @windowrect_item.bitmap = Bitmap.new(640, 480)
        @windowrect_item.z = 5002
      end
      update_rectline
    else
      if @windowrect_block != nil
        @windowrect_body.bitmap.dispose
        @windowrect_body.dispose
        @windowrect_body = nil
        @windowrect_atk.bitmap.dispose
        @windowrect_atk.dispose
        @windowrect_atk = nil
        @windowrect_block.bitmap.dispose
        @windowrect_block.dispose
        @windowrect_block = nil
        @windowrect_item.bitmap.dispose
        @windowrect_item.dispose
        @windowrect_item = nil
        GC.start
      end
    end  
    

    

  end
  #--------------------------------------------------------------------------
  # ○ フレーム更新(レクトライン)
  #--------------------------------------------------------------------------
  def update_rectline

    #return unless ENABLE_RECTLINE_WINDOW
  #  @window_rectline.clear
    @windowrect_body.bitmap.clear
    @windowrect_atk.bitmap.clear
    @windowrect_block.bitmap.clear
    @windowrect_item.bitmap.clear
    zoom = 185.0 / $xcam_z
    # バトラー
    for battler in $game_party.actors + $game_troop.enemies + @battle_bullets + @battle_field_objects
      next if battler.nil? or battler.hidden
      # ---身體判定---
      if !battler.is_a?(Game_BattleBullet)

        battler_rect    = battler.body_rect.dup
        battler_rect.width  *= zoom
        battler_rect.height *= zoom
        
        # 逆向(面左)時
        if battler.direction == -1
          battler_rect.x = -1 * battler_rect.x - battler_rect.width        
        end
        if battler.motion.eva_invincible_duration > 0
          r,g,b = 255,255,255
        else
          r,g,b = 120,125,255
        end
        battler_rect.x += battler.screen_x
        battler_rect.y += battler.screen_y# - battler_rect.height
     #   @window_rectline.write_rect(battler_rect, Color.new(120, 125, 255, 255))
        @windowrect_body.bitmap.fill_rect(battler_rect, Color.new(r, g, b, 110))
    
      end
      
      # ---攻擊判定---
      atk_rect    = battler.motion.attack_rect.dup
      for atk_r in atk_rect
        atk_part = atk_r.dup
        atk_part.width  *= zoom
        atk_part.height *= zoom
        # 通常 / シューティングターゲット
        if battler.direction == -1
          # 逆向きの場合
          atk_part.x = -1 * atk_part.x - atk_part.width
        end
        atk_part.x += battler.screen_x
        atk_part.y += battler.screen_y   
      #  @window_rectline.write_rect(atk_part, Color.new(255, 128, 128, 255))
        @windowrect_atk.bitmap.fill_rect(atk_part, Color.new(255, 128, 128, 190))
      end
      
    end
    
    
    # ブロック
    for board in @field_boards
      # ---ボードレクト---
      board_rect = board.dup
      board_rect.x =  get_zoom_in_out_x(board_rect.x, zoom)
      board_rect.y =  get_zoom_in_out_y(-board_rect.y, zoom)
      board_rect.width  *= zoom
      board_rect.height  *= zoom
  #    @window_rectline.write_rect(board.dup, Color.new(128, 255, 128, 255))
      @windowrect_block.bitmap.fill_rect(board_rect, Color.new(128, 255, 128, 190))
    end
    for block in @field_blocks
      # ---ブロックレクト---
      block_rect = block.dup
      block_rect.x =  get_zoom_in_out_x(block_rect.x, zoom)
      block_rect.y =  get_zoom_in_out_y(-block_rect.y, zoom)
      block_rect.width  *= zoom
      block_rect.height  *= zoom
   #   @window_rectline.write_rect(block_rect.dup, Color.new(255, 0, 0, 255))
      @windowrect_block.bitmap.fill_rect(block_rect, Color.new(80, 80, 0, 160))
    end
    
    for ev_block in @field_events
      # ---ブロックレクト---
      ev_block_rect = ev_block.dup
      ev_block_rect.x =  get_zoom_in_out_x(ev_block_rect.x, zoom)
      ev_block_rect.y =  get_zoom_in_out_y(-ev_block_rect.y, zoom)
      ev_block_rect.width  *= zoom
      ev_block_rect.height  *= zoom
   #   @window_rectline.write_rect(block_rect.dup, Color.new(255, 0, 0, 255))
      @windowrect_block.bitmap.fill_rect(ev_block_rect, Color.new(225, 80, 0, 160))
    end
    
    # 道具判定
    for item in @battle_items
      item_rect = item.body_rect.dup
      item_rect.width  *= zoom
      item_rect.height  *= zoom
      item_rect.x += item.screen_x
      item_rect.y += item.screen_y
      @windowrect_item.bitmap.fill_rect(item_rect, Color.new(30, 205, 30, 125))
    end
    
    
    # フレームリセット
    Graphics.frame_reset 
  end
  
  
end
#==============================================================================
# □ Window_RectLine
#==============================================================================
class Window_RectLine < Window_Base
  #--------------------------------------------------------------------------
  # ○ オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize
    super(-16, -16, 672, 512)
    self.contents = Bitmap.new(width - 32, height - 32)
    self.opacity = 64
    self.back_opacity = 64
    
  end
  #--------------------------------------------------------------------------
  # ○ クリア
  #--------------------------------------------------------------------------
  def clear
    self.contents.clear
  end
  #--------------------------------------------------------------------------
  # ○ レクトライン描画
  #--------------------------------------------------------------------------
  def write_rect(rect, color)
    self.contents.draw_rect(rect, color)
  end
end
# ▼▲▼ XRXL 1. ライン・図形描写 ▼▲▼
# by 桜雅 在土, 和希

#==============================================================================
# ◇ 外部ライブラリ
#==============================================================================
class Bitmap
  #--------------------------------------------------------------------------
  # ● ライン描画 by 桜雅 在土
  #--------------------------------------------------------------------------
  def draw_line(start_x, start_y, end_x, end_y, start_color, width = 1, end_color = start_color)
    # 描写距離の計算。大きめに直角時の長さ。
    distance = (start_x - end_x).abs + (start_y - end_y).abs
    # 描写開始
    if end_color == start_color
      for i in 1..distance
        x = (start_x + 1.0 * (end_x - start_x) * i / distance).to_i
        y = (start_y + 1.0 * (end_y - start_y) * i / distance).to_i
        if width == 1
          self.set_pixel(x, y, start_color) 
        else
          self.fill_rect(x, y, width, width, start_color) 
        end
      end
    else
      for i in 1..distance
        x = (start_x + 1.0 * (end_x - start_x) * i / distance).to_i
        y = (start_y + 1.0 * (end_y - start_y) * i / distance).to_i
        r = start_color.red   * (distance-i)/distance + end_color.red   * i/distance
        g = start_color.green * (distance-i)/distance + end_color.green * i/distance
        b = start_color.blue  * (distance-i)/distance + end_color.blue  * i/distance
        a = start_color.alpha * (distance-i)/distance + end_color.alpha * i/distance
        if width == 1
          self.set_pixel(x, y, Color.new(r, g, b, a))
        else
          self.fill_rect(x, y, width, width, Color.new(r, g, b, a)) 
        end
      end
    end
  end
  #--------------------------------------------------------------------------
  # ● 多角形の描画(塗りつぶしなし) by 和希
  #    peaks    : 頂点座標の配列 [[x1,y1],[x2,y2],[x3,y3], ... ]
  #    color    : 線の色
  #    width    : 線の幅
  #--------------------------------------------------------------------------
  def draw_polygon(peaks, color, width = 1)
    # 辺(=頂点)の個数分だけ辺を描く
    for i in 0 ... (peaks.size - 1)
      # 頂点同士を線で結ぶ
      draw_line( peaks[i][0], peaks[i][1], peaks[i+1][0], peaks[i+1][1], color, width )
    end
    # 最後の頂点と最初の頂点を結ぶ
    draw_line( peaks[peaks.size - 1][0], peaks[peaks.size - 1][1], peaks[0][0], peaks[0][1], color, width )
  end
  #--------------------------------------------------------------------------
  # ● Rectの描画(draw_polygonを利用)
  #--------------------------------------------------------------------------
  def draw_rect(rect, color = Color.new(255, 255, 255, 255))
    self.draw_polygon([
      [rect.x             , rect.y              ],
      [rect.x + rect.width, rect.y              ],
      [rect.x + rect.width, rect.y + rect.height],
      [rect.x             , rect.y + rect.height]
    ],
    color, 1)
  end
end

