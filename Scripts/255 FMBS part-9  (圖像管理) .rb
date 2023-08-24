# ▼▲▼ XRXS_BP11. バトラーモーションXC. ver..04b ▼▲▼
# by 桜雅 在土

#==============================================================================
# □ カスタマイズポイント
#==============================================================================
class Scene_Battle
  #
  # 「自動アニメ」稼動
  #
  AUTO_UPDATE_DECPLACE = false
  #
  # 「自動アニメ」:自動的に下一桁を加算するモーションの配列
  # 會自動變化的動作(編號為第一張，後續的就是以此往下加)
  # 比方說跳躍動作第一張為41，有42的話就會變成42
  # 總之只要動作的圖像符合數組編號就會自動進行
  AUTO_UPDATE_NUMBERS = [1,41,51,61,71]
  #
  # アニメを繰り返すモーションの配列(下一桁は1)
  # 當最後一張結束時會返回第一張循環
  # 9/23 功能廢除
  # AUTO_UPDATE_LOOP = [1,41,51,81,101, 221, 231,301] 
end
class Game_Battler
  #
  # "バッドステート"であると判断するステートのIDの配列
  #
  BAD_STATE_IDS = [2, 3, 4, 5, 6, 7, 8]
  #--------------------------------------------------------------------------
  # ○ スキルが魔法スキルがどうかの判別
  #--------------------------------------------------------------------------
  def skill_is_a_magic?(skill)
    return skill == nil ? false : (skill.str_f < skill.int_f)
  end
end
# □ 固定値の設定
module XRXS_BP11
  
  # Frame ID List(這邊數值僅供備忘)

  BASIC        =   1              # 待機：基本(1に固定)
  DASHBREAK = 29          # 衝刺停止
  JUMP_READY  =  31              # 起跳準備/著地
  AIR_FD  =  36              # 空前衝
  AIR_BD  =  38              # 空後衝
  JUMPING1  =  41              # 跳躍中(上升)
  JUMPING2  =  51              # 跳躍中(落下)
  JUMPING3  =  61              # 衝刺跳躍中(上升)
  JUMPING4  =  71              # 衝刺跳躍中(落下)
  GUARD  =  81                        # 防御
  GUARD_SHOCK  =  86           # 防御受擊
  DAMAGE1 =  91              # ダメージ受け1
  DAMAGE2 =  94              # ダメージ受け2
  DAMAGE3 =  97              # ダメージ受け3

  DOWN         =  121             # 倒地
    
  BAD_STATE    =  951              # 無法行動
  LIGHT_BLOW = 961             #被打飛(輕度)
  HARD_BLOW = 971              #被打飛(重度)
  WIN_ACTION   = 981              # 戦闘勝利時
  WIN_ACTION   = 991              # 戦闘勝利時
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_accessor :now_form_id              # フォームID
  attr_accessor :battler_name_basic_form  # バトラーの基本バトラーグラフィック
  #--------------------------------------------------------------------------
  # ○ フォームID
  #--------------------------------------------------------------------------
  def now_form_id
    if @now_form_id != nil
      return @now_form_id
    else
      return 1
    end
  end
  #--------------------------------------------------------------------------
  # ○ 基本待機フォームへのバトラーグラフィックの変更
  #--------------------------------------------------------------------------
  def transgraphic_basic_form
    if dead? and battler_graphic_exist?(XRXS_BP11::DOWN)
      form_id = XRXS_BP11::DOWN
    else
      form_id = XRXS_BP11::BASIC
      for state_id in @states
        form_id = XRXS_BP11::BAD_STATE if BAD_STATE_IDS.include?(state_id)
      end
    end
    transgraphic(form_id)
  end
  #--------------------------------------------------------------------------
  # ○ バトラーグラフィックの変更
  # 　　　form_id : 変更後のフォームのID
  #--------------------------------------------------------------------------
  def transgraphic(form_id)
    # 現在フォームID の更新。
   # @now_form_id = form_id
    if form_id == 0
      # 0 が指定された場合、グラフィックを消す
      @battler_name = ""
      return
  #  elsif form_id == 1
      # 1 が指定された場合、初期グラフィックへ戻す
     # @battler_name = @battler_name_basic_form.to_s
    else
      # 有無チェック
      if battler_graphic_exist?(form_id)
        # グラフィック変更
        @battler_name = form_id_to_name(form_id)
        # 有變更圖像時才更新現在的圖片號
        @now_form_id = form_id
      end
    end
  end
  #--------------------------------------------------------------------------
  # ○ バトラーグラフィックの有無
  #--------------------------------------------------------------------------
  def battler_graphic_exist?(form_id)    
    # バトラーグラフィックス読み込みテスト
    begin
      RPG::Cache.battler(form_id_to_name(form_id), @battler_hue)
    rescue  
      # 無かったときの処理
      return false
    end
    return true
  end
  
  #--------------------------------------------------------------------------
  # ○ 獲取圖像大小
  #--------------------------------------------------------------------------
  def graphic_size
     picture = RPG::Cache.battler(@battler_name, @battler_hue)
     return [picture.width, picture.height]
  end
  
  #--------------------------------------------------------------------------
  # ○ form_id と @battler_name_basic_form から form_name を作成 (String)
  #--------------------------------------------------------------------------
  def form_id_to_name(form_id)
    #form_name = @battler_name_basic_form.to_s + "_"
     form_name = @battler_name_basic_form.to_s + "_battler/" + @battler_name_basic_form.to_s + "_"
     # if self.is_a?(Game_BattleBullet)
    #    form_id += 10000
    #  end
    if form_id < 10
      form_name += "00"
    elsif form_id < 100
      form_name += "0"
    end
    form_name += form_id.to_s
    return form_name
  end
