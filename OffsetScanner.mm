#import <mach-o/dyld.h>
#import <stdint.h>
#import <string.h>

// TỰ ĐỘNG LẤY BASE ADDRESS CỦA UNITY FRAMEWORK
uintptr_t get_unity_base() {
    return (uintptr_t)_dyld_get_image_vmaddr_slide(0) + 0x100000000;
}

// THUẬT TOÁN QUÉT MÃ VẠCH (AOB SCANNING) 2026
uintptr_t find_pattern(const char* pattern, const char* mask) {
    uintptr_t start = get_unity_base();
    uintptr_t end = start + 0x6000000; // Quét vùng nhớ 96MB đầu
    size_t maskLen = strlen(mask);

    for (uintptr_t i = start; i < end - maskLen; i++) {
        bool found = true;
        for (size_t j = 0; j < maskLen; j++) {
            if (mask[j] != '?' && pattern[j] != *(char*)(i + j)) {
                found = false;
                break;
            }
        }
        if (found) return i;
    }
    return 0;
}
