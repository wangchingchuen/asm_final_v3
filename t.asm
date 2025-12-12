INCLUDE Irvine32.inc


WinExec PROTO,
    lpCmdLine:PTR BYTE,
    uCmdShow:DWORD

; =============================================================
; ★ 修復點 1：顯式宣告 Windows API Beep 原型
; =============================================================
Beep PROTO,
    dwFreq:DWORD,
    dwDuration:DWORD

; 頻率表 (Hz)
NOTE_C4  EQU 262
NOTE_D4  EQU 294
NOTE_E4  EQU 330
NOTE_F4  EQU 349
NOTE_G4  EQU 392
NOTE_A4  EQU 440
NOTE_B4  EQU 494
NOTE_C5  EQU 523
NOTE_D5  EQU 587
NOTE_E5  EQU 659
NOTE_G5  EQU 784
NOTE_C6  EQU 1046

MAX_NAME_LEN   EQU 64
MAX_BIRTH_LEN  EQU 32
MAX_ZODIAC_LEN EQU 32
BITS           EQU 16
NUM_FORTUNES_PER_CAT EQU 24

.data
ESC_CODE EQU 27

; ================================
; ★ 1. 視覺風格設定 (置中與顏色)
; ================================
margin       BYTE "                      ", 0 ; 通用左邊距

; 背景色
setShrineBg  BYTE ESC_CODE, "[47;30m", 0                 ; 神社白底黑字
setLoveBg    BYTE ESC_CODE, "[48;2;255;235;235;30m", 0   ; 愛情粉
setStudyBg   BYTE ESC_CODE, "[48;2;240;255;240;30m", 0   ; 課業青
setWealthBg  BYTE ESC_CODE, "[48;2;255;250;205;30m", 0   ; 財運金

clearAll     BYTE ESC_CODE, "[2J", ESC_CODE, "[H", 0
resetColor   BYTE ESC_CODE, "[0m", 0

; 前景色 (更鮮豔)
colorRed     BYTE ESC_CODE, "[1;31m", 0 
colorGold    BYTE ESC_CODE, "[1;33m", 0 
colorPink    BYTE ESC_CODE, "[1;35m", 0 
colorCyan    BYTE ESC_CODE, "[1;36m", 0 
colorWhite   BYTE ESC_CODE, "[1;37m", 0 

currentBg    DWORD 0   ; 0=預設, 1=愛, 2=學, 3=財

; ================================
; ★ 2. 巨型置中鳥居 (Fancy 版)
; ================================
torii1  BYTE "                  ___________________________________________      ", 0Dh, 0Ah, 0
torii2  BYTE "                 /___________________________________________\     ", 0Dh, 0Ah, 0
torii3  BYTE "                  ||           |               |           ||      ", 0Dh, 0Ah, 0
torii4  BYTE "                  ||           |   ★ 開 運 ★   |           ||      ", 0Dh, 0Ah, 0
torii5  BYTE "                  ||           |___ _______ ___|           ||      ", 0Dh, 0Ah, 0
torii6  BYTE "                  ||           |  御 |   | 守  |           ||      ", 0Dh, 0Ah, 0
torii7  BYTE "                  ||           |  神 |   | 護  |           ||      ", 0Dh, 0Ah, 0
torii8  BYTE "                  ||           |  籤 |   | 所  |           ||      ", 0Dh, 0Ah, 0
torii9  BYTE "              ____||___________|_____|___|_____|___________||____  ", 0Dh, 0Ah, 0
torii10 BYTE "             |___________________________________________________| ", 0Dh, 0Ah, 0



; ================================
; 選單與介面 (全部置中)
; ================================
welcomeTitle BYTE 0Dh,0Ah,
             "                  ╔════════════════════════════════════╗",0Dh,0Ah,
             "                  ║      ⛩  日式開運御神籤  ⛩          ║",0Dh,0Ah,
             "                  ╚════════════════════════════════════╝",0Dh,0Ah,0

menuPrompt BYTE 0Dh,0Ah,
           "                    1. 愛情結緣",0Dh,0Ah,
           "                    2. 學業成就",0Dh,0Ah,
           "                    3. 金運招財",0Dh,0Ah,
           0Dh,0Ah,
           "                  ------------------------------------",0Dh,0Ah,
           "                          請輸入選擇 (1-3)：",0

errorMsg     BYTE 0Dh,0Ah,"                      [輸入錯誤，神明幫你選 1]",0Dh,0Ah,0