end
#==============================================================================
# ■ Sprite_Battler
#==============================================================================
class Sprite_Battler < RPG::Sprite
  #--------------------------------------------------------------------------
  # ● コラプス
  #--------------------------------------------------------------------------
  def collapse
    # 掉補品
    if @battler.is_a?(Game_Enemy) and rand(3) > 1 and @battler.id != 6 and $game_temp.battle_troop_id < 39 and !$game_switches[STILILA::NO_MEAT]
      drop_item = Game_Item.new(@battler.x_pos, @battler.y_pos, @battler.zoom, 500, 0, Rect.new(-30,-32, 60, 32), 1, @battler.y_min)
      $scene.items_add(drop_item)
    end
    if @battler.battler_graphic_exist?(XRXS_BP11::DOWN) and @battler.is_a?(Game_Actor)
    else
    super
    end
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  alias xrxs_bp11_update update
  def update
    xrxs_bp11_update
    return if @battler == nil
    
    if @battler.is_a?(Game_Actor) and @battler.motion != nil
      if @battler.motion.eva_invincible_duration > 0
        @battler.blink = true
     #  self.opacity = 180
     else
        @battler.blink = false
      # self.opacity = 255
     end
   end
   
    
#    if @battler.dead? and @battler.battler_graphic_exist?(XRXS_BP11::DOWN) and !@battler.is_a?(Game_Enemy)
    #  self.opacity = 255
  #  end
  end
end

#==============================================================================
# ■ Game_Actor
#==============================================================================
class Game_Actor < Game_Battler
  #--------------------------------------------------------------------------
  # ○ 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_reader   :battler_name_basic_form      # バトラー ファイル名:基本
  #--------------------------------------------------------------------------
  # ● セットアップ
  #--------------------------------------------------------------------------
  alias xrxs_bp11_setup setup
  def setup(actor_id)
    xrxs_bp11_setup(actor_id)
    @battler_name_basic_form = @battler_name
  end
  #--------------------------------------------------------------------------
  # ● グラフィックの変更
  #--------------------------------------------------------------------------
  alias xrxs_bp11_set_graphic set_graphic
  def set_graphic(character_name, character_hue, battler_name, battler_hue)
    xrxs_bp11_set_graphic(character_name, character_hue, battler_name, battler_hue)
    @battler_name_basic_form = @battler_name
  end
