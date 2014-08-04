

#import <UIKit/UIKit.h>

@interface PopupMessageTwoButton : UIView

@property (nonatomic, copy) void (^didFinishShowingCompletion)(BOOL isCanceled);


@end
