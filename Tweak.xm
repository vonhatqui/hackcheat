#import <substrate.h>
#import "OffsetScanner.mm"

bool aimbot = false;
float fov = 90.0f;
bool esp_line = false;

// TỰ ĐỘNG DÒ VÀ HOOK KHI VÀO GAME
void init_hack() {
    // Quét pattern cho Aimbot và ESP 2026
    uintptr_t aim_addr = find_pattern("\x48\x89\x5C\x24\x08\x57\x48\x83\xEC", "xxxxxxxxx");
    
    if (aim_addr) {
        // MSHookFunction((void*)aim_addr, (void*)&new_aim, (void**)&old_aim);
    }
}

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        init_hack();
        // Hiện menu cho Đại ca
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIView *menu = [[SavageMenu alloc] initWithFrame:CGRectMake(50, 50, 280, 400)];
        [keyWindow addSubview:menu];
    });
}
