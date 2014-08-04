
#import "MyStateStarting.h"
#import "MyPlayApi.h"


@implementation MyStateStarting

static MyStateStarting* sharedData_ = nil;

+ (MyStateStarting*)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData_ = [[MyStateStarting alloc] init];
    });
    return sharedData_;
}

- (void)startPlaying:(void (^)(bool success))completion
{
    NSLog(@"MyStateStarting.startPlaying");
    
    [[MyPlayApi sharedManager] startPlaying];
    
    completion(true);
}


@end