; 輸入介面 (置中)
promptTitle      BYTE 0Dh,0Ah,0Dh,0Ah,"                                                     === ✍ 請填寫參拜單 ✍ ===",0Dh,0Ah,0
promptEnterName  BYTE "                                             英文名字：", 0

; 結果標題
resultHeader     BYTE 0Dh,0Ah,0Dh,0Ah,"             ✧･ﾟ: *✧･ﾟ:* 神 明 的 指 引  *:･ﾟ✧*:･ﾟ✧",0Dh,0Ah,0
fortuneHeader    BYTE 0Dh,0Ah,"             -------------------------------------------",0Dh,0Ah,0
hashMsg          BYTE 0Dh,0Ah,"                      [靈魂共鳴值]: ",0

; ================================
; 運勢資料庫
; ================================
fortunesLove DWORD OFFSET l1, OFFSET l2, OFFSET l3, OFFSET l4, OFFSET l5, OFFSET l6, OFFSET l7, OFFSET l8, OFFSET l9, OFFSET l10, OFFSET l11, OFFSET l12, OFFSET l13, OFFSET l14, OFFSET l15, OFFSET l16, OFFSET l17, OFFSET l18, OFFSET l19, OFFSET l20, OFFSET l21, OFFSET l22, OFFSET l23, OFFSET l24
l1 BYTE "大吉：桃花盛開，轉角遇到愛。",0
l2 BYTE "大吉：心有靈犀，對方也在想你。",0
l3 BYTE "大吉：紅線已牽，大膽行動吧。",0
l4 BYTE "中吉：氣氛曖昧，適合約會。",0
l5 BYTE "中吉：多說好話，感情升溫。",0
l6 BYTE "中吉：甜蜜互動，羨煞旁人。",0
l7 BYTE "小吉：傳個訊息，會有回應。",0
l8 BYTE "小吉：淡淡的幸福最長久。",0
l9 BYTE "小吉：適合在咖啡廳偶遇。",0
l10 BYTE "吉：平平淡淡也是真愛。",0
l11 BYTE "吉：微笑是最好的武器。",0
l12 BYTE "吉：放輕鬆，自然更有魅力。",0
l13 BYTE "末吉：不要太急，慢慢來。",0
l14 BYTE "末吉：容易會錯意，多觀察。",0
l15 BYTE "末吉：適合單戀，享受過程。",0
l16 BYTE "凶：溝通不良，今天少說話。",0
l17 BYTE "凶：情緒不穩，容易吵架。",0
l18 BYTE "凶：舊愛還是最美？別想了。",0
l19 BYTE "小凶：對方已讀不回，別在意。",0
l20 BYTE "小凶：落花有意流水無情。",0
l21 BYTE "小凶：別做白日夢了，醒醒。",0
l22 BYTE "大凶：今日不宜告白，會爆。",0
l23 BYTE "大凶：爛桃花纏身，快跑。",0
l24 BYTE "大凶：還是愛自己比較實在。",0

fortunesStudy DWORD OFFSET s1, OFFSET s2, OFFSET s3, OFFSET s4, OFFSET s5, OFFSET s6, OFFSET s7, OFFSET s8, OFFSET s9, OFFSET s10, OFFSET s11, OFFSET s12, OFFSET s13, OFFSET s14, OFFSET s15, OFFSET s16, OFFSET s17, OFFSET s18, OFFSET s19, OFFSET s20, OFFSET s21, OFFSET s22, OFFSET s23, OFFSET s24
s1 BYTE "大吉：文昌帝君附體，過目不忘。",0
s2 BYTE "大吉：考運爆棚，猜的都對。",0
s3 BYTE "大吉：難題迎刃而解，如有神助。",0
s4 BYTE "中吉：努力有回報，進步明顯。",0
s5 BYTE "中吉：適合規劃讀書計畫。",0
s6 BYTE "中吉：專注力提升，效率高。",0
s7 BYTE "小吉：多背幾個單字，會有用。",0
s8 BYTE "小吉：適合複習舊進度。",0
s9 BYTE "小吉：和同學討論會有收穫。",0
s10 BYTE "吉：按部就班，穩定發揮。",0
s11 BYTE "吉：圖書館是你的幸運地。",0
s12 BYTE "吉：保持平常心就好。",0
s13 BYTE "末吉：容易分心，手機收起來。",0
s14 BYTE "末吉：進度稍微落後。",0
s15 BYTE "末吉：要補的洞有點多。",0
s16 BYTE "凶：書都讀不進去，去睡覺。",0
s17 BYTE "凶：考試容易粗心大意。",0
s18 BYTE "凶：作業寫不完，眼神死。",0
s19 BYTE "小凶：腦袋一片空白。",0
s20 BYTE "小凶：容易被老師點名。",0
s21 BYTE "小凶：今天適合放空，別讀了。",0
s22 BYTE "大凶：不想面對成績單。",0
s23 BYTE "大凶：書本對你使用了催眠術。",0
s24 BYTE "大凶：建議重修，下學期再來。",0

