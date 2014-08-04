
#import "MyState.h"
#import "SIAlertView.h"


@interface MyState ()
@end


@implementation MyState


- (void)setupPlayer:(void (^)(bool success))completion
{
    completion(false);
}

- (void)startPlaying:(void (^)(bool success))completion
{
    completion(false);
}

- (void)checkPlayState:(void (^)(bool isCanceled))completion
{
    completion(true);
}

- (void)cancelPlaying
{
    
}


#pragma mark - Private

- (void)showPopupAsync:(NSString*)message
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


@end
