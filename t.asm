INCLUDE Irvine32.inc

MAX_NAME_LEN   EQU 64
MAX_BIRTH_LEN  EQU 32
MAX_ZODIAC_LEN EQU 32
BITS           EQU 16
NUM_FORTUNES_PER_CAT EQU 24

.data
ESC_CODE EQU 27
zodiacMenu BYTE 0Dh, 0Ah, "請選擇星座 (上下鍵選擇，Enter確認)：", 0Dh, 0Ah, 0

zodiac1  BYTE "Aries", 0
zodiac2  BYTE "Taurus", 0
zodiac3  BYTE "Gemini", 0
zodiac4  BYTE "Cancer", 0
zodiac5  BYTE "Leo", 0
zodiac6  BYTE "Virgo", 0
zodiac7  BYTE "Libra", 0
zodiac8  BYTE "Scorpio", 0
zodiac9  BYTE "Sagittarius", 0
zodiac10 BYTE "Capricorn", 0
zodiac11 BYTE "Aquarius", 0
zodiac12 BYTE "Pisces", 0

zodiacList DWORD OFFSET zodiac1, OFFSET zodiac2, OFFSET zodiac3
           DWORD OFFSET zodiac4, OFFSET zodiac5, OFFSET zodiac6
           DWORD OFFSET zodiac7, OFFSET zodiac8, OFFSET zodiac9
           DWORD OFFSET zodiac10, OFFSET zodiac11, OFFSET zodiac12

zodiacSel  DWORD 0           ; 目前選擇 (0-11)
arrowMark  BYTE "> ", 0
spaceMark  BYTE "  ", 0
clearLine  BYTE ESC_CODE, "[K", 0    ; 清除該行
cursorUp12 BYTE ESC_CODE, "[12A", 0  ; 游標上移 12 行
pressRightMsg BYTE 0Dh, 0Ah, "按右鍵繼續...", 0
progressInit BYTE 0Dh, 0Ah, "抽籤進度：", 0
barBlock     BYTE "█", 0
pctBack      BYTE ESC_CODE, "[4D", 0     ; 往左 4 格覆蓋百分比
setLoveBg    BYTE ESC_CODE, "[48;2;235;214;214;30m", 0   ; #EBD6D6 粉色
setStudyBg   BYTE ESC_CODE, "[48;2;196;225;225;30m", 0   ; #C4E1E1 青色
setHealthBg  BYTE ESC_CODE, "[48;2;255;248;215;30m", 0   ; #FFF8D7 黃色

currentBg    DWORD 0    ; 0=白色, 1=粉色, 2=青色, 3=黃色
; 白底黑字設定
setWhiteBg   BYTE ESC_CODE, "[47;30m", 0
clearAll     BYTE ESC_CODE, "[2J", ESC_CODE, "[H", 0
resetColor   BYTE ESC_CODE, "[0m", 0
; ================================
; 愛心
; ================================
love_heart1  BYTE ESC_CODE, "[38;5;213m", "      ░░░░░      ░░░░░      ", ESC_CODE, "[0;48;2;235;214;214;30m", 0Dh, 0Ah, 0
love_heart2  BYTE ESC_CODE, "[38;5;218m", "    ░░▒▒▒▒░░    ░░▒▒▒▒░░    ", ESC_CODE, "[0;48;2;235;214;214;30m", 0Dh, 0Ah, 0
love_heart3  BYTE ESC_CODE, "[38;5;219m", "   ░▒▒▓▓▓▓▒▒░░░░▒▒▓▓▓▓▒▒░   ", ESC_CODE, "[0;48;2;235;214;214;30m", 0Dh, 0Ah, 0
love_heart4  BYTE ESC_CODE, "[38;5;197m", "  ░▒▓▓████▓▓▒▒▒▒▓▓████▓▓▒░  ", ESC_CODE, "[0;48;2;235;214;214;30m", 0Dh, 0Ah, 0
love_heart5  BYTE ESC_CODE, "[38;5;198m", "  ░▒▓███████▓▓▓▓███████▓▒░  ", ESC_CODE, "[0;48;2;235;214;214;30m", 0Dh, 0Ah, 0
love_heart6  BYTE ESC_CODE, "[38;5;199m", "  ░▒▓████████████████▓▓▒░  ", ESC_CODE, "[0;48;2;235;214;214;30m", 0Dh, 0Ah, 0
love_heart7  BYTE ESC_CODE, "[38;5;200m", "   ░▒▓██████████████▓▓▒░   ", ESC_CODE, "[0;48;2;235;214;214;30m", 0Dh, 0Ah, 0
love_heart8  BYTE ESC_CODE, "[38;5;201m", "    ░▒▓████████████▓▒░    ", ESC_CODE, "[0;48;2;235;214;214;30m", 0Dh, 0Ah, 0
love_heart9  BYTE ESC_CODE, "[38;5;213m", "     ░▒▓██████████▓▒░     ", ESC_CODE, "[0;48;2;235;214;214;30m", 0Dh, 0Ah, 0
love_heart10 BYTE ESC_CODE, "[38;5;218m", "       ░▒▓██████▓▒░       ", ESC_CODE, "[0;48;2;235;214;214;30m", 0Dh, 0Ah, 0
love_heart11 BYTE ESC_CODE, "[38;5;219m", "        ░▒▓████▓▒░        ", ESC_CODE, "[0;48;2;235;214;214;30m", 0Dh, 0Ah, 0
love_heart12 BYTE ESC_CODE, "[38;5;225m", "          ░▒▓▓▒░          ", ESC_CODE, "[0;48;2;235;214;214;30m", 0Dh, 0Ah, 0

; ================================
; 標題和選單
; ================================
welcomeTitle BYTE "+------------------------------+",0Dh,0Ah,
             "| 測測你今天的運勢             |",0Dh,0Ah,
             "+------------------------------+",0Dh,0Ah,0