fortunesWealth DWORD OFFSET w1, OFFSET w2, OFFSET w3, OFFSET w4, OFFSET w5, OFFSET w6, OFFSET w7, OFFSET w8, OFFSET w9, OFFSET w10, OFFSET w11, OFFSET w12, OFFSET w13, OFFSET w14, OFFSET w15, OFFSET w16, OFFSET w17, OFFSET w18, OFFSET w19, OFFSET w20, OFFSET w21, OFFSET w22, OFFSET w23, OFFSET w24
w1 BYTE "大吉：財神爺敲門，橫財就手！",0
w2 BYTE "大吉：投資精準，回報超乎想像。",0
w3 BYTE "大吉：走路都會撿到錢，氣勢如虹。",0
w4 BYTE "中吉：正財穩定，適合存錢。",0
w5 BYTE "中吉：有意外的小獎金或禮物。",0
w6 BYTE "中吉：買東西會遇到超值折扣。",0
w7 BYTE "小吉：發票可能會中兩百。",0
w8 BYTE "小吉：收支平衡，小有結餘。",0
w9 BYTE "小吉：適合做小額儲蓄。",0
w10 BYTE "吉：不花就是賺，守財有道。",0
w11 BYTE "吉：朋友請客，省了一餐。",0
w12 BYTE "吉：財務狀況平穩。",0
w13 BYTE "末吉：衝動購物前請三思。",0
w14 BYTE "末吉：錢包有點破洞，注意花費。",0
w15 BYTE "末吉：別借錢給別人。",0
w16 BYTE "凶：今日不宜投資，風險高。",0
w17 BYTE "凶：小心遺失錢包或悠遊卡。",0
w18 BYTE "凶：容易買到雷貨。",0
w19 BYTE "小凶：月底吃土預警。",0
w20 BYTE "小凶：會有必要的意外支出。",0
w21 BYTE "小凶：股票一片綠油油。",0
w22 BYTE "大凶：破財消災，人沒事就好。",0
w23 BYTE "大凶：詐騙猖獗，接電話要小心。",0
w24 BYTE "大凶：窮神附體，乖乖待在家。",0

choiceInput BYTE 4 DUP(?)
choiceVal  DWORD ?

; 日期選擇用
yearVal      DWORD 2000
monthVal     DWORD 1
dayVal       DWORD 1
dateField    DWORD 0

datePrompt   BYTE "                                             生日：(左右鍵切換，上下鍵調整，Enter確認)", 0Dh, 0Ah, 0
dateIndent   BYTE "                                             ", 0
dateDash     BYTE " - ", 0
dateYearHL   BYTE ESC_CODE, "[7m", 0
dateNormal   BYTE ESC_CODE, "[27m", 0
cursorUp1    BYTE ESC_CODE, "[1A", 0
zodiacIndent BYTE "                                             ", 0

; 星座選單
zodiacFirstDraw DWORD 1    ; 1=第一次畫, 0=更新
zodiacPrompt BYTE 0Dh, 0Ah, "                                             星座：(上下鍵選擇，Enter確認)", 0Dh, 0Ah, 0
zodiac1  BYTE "Aries      ", 0
zodiac2  BYTE "Taurus     ", 0
zodiac3  BYTE "Gemini     ", 0
zodiac4  BYTE "Cancer     ", 0
zodiac5  BYTE "Leo        ", 0
zodiac6  BYTE "Virgo      ", 0
zodiac7  BYTE "Libra      ", 0
zodiac8  BYTE "Scorpio    ", 0
zodiac9  BYTE "Sagittarius", 0
zodiac10 BYTE "Capricorn  ", 0
zodiac11 BYTE "Aquarius   ", 0
zodiac12 BYTE "Pisces     ", 0
zodiacList DWORD OFFSET zodiac1, OFFSET zodiac2, OFFSET zodiac3, OFFSET zodiac4, OFFSET zodiac5, OFFSET zodiac6
           DWORD OFFSET zodiac7, OFFSET zodiac8, OFFSET zodiac9, OFFSET zodiac10, OFFSET zodiac11, OFFSET zodiac12
