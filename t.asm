INCLUDE Irvine32.inc

MAX_NAME_LEN   EQU 64
MAX_BIRTH_LEN  EQU 32
MAX_ZODIAC_LEN EQU 32
BITS           EQU 16
NUM_FORTUNES_PER_CAT EQU 24

.data
; ================================
; 標題和選單 (移到最前面)
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


; ===== 大吉 (Love) =====
love_great_1 BYTE "愛情大吉：你的魅力爆棚，任何告白都有成功機率！",0
love_great_2 BYTE "愛情大吉：心中所想之人，也正默默注意著你。",0
love_great_3 BYTE "愛情大吉：命運正在推你們靠近，把握每次相遇。",0

; ===== 中吉 (Love) =====
love_good_1  BYTE "愛情中吉：彼此心意清晰，多交流會更甜蜜。",0
love_good_2  BYTE "愛情中吉：互動順利，適合安排一個小約會。",0
love_good_3  BYTE "愛情中吉：你們的距離正在縮短，耐心陪伴即可。",0

; ===== 小吉 (Love) =====
love_small_1 BYTE "愛情小吉：對方對你抱持好感，給點時間發酵。",0
love_small_2 BYTE "愛情小吉：適合傳訊息問候，能巧妙拉近距離。",0
love_small_3 BYTE "愛情小吉：一些小互動會帶來好進展。",0

; ===== 吉 (Love) =====
love_luck_1  BYTE "愛情吉：今天情緒穩定，氣氛容易營造。",0
love_luck_2  BYTE "愛情吉：主動一點會有意外收穫。",0
love_luck_3  BYTE "愛情吉：你散發的自然感，讓人很舒服。",0

; ===== 末吉 (Love) =====
love_minor_1 BYTE "愛情末吉：互相試探較多，需要耐心。",0
love_minor_2 BYTE "愛情末吉：容易誤會，說話前多想一下。",0
love_minor_3 BYTE "愛情末吉：適合觀察，不急著行動。",0

; ===== 凶 (Love) =====
love_bad_1   BYTE "愛情凶：溝通可能卡住，保持冷靜。",0
love_bad_2   BYTE "愛情凶：不要因為一時情緒做決定。",0
love_bad_3   BYTE "愛情凶：暫時避開敏感話題。",0

; ===== 小凶 (Love) =====
love_sbad_1  BYTE "愛情小凶：期待落空，但不影響長期。",0
love_sbad_2  BYTE "愛情小凶：對方忙碌，回應較慢。",0
love_sbad_3  BYTE "愛情小凶：不要過度猜測對方心情。",0

; ===== 大凶 (Love) =====
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

; ===== 大吉 (Study) =====
study_great_1 BYTE "學業大吉：讀書效率爆發，理解力滿點。",0
study_great_2 BYTE "學業大吉：難題突然迎刃而解，信心倍增。",0
study_great_3 BYTE "學業大吉：今天超適合寫作業或準備考試！",0

; ===== 中吉 (Study) =====
study_good_1  BYTE "學業中吉：進度穩定，適合排新的讀書計畫。",0
study_good_2  BYTE "學業中吉：小小努力就有明顯成效。",0
study_good_3  BYTE "學業中吉：與同學討論會有好結果。",0

; ===== 小吉 (Study) =====
study_small_1 BYTE "學業小吉：適合複習，能補上弱點。",0
study_small_2 BYTE "學業小吉：今天讀起來比平常順。",0
study_small_3 BYTE "學業小吉：小突破讓你更有動力。",0

; ===== 吉 (Study) =====
study_luck_1  BYTE "學業吉：理解速度還不錯，保持節奏。",0
study_luck_2  BYTE "學業吉：適合念你想念的科目。",0
study_luck_3  BYTE "學業吉：讀書環境越安靜效果越好。",0

