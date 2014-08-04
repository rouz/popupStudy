
#import "ProgressView.h"

#import <QuartzCore/QuartzCore.h>


@interface ProgressView ()

@property (nonatomic, readonly) CAGradientLayer* gradientLayer;
@property (nonatomic,readwrite) float progress;

@end


@implementation ProgressView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer*)self.layer;
}

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    
    [self commonInit];
    
    return self;
}


- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    self.trackTintColor = [UIColor clearColor];
    self.progressTintColor = [UIColor redColor];
    self.gradientLayer.locations = @[@0.f, @0.f];
    self.gradientLayer.startPoint = CGPointMake(0,0.5);
    self.gradientLayer.endPoint = CGPointMake(1,0.5);
    self.progress = 0.f;
}


- (void)didMoveToWindow
{
    self.gradientLayer.contentsScale = [UIScreen mainScreen].scale;
}


#pragma mark - Setters & Getters


- (void)updateGradientColors
{
    self.gradientLayer.colors = [[NSArray alloc] initWithObjects:
                                 (id)self.progressTintColor.CGColor,
                                 (id)self.trackTintColor.CGColor, nil];
    [self.gradientLayer setNeedsDisplay];
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    if (trackTintColor != _trackTintColor) {
        _trackTintColor = trackTintColor;
        [self updateGradientColors];
    }
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    if (progressTintColor != _progressTintColor) {
        _progressTintColor = progressTintColor;
        [self updateGradientColors];
    }
}


#pragma mark - Progress

- (NSArray *)gradientLocations:(CGFloat)progress
{
    return @[[NSNumber numberWithFloat:progress], [NSNumber numberWithFloat:progress]];
}


- (void)setProgress:(float)progress animated:(BOOL)animated
{
    CGFloat pinnedProgress = MIN(MAX(progress, 0.f), 1.f);
    NSArray* newLocations = [self gradientLocations:pinnedProgress];
    
    if (animated) {
        NSTimeInterval duration = 0.5;
        [UIView animateWithDuration:duration animations:^{
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.duration = duration;
            animation.delegate = self;
            animation.fromValue = self.gradientLayer.locations;
            animation.toValue = newLocations;
            [self.gradientLayer addAnimation:animation forKey:@"animateLocations"];
        }];
    }
    else {
        [self.gradientLayer setNeedsDisplay];
    }
    
    self.gradientLayer.locations = newLocations;
    _progress = pinnedProgress;
}

- (void)minus:(CGFloat)delta animated:(BOOL)animated
{
    [self setProgress:(self.progress - delta) animated:animated];
}

- (void)add:(CGFloat)delta animated:(BOOL)animated
{
    [self setProgress:(self.progress + delta) animated:animated];
}


@end
