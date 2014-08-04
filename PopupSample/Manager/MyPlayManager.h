
#import <Foundation/Foundation.h>
#import "MyModelType.h"


@interface MyPlayManager : NSObject

+ (MyPlayManager*)sharedManager;

@property (assign, readonly, nonatomic) float progress;
@property (assign, readonly, nonatomic) MyModelState state;

- (bool)setupPlayer:(void (^)(bool success))completion;
- (bool)startPlaying:(void (^)(bool success))completion;
- (bool)checkPlayState:(void (^)(bool isCanceled))completion;
- (void)cancelPlaying;

- (void)applicationDidBecomeActive;

@end