menuPrompt BYTE "| 1. 愛情運勢                  |",0Dh,0Ah,
           "| 2. 學業運勢                  |",0Dh,0Ah,
           "| 3. 健康與財運                |",0Dh,0Ah,
           "+------------------------------+",0Dh,0Ah,
           "請輸入 1 / 2 / 3：",0

errorMsg     BYTE 0Dh,0Ah,"[輸入無效！預設為愛情運勢]",0Dh,0Ah,0

promptTitle      BYTE 0Dh,0Ah,"=== 請輸入個人資料 ===",0Dh,0Ah,0
promptEnterName  BYTE "請輸入英文名字: ",0
promptEnterBirth BYTE "請輸入生日 (例如 2005-03-14 或 20050314): ",0
promptEnterZod   BYTE "請輸入星座 (例如 Aries / Taurus / Gemini ...): ",0

resultHeader     BYTE 0Dh,0Ah,"--- 計算結果 ---",0Dh,0Ah,0
hashIntMsg       BYTE "Hash 整數值: ",0
hashBinMsg       BYTE "Hash 二進位: ",0
fortuneHeader    BYTE 0Dh,0Ah,"--- 你的籤 ---",0Dh,0Ah,0

; ================================
; 愛情運勢 (fortunesLove)
; ================================
fortunesLove DWORD OFFSET love_great_1, OFFSET love_great_2
         DWORD OFFSET love_great_3, OFFSET love_good_1
         DWORD OFFSET love_good_2, OFFSET love_good_3
         DWORD OFFSET love_small_1, OFFSET love_small_2
         DWORD OFFSET love_small_3, OFFSET love_luck_1
         DWORD OFFSET love_luck_2, OFFSET love_luck_3
         DWORD OFFSET love_minor_1, OFFSET love_minor_2
         DWORD OFFSET love_minor_3, OFFSET love_bad_1
         DWORD OFFSET love_bad_2, OFFSET love_bad_3
         DWORD OFFSET love_sbad_1, OFFSET love_sbad_2
         DWORD OFFSET love_sbad_3, OFFSET love_worst_1
         DWORD OFFSET love_worst_2, OFFSET love_worst_3

love_great_1 BYTE "愛情大吉：你的魅力爆棚，任何告白都有成功機率！",0
love_great_2 BYTE "愛情大吉：心中所想之人，也正默默注意著你。",0
love_great_3 BYTE "愛情大吉：命運正在推你們靠近，把握每次相遇。",0

love_good_1  BYTE "愛情中吉：彼此心意清晰，多交流會更甜蜜。",0
love_good_2  BYTE "愛情中吉：互動順利，適合安排一個小約會。",0
love_good_3  BYTE "愛情中吉：你們的距離正在縮短，耐心陪伴即可。",0

love_small_1 BYTE "愛情小吉：對方對你抱持好感，給點時間發酵。",0
love_small_2 BYTE "愛情小吉：適合傳訊息問候，能巧妙拉近距離。",0
love_small_3 BYTE "愛情小吉：一些小互動會帶來好進展。",0

love_luck_1  BYTE "愛情吉：今天情緒穩定，氣氛容易營造。",0
love_luck_2  BYTE "愛情吉：主動一點會有意外收穫。",0
love_luck_3  BYTE "愛情吉：你散發的自然感，讓人很舒服。",0

love_minor_1 BYTE "愛情末吉：互相試探較多，需要耐心。",0
love_minor_2 BYTE "愛情末吉：容易誤會，說話前多想一下。",0
love_minor_3 BYTE "愛情末吉：適合觀察，不急著行動。",0

love_bad_1   BYTE "愛情凶：溝通可能卡住，保持冷靜。",0
love_bad_2   BYTE "愛情凶：不要因為一時情緒做決定。",0
love_bad_3   BYTE "愛情凶：暫時避開敏感話題。",0

love_sbad_1  BYTE "愛情小凶：期待落空，但不影響長期。",0
love_sbad_2  BYTE "愛情小凶：對方忙碌，回應較慢。",0
love_sbad_3  BYTE "愛情小凶：不要過度猜測對方心情。",0

love_worst_1 BYTE "愛情大凶：今天不適合談論未來或表白。",0
love_worst_2 BYTE "愛情大凶：容易有爭執，保持距離較好。",0
love_worst_3 BYTE "愛情大凶：暫時冷靜，明天再試會比較順。",0

; ================================
; 學業運勢 (fortunesStudy)
; ================================
fortunesStudy DWORD OFFSET study_great_1, OFFSET study_great_2
          DWORD OFFSET study_great_3, OFFSET study_good_1
          DWORD OFFSET study_good_2, OFFSET study_good_3
          DWORD OFFSET study_small_1, OFFSET study_small_2
          DWORD OFFSET study_small_3, OFFSET study_luck_1
          DWORD OFFSET study_luck_2, OFFSET study_luck_3
          DWORD OFFSET study_minor_1, OFFSET study_minor_2
          DWORD OFFSET study_minor_3, OFFSET study_bad_1
          DWORD OFFSET study_bad_2, OFFSET study_bad_3
          DWORD OFFSET study_sbad_1, OFFSET study_sbad_2
          DWORD OFFSET study_sbad_3, OFFSET study_worst_1
          DWORD OFFSET study_worst_2, OFFSET study_worst_3

study_great_1 BYTE "學業大吉：讀書效率爆發，理解力滿點。",0
study_great_2 BYTE "學業大吉：難題突然迎刃而解，信心倍增。",0
study_great_3 BYTE "學業大吉：今天超適合寫作業或準備考試！",0

study_good_1  BYTE "學業中吉：進度穩定，適合排新的讀書計畫。",0
study_good_2  BYTE "學業中吉：小小努力就有明顯成效。",0
study_good_3  BYTE "學業中吉：與同學討論會有好結果。",0