zodiacSel  DWORD 0           
arrowMark  BYTE "👉   ", 0      
spaceMark  BYTE "      ", 0
clearLine  BYTE ESC_CODE, "[K", 0    
cursorUp12 BYTE ESC_CODE, "[12A", 0  
pressRightMsg BYTE 0Dh, 0Ah, "                      按任意鍵領取神旨...", 0

pressEnterMsg BYTE 0Dh, 0Ah, "                  ⛩ 進入開運御神籤抽籤，請按 Enter 開始 ⛩", 0Dh, 0Ah, 0
vbsIntro      BYTE "wscript play_intro.vbs", 0
vbsStop       BYTE "wscript stop_music.vbs", 0

fortunesTables DWORD OFFSET fortunesLove, OFFSET fortunesStudy, OFFSET fortunesWealth

nameBuf   BYTE MAX_NAME_LEN   DUP(?)
birthBuf  BYTE MAX_BIRTH_LEN  DUP(?)
zodiacBuf BYTE MAX_ZODIAC_LEN DUP(?)
qInput    BYTE 4 DUP(?)      
qSum      DWORD ?            
levelIndex DWORD ?           
hashVal   DWORD ?
indexVal  DWORD ?

; ===== 問題（改回愛情版） =====
q1Msg BYTE 0Dh,0Ah,"                      Q1. 愛情的觸感是什麼？",0Dh,0Ah,\
                   "                      1) 堅實的    2) 柔滑的",0Dh,0Ah,\
                   "                      3) 輕盈的    4) 溫軟的",0Dh,0Ah,\
                   "                      請輸入 1-4：",0

q2Msg BYTE 0Dh,0Ah,"                      Q2. 你在愛情中的步伐像什麼？",0Dh,0Ah,\
                   "                      1) 穩穩走    2) 緩緩靠近",0Dh,0Ah,\
                   "                      3) 偶爾衝動  4) 直覺行動",0Dh,0Ah,\
                   "                      請輸入 1-4：",0

q3Msg BYTE 0Dh,0Ah,"                      Q3. 如果把戀愛比喻成天氣，你是？",0Dh,0Ah,\
                   "                      1) 晴朗無雲  2) 微風和煦",0Dh,0Ah,\
                   "                      3) 陣雨轉晴  4) 流星夜空",0Dh,0Ah,\
                   "                      請輸入 1-4：",0

q4Msg BYTE 0Dh,0Ah,"                      Q4. 你最期待的愛情狀態是？",0Dh,0Ah,\
                   "                      1) 安定踏實  2) 溫柔互動",0Dh,0Ah,\
                   "                      3) 心動火花  4) 劇烈浪漫",0Dh,0Ah,\
                   "                      請輸入 1-4：",0

q5Msg BYTE 0Dh,0Ah,"                      Q5. 當你想念一個人時，你會？",0Dh,0Ah,\
                   "                      1) 默默等待  2) 傳訊問候",0Dh,0Ah,\
                   "                      3) 計畫見面  4) 直接衝去找他",0Dh,0Ah,\
                   "                      請輸入 1-4：",0

levelHeader BYTE 0Dh,0Ah,"                      [靈力等級評定]: ",0
level1 BYTE "拉完了",0
level2 BYTE "NPC",0
level3 BYTE "人上人",0
level4 BYTE "頂級",0
level5 BYTE "夯",0
levelTable DWORD OFFSET level1, OFFSET level2, OFFSET level3, OFFSET level4, OFFSET level5
levelPtr DWORD ?

loadingMsg BYTE 0Dh,0Ah,"                      祈願傳送中...",0

; 動畫符號
heartChars    BYTE "♥o*~.+", 0
moneyChars    BYTE "$¥€£¢", 0

.code

; ==================================================
; ★ 3. 音樂函式庫
; ==================================================

; --- 開場主題曲 ---
PlayIntroMusic PROC USES eax
    INVOKE Beep, NOTE_C4, 150
    INVOKE Beep, NOTE_E4, 150
    INVOKE Beep, NOTE_G4, 150
    INVOKE Beep, NOTE_C5, 300
    INVOKE Beep, NOTE_G4, 150
    INVOKE Beep, NOTE_C5, 500
    ret