end
#==============================================================================
# ■ Game_Enemy
#==============================================================================
class Game_Enemy < Game_Battler
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  alias xrxs_bp11_initialize initialize
  def initialize(troop_id, member_index, pos, id, hidden, immortal)
    xrxs_bp11_initialize(troop_id, member_index, pos, id, hidden, immortal)
    @battler_name_basic_form = @battler_name
  end
end

#==============================================================================
# ■ Game_BattleBullet
#==============================================================================
class Game_BattleBullet < Game_Battler
  attr_accessor :battler_name
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  alias xrxs_bp11_initialize initialize
  def initialize(user,anime,frame_id,x,y,gravity_affect,piercing,other_vars=nil)
    xrxs_bp11_initialize(user,anime,frame_id,x,y,gravity_affect,piercing,other_vars)
    @battler_name_basic_form = user.battler_name_basic_form
  end
end


#==============================================================================
# ■ Scene_Battle
#==============================================================================
class Scene_Battle
  #--------------------------------------------------------------------------
  # ● メイン処理
  #--------------------------------------------------------------------------
  alias xrxs_bp11_main main
  def main
    @wait_count_motion = 0
    xrxs_bp11_main
  end
=begin
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  alias xrxs_bp11_update update
  def update
    xrxs_bp11_update
    
    #定格特效
    if @all_stop_time > 0
      @all_stop_time -= 1
        return
    end
    # バトラーグラフィック表示更新
    if @wait_count_motion > 0
      # ウェイトカウントを減らす
      @wait_count_motion -= 1
    elsif AUTO_UPDATE_DECPLACE
      for battler in $game_party.actors + $game_troop.enemies + @battle_bullets
        next if battler.nil?
        next if !battler.motion.attack_motion_plan.empty?
        
        # バトラー待機グラフィックの更新
        trance_id = battler.now_form_id
        
        if battler.is_a?(Game_BattleBullet)
          trance_id += 1
          unless battler.battler_graphic_exist?(trance_id)
            trance_id = 1
          end 
        elsif AUTO_UPDATE_NUMBERS.include?(trance_id/10 * 10 + 1)  
          
        #  p trance_id if battler.is_a?(Game_Actor)
          
          # 一つ進める
          if  (trance_id%10) == 9          #or (trance_id/10 * 10) != 1
            trance_id -= 8  
          else
            trance_id += 1
          end
          unless battler.battler_graphic_exist?(trance_id)
            id_mines = ((trance_id%10)-1)
            trance_id =  trance_id - id_mines
          end
        end
        battler.transgraphic(trance_id)  
      end
      unless trance_id.nil?
        if (trance_id/10 * 10 + 1) == 971
          @wait_count_motion = 0
        else
          @wait_count_motion = 4
        end
      end
    end
  end
=end
  #--------------------------------------------------------------------------
  # ● プレバトルフェーズ開始
  #--------------------------------------------------------------------------
  alias xrxs_bp11_start_phase1 start_phase1
  def start_phase1
    xrxs_bp11_start_phase1
    # モーションをリセット
    actors_motion_reset
  end
  #--------------------------------------------------------------------------
  # ○ アクター達のモーションをリセット
  #--------------------------------------------------------------------------
  def actors_motion_reset
    for actor in $game_party.actors
      actor.transgraphic_basic_form
    end
  end
  #--------------------------------------------------------------------------
  # ● バトル終了
  #--------------------------------------------------------------------------
  alias xrxs_bp11_battle_end battle_end
  def battle_end(result)
    # モーションを基本に戻す
    for actor in $game_party.actors
      actor.set_graphic(actor.character_name, actor.character_hue, actor.battler_name_basic_form, actor.battler_hue)
      actor.now_form_id = 1
    end
    # 呼び戻す
    xrxs_bp11_battle_end(result)
  end
  
  
end
