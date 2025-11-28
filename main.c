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

    printf("\n--- 計算結果 ---\n");
    printf("Hash 整數值: %u\n", h);
    printf("Hash 二進位(%d bits): %s\n", BITS, bin);

    // 籤詩列表（你可以改成自己的內容）
    const char *fortunes[] = {
        "大吉：今天超適合開始新的計畫。",
        "中吉：平穩的一天，好好累積實力。",
        "小吉：多聽別人的建議會有收穫。",
        "吉：適合跟朋友合作，會有好結果。",
        "末吉：事情進展慢一點，但不要急。",
        "凶：先冷靜一下，今天少做重大決定。",
        "小凶：注意休息，不要太熬夜。",
        "大凶：先睡一覺，明天會更好。"
    };
    const int NUM_FORTUNES = (int)(sizeof(fortunes) / sizeof(fortunes[0]));

    int index = (int)(h % NUM_FORTUNES);

    printf("\n--- 你的籤 ---\n");
    printf("%s\n", fortunes[index]);

    return 0;
}