study_small_1 BYTE "學業小吉：適合複習，能補上弱點。",0
study_small_2 BYTE "學業小吉：今天讀起來比平常順。",0
study_small_3 BYTE "學業小吉：小突破讓你更有動力。",0

study_luck_1  BYTE "學業吉：理解速度還不錯，保持節奏。",0
study_luck_2  BYTE "學業吉：適合念你想念的科目。",0
study_luck_3  BYTE "學業吉：讀書環境越安靜效果越好。",0

study_minor_1 BYTE "學業末吉：進度稍慢，不要焦急。",0
study_minor_2 BYTE "學業末吉：可能分心，需要整理心情。",0
study_minor_3 BYTE "學業末吉：適合做簡單的內容，避免困難題。",0

study_bad_1   BYTE "學業凶：容易卡住，不妨換一科讀。",0
study_bad_2   BYTE "學業凶：注意專注力，避免分心。",0
study_bad_3   BYTE "學業凶：適合休息一下再繼續。",0

study_sbad_1  BYTE "學業小凶：計畫趕不上變化，調整一下即可。",0
study_sbad_2  BYTE "學業小凶：今天念書可能不太順。",0
study_sbad_3  BYTE "學業小凶：不要硬讀，容易疲倦。",0

study_worst_1 BYTE "學業大凶：注意精神疲勞，不適合讀太久。",0
study_worst_2 BYTE "學業大凶：進度停滯，建議休息一天。",0
study_worst_3 BYTE "學業大凶：念書容易煩躁，慢慢來比較好。",0

; ================================
; 健康＋財運 (fortunesHealth)
; ================================
fortunesHealth DWORD OFFSET health_great_1, OFFSET health_great_2
           DWORD OFFSET health_great_3, OFFSET health_good_1
           DWORD OFFSET health_good_2, OFFSET health_good_3
           DWORD OFFSET health_small_1, OFFSET health_small_2
           DWORD OFFSET health_small_3, OFFSET health_luck_1
           DWORD OFFSET health_luck_2, OFFSET health_luck_3
           DWORD OFFSET health_minor_1, OFFSET health_minor_2
           DWORD OFFSET health_minor_3, OFFSET health_bad_1
           DWORD OFFSET health_bad_2, OFFSET health_bad_3
           DWORD OFFSET health_sbad_1, OFFSET health_sbad_2
           DWORD OFFSET health_sbad_3, OFFSET health_worst_1
           DWORD OFFSET health_worst_2, OFFSET health_worst_3

health_great_1 BYTE "健康財運大吉：精神飽滿，財運走上坡！",0
health_great_2 BYTE "健康大吉：身體狀態極佳，活力滿點。",0
health_great_3 BYTE "財運大吉：可能有小驚喜或意外收入。",0

health_good_1  BYTE "中吉：狀態平穩，適合規劃新目標。",0
health_good_2  BYTE "中吉：心情愉快，能量充足。",0
health_good_3  BYTE "中吉：理財靈感提升，適合做計畫。",0

health_small_1 BYTE "小吉：稍作運動能讓你更有精神。",0
health_small_2 BYTE "小吉：財運略有提升，小花費也值得。",0
health_small_3 BYTE "小吉：保持規律生活會讓運勢更好。",0

health_luck_1  BYTE "吉：身心均衡，適合外出走走。",0
health_luck_2  BYTE "吉：工作效率普通但穩定。",0
health_luck_3  BYTE "吉：消費要節制，不衝動購物。",0

health_minor_1 BYTE "末吉：稍微疲倦，注意休息。",0
health_minor_2 BYTE "末吉：避免大額花費。",0
health_minor_3 BYTE "末吉：精神狀態需要調整。",0

health_bad_1   BYTE "凶：可能感到壓力，放慢步調。",0
health_bad_2   BYTE "凶：小病痛容易出現，多喝水。",0
health_bad_3   BYTE "凶：注意荷包，避免破財。",0

health_sbad_1  BYTE "小凶：疲累累積，需要補眠。",0
health_sbad_2  BYTE "小凶：財運下降，避免投資。",0
health_sbad_3  BYTE "小凶：不適合外出太久。",0

health_worst_1 BYTE "大凶：精神不濟，今日運勢較弱。",0
health_worst_2 BYTE "大凶：財運不佳，建議不要做決策。",0
health_worst_3 BYTE "大凶：身體需要休息，別硬撐。",0

choiceInput BYTE 4 DUP(?)
choiceVal  DWORD ?

; ===== 愛情問題 (5 題) =====
question1Msg BYTE 0Dh,0Ah,"Q1. 愛情的觸感是什麼？",0Dh,0Ah,\
                    "1) 堅實的    2) 柔滑的",0Dh,0Ah,\
                    "3) 輕盈的    4) 溫軟的",0Dh,0Ah,\
                    "請輸入 1-4：",0

question2Msg BYTE 0Dh,0Ah,"Q2. 你在愛情中的步伐像什麼？",0Dh,0Ah,\
                    "1) 穩穩走    2) 緩緩靠近",0Dh,0Ah,\
                    "3) 偶爾衝動  4) 直覺行動",0Dh,0Ah,\
                    "請輸入 1-4：",0

question3Msg BYTE 0Dh,0Ah,"Q3. 如果把戀愛比喻成天氣，你是？",0Dh,0Ah,\
                    "1) 晴朗無雲  2) 微風和煦",0Dh,0Ah,\
                    "3) 陣雨轉晴  4) 流星夜空",0Dh,0Ah,\
                    "請輸入 1-4：",0

