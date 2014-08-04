
#import <Foundation/Foundation.h>

@protocol MyStub1Delegate
- (void)didChangeDProgress:(float)progress;
- (void)didFailToPlaying;
@end


@interface MyStub1 : NSObject

+ (MyStub1*)sharedManager;

@property (nonatomic,weak) id<MyStub1Delegate> delegate;

- (void)startPlay_Test;
- (void)cancelPlay_Test;
- (void)applicationDidBecomeActive;

@end
