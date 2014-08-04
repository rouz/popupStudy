
#import "MyState.h"

@interface MyStateNone : MyState

+ (MyStateNone*)sharedManager;

- (void)setupPlayer:(void (^)(bool success))completion;

@end