question4Msg BYTE 0Dh,0Ah,"Q4. 你最期待的愛情狀態是？",0Dh,0Ah,\
                    "1) 安定踏實  2) 溫柔互動",0Dh,0Ah,\
                    "3) 心動火花  4) 劇烈浪漫",0Dh,0Ah,\
                    "請輸入 1-4：",0

question5Msg BYTE 0Dh,0Ah,"Q5. 當你想念一個人時，你會？",0Dh,0Ah,\
                    "1) 默默等待  2) 傳訊問候",0Dh,0Ah,\
                    "3) 計畫見面  4) 直接衝去找他",0Dh,0Ah,\
                    "請輸入 1-4：",0

qInput   BYTE 4 DUP(?)      ; 讀每一題的 1~4
qSum     DWORD ?            ; 五題總分

loveLevelHeader BYTE 0Dh,0Ah,"--- 愛情等級小評語 ---",0Dh,0Ah,0
loveLevel_1 BYTE "你現在的愛情等級是：拉完了（加油好嗎）。",0
loveLevel_2 BYTE "你現在的愛情等級是：NPC（偶爾也可以主動一下）。",0
loveLevel_3 BYTE "你現在的愛情等級是：人上人（穩穩發光的類型）。",0
loveLevel_4 BYTE "你現在的愛情等級是：頂級（魅力值已經很高了）。",0
loveLevel_5 BYTE "你現在的愛情等級是：夯（今天超級戀愛 buff）。",0

loveLevelTable DWORD OFFSET loveLevel_1, OFFSET loveLevel_2, \
                     OFFSET loveLevel_3, OFFSET loveLevel_4, \
                     OFFSET loveLevel_5
loveLevelPtr   DWORD ?      ; 存放選好的等級字串位址


fortunesTables DWORD OFFSET fortunesLove, OFFSET fortunesStudy, OFFSET fortunesHealth

nameBuf   BYTE MAX_NAME_LEN   DUP(?)
birthBuf  BYTE MAX_BIRTH_LEN  DUP(?)
zodiacBuf BYTE MAX_ZODIAC_LEN DUP(?)
binBuf    BYTE BITS+1 DUP(?)

; ===== 學業問題 (5 題) =====
studyQ1Msg BYTE 0Dh,0Ah,"Q1. 今天的讀書狀態？",0Dh,0Ah,\
                    "1) 完全讀不下去",0Dh,0Ah,\
                    "2) 勉強硬撐一下",0Dh,0Ah,\
                    "3) 有進度還可以",0Dh,0Ah,\
                    "4) 超專心效率爆棚",0Dh,0Ah,\
                    "請輸入 1-4：",0

studyQ2Msg BYTE 0Dh,0Ah,"Q2. 你的讀書節奏比較像？",0Dh,0Ah,\
                    "1) 考前一天爆肝",0Dh,0Ah,\
                    "2) 靈感來才讀",0Dh,0Ah,\
                    "3) 每天固定一點點",0Dh,0Ah,\
                    "4) 早早規劃超前部署",0Dh,0Ah,\
                    "請輸入 1-4：",0

studyQ3Msg BYTE 0Dh,0Ah,"Q3. 面對考試時，你的心情？",0Dh,0Ah,\
                    "1) 完全放飛自我",0Dh,0Ah,\
                    "2) 有點慌但還撐著",0Dh,0Ah,\
                    "3) 還算有把握",0Dh,0Ah,\
                    "4) 信心滿滿等放榜",0Dh,0Ah,\
                    "請輸入 1-4：",0

studyQ4Msg BYTE 0Dh,0Ah,"Q4. 你和待辦清單的關係？",0Dh,0Ah,\
                    "1) 看了就關掉",0Dh,0Ah,\
                    "2) 做一點點就分心",0Dh,0Ah,\
                    "3) 大部分能完成",0Dh,0Ah,\
                    "4) 幾乎都能照計畫走",0Dh,0Ah,\
                    "請輸入 1-4：",0

studyQ5Msg BYTE 0Dh,0Ah,"Q5. 最近吸收新知的感覺？",0Dh,0Ah,\
                    "1) 進去 0 出來 0",0Dh,0Ah,\
                    "2) 有聽沒有很懂",0Dh,0Ah,\
                    "3) 多看幾次就懂",0Dh,0Ah,\
                    "4) 一看就懂還能教人",0Dh,0Ah,\
                    "請輸入 1-4：",0

studyLevelHeader BYTE 0Dh,0Ah,"--- 學業等級小評語 ---",0Dh,0Ah,0
studyLevel_1 BYTE "你的學業等級是：拉完了（課本先打開一下好嗎）。",0
studyLevel_2 BYTE "你的學業等級是：NPC（有上線，但存在感還能再提升）。",0
studyLevel_3 BYTE "你的學業等級是：人上人（穩定輸出，越來越強）。",0
studyLevel_4 BYTE "你的學業等級是：頂級（讀書節奏很可以）。",0
studyLevel_5 BYTE "你的學業等級是：夯（今天腦袋是黃金狀態）。",0

studyLevelTable DWORD OFFSET studyLevel_1, OFFSET studyLevel_2, \
                       OFFSET studyLevel_3, OFFSET studyLevel_4, \
                       OFFSET studyLevel_5
studyLevelPtr   DWORD ?      ; 存放選好的學業等級字串位址

; ===== 健康＋財運問題 (5 題) =====
healthQ1Msg BYTE 0Dh,0Ah,"Q1. 最近身體的感覺？",0Dh,0Ah,\
                     "1) 超累只想躺",0Dh,0Ah,\
                     "2) 容易疲倦",0Dh,0Ah,\
                     "3) 還算有精神",0Dh,0Ah,\
                     "4) 精力充沛想到處跑",0Dh,0Ah,\
                     "請輸入 1-4：",0

