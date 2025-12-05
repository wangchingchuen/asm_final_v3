INCLUDE Irvine32.inc

MAX_NAME_LEN   EQU 64
MAX_BIRTH_LEN  EQU 32
MAX_ZODIAC_LEN EQU 32
BITS           EQU 16
NUM_FORTUNES_PER_CAT EQU 24

.data
ESC_CODE EQU 27
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

fortunesTables DWORD OFFSET fortunesLove, OFFSET fortunesStudy, OFFSET fortunesHealth

nameBuf   BYTE MAX_NAME_LEN   DUP(?)
birthBuf  BYTE MAX_BIRTH_LEN  DUP(?)
zodiacBuf BYTE MAX_ZODIAC_LEN DUP(?)
binBuf    BYTE BITS+1 DUP(?)

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

    mov edx, OFFSET promptEnterZod
    call WriteString
    mov edx, OFFSET zodiacBuf
    mov ecx, MAX_ZODIAC_LEN
    call ReadString

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
    ; 6. 顯示 Hash 結果
    ;---------------------------------------
    mov edx, OFFSET resultHeader
    call WriteString

    mov edx, OFFSET hashIntMsg
    call WriteString
    mov eax, hashVal
    call WriteDec
    call CrLf

    mov edx, OFFSET hashBinMsg
    call WriteString
    mov edx, OFFSET binBuf
    call WriteString
    call CrLf

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
    ; 10. 如果是愛情運勢,顯示愛心
    ;---------------------------------------
    mov ebx, edx  ; 保存籤詩位址

    mov eax, choiceVal
    cmp eax, 1
    jne skip_heart
    
    call show_love_heart
    
    mov eax, 2000
    call Delay

skip_heart:

    ;---------------------------------------
    ; 11. 顯示籤詩
    ;---------------------------------------
    call ClearWithBg

    mov edx, OFFSET fortuneHeader
    call WriteString

    mov edx, ebx
    mov ecx, 30
    call Typewriter
    call CrLf
    
    mov edx, OFFSET pressRightMsg
    call WriteString
    call WaitRightKey
    
    call CrLf

    call FireworkAndHeart
    call WaitMsg
    exit
start@0 ENDP

END start@0