PlayIntroMusic ENDP

; --- 確認音效 ---
PlayCoinSound PROC USES eax
    INVOKE Beep, NOTE_B4, 100
    INVOKE Beep, NOTE_E5, 200
    ret
PlayCoinSound ENDP

; --- 移動游標音效 ---
PlayMoveSound PROC USES eax
    INVOKE Beep, NOTE_A4, 50
    ret
PlayMoveSound ENDP

; --- 結果發表音效（目前不呼叫） ---
PlayWinSound PROC USES eax
    INVOKE Beep, NOTE_C5, 100
    INVOKE Beep, NOTE_D5, 100
    INVOKE Beep, NOTE_E5, 100
    INVOKE Beep, NOTE_G5, 100
    INVOKE Beep, NOTE_C6, 600
    ret
PlayWinSound ENDP

; --- 播放開場背景音樂 ---
PlayIntroBGM PROC USES eax edx
    INVOKE WinExec, ADDR vbsIntro, 0
    ret
PlayIntroBGM ENDP

; ==================================================
; ★ 4. Fancy 霓虹神社開場 (置中 + 閃爍)
; ==================================================
ShrineIntro PROC USES eax ecx edx
    call SetShrineBackground
    
    ; 播放開場音樂
    call PlayIntroBGM
    
    ; 霓虹燈閃爍效果
    mov ecx, 3 
flash_loop:
    push ecx
    
    ; 顏色 1: 紅
    mov edx, OFFSET colorRed
    call WriteString
    call DrawTorii
    mov eax, 300
    call Delay
    call ClearWithBg
    
    ; 顏色 2: 金
    mov edx, OFFSET colorGold
    call WriteString
    call DrawTorii
    mov eax, 300
    call Delay
    call ClearWithBg

    ; 顏色 3: 白
    mov edx, OFFSET colorWhite
    call WriteString
    call DrawTorii
    mov eax, 300
    call Delay
    call ClearWithBg

    pop ecx
    loop flash_loop

    ; 最後定格在紅色
    mov edx, OFFSET colorRed
    call WriteString
    call DrawTorii
    
      ; 顯示按 Enter 開始提示
    mov edx, OFFSET pressEnterMsg
    call WriteString

wait_enter:
    call ReadChar
    cmp al, 13
    jne wait_enter

    ret
ShrineIntro ENDP

DrawTorii PROC USES edx
    mov edx, OFFSET torii1
    call WriteString
    mov edx, OFFSET torii2
    call WriteString
    mov edx, OFFSET torii3
    call WriteString
    mov edx, OFFSET torii4
    call WriteString
    mov edx, OFFSET torii5
    call WriteString
    mov edx, OFFSET torii6
    call WriteString
    mov edx, OFFSET torii7
    call WriteString
    mov edx, OFFSET torii8
    call WriteString
    mov edx, OFFSET torii9
    call WriteString
    mov edx, OFFSET torii10
    call WriteString
    ret
DrawTorii ENDP

; ==================================================
; ★ 5. 華麗的置中動畫
; ==================================================

; 通用等待動畫
FancyLoading PROC USES eax ecx edx
    mov edx, OFFSET loadingMsg
    call WriteString
    
    mov ecx, 10
loading_loop:
    mov al, '.'
    call WriteChar
    mov eax, 100
    call Delay
    loop loading_loop
    
    call ClearWithBg
    ret
FancyLoading ENDP

; 金幣雨動畫
WealthRain PROC USES eax ecx edx esi
    mov edx, OFFSET colorGold
    call WriteString
    mov ecx, 60
w_loop:
    mov eax, 20      ; 行
    call RandomRange
    mov dh, al
    mov eax, 60      ; 列 (限制在中間區域)
    call RandomRange
    add al, 10       ; 左邊偏移
    mov dl, al
    call Gotoxy
    
    mov eax, 5
    call RandomRange
    mov esi, OFFSET moneyChars
    add esi, eax
    mov al, [esi]
    call WriteChar
    
    mov eax, 30
    call Delay
    loop w_loop
    call ClearWithBg
    ret
WealthRain ENDP

; ==================================================
; 輔助函式
; ==================================================


