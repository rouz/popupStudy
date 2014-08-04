
#import "MyPlayApi.h"
#import "MyStub1.h"

@interface MyPlayApi ()<MyStub1Delegate>
@end

@implementation MyPlayApi

static MyPlayApi* sharedData_ = nil;

+ (MyPlayApi*)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData_ = [[MyPlayApi alloc] init];
    });
    return sharedData_;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    return self;
}

- (void)registSHListener
{
    [MyStub1 sharedManager].delegate = self;
}

- (void)unRegistSHListener
{
    [MyStub1 sharedManager].delegate = nil;
}

- (void)startPlaying
{
    [[MyStub1 sharedManager] startPlay_Test];
}

- (void)applicationDidBecomeActive
{
    [[MyStub1 sharedManager] applicationDidBecomeActive];
}



#pragma mark - MyStub1Delegate

- (void)didChangeDProgress:(float)progress
{
    [self.delegate didChangeRunningProgress:progress];
}

- (void)didFailToPlaying
{
    [self.delegate didFailToPlaying];
}

#pragma mark - MyStub2Delegate



@end
