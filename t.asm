INCLUDE Irvine32.inc

MAX_NAME_LEN   EQU 64
MAX_BIRTH_LEN  EQU 32
MAX_ZODIAC_LEN EQU 32
BITS           EQU 16
NUM_FORTUNES   EQU 8

.data
promptTitle      BYTE "=== 個人資料籤詩產生器 ===",0
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
fortunesLove DWORD \
    OFFSET love_great_1, OFFSET love_great_2, OFFSET love_great_3, \
    OFFSET love_good_1, OFFSET love_good_2, OFFSET love_good_3, \
    OFFSET love_small_1, OFFSET love_small_2, OFFSET love_small_3, \
    OFFSET love_luck_1, OFFSET love_luck_2, OFFSET love_luck_3, \
    OFFSET love_minor_1, OFFSET love_minor_2, OFFSET love_minor_3, \
    OFFSET love_bad_1, OFFSET love_bad_2, OFFSET love_bad_3, \
    OFFSET love_sbad_1, OFFSET love_sbad_2, OFFSET love_sbad_3, \
    OFFSET love_worst_1, OFFSET love_worst_2, OFFSET love_worst_3


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
fortunesStudy DWORD \
    OFFSET study_great_1, OFFSET study_great_2, OFFSET study_great_3, \
    OFFSET study_good_1,  OFFSET study_good_2,  OFFSET study_good_3, \
    OFFSET study_small_1, OFFSET study_small_2, OFFSET study_small_3, \
    OFFSET study_luck_1,  OFFSET study_luck_2,  OFFSET study_luck_3, \
    OFFSET study_minor_1, OFFSET study_minor_2, OFFSET study_minor_3, \
    OFFSET study_bad_1,   OFFSET study_bad_2,   OFFSET study_bad_3, \
    OFFSET study_sbad_1,  OFFSET study_sbad_2,  OFFSET study_sbad_3, \
    OFFSET study_worst_1, OFFSET study_worst_2, OFFSET study_worst_3

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
fortunesHealth DWORD \
    OFFSET health_great_1, OFFSET health_great_2, OFFSET health_great_3, \
    OFFSET health_good_1,  OFFSET health_good_2,  OFFSET health_good_3, \
    OFFSET health_small_1, OFFSET health_small_2, OFFSET health_small_3, \
    OFFSET health_luck_1,  OFFSET health_luck_2,  OFFSET health_luck_3, \
    OFFSET health_minor_1, OFFSET health_minor_2, OFFSET health_minor_3, \
    OFFSET health_bad_1,   OFFSET health_bad_2,   OFFSET health_bad_3, \
    OFFSET health_sbad_1,  OFFSET health_sbad_2,  OFFSET health_sbad_3, \
    OFFSET health_worst_1, OFFSET health_worst_2, OFFSET health_worst_3

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


; ================================
; 顯示分類菜單（新增）
; ================================
menuPrompt BYTE 0Dh,0Ah,"請選擇想求的運勢：",0Dh,0Ah,
           "1 = 愛情運勢",0Dh,0Ah,
           "2 = 學業運勢",0Dh,0Ah,
           "3 = 健康與財運",0Dh,0Ah,
           "請輸入 1 / 2 / 3：",0

choiceInput BYTE 4 DUP(?)     ; 暫存使用者輸入
choiceVal  DWORD ?            ; 1~3


; 緩衝區與變數
nameBuf   BYTE MAX_NAME_LEN   DUP(?)
birthBuf  BYTE MAX_BIRTH_LEN  DUP(?)
zodiacBuf BYTE MAX_ZODIAC_LEN DUP(?)
binBuf    BYTE BITS+1 DUP(?)

hashVal   DWORD ?
indexVal  DWORD ?
.code
start@0 PROC
    call Clrscr

    ; 顯示標題
    mov edx, OFFSET promptTitle
    call WriteString
    call CrLf

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
    ; simple_hash: h = 0; P = 131;
    ; 對 name / birth / zodiac 每字元做：
    ;   h = h * 131 + (unsigned char)c
    ;---------------------------------------
    xor eax, eax          ; EAX = h = 0
    mov ebx, 131          ; EBX = P

    ; hash nameBuf
    mov esi, OFFSET nameBuf