SelectZodiac PROC USES eax ebx ecx edx esi
    mov zodiacSel, 0
    mov zodiacFirstDraw, 1    ; 重設為第一次畫
    
    ; 印出星座提示
    mov edx, OFFSET zodiacPrompt
    call WriteString
    
    ; 印出 12 個星座
    call DrawZodiacList

select_loop:
    call ReadKey
    cmp ah, 72
    je go_up
    cmp ah, 80
    je go_down
    cmp al, 13
    je select_done
    jmp select_loop

go_up:
    cmp zodiacSel, 0
    je select_loop
    dec zodiacSel
    call PlayMoveSound
    call DrawZodiacList
    jmp select_loop

go_down:
    cmp zodiacSel, 11
    je select_loop
    inc zodiacSel
    call PlayMoveSound
    call DrawZodiacList
    jmp select_loop

select_done:
    call PlayCoinSound
    mov eax, zodiacSel
    shl eax, 2
    mov esi, OFFSET zodiacList
    add esi, eax
    mov esi, [esi]       
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

SelectDate PROC USES eax ebx ecx edx
    mov yearVal, 2000
    mov monthVal, 1
    mov dayVal, 1
    mov dateField, 0
    
    mov edx, OFFSET datePrompt
    call WriteString
    
    ; 先印一行（讓 DrawDate 的 cursorUp1 有東西可以覆蓋）
    mov edx, OFFSET dateIndent
    call WriteString
    mov eax, yearVal
    call WriteDec
    mov edx, OFFSET dateDash
    call WriteString
    mov al, '0'
    call WriteChar
    mov eax, monthVal
    call WriteDec
    mov edx, OFFSET dateDash
    call WriteString
    mov al, '0'
    call WriteChar
    mov eax, dayVal
    call WriteDec
    call CrLf
    
    call DrawDate

date_loop:
    call ReadKey
    
    cmp ah, 75        ; 左鍵
    je date_left
    cmp ah, 77        ; 右鍵
    je date_right
    cmp ah, 72        ; 上鍵
    je date_up
    cmp ah, 80        ; 下鍵
    je date_down
    cmp al, 13        ; Enter
    je date_done
    jmp date_loop

date_left:
    cmp dateField, 0
    je date_loop
    dec dateField
    call DrawDate
    jmp date_loop

date_right:
    cmp dateField, 2
    je date_loop
    inc dateField
    call DrawDate
    jmp date_loop

date_up:
    cmp dateField, 0
    je inc_year
    cmp dateField, 1
    je inc_month
    jmp inc_day

inc_year:
    cmp yearVal, 2025
    jge date_loop
    inc yearVal
    call DrawDate
    jmp date_loop

inc_month:
    cmp monthVal, 12
    jge date_loop
    inc monthVal
    call DrawDate
    jmp date_loop

inc_day:
    cmp dayVal, 31
    jge date_loop
    inc dayVal
    call DrawDate
    jmp date_loop

date_down:
    cmp dateField, 0
    je dec_year
    cmp dateField, 1
    je dec_month
    jmp dec_day

dec_year:
    cmp yearVal, 1950
    jle date_loop
    dec yearVal
    call DrawDate
    jmp date_loop

dec_month:
    cmp monthVal, 1
    jle date_loop
    dec monthVal
    call DrawDate
    jmp date_loop

dec_day:
    cmp dayVal, 1
    jle date_loop
    dec dayVal
    call DrawDate
    jmp date_loop

date_done:
    ; 把日期組成字串存到 birthBuf
    ; 格式: YYYY-MM-DD
    mov edi, OFFSET birthBuf
    
    ; 年
    mov eax, yearVal
    mov ebx, 1000
    xor edx, edx
    div ebx
    add al, '0'
    mov [edi], al
    inc edi
    
    mov eax, edx
    mov ebx, 100
    xor edx, edx
    div ebx
    add al, '0'
    mov [edi], al
    inc edi
    
    mov eax, edx
    mov ebx, 10
    xor edx, edx
    div ebx
    add al, '0'
    mov [edi], al
    inc edi
    
    add dl, '0'
    mov [edi], dl
    inc edi
    
    mov BYTE PTR [edi], '-'
    inc edi
    
    ; 月
    mov eax, monthVal
    mov ebx, 10
    xor edx, edx
    div ebx
    add al, '0'
    mov [edi], al
    inc edi
    add dl, '0'
    mov [edi], dl
    inc edi
    
    mov BYTE PTR [edi], '-'
    inc edi
    
    ; 日
    mov eax, dayVal
    mov ebx, 10
    xor edx, edx
    div ebx
    add al, '0'
    mov [edi], al
    inc edi
    add dl, '0'
    mov [edi], dl
    inc edi
    
    mov BYTE PTR [edi], 0
    
    call CrLf
    ret
