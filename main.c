#include <stdio.h>
#include <string.h>

#define MAX_NAME_LEN   64
#define MAX_BIRTH_LEN  32
#define MAX_ZODIAC_LEN 32
#define BITS           16   // 要輸出幾個 bits，可以改成 32 之類

// 簡單讀一行，去掉最後的 '\n'
void read_line(char *buf, int size) {
    if (fgets(buf, size, stdin) != NULL) {
        int len = (int)strlen(buf);
        if (len > 0 && buf[len - 1] == '\n') {
            buf[len - 1] = '\0';
        }
    }
}

// 簡單 hash：把 name / birthday / zodiac 串起來走一遍
unsigned int simple_hash(const char *name, const char *birth, const char *zodiac) {
    unsigned int h = 0;
    const unsigned int P = 131;  // 一個隨便選的質數

    const char *p;

    // 先吃名字
    for (p = name;*p != '\0'; p++) {
        h = h * P + (unsigned char)(*p);
    }

    // 再吃生日
    for (p = birth;*p != '\0'; p++) {
        h = h * P + (unsigned char)(*p);
    }

    // 再吃星座
    for (p = zodiac;*p != '\0'; p++) {
        h = h * P + (unsigned char)(*p);
    }

    return h;
}

int show_menu() {
    int choice;
    printf("\n");
    printf("+----------------------------+\n");
    printf("|  測測你今天的運勢          |\n");
    printf("+----------------------------+\n");
    printf("| 1. 愛情運勢                |\n");
    printf("| 2. 金錢運勢                |\n");
    printf("| 3. 學業運勢                |\n");
    printf("| 0. 離開                    |\n");
    printf("+----------------------------+\n");
    printf("請選擇 (0-3): ");
    scanf("%d", &choice);
    getchar(); // 吃掉換行
    return choice;
}

// 取得不同類型的籤詩
void get_fortune(int type, unsigned int hash) {
    // 愛情運勢
    const char *love_fortunes[] = {
        "大吉：今天桃花運爆棚，有機會遇到對的人！",
        "中吉：感情穩定發展，適合約會。",
        "小吉：單身者有機會認識新朋友。",
        "吉：另一半會給你驚喜。",
        "末吉：感情需要多溝通，別悶著。",
        "凶：今天別吵架，冷靜點。",
        "小凶：給彼此一點空間會更好。",
        "大凶：今天專心工作吧，感情先放一邊。"
    };

    // 金錢運勢
    const char *money_fortunes[] = {
        "大吉：有意外之財，可以小試手氣！",
        "中吉：收入穩定，可以考慮投資。",
        "小吉：記得記帳，財運會更好。",
        "吉：適合談薪水或談生意。",
        "末吉：不要衝動購物，三思而後行。",
        "凶：今天錢包看緊一點。",
        "小凶：避免借錢給別人。",
        "大凶：今天不適合做重大財務決定。"
    };

    // 學業運勢
    const char *study_fortunes[] = {
        "大吉：今天讀書效率超高，把握時間！",
        "中吉：適合複習舊的內容，會有新領悟。",
        "小吉：多和同學討論，會有收穫。",
        "吉：考試運不錯，保持信心。",
        "末吉：專注力普通，少滑手機。",
        "凶：今天適合休息，別硬撐。",
        "小凶：讀不下書就先放鬆一下。",
        "大凶：今天不適合熬夜，早點睡！"
    };

    const char **fortunes;
    int num_fortunes = 8;

    switch(type) {
        case 1:
            fortunes = love_fortunes;
            printf("\n=== 愛情運勢 ===\n");
            break;
        case 2:
            fortunes = money_fortunes;
            printf("\n=== 金錢運勢 ===\n");
            break;
        case 3:
            fortunes = study_fortunes;
            printf("\n=== 學業運勢 ===\n");
            break;
        default:
            return;
    }

    int index = (int)(hash % num_fortunes);
    printf("%s\n", fortunes[index]);
}

// 把整數轉成二進位字串（高位在前）
void to_binary(unsigned int x, char *out, int bits) {
    for (int i = 0; i < bits; i++) {
        // 從最高位開始取
        unsigned int mask = 1u << (bits - 1 - i);
        out[i] = (x & mask) ? '1' : '0';
    }
    out[bits] = '\0';
}

int main(void) {
    char name[MAX_NAME_LEN];
    char birth[MAX_BIRTH_LEN];
    char zodiac[MAX_ZODIAC_LEN];

     // 進入選單循環
    while(1) {
        int choice = show_menu();
        
        if (choice == 0) {
            printf("\n感謝使用，掰掰！\n");
            break;
        }
        
        if (choice >= 1 && choice <= 3) {
            get_fortune(choice, h);
        } else {
            printf("無效的選擇，請重新輸入。\n");
        }
    }

    printf("=== 個人資料籤詩產生器 ===\n");
    printf("請輸入英文名字: ");
    read_line(name, MAX_NAME_LEN);

    printf("請輸入生日 (例如 2005-03-14 或 20050314): ");
    read_line(birth, MAX_BIRTH_LEN);

    printf("請輸入星座 (例如 Aries / Taurus / Gemini ...): ");
    read_line(zodiac, MAX_ZODIAC_LEN);

    // 計算 hash
    unsigned int h = simple_hash(name, birth, zodiac);

    // 把 hash 轉成二進位
    char bin[BITS + 1];
    to_binary(h, bin, BITS);

     // 進入選單循環
    while(1) {
        int choice = show_menu();
        
        if (choice == 0) {
            printf("\n感謝使用，掰掰！\n");
            break;
        }
        
        if (choice >= 1 && choice <= 3) {
            get_fortune(choice, h);
        } else {
            printf("無效的選擇，請重新輸入。\n");
        }
    }

    return 0;
}