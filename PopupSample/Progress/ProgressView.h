

#import <UIKit/UIKit.h>


@interface ProgressView : UIView <UIAppearance>

@property (strong, nonatomic) UIColor *trackTintColor;
@property (strong, nonatomic) UIColor *progressTintColor;


@property (nonatomic,readonly) float progress;

- (void)setProgress:(float)progress animated:(BOOL)animated;


@end
