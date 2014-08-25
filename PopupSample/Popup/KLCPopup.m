
#import "KLCPopup.h"


@interface KLCPopup () {
    UIView* _backgroundView;
    UIView* _containerView;
    
    // state flags
    BOOL _isBeingShown;
    BOOL _isShowing;
    BOOL _isBeingDismissed;
}


// This is the view that you want to appear in Popup.
// - Must provide contentView before or in willStartShowing.
// - Must set desired size of contentView before or in willStartShowing.
@property (nonatomic, strong) UIView* contentView;

@end


@implementation KLCPopup


- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}


- (id)init {
    return [self initWithFrame:[self topView].bounds];
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
		self.alpha = 0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.autoresizesSubviews = YES;
        
        self.dimmedMaskAlpha = 0.5;
        
        _isBeingShown = NO;
        _isShowing = NO;
        _isBeingDismissed = NO;
        
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor clearColor];
        _backgroundView.userInteractionEnabled = NO;
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundView.frame = self.bounds;
        
        _containerView = [[UIView alloc] init];
        _containerView.autoresizesSubviews = NO;
        _containerView.userInteractionEnabled = YES;
        _containerView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_backgroundView];
        [self addSubview:_containerView];
        
    }
    return self;
}


#pragma mark - UIView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView* hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        
        // If no mask, then return nil so touch passes through to underlying views.
        return hitView;
        
    } else {
        
        return hitView;
    }
}


#pragma mark - Class Public

+ (KLCPopup*)popupWithContentView:(UIView*)contentView
{
    KLCPopup* popup = [[[self class] alloc] init];
    popup.contentView = contentView;
    return popup;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


#pragma mark - Public

- (void)show {
    
    // If popup can be shown
    if (!_isBeingShown && !_isShowing && !_isBeingDismissed) {
        _isBeingShown = YES;
        _isShowing = NO;
        _isBeingDismissed = NO;
        
        
        dispatch_async( dispatch_get_main_queue(), ^{
            
            // Prepare by adding to the top window.
            if(!self.superview){
                UIViewController *vc = [self topMostController];
                [vc.view addSubview:self];
            }
            
            // Before we calculate layout for containerView, make sure we are transformed for current orientation.
            //  [self updateForInterfaceOrientation];
            
            // Make sure we're not hidden
            self.hidden = NO;
            self.alpha = 1.0;
            
            // Setup background view
            _backgroundView.alpha = 0.0;
            _backgroundView.backgroundColor = [UIColor colorWithRed:(0.0/255.0f) green:(0.0/255.0f) blue:(0.0/255.0f) alpha:self.dimmedMaskAlpha];
            
            _backgroundView.alpha = 1.0;


            // Add contentView to container
            if (self.contentView.superview != _containerView) {
                [_containerView addSubview:self.contentView];
            }
            
            // Re-layout (this is needed if the contentView is using autoLayout)
            [self.contentView layoutIfNeeded];
            
            // Size container to match contentView
            CGRect containerFrame = _containerView.frame;
            containerFrame.size = self.contentView.frame.size;
            _containerView.frame = containerFrame;
            // Position contentView to fill it
            CGRect contentViewFrame = self.contentView.frame;
            contentViewFrame.origin = CGPointZero;
            self.contentView.frame = contentViewFrame;
            
            // Determine final position and necessary autoresizingMask for container.
            CGRect finalContainerFrame = containerFrame;
            UIViewAutoresizing containerAutoresizingMask = UIViewAutoresizingNone;
            
            // Use explicit center coordinates if provided.
            finalContainerFrame.origin.x = floorf((CGRectGetWidth(self.bounds) - CGRectGetWidth(containerFrame))/2.0);
            containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            
            finalContainerFrame.origin.y = floorf((CGRectGetHeight(self.bounds) - CGRectGetHeight(containerFrame))/2.0);
            containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            
            _containerView.autoresizingMask = containerAutoresizingMask;
            
            // Animate content if needed
            self.containerView.alpha = 1.0;
            self.containerView.transform = CGAffineTransformIdentity;
            self.containerView.frame = finalContainerFrame;
            
            _isBeingShown = NO;
            _isShowing = YES;
            _isBeingDismissed = NO;
            
        });
    }
}


- (void)dismiss {
    
    if (_isShowing && !_isBeingDismissed) {
        _isBeingShown = NO;
        _isShowing = NO;
        _isBeingDismissed = YES;
        
        // cancel previous dismiss requests (i.e. the dismiss after duration call).
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            
            _backgroundView.alpha = 0.0;
            
            // Animate content if needed
            self.containerView.alpha = 0.0;
            [self removeFromSuperview];
            
            _isBeingShown = NO;
            _isShowing = NO;
            _isBeingDismissed = NO;
            
        });
    }
}


#pragma mark - Private

- (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

-(UIView*)topView {
    UIViewController *recentView = [self topMostController];
    
    while (recentView.parentViewController != nil) {
        recentView = recentView.parentViewController;
    }
    return recentView.view;
}

@end



#pragma mark - Categories

@implementation UIView(KLCPopup)

+ (id)loadFromNib
{
    NSString *nibName = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
}

+ (id)loadFromIdiomNib
{
    NSString *nibName = NSStringFromClass([self class]);
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibName = [nibName stringByAppendingString:@"_iPhone"];
    } else {
        nibName = [nibName stringByAppendingString:@"_iPad"];
    }
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
}

@end



