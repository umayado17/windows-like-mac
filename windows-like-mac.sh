#!/bin/zsh
# Windows寄せMac設定スクリプト (2026-11-20, ノリさん用)
# 使い方: 各Macで一度だけ実行する。  zsh ~/windows-like-mac.sh
# 元に戻す項目は末尾のメモ参照。実行後に Dock / Finder は再起動され、
# 「ディスプレイごとに個別の操作スペース」だけはログアウト→ログインで有効になる。
#
# 【iMac (hd-05) 実測メモ 2026-11-20】このスクリプトは iMac の現状 = 本人の確定形。
# 次の4点は本人が意図的に ON のままにすると決めたもの (2026-11-20「わざとだからよい」)。
# スクリプトでも OFF にせず、該当行はコメントアウトしてある:
#   ・スペースの自動並べ替え (下の mru-spaces 行)
#   ・スペル自動変換 / スマート引用符・ダッシュ (下の文字入力の該当行)
#   ・ポインタをシェイクして見つける (末尾のGUI対象外リスト参照)
# 逆に iMac で実施済みなのにスクリプト対象外のもの:
#   ・Edge「タブを整理しましょう」OFF / マウスのページ間スワイプ OFF / スマートズーム OFF

set -x

# --- ウインドウ: ドラッグでタイル表示 / 画面いっぱい を止める ---
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTilingOptionAccelerator -bool false
# --- ウインドウ: 壁紙クリックでデスクトップ表示 を止める / ステージマネージャ OFF ---
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
defaults write com.apple.WindowManager GloballyEnabled -bool false
# --- ウインドウ: タイトルバーのダブルクリックで拡大 を止める ---
defaults write -g AppleActionOnDoubleClick -string "None"

# --- Dock: 拡大 OFF / 自動的に表示・非表示 OFF ---
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock autohide -bool false
# --- ホットコーナー: 四隅すべて無効 (0 = 何もしない) ---
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-br-corner -int 0
# --- Mission Control: スペースを最近の使用順に自動で並べ替える ---
# ※ 本人が意図的に ON のままにする (2026-11-20確定)。切るなら次の行を有効化:
# defaults write com.apple.dock mru-spaces -bool false
# --- ディスプレイごとに個別の操作スペース OFF (= Dockが別モニターへ移らない。要・再ログイン) ---
defaults write com.apple.spaces spans-displays -bool true

# --- マウス: ナチュラルスクロール OFF (ホイールがWindowsと同じ向き) ---
defaults write -g com.apple.swipescrolldirection -bool false
# --- ブラウザ等: 横スワイプで「戻る/進む」の誤発を止める ---
defaults write -g AppleEnableSwipeNavigateWithScrolls -bool false
defaults write -g AppleEnableMouseSwipeNavigateWithScrolls -bool false

# --- 文字入力: 勝手な書き換えを止める (英文向け。日本語入力には影響なし) ---
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
# ※ 次の3点は本人が意図的に ON のままにする (2026-11-20確定)。切るなら有効化:
# defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
# defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
# defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

# --- Finder: エクスプローラー寄せ ---
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

killall Dock Finder SystemUIServer 2>/dev/null
echo "完了。ログアウト→ログインすると『ディスプレイごとに個別の操作スペース OFF』まで有効になります。"

# --- GUIでしか確実に切れないもの (このスクリプト対象外) ---
# ・ポインタをシェイクして見つける : アクセシビリティ > ディスプレイ > ポインタ
#   ※ 本人が意図的に ON のままにする (2026-11-20確定)
# ・スマートズーム OFF                  : マウス > ポイントとクリック
#   ※ iMacでは実施済み (OFF)
# ・マウスのページ間スワイプ OFF        : マウス > その他のジェスチャ
#   ※ iMacでは実施済み (「オフ」)。ただしフルスクリーンアプリ間スワイプと
#     Mission Controlジェスチャ (2本指ダブルタップ) は iMac では ON のまま
# ・ウインドウを画面上部にドラッグしてMission Controlに入る OFF
#   : デスクトップとDock > Mission Control ※ iMacでは ON のまま (未提案)
# ・Edgeのタブ自動整理 OFF              : Edge設定 > プライバシー、検索、サービス
#   「Microsoft Edge でタブを整理しましょう」をオフ (Edge側の同期が効く場合あり)
#   ※ iMacでは実施済み (OFF)
#
# --- 戻し方メモ ---
# 各項目は defaults delete <domain> <key> で既定に戻る。
# 例: defaults delete com.apple.dock autohide && killall Dock
