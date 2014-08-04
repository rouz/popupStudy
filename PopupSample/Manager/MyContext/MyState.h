
#import <Foundation/Foundation.h>
#import "MyModelType.h"


@interface MyState : NSObject


- (void)setupPlayer:(void (^)(bool success))completion;
- (void)startPlaying:(void (^)(bool success))completion;
- (void)checkPlayState:(void (^)(bool isCanceled))completion;
- (void)cancelPlaying;

@end
