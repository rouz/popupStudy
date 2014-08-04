
#import "MyModelType.h"
#import "MyState.h"
#import "MyStateNone.h"
#import "MyStateSetuped.h"
#import "MyStateStarting.h"
#import "MyStateRunning.h"

@implementation MyModelTypes

+ (MyModelState)convertToModelState:(MyState*)state
{
    if ([state isMemberOfClass:[MyStateNone class]]) {
        return MyModelStateNone;
    } else if([state isMemberOfClass:[MyStateSetuped class]]) {
        return MyModelStateSetuped;
    } else if([state isMemberOfClass:[MyStateStarting class]]) {
        return MyModelStateStarting;
    } else if([state isMemberOfClass:[MyStateRunning class]]) {
        return MyModelStateRunning;
    } else {
        NSAssert(0, @"state is invalid");
        return MyModelStateNone;
    }
}

@end