SelectDate ENDP

DrawDate PROC USES eax ebx edx
    mov edx, OFFSET cursorUp1
    call WriteString
    mov edx, OFFSET clearLine
    call WriteString
    
    ; 縮排對齊
    mov edx, OFFSET dateIndent
    call WriteString
    
    ; 印年
    cmp dateField, 0
    jne year_normal
    mov edx, OFFSET dateYearHL
    call WriteString
year_normal:
    mov eax, yearVal
    call WriteDec
    mov edx, OFFSET dateNormal
    call WriteString
    
    mov edx, OFFSET dateDash
    call WriteString
    
    ; 印月
    cmp dateField, 1
    jne month_normal
    mov edx, OFFSET dateYearHL
    call WriteString
month_normal:
    mov eax, monthVal
    cmp eax, 10
    jge month_print
    mov al, '0'
    call WriteChar
    mov eax, monthVal
month_print:
    call WriteDec
    mov edx, OFFSET dateNormal
    call WriteString
    
    mov edx, OFFSET dateDash
    call WriteString
    
    ; 印日
    cmp dateField, 2
    jne day_normal
    mov edx, OFFSET dateYearHL
    call WriteString
day_normal:
    mov eax, dayVal
    cmp eax, 10
    jge day_print
    mov al, '0'
    call WriteChar
    mov eax, dayVal
day_print:
    call WriteDec
    mov edx, OFFSET dateNormal
    call WriteString
    
    call CrLf
    ret
DrawDate ENDP

DrawZodiacList PROC USES eax ebx ecx edx esi
    ; 只有非第一次才往上移
    cmp zodiacFirstDraw, 1
    je skip_cursor_up
    mov edx, OFFSET cursorUp12
    call WriteString
    jmp start_draw
    
skip_cursor_up:
    mov zodiacFirstDraw, 0    ; 之後就不是第一次了
    
start_draw:
    mov ecx, 0

draw_loop:
    cmp ecx, 12
    jge draw_done
    
    mov edx, OFFSET clearLine
    call WriteString
    
    ; 縮排
    mov edx, OFFSET zodiacIndent
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
    mov eax, ecx
    shl eax, 2
    mov esi, OFFSET zodiacList
    add esi, eax
    mov edx, [esi]
    call WriteString
    call CrLf
    
    inc ecx
    jmp draw_loop

skip_extra_space:
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

SetShrineBackground PROC
    mov edx, OFFSET setShrineBg
    call WriteString
    mov edx, OFFSET clearAll
    call WriteString
    ret
SetShrineBackground ENDP

ClearWithBg PROC
    cmp currentBg, 1
    je use_love
    cmp currentBg, 2
    je use_study
    cmp currentBg, 3
    je use_wealth
    mov edx, OFFSET setShrineBg
    jmp do_c
use_love: mov edx, OFFSET setLoveBg
    jmp do_c
use_study: mov edx, OFFSET setStudyBg
    jmp do_c
use_wealth: mov edx, OFFSET setWealthBg
do_c:
    call WriteString
    mov edx, OFFSET clearAll
    call WriteString
    ret
ClearWithBg ENDP

ResetColors PROC
    mov edx, OFFSET resetColor
    call WriteString
    ret
ResetColors ENDP

; --- 停止背景音樂 ---
StopBGM PROC USES eax edx
    INVOKE WinExec, ADDR vbsStop, 0
    ret
StopBGM ENDP

; ==================================================
; ★ 主程式
; ==================================================
start@0 PROC
    call Randomize          
    
    ; 1. 豪華開場
    call ShrineIntro
    
    ; 2. 選單 (置中)
    call SetShrineBackground
    mov edx, OFFSET welcomeTitle
    call WriteString
    mov edx, OFFSET menuPrompt
    call WriteString

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
    call StopBGM 
    call PlayCoinSound
    mov eax, choiceVal
    mov currentBg, eax    
    call ClearWithBg      

    ; 3. 輸入資料 (置中)
    call ClearWithBg
    mov edx, OFFSET promptTitle
    call WriteString
    mov edx, OFFSET promptEnterName
    call WriteString
    mov edx, OFFSET nameBuf
    mov ecx, MAX_NAME_LEN
    call ReadString
    call CrLf
    call SelectDate

    call SelectZodiac

    ; 4. 計算 Hash（簡化版：只用名字）
    xor eax, eax
    mov ebx, 131
    mov esi, OFFSET nameBuf
