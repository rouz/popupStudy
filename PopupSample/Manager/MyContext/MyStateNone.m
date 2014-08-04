
#import "MyStateNone.h"
#import "SIAlertView.h"

@implementation MyStateNone

static MyStateNone* sharedData_ = nil;

+ (MyStateNone*)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData_ = [[MyStateNone alloc] init];
    });
    return sharedData_;
}

- (void)setupPlayer:(void (^)(bool success))completion
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"test"
                                                     andMessage:@"準備しますか？"];
    
    __weak MyStateNone *weakSelf = self;
    [alertView addButtonWithTitle:@"はい"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alert) {
                              [weakSelf prepairForPlayer:completion];
                          }];
    
    [alertView addButtonWithTitle:@"キャンセル"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alert) {
                              completion(false);
                          }];
    
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    [alertView show];
}

- (void)prepairForPlayer:(void (^)(bool success))completion
{
    completion(true);
}


@end
