
#import <Foundation/Foundation.h>
#import "MyModelType.h"

@protocol MyContextDelegate
- (void)didChangePlayState:(MyModelState)state;
@end

@interface MyContext : NSObject

+ (MyContext*)sharedManager;

@property (nonatomic,weak) id<MyContextDelegate> delegate;

- (bool)canSetupPlayer;
- (void)setupPlayer:(void (^)(bool success))completion;

- (bool)canStartPlayer;
- (void)startPlaying:(void (^)(bool success))completion;

- (void)checkPlayState:(void (^)(bool isCanceled))completion;
- (void)cancelPlaying;

- (void)resetState;

@end