healthQ2Msg BYTE 0Dh,0Ah,"Q2. 你的作息比較像？",0Dh,0Ah,\
                     "1) 爆炸熬夜型",0Dh,0Ah,\
                     "2) 常常晚睡追東西",0Dh,0Ah,\
                     "3) 偶爾晚睡但會補眠",0Dh,0Ah,\
                     "4) 規律早睡早起",0Dh,0Ah,\
                     "請輸入 1-4：",0

healthQ3Msg BYTE 0Dh,0Ah,"Q3. 你對自己錢包的感覺？",0Dh,0Ah,\
                     "1) 已經乾掉了",0Dh,0Ah,\
                     "2) 快要見底有點怕",0Dh,0Ah,\
                     "3) 還算 OK 可以撐",0Dh,0Ah,\
                     "4) 滿滿的很安心",0Dh,0Ah,\
                     "請輸入 1-4：",0

healthQ4Msg BYTE 0Dh,0Ah,"Q4. 面對花錢你的反應？",0Dh,0Ah,\
                     "1) 先刷再說之後再煩惱",0Dh,0Ah,\
                     "2) 有點衝動但會猶豫一下",0Dh,0Ah,\
                     "3) 會想一下再決定",0Dh,0Ah,\
                     "4) 一定先算清楚再花",0Dh,0Ah,\
                     "請輸入 1-4：",0

healthQ5Msg BYTE 0Dh,0Ah,"Q5. 你最近照顧自己的程度？",0Dh,0Ah,\
                     "1) 幾乎放生自己",0Dh,0Ah,\
                     "2) 偶爾才想到要休息",0Dh,0Ah,\
                     "3) 有刻意調整飲食/休息",0Dh,0Ah,\
                     "4) 穩定運動又好好睡覺",0Dh,0Ah,\
                     "請輸入 1-4：",0

healthLevelHeader BYTE 0Dh,0Ah,"--- 健康與財運等級小評語 ---",0Dh,0Ah,0
healthLevel_1 BYTE "你的健康財運等級是：拉完了（拜託先睡飽跟存一點錢）。",0
healthLevel_2 BYTE "你的健康財運等級是：NPC（還在場上，但要多照顧自己）。",0
healthLevel_3 BYTE "你的健康財運等級是：人上人（身心逐漸穩定起來）。",0
healthLevel_4 BYTE "你的健康財運等級是：頂級（狀態良好，運勢跟著走高）。",0
healthLevel_5 BYTE "你的健康財運等級是：夯（整體氣場超好，適合展開行動）。",0

healthLevelTable DWORD OFFSET healthLevel_1, OFFSET healthLevel_2, \
                        OFFSET healthLevel_3, OFFSET healthLevel_4, \
                        OFFSET healthLevel_5
healthLevelPtr   DWORD ?      ; 存放選好的健康財運等級字串位址


hashVal   DWORD ?
indexVal  DWORD ?

; ================================
; 動畫用字串
; ================================
introStars BYTE \
"            *        *        *",0Dh,0Ah,\
"      *         今日運勢占卜        *",0Dh,0Ah,\
"  *        *        *       *   ",0Dh,0Ah,0

loadingMsg BYTE 0Dh,0Ah,"抽籤中，請稍候...",0

fireFrame1 BYTE \
"           .            ",0Dh,0Ah,\
0Dh,0Ah,\
0Dh,0Ah,0

fireFrame2 BYTE \
"           *            ",0Dh,0Ah,\
"          * *           ",0Dh,0Ah,\
0Dh,0Ah,0

fireFrame3 BYTE \
"        .  *  .         ",0Dh,0Ah,\
"       *  ***  *        ",0Dh,0Ah,\
"        .  *  .         ",0Dh,0Ah,0

heartFrame BYTE \
"      **     **         ",0Dh,0Ah,\
"     ****   ****        ",0Dh,0Ah,\
"     ****** *****       ",0Dh,0Ah,\
"      *********         ",0Dh,0Ah,\
"        *****           ",0Dh,0Ah,\
"          *             ",0Dh,0Ah,0

.code

SelectZodiac PROC USES eax ebx ecx edx esi
    mov zodiacSel, 0
    
    ; 印出選單標題
    mov edx, OFFSET zodiacMenu
    call WriteString
    
    ; 印出 12 個星座
    call DrawZodiacList

select_loop:
    call ReadKey
    
    cmp ah, 72        ; 上鍵
    je go_up
    cmp ah, 80        ; 下鍵
    je go_down
    cmp al, 13        ; Enter
    je select_done
    jmp select_loop

go_up:
    cmp zodiacSel, 0
    je select_loop
    dec zodiacSel
    call DrawZodiacList
    jmp select_loop

go_down:
    cmp zodiacSel, 11
    je select_loop
    inc zodiacSel
    call DrawZodiacList
    jmp select_loop

select_done:
    ; 把選擇的星座複製到 zodiacBuf
    mov eax, zodiacSel
    shl eax, 2
    mov esi, OFFSET zodiacList
    add esi, eax
    mov esi, [esi]       ; esi = 選中星座字串
    
    mov edi, OFFSET zodiacBuf
copy_zodiac:
    mov al, [esi]
    mov [edi], al
    cmp al, 0
    je copy_done
    inc esi
    inc edi
    jmp copy_zodiac
copy_done:
    ret
SelectZodiac ENDP

DrawZodiacList PROC USES eax ebx ecx edx esi
    ; 游標上移 12 行
    mov edx, OFFSET cursorUp12
    call WriteString
    
    mov ecx, 0      ; 計數器 0-11
    
draw_loop:
    cmp ecx, 12
    jge draw_done
    
    ; 清除該行
    mov edx, OFFSET clearLine
    call WriteString
    
    ; 印箭頭或空白
    cmp ecx, zodiacSel
    jne no_arrow
    mov edx, OFFSET arrowMark
    call WriteString
    jmp print_name
