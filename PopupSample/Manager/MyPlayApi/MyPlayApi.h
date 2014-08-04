
#import <Foundation/Foundation.h>
#import "MyModelType.h"

@protocol MyPlayApiDelegate
- (void)didChangeRunningProgress:(float)progress;
- (void)didFailToPlaying;
@end


@interface MyPlayApi : NSObject

+ (MyPlayApi*)sharedManager;

@property (nonatomic,weak) id<MyPlayApiDelegate> delegate;

- (void)startPlaying;

- (void)registSHListener;
- (void)unRegistSHListener;

- (void)applicationDidBecomeActive;

@end
