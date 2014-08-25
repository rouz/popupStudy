

@interface KLCPopup : UIView


// Convenience method for creating popup with default values (mimics UIAlertView).
+ (KLCPopup*)popupWithContentView:(UIView*)contentView;

// Show popup with center layout. Animation determined by showType.
- (void)show;
// Dismiss popup. Uses dismissType if animated is YES.
- (void)dismiss;

// Overrides alpha value for dimmed background mask. default = 0.5
@property (nonatomic, assign) CGFloat dimmedMaskAlpha;

#pragma mark Subclassing

@property (nonatomic, strong, readonly) UIView *backgroundView;
@property (nonatomic, strong, readonly) UIView *containerView;
@property (nonatomic, assign, readonly) BOOL isBeingShown;
@property (nonatomic, assign, readonly) BOOL isShowing;
@property (nonatomic, assign, readonly) BOOL isBeingDismissed;

@end


#pragma mark - UIView Category

@interface UIView(KLCPopup)
+ (id)loadFromNib;
+ (id)loadFromIdiomNib;
@end