no_arrow:
    mov edx, OFFSET spaceMark
    call WriteString

print_name:
    ; 印星座名稱
    mov eax, ecx
    shl eax, 2
    mov esi, OFFSET zodiacList
    add esi, eax
    mov edx, [esi]
    call WriteString
    call CrLf
    
    inc ecx
    jmp draw_loop

draw_done:
    ret
DrawZodiacList ENDP

WaitRightKey PROC USES eax
wait_loop:
    call ReadKey
    cmp ah, 77        ; 右鍵的 scan code
    jne wait_loop
    ret
WaitRightKey ENDP

SetWhiteBackground PROC
    mov edx, OFFSET setWhiteBg
    call WriteString
    mov edx, OFFSET clearAll
    call WriteString
    ret
SetWhiteBackground ENDP

ResetColors PROC
    mov edx, OFFSET resetColor
    call WriteString
    ret
ResetColors ENDP


; ==================================================
; 顯示愛心
; ==================================================
show_love_heart PROC
    mov edx, OFFSET setLoveBg
    call WriteString
    call ClearWithBg
    
    mov edx, OFFSET love_heart1
    call WriteString
    mov edx, OFFSET love_heart2
    call WriteString
    mov edx, OFFSET love_heart3
    call WriteString
    mov edx, OFFSET love_heart4
    call WriteString
    mov edx, OFFSET love_heart5
    call WriteString
    mov edx, OFFSET love_heart6
    call WriteString
    mov edx, OFFSET love_heart7
    call WriteString
    mov edx, OFFSET love_heart8
    call WriteString
    mov edx, OFFSET love_heart9
    call WriteString
    mov edx, OFFSET love_heart10
    call WriteString
    mov edx, OFFSET love_heart11
    call WriteString
    mov edx, OFFSET love_heart12
    call WriteString
    
    ret
show_love_heart ENDP

; ==================================================
; 打字機效果
; ==================================================
Typewriter PROC USES eax ebx edx esi
    mov esi, edx
    mov ebx, ecx

NextChar:
    mov al, [esi]
    cmp al, 0
    je  Done

    call WriteChar

    mov eax, ebx
    call Delay

    inc esi
    jmp NextChar

Done:
    ret
Typewriter ENDP

; ==================================================
; 旋轉棒 Loading 動畫
; ==================================================
Spinner PROC USES eax ecx
    mov ecx, 10

spin_loop:
    mov al, '|'
    call WriteChar
    mov eax, 60
    call Delay
    mov al, 8
    call WriteChar

    mov al, '/'
    call WriteChar
    mov eax, 60
    call Delay
    mov al, 8
    call WriteChar

    mov al, '-'
    call WriteChar
    mov eax, 60
    call Delay
    mov al, 8
    call WriteChar

    mov al, '\'
    call WriteChar
    mov eax, 60
    call Delay
    mov al, 8
    call WriteChar

    loop spin_loop
    ret
Spinner ENDP

; ==================================================
; 進度條動畫
; ==================================================
ProgressBar PROC USES eax ebx ecx edx esi
    ; 印出標題
    mov edx, OFFSET progressInit
    call WriteString
    
    ; 印出 20 個空白 + "  0%"
    mov ecx, 20
init_space:
    cmp ecx, 0
    je init_space_done
    mov al, ' '
    call WriteChar
    dec ecx
    jmp init_space
init_space_done:
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, '0'
    call WriteChar
    mov al, '%'
    call WriteChar
    
    mov esi, 1

bar_loop:
    cmp esi, 20
    jg bar_done
    
    ; 往左移 24 格（回到進度條最左邊）
    mov ecx, 24
go_back:
    cmp ecx, 0
    je go_back_done
    mov al, 8
    call WriteChar
    dec ecx
    jmp go_back
go_back_done:
    
    ; 印方塊
    mov ecx, esi
fill_loop:
    cmp ecx, 0
    je fill_done
    mov edx, OFFSET barBlock
    call WriteString
    dec ecx
    jmp fill_loop
fill_done:

    ; 印空白補滿到 20 格
    mov ecx, 20
    sub ecx, esi
space_loop:
    cmp ecx, 0
    je space_done
    mov al, ' '
    call WriteChar
    dec ecx
    jmp space_loop
space_done:

    ; 印固定寬度百分比 (4 字元: 空白+數字+%)
    mov eax, esi
    mov ebx, 5
    mul ebx              ; eax = 百分比
    
    cmp eax, 100
    jge print_pct
    cmp eax, 10
    jge one_space
    ; 一位數，印兩個空白
    push eax
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    pop eax
    jmp print_pct
one_space:
    ; 兩位數，印一個空白
    push eax
    mov al, ' '
    call WriteChar
    pop eax
print_pct:
    call WriteDec
    mov al, '%'
    call WriteChar
    
    ; 判斷是否到 100%
    cmp esi, 20
    jne normal_delay
    ; 100% 停 2 秒
    mov eax, 2000
    call Delay
    jmp bar_done
normal_delay:
    mov eax, 100
    call Delay
    
    inc esi
    jmp bar_loop

bar_done:
    call CrLf
    ret
ProgressBar ENDP

; ==================================================
; 煙火 + 愛心動畫
; ==================================================
FireworkAndHeart PROC USES eax edx
    call ClearWithBg
    mov edx, OFFSET fireFrame1
    call WriteString
    mov eax, 200
    call Delay

    call ClearWithBg
    mov edx, OFFSET fireFrame2
    call WriteString
    mov eax, 200
    call Delay

    call ClearWithBg
    mov edx, OFFSET fireFrame3
    call WriteString
    mov eax, 300
    call Delay

    call ClearWithBg
    mov edx, OFFSET heartFrame
    call WriteString
    mov eax, 500
    call Delay

    ret
FireworkAndHeart ENDP

