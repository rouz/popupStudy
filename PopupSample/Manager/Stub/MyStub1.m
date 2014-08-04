
#import "MyStub1.h"
#import "NSTimer+BlocksSupport.h"


@interface MyStub1 ()
@property (strong, nonatomic) NSTimer *progressSimulateTimer;
@property float progress;
@end

@implementation MyStub1

static MyStub1* sharedData_ = nil;

+ (MyStub1*)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData_ = [MyStub1 new];
    });
    return sharedData_;
}

- (void)startPlay_Test
{
    __weak MyStub1 *wealSelf = self;
    
    float step = 0.1/140;
    self.progressSimulateTimer = [NSTimer sh_scheduledTimerWithTimeInterval:0.1 block:^{
        if(wealSelf.progress > 0.9) {
            [wealSelf.progressSimulateTimer invalidate];
            wealSelf.progressSimulateTimer = nil;
            return;
        }
        [wealSelf.delegate didChangeDProgress:wealSelf.progress];
        wealSelf.progress += step;
    } repeats:YES];

}

- (void)applicationDidBecomeActive
{
    __weak MyStub1 *wealSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(3 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [wealSelf.delegate didFailToPlaying];
                   });
}

- (void)cancelPlay_Test
{
    if (self.progressSimulateTimer) {
        [self.progressSimulateTimer invalidate];
        self.progressSimulateTimer = nil;
    }
    self.progress = 0;
}


- (void)dealloc
{
    
}


@end
