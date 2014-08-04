
#import <Foundation/Foundation.h>

@interface NSTimer (BlocksSupport)

+ (NSTimer*)sh_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        block:(void(^)())block
                                      repeats:(BOOL)repeats;

@end