; ==================================================
; 開場星星 + 標題打字
; ==================================================
IntroScreen PROC USES eax edx ecx
    call ClearWithBg

    mov edx, OFFSET introStars
    mov ecx, 10
    call Typewriter

    call CrLf
    call CrLf

    mov edx, OFFSET welcomeTitle
    mov ecx, 10
    call Typewriter

    ret
IntroScreen ENDP

SetLoveBackground PROC
    mov edx, OFFSET setLoveBg
    call WriteString
    mov edx, OFFSET clearAll
    call WriteString
    ret
SetLoveBackground ENDP

ClearWithBg PROC
    cmp currentBg, 1
    je use_love_bg
    cmp currentBg, 2
    je use_study_bg
    cmp currentBg, 3
    je use_health_bg
    ; 預設白色背景
    mov edx, OFFSET setWhiteBg
    jmp do_clear
use_love_bg:
    mov edx, OFFSET setLoveBg
    jmp do_clear
use_study_bg:
    mov edx, OFFSET setStudyBg
    jmp do_clear
use_health_bg:
    mov edx, OFFSET setHealthBg
do_clear:
    call WriteString
    mov edx, OFFSET clearAll
    call WriteString
    ret
ClearWithBg ENDP

; ==================================================
; 主程式
; ==================================================
start@0 PROC
    call SetWhiteBackground
    ;---------------------------------------
    ; 2. 開場動畫 + 選單
    ;---------------------------------------
    call IntroScreen

    mov edx, OFFSET menuPrompt
    mov ecx, 5
    call Typewriter

    ; 讀入使用者選擇
    mov edx, OFFSET choiceInput
    mov ecx, 4
    call ReadString

    mov dl, BYTE PTR choiceInput
    sub dl, '0'
    movzx eax, dl
    mov choiceVal, eax

    cmp eax, 1
    jl  invalid_choice
    cmp eax, 3
    jg  invalid_choice
    jmp valid_choice

invalid_choice:
    mov edx, OFFSET errorMsg
    call WriteString
    mov choiceVal, 1

valid_choice:
  mov eax, choiceVal
    mov currentBg, eax    ; 直接用 1/2/3 當旗標

    call ClearWithBg      ; 立即切換背景

; 如果選擇愛情運勢，切換粉色背景
    cmp choiceVal, 1
    jne skip_love_bg
    mov edx, OFFSET setLoveBg
    call WriteString
    mov edx, OFFSET clearAll
    call WriteString
skip_love_bg:
    ;---------------------------------------
    ; 3. 輸入個人資料
    ;---------------------------------------
    call ClearWithBg

    mov edx, OFFSET promptTitle
    call WriteString

    mov edx, OFFSET promptEnterName
    call WriteString
    mov edx, OFFSET nameBuf
    mov ecx, MAX_NAME_LEN
    call ReadString

    mov edx, OFFSET promptEnterBirth
    call WriteString
    mov edx, OFFSET birthBuf
    mov ecx, MAX_BIRTH_LEN
    call ReadString

    ; 先印 12 行空白給選單用
    mov ecx, 12
    print_blank:
    call CrLf
    loop print_blank
    
    call SelectZodiac

    ;---------------------------------------
    ; 4. Hash 計算
    ;---------------------------------------
    xor eax, eax
    mov ebx, 131

    mov esi, OFFSET nameBuf
hash_name_loop:
    mov dl, [esi]
    cmp dl, 0
    je  hash_birth_start
    imul eax, ebx
    movzx edx, dl
    add eax, edx
    inc esi
    jmp hash_name_loop

hash_birth_start:
    mov esi, OFFSET birthBuf
hash_birth_loop:
    mov dl, [esi]
    cmp dl, 0
    je  hash_zod_start
    imul eax, ebx
    movzx edx, dl
    add eax, edx
    inc esi
    jmp hash_birth_loop

hash_zod_start:
    mov esi, OFFSET zodiacBuf
hash_zod_loop:
    mov dl, [esi]
    cmp dl, 0
    je  hash_done
    imul eax, ebx
    movzx edx, dl
    add eax, edx
    inc esi
    jmp hash_zod_loop

hash_done:
    mov hashVal, eax

    ;---------------------------------------
    ; 5. 二進位轉換
    ;---------------------------------------
    call ClearWithBg

    mov eax, hashVal
    mov edi, OFFSET binBuf
    mov ecx, BITS

    mov ebx, 1
    mov edx, BITS
    dec edx
mask_build_loop:
    cmp edx, 0
    jle mask_ready
    shl ebx, 1
    dec edx
    jmp mask_build_loop
mask_ready:

    xor esi, esi
    mov edx, BITS

bit_loop:
    cmp edx, 0
    jle bits_done

    test eax, ebx
    jz  bit_zero
    mov BYTE PTR [edi+esi], '1'
    jmp bit_next

bit_zero:
    mov BYTE PTR [edi+esi], '0'

bit_next:
    shr ebx, 1
    inc esi
    dec edx
    jmp bit_loop

bits_done:
    mov BYTE PTR [edi+esi], 0

    ;---------------------------------------
    ; 7. 抽籤動畫
    ;---------------------------------------
    mov edx, OFFSET loadingMsg
    call WriteString
    call Spinner
    call ProgressBar

    ;---------------------------------------
    ; 8. 計算籤詩索引
    ;---------------------------------------
    mov eax, hashVal
    mov ebx, NUM_FORTUNES_PER_CAT
    xor edx, edx
    div ebx
    mov indexVal, edx

;---------------------------------------
; 9. 選擇運勢陣列
;---------------------------------------
mov eax, choiceVal
dec eax
shl eax, 2
mov edx, OFFSET fortunesTables
add edx, eax
mov edx, [edx]

mov eax, indexVal
shl eax, 2
add edx, eax
mov edx, [edx]