; ===== 末吉 (Study) =====
study_minor_1 BYTE "學業末吉：進度稍慢，不要焦急。",0
study_minor_2 BYTE "學業末吉：可能分心，需要整理心情。",0
study_minor_3 BYTE "學業末吉：適合做簡單的內容，避免困難題。",0

; ===== 凶 (Study) =====
study_bad_1   BYTE "學業凶：容易卡住，不妨換一科讀。",0
study_bad_2   BYTE "學業凶：注意專注力，避免分心。",0
study_bad_3   BYTE "學業凶：適合休息一下再繼續。",0

; ===== 小凶 (Study) =====
study_sbad_1  BYTE "學業小凶：計畫趕不上變化，調整一下即可。",0
study_sbad_2  BYTE "學業小凶：今天念書可能不太順。",0
study_sbad_3  BYTE "學業小凶：不要硬讀，容易疲倦。",0

; ===== 大凶 (Study) =====
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

; ===== 大吉 (Health & Wealth) =====
health_great_1 BYTE "健康財運大吉：精神飽滿，財運走上坡！",0
health_great_2 BYTE "健康大吉：身體狀態極佳，活力滿點。",0
health_great_3 BYTE "財運大吉：可能有小驚喜或意外收入。",0

; ===== 中吉 =====
health_good_1  BYTE "中吉：狀態平穩，適合規劃新目標。",0
health_good_2  BYTE "中吉：心情愉快，能量充足。",0
health_good_3  BYTE "中吉：理財靈感提升，適合做計畫。",0

; ===== 小吉 =====
health_small_1 BYTE "小吉：稍作運動能讓你更有精神。",0
health_small_2 BYTE "小吉：財運略有提升，小花費也值得。",0
health_small_3 BYTE "小吉：保持規律生活會讓運勢更好。",0

; ===== 吉 =====
health_luck_1  BYTE "吉：身心均衡，適合外出走走。",0
health_luck_2  BYTE "吉：工作效率普通但穩定。",0
health_luck_3  BYTE "吉：消費要節制，不衝動購物。",0

; ===== 末吉 =====
health_minor_1 BYTE "末吉：稍微疲倦，注意休息。",0
health_minor_2 BYTE "末吉：避免大額花費。",0
health_minor_3 BYTE "末吉：精神狀態需要調整。",0

; ===== 凶 =====
health_bad_1   BYTE "凶：可能感到壓力，放慢步調。",0
health_bad_2   BYTE "凶：小病痛容易出現，多喝水。",0
health_bad_3   BYTE "凶：注意荷包，避免破財。",0

; ===== 小凶 =====
health_sbad_1  BYTE "小凶：疲累累積，需要補眠。",0
health_sbad_2  BYTE "小凶：財運下降，避免投資。",0
health_sbad_3  BYTE "小凶：不適合外出太久。",0

; ===== 大凶 =====
health_worst_1 BYTE "大凶：精神不濟，今日運勢較弱。",0
health_worst_2 BYTE "大凶：財運不佳，建議不要做決策。",0
health_worst_3 BYTE "大凶：身體需要休息，別硬撐。",0


choiceInput BYTE 4 DUP(?)
choiceVal  DWORD ?

; 跳轉表
fortunesTables DWORD OFFSET fortunesLove, OFFSET fortunesStudy, OFFSET fortunesHealth

; 緩衝區與變數
nameBuf   BYTE MAX_NAME_LEN   DUP(?)
birthBuf  BYTE MAX_BIRTH_LEN  DUP(?)
zodiacBuf BYTE MAX_ZODIAC_LEN DUP(?)
binBuf    BYTE BITS+1 DUP(?)

hashVal   DWORD ?
indexVal  DWORD ?; ================================
; 動畫用字串
; ================================
introStars BYTE \
"            *        *        *",0Dh,0Ah,\
"      *         今日運勢占卜        *",0Dh,0Ah,\
"  *        *        *       *   ",0Dh,0Ah,0

loadingMsg BYTE 0Dh,0Ah,"抽籤中，請稍候...",0

