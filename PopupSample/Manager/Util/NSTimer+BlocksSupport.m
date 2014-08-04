
#import "NSTimer+BlocksSupport.h"

@implementation NSTimer (BlocksSupport)

+ (NSTimer*)sh_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        block:(void(^)())block
                                      repeats:(BOOL)repeats {
    
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(sh_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)sh_blockInvoke:(NSTimer*)timer {

    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
    
}

@end