;---------------------------------------
; 10. 根據選擇 (1 愛情 / 2 學業 / 3 健康財運)
;     問五題 & 計算對應等級
;---------------------------------------
mov ebx, edx      ; 保存籤詩位址（之後要印籤詩）

mov eax, choiceVal
cmp eax, 1
je do_love_questions
cmp eax, 2
je do_study_questions
cmp eax, 3
je do_health_questions
jmp after_questions      ; 理論上不會到這裡

; ===== 愛情：五題 + 愛情等級 + 愛心動畫 =====
do_love_questions:
    xor eax, eax
    mov qSum, eax

    ; ---- 愛情 Q1 ----
    mov edx, OFFSET question1Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ---- 愛情 Q2 ----
    mov edx, OFFSET question2Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ---- 愛情 Q3 ----
    mov edx, OFFSET question3Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ---- 愛情 Q4 ----
    mov edx, OFFSET question4Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ---- 愛情 Q5 ----
    mov edx, OFFSET question5Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ==== 用 qSum 算愛情等級 index (0~4) ====
    ; 總分範圍：5~20
    mov eax, qSum

    cmp eax, 8
    jl  love_level_0        ; < 8  → 拉完了
    cmp eax, 12
    jl  love_level_1        ; < 12 → NPC
    cmp eax, 16
    jl  love_level_2        ; < 16 → 人上人
    cmp eax, 19
    jl  love_level_3        ; < 19 → 頂級
    jmp love_level_4        ; >=19 → 夯

love_level_0:
    mov eax, 0
    jmp love_level_done
love_level_1:
    mov eax, 1
    jmp love_level_done
love_level_2:
    mov eax, 2
    jmp love_level_done
love_level_3:
    mov eax, 3
    jmp love_level_done
love_level_4:
    mov eax, 4

love_level_done:
    ; eax = 等級 index (0~4)
    mov ecx, eax
    shl ecx, 2                    ; *4
    mov edx, OFFSET loveLevelTable
    add edx, ecx
    mov edx, [edx]                ; edx = loveLevel_x 的位址
    mov loveLevelPtr, edx

    ; 愛情專屬動畫
    call show_love_heart
    mov eax, 2000
    call Delay

    jmp after_questions

; ===== 學業：五題 + 學業等級 =====
do_study_questions:
    xor eax, eax
    mov qSum, eax

    ; ---- 學業 Q1 ----
    mov edx, OFFSET studyQ1Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ---- 學業 Q2 ----
    mov edx, OFFSET studyQ2Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ---- 學業 Q3 ----
    mov edx, OFFSET studyQ3Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ---- 學業 Q4 ----
    mov edx, OFFSET studyQ4Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ---- 學業 Q5 ----
    mov edx, OFFSET studyQ5Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ==== 用 qSum 算學業等級 index (0~4) ====
    mov eax, qSum

    cmp eax, 8
    jl  study_level_0
    cmp eax, 12
    jl  study_level_1
    cmp eax, 16
    jl  study_level_2
    cmp eax, 19
    jl  study_level_3
    jmp study_level_4

study_level_0:
    mov eax, 0
    jmp study_level_done
study_level_1:
    mov eax, 1
    jmp study_level_done
study_level_2:
    mov eax, 2
    jmp study_level_done
study_level_3:
    mov eax, 3
    jmp study_level_done
study_level_4:
    mov eax, 4

study_level_done:
    mov ecx, eax
    shl ecx, 2
    mov edx, OFFSET studyLevelTable
    add edx, ecx
    mov edx, [edx]
    mov studyLevelPtr, edx

    jmp after_questions

; ===== 健康＋財運：五題 + 健康財運等級 =====
do_health_questions:
    xor eax, eax
    mov qSum, eax

    ; ---- 健康財運 Q1 ----
    mov edx, OFFSET healthQ1Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ---- 健康財運 Q2 ----
    mov edx, OFFSET healthQ2Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ---- 健康財運 Q3 ----
    mov edx, OFFSET healthQ3Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ---- 健康財運 Q4 ----
    mov edx, OFFSET healthQ4Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ---- 健康財運 Q5 ----
    mov edx, OFFSET healthQ5Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; ==== 用 qSum 算健康財運等級 index (0~4) ====
    mov eax, qSum

    cmp eax, 8
    jl  health_level_0
    cmp eax, 12
    jl  health_level_1
    cmp eax, 16
    jl  health_level_2
    cmp eax, 19
    jl  health_level_3
    jmp health_level_4

health_level_0:
    mov eax, 0
    jmp health_level_done
health_level_1:
    mov eax, 1
    jmp health_level_done
health_level_2:
    mov eax, 2
    jmp health_level_done
health_level_3:
    mov eax, 3
    jmp health_level_done
health_level_4:
    mov eax, 4

health_level_done:
    mov ecx, eax
    shl ecx, 2
    mov edx, OFFSET healthLevelTable
    add edx, ecx
    mov edx, [edx]
    mov healthLevelPtr, edx

    jmp after_questions

after_questions:


; ===== 根據選項顯示對應等級 =====
mov eax, choiceVal
cmp eax, 1
je print_love_level
cmp eax, 2
je print_study_level
cmp eax, 3
je print_health_level
jmp no_any_level

print_love_level:
    mov edx, OFFSET loveLevelHeader
    call WriteString
    mov edx, loveLevelPtr
    call WriteString
    call CrLf
    call CrLf
    jmp no_any_level

print_study_level:
    mov edx, OFFSET studyLevelHeader
    call WriteString
    mov edx, studyLevelPtr
    call WriteString
    call CrLf
    call CrLf
    jmp no_any_level

print_health_level:
    mov edx, OFFSET healthLevelHeader
    call WriteString
    mov edx, healthLevelPtr
    call WriteString
    call CrLf
    call CrLf

no_any_level:


call WaitMsg
exit


start@0 ENDP

END start@0