progressMsg BYTE 0Dh,0Ah,"抽籤進度：",0

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

; ==================================================
; 動畫工具：打字機效果
;  呼叫前：
;    EDX = 字串位址
;    ECX = 每個字延遲毫秒 (例如 20~60)
; ==================================================
Typewriter PROC USES eax ebx edx esi
    mov esi, edx       ; esi 指向字串
    mov ebx, ecx       ; delay 存到 ebx

NextChar:
    mov al, [esi]
    cmp al, 0
    je  Done

    call WriteChar     ; WriteChar 用 AL

    mov eax, ebx
    call Delay

    inc esi
    jmp NextChar

Done:
    ret
Typewriter ENDP

; ==================================================
; 旋轉棒 Loading 動畫
;  顯示類似：| / - \ 轉圈
; ==================================================
Spinner PROC USES eax ecx
    mov ecx, 10        ; 轉 10 圈，可自行調整

spin_loop:
    ; |
    mov al, '|'
    call WriteChar
    mov eax, 60
    call Delay
    mov al, 8          ; Backspace
    call WriteChar

    ; /
    mov al, '/'
    call WriteChar
    mov eax, 60
    call Delay
    mov al, 8
    call WriteChar

    ; -
    mov al, '-'
    call WriteChar
    mov eax, 60
    call Delay
    mov al, 8
    call WriteChar

    ; \
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
; 簡單進度條動畫：[##########] 100%
; 每一格都畫在「新的一行」，不做光標回朔，超安全版本
; ==================================================
ProgressBar PROC USES eax ebx ecx edx esi

    mov esi, 0              ; esi = 已填格數 (0..10)

bar_loop:
    cmp esi, 11
    jge bar_done            ; 跑到 0~10 共 11 步，最後是 100%

    ; 顯示「抽籤進度：」
    mov edx, OFFSET progressMsg
    call WriteString

    ; 印 [
    mov al, '['
    call WriteChar

    ; 已填滿部分（'#'）
    mov ecx, esi
filled_loop:
    cmp ecx, 0
    je filled_done
    mov al, '#'
    call WriteChar
    dec ecx
    jmp filled_loop
filled_done:

    ; 未填滿部分（空白）
    mov ecx, 10
    sub ecx, esi
empty_loop:
    cmp ecx, 0
    je empty_done
    mov al, ' '
    call WriteChar
    dec ecx
    jmp empty_loop
empty_done:

    ; 印 ]
    mov al, ']'
    call WriteChar

    ; 空格
    mov al, ' '
    call WriteChar

    ; 百分比 = esi * 10
    mov eax, esi
    mov ebx, 10
    mul ebx          ; EDX:EAX = EAX * 10，這裡數字小，EDX 會是 0
    call WriteDec

    mov al, '%'
    call WriteChar

    call CrLf        ; 換下一行顯示下一個進度

    ; 延遲一下
    mov eax, 150
    call Delay

    inc esi
    jmp bar_loop

bar_done:
    ret
ProgressBar ENDP

; ==================================================
; 抽完籤後的小煙火 + 愛心動畫
; ==================================================
FireworkAndHeart PROC USES eax edx
    ; 煙火 frame 1
    call Clrscr
    mov edx, OFFSET fireFrame1
    call WriteString
    mov eax, 200
    call Delay

    ; frame 2
    call Clrscr
    mov edx, OFFSET fireFrame2
    call WriteString
    mov eax, 200
    call Delay

    ; frame 3
    call Clrscr
    mov edx, OFFSET fireFrame3
    call WriteString
    mov eax, 300
    call Delay

    ; 愛心
    call Clrscr
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
    call Clrscr

    ; 星星背景
    mov edx, OFFSET introStars
    mov ecx, 10          ; 打字速度較快
    call Typewriter

    call CrLf
    call CrLf

    ; 原本的邊框標題也用打字機印出
    mov edx, OFFSET welcomeTitle
    mov ecx, 10
    call Typewriter

    ret
IntroScreen ENDP

.code
start@0 PROC
    ;---------------------------------------
    ; 1. 開場動畫 + 選單
    ;---------------------------------------
    call IntroScreen      ; 會清屏＋印星星＋標題

    ; 顯示選單，用打字機印
    mov edx, OFFSET menuPrompt
    mov ecx, 5           ; 比較快一點
    call Typewriter

    ; 讀入使用者選擇 (1/2/3)
    mov edx, OFFSET choiceInput
    mov ecx, 4
    call ReadString

    ; choiceVal = choiceInput[0] - '0'
    mov dl, BYTE PTR choiceInput
    sub dl, '0'
    movzx eax, dl
    mov choiceVal, eax

    ; 驗證輸入範圍 (1~3)
    cmp eax, 1
    jl  invalid_choice
    cmp eax, 3
    jg  invalid_choice
    jmp valid_choice

invalid_choice:
    mov edx, OFFSET errorMsg
    call WriteString
    mov choiceVal, 1        ; 預設為愛情運勢

valid_choice:
    ;---------------------------------------
    ; 2. 顯示個人資料輸入提示
    ;---------------------------------------
    call Clrscr

    mov edx, OFFSET promptTitle
    call WriteString

    ; 輸入名字
    mov edx, OFFSET promptEnterName
    call WriteString
    mov edx, OFFSET nameBuf
    mov ecx, MAX_NAME_LEN
    call ReadString

    ; 輸入生日
    mov edx, OFFSET promptEnterBirth
    call WriteString
    mov edx, OFFSET birthBuf
    mov ecx, MAX_BIRTH_LEN
    call ReadString

    ; 輸入星座
    mov edx, OFFSET promptEnterZod
    call WriteString
    mov edx, OFFSET zodiacBuf
    mov ecx, MAX_ZODIAC_LEN
    call ReadString

    ;---------------------------------------
    ; 3. Hash 計算 (沿用你的原本邏輯)
    ;---------------------------------------
    xor eax, eax
    mov ebx, 131

    ; hash nameBuf
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
    ; 4. 二進位轉換 (你的原本做法，可保留)
    ;---------------------------------------
    call Clrscr

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
    ; 5. 顯示 Hash 結果（讓玩家感覺有過程）
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
    ; 6. 抽籤動畫：Loading + 旋轉棒 + 進度條
    ;---------------------------------------
    mov edx, OFFSET loadingMsg
    call WriteString
    call Spinner
    call ProgressBar


    ;---------------------------------------
    ; 7. 計算籤詩索引
    ;---------------------------------------
    mov eax, hashVal
    mov ebx, NUM_FORTUNES_PER_CAT
    ; 建議用 unsigned div，避免負數問題
    xor edx, edx
    div ebx
    mov indexVal, edx          ; 0 ~ NUM_FORTUNES_PER_CAT-1

    ;---------------------------------------
    ; 8. 使用跳轉表選擇運勢陣列
    ;---------------------------------------
    mov eax, choiceVal
    dec eax
    shl eax, 2
    mov edx, OFFSET fortunesTables
    add edx, eax
    mov edx, [edx]             ; edx = 該分類 fortunes 陣列起始

    mov eax, indexVal
    shl eax, 2
    add edx, eax
    mov edx, [edx]             ; edx = 最終選到的籤詩字串位址

    ;---------------------------------------
    ; 9. 顯示籤詩（打字機效果）
    ;---------------------------------------
    call Clrscr
    mov ebx, edx               ; 先存起來

    mov edx, OFFSET fortuneHeader
    call WriteString

    mov edx, ebx               ; 籤詩位址
    mov ecx, 30                ; 打字稍微慢一點
    call Typewriter
    call CrLf
    call CrLf

    ; 小煙火 + 愛心動畫
    call FireworkAndHeart

    call WaitMsg
    exit
start@0 ENDP

END start@0
