
#import "MyStateRunning.h"
#import "MyStub1.h"

@interface MyStateRunning ()
@end


@implementation MyStateRunning

static MyStateRunning* sharedData_ = nil;

+ (MyStateRunning*)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData_ = [[MyStateRunning alloc] init];
    });
    return sharedData_;
}


- (void)cancelPlaying
{
    NSLog(@"MyStateRunning.cancelPlaying");
    
    [[MyStub1 sharedManager] cancelPlay_Test];
}

@end
