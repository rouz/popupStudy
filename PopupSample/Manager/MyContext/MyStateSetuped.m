
#import "MyStateSetuped.h"

@implementation MyStateSetuped

static MyStateSetuped* sharedData_ = nil;

+ (MyStateSetuped*)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData_ = [[MyStateSetuped alloc] init];
    });
    return sharedData_;
}



@end
