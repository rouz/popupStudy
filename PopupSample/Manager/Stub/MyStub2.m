
#import "MyStub2.h"

@implementation MyStub2

static MyStub2* sharedData_ = nil;

+ (MyStub2*)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData_ = [MyStub2 new];
    });
    return sharedData_;
}

@end