hash_name_loop:
    mov dl, [esi]
    cmp dl, 0
    je  hash_birth_start
    imul eax, ebx         ; h = h * 131
    movzx edx, dl
    add eax, edx          ; h += (unsigned char)c
    inc esi
    jmp hash_name_loop

    ; hash birthBuf
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

    ; hash zodiacBuf
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
    mov hashVal, eax      ; 存 hash 結果

    ;---------------------------------------
    ; to_binary: 把 hashVal 轉成 16-bit 0/1 字串到 binBuf
    ;---------------------------------------
    mov eax, hashVal      ; x
    mov edi, OFFSET binBuf ; out 指標
    mov ecx, BITS         ; bits = 16

    ; 先算出 mask = 1 << (BITS - 1)
    mov ebx, 1
    mov edx, BITS
    dec edx               ; edx = bits - 1
mask_build_loop:
    cmp edx, 0
    jle mask_ready
    shl ebx, 1
    dec edx
    jmp mask_build_loop
mask_ready:
    ; EBX = mask (最高位)

    xor esi, esi          ; i = 0
    mov edx, BITS         ; remaining bits count

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
    shr ebx, 1            ; mask >>= 1
    inc esi               ; i++
    dec edx               ; remaining--
    jmp bit_loop

bits_done:
    mov BYTE PTR [edi+esi], 0   ; 字串終止符號

    ;---------------------------------------
    ; 顯示 hash 結果
    ;---------------------------------------
    mov edx, OFFSET resultHeader
    call WriteString

    ; Hash 整數值:
    mov edx, OFFSET hashIntMsg
    call WriteString
    mov eax, hashVal
    call WriteDec
    call CrLf

    ; Hash 二進位:
    mov edx, OFFSET hashBinMsg
    call WriteString
    mov edx, OFFSET binBuf
    call WriteString
    call CrLf

    ;---------------------------------------
    ; 顯示分類選單：1=愛情, 2=學業, 3=健康與財運
    ;---------------------------------------
    mov edx, OFFSET menuPrompt
    call WriteString

    ; 讀入使用者輸入 (1/2/3)
    mov edx, OFFSET choiceInput
    mov ecx, 4
    call ReadString

    ; choiceVal = choiceInput[0] - '0'
    mov dl, BYTE PTR choiceInput
    sub dl, '0'
    movzx eax, dl
    mov choiceVal, eax      ; 1 / 2 / 3

    ;---------------------------------------
    ; index = hashVal % 24  (每類 24 筆籤)
    ;---------------------------------------
    mov eax, hashVal
    mov ebx, 24
    cdq
    idiv ebx                ; 商在 EAX, 餘數在 EDX
    mov indexVal, edx       ; 0..23

    ;---------------------------------------
    ; 根據 choiceVal 決定使用哪一組 fortunes
    ;---------------------------------------
    mov eax, choiceVal
    cmp eax, 1
    je  choose_love
    cmp eax, 2
    je  choose_study
    cmp eax, 3
    je  choose_health

    ; 非 1~3，預設使用愛情
    jmp choose_love

; ===== 愛情運勢 =====
choose_love:
    mov eax, indexVal       ; index (0..23)
    shl eax, 2              ; *4 (DWORD)
    mov edx, OFFSET fortunesLove
    add edx, eax
    mov edx, [edx]          ; edx = fortunesLove[index]
    jmp print_fortune

; ===== 學業運勢 =====
choose_study:
    mov eax, indexVal
    shl eax, 2
    mov edx, OFFSET fortunesStudy
    add edx, eax
    mov edx, [edx]          ; edx = fortunesStudy[index]
    jmp print_fortune

; ===== 健康與財運 =====
choose_health:
    mov eax, indexVal
    shl eax, 2
    mov edx, OFFSET fortunesHealth
    add edx, eax
    mov edx, [edx]          ; edx = fortunesHealth[index]
    jmp print_fortune

; ===== 統一顯示籤詩 =====
print_fortune:
    mov ebx, edx            ; EBX 暫存字串位址

    mov edx, OFFSET fortuneHeader
    call WriteString

    mov edx, ebx
    call WriteString
    call CrLf

    exit
start@0 ENDP

END start@0
