
#import "MyPlayManager.h"
#import "MyContext.h"
#import "MyPlayApi.h"
#import "SIAlertView.h"

@interface MyPlayManager ()<MyPlayApiDelegate,MyContextDelegate>
@property (assign, readwrite, nonatomic) float progress;
@property (assign, readwrite, nonatomic) MyModelState state;
@end


@implementation MyPlayManager

static MyPlayManager* sharedData_ = nil;

+ (MyPlayManager*)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData_ = [[MyPlayManager alloc] init];
    });
    return sharedData_;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [MyPlayApi sharedManager].delegate = self;
    
    return self;
}


- (bool)setupPlayer:(void (^)(bool success))completion
{
    if (!completion) {
        return false;
    }
    
    if (![[MyContext sharedManager] canSetupPlayer]) {
        completion(false);
        return false;
    }
    
    [[MyContext sharedManager] setupPlayer:completion];
    
    return true;
}

- (bool)startPlaying:(void (^)(bool success))completion
{
    if (!completion) {
        return false;
    }
    
    if (![[MyContext sharedManager] canStartPlayer]) {
        completion(false);
        return false;
    }
    
    [[MyContext sharedManager] startPlaying:completion];
    return true;
}

- (bool)checkPlayState:(void (^)(bool isCanceled))completion
{
    if (!completion) {
        return false;
    }
    
    [[MyContext sharedManager] checkPlayState:completion];
    return true;
}

- (void)cancelPlaying
{
    [[MyContext sharedManager] cancelPlaying];
}


#pragma mark - Private

- (void)showErrorMessage:(NSString*)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"test2"
                                                         andMessage:message];
        [alertView addButtonWithTitle:@"OK"
                                 type:SIAlertViewButtonTypeDefault
                              handler:nil];
        
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
    });
}


#pragma mark - MyWatcherDelegate,MyContextDelegate

- (void)didChangePlayState:(MyModelState)state
{
    self.state = state;
}

- (void)didChangeRunningProgress:(float)progress
{
    self.progress = progress;
}

- (void)didFailToPlaying
{
    [self showErrorMessage:@"エラーが発生しました"];
    
    [[MyContext sharedManager] resetState];
    
}

#pragma mark - Other

- (void)applicationDidBecomeActive
{
    [[MyPlayApi sharedManager] applicationDidBecomeActive];
}


@end