hash_loop:
    mov dl, [esi]
    cmp dl, 0
    je hash_done
    imul eax, ebx
    movzx edx, dl
    add eax, edx
    inc esi
    jmp hash_loop
hash_done:
    mov hashVal, eax

    ; 5. 動畫轉場
    cmp choiceVal, 3
    jne normal_anim
    call WealthRain
    jmp anim_finish
normal_anim:
    call FancyLoading
anim_finish:

    ; 6. 問問題＆算 qSum
    call ClearWithBg
    xor eax, eax
    mov qSum, eax

    mov edx, OFFSET q1Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax
    
    mov edx, OFFSET q2Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    mov edx, OFFSET q3Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    mov edx, OFFSET q4Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    mov edx, OFFSET q5Msg
    call WriteString
    mov edx, OFFSET qInput
    mov ecx, 4
    call ReadString
    mov dl, BYTE PTR qInput
    sub dl, '0'
    movzx eax, dl
    add qSum, eax

    ; 7. 將 qSum 轉成 0~4 等級 index
    mov eax, qSum        ; 5~20

    cmp eax, 8
    jl  l_1
    cmp eax, 12
    jl  l_2
    cmp eax, 15
    jl  l_3
    cmp eax, 18
    jl  l_4
    jmp l_5

l_1: mov eax, 0
     jmp l_done
l_2: mov eax, 1
     jmp l_done
l_3: mov eax, 2
     jmp l_done
l_4: mov eax, 3
     jmp l_done
l_5: mov eax, 4
l_done:
    mov levelIndex, eax          ; 記住等級 0~4

    mov ecx, eax
    shl ecx, 2
    mov edx, OFFSET levelTable
    add edx, ecx
    mov edx, [edx]
    mov levelPtr, edx

    ; 8. 顯示結果（不再播放 PlayWinSound）
    call ClearWithBg

    mov edx, OFFSET resultHeader
    call WriteString

    mov edx, OFFSET hashMsg
    call WriteString
    mov eax, hashVal
    call WriteDec
    call CrLf

    ; 計算運勢字串 index
    mov eax, hashVal
    mov ebx, NUM_FORTUNES_PER_CAT
    xor edx, edx
    div ebx                 ; EDX = hashVal % 24

    mov eax, choiceVal
    dec eax
    shl eax, 2
    mov ebx, OFFSET fortunesTables
    add ebx, eax
    mov ebx, [ebx]          ; ebx = 該類別 fortunes 開頭

    shl edx, 2
    add ebx, edx
    mov ebx, [ebx]          ; ebx = 某一條籤詩位址

    ; 顯示籤詩
    mov edx, OFFSET fortuneHeader
    call WriteString
    
    mov edx, OFFSET margin
    call WriteString
    mov edx, OFFSET colorRed
    call WriteString
    mov edx, ebx
    call WriteString
    call CrLf
    
    ; 顯示等級：標題 + 等級文字同一顏色
    mov eax, levelIndex
    cmp eax, 0
    je lvl0
    cmp eax, 1
    je lvl1
    cmp eax, 2
    je lvl2
    cmp eax, 3
    je lvl3
    ; 其他 → lvl4
lvl4:
    mov edx, OFFSET colorRed         ; 夯：紅色
    jmp show_level
lvl3:
    mov edx, OFFSET colorPink        ; 頂級：粉色
    jmp show_level
lvl2:
    mov edx, OFFSET colorGold        ; 人上人：金色
    jmp show_level
lvl1:
    mov edx, OFFSET colorCyan        ; NPC：青色
    jmp show_level
lvl0:
    mov edx, OFFSET colorWhite       ; 拉完了：白色

show_level:
    call WriteString                 ; 設定顏色
    mov edx, OFFSET levelHeader
    call WriteString
    mov edx, levelPtr                ; 「拉完了 / NPC / 人上人 / 頂級 / 夯」
    call WriteString
    call CrLf
    call CrLf

    call ResetColors
    mov edx, OFFSET pressRightMsg
    call WriteString
    call ReadChar

    call StopBGM 
    exit
start@0 ENDP
END start@0
