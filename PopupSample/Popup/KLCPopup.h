
// KLCPopupShowType: Controls how the popup will be presented.
typedef NS_ENUM(NSInteger, KLCPopupShowType) {
	KLCPopupShowTypeNone = 0,
	KLCPopupShowTypeFadeIn,
};

// KLCPopupDismissType: Controls how the popup will be dismissed.
typedef NS_ENUM(NSInteger, KLCPopupDismissType) {
	KLCPopupDismissTypeNone = 0,
	KLCPopupDismissTypeFadeOut,
};

@interface KLCPopup : UIView

// This is the view that you want to appear in Popup.
// - Must provide contentView before or in willStartShowing.
// - Must set desired size of contentView before or in willStartShowing.
@property (nonatomic, strong) UIView* contentView;

// Animation transition for presenting contentView. default = shrink in
@property (nonatomic, assign) KLCPopupShowType showType;

// Animation transition for dismissing contentView. default = shrink out
@property (nonatomic, assign) KLCPopupDismissType dismissType;


// Overrides alpha value for dimmed background mask. default = 0.5
@property (nonatomic, assign) CGFloat dimmedMaskAlpha;


// Block gets called after show animation finishes. Be sure to use weak reference for popup within the block to avoid retain cycle.
@property (nonatomic, copy) void (^didFinishShowingCompletion)();

// Block gets called when dismiss animation starts. Be sure to use weak reference for popup within the block to avoid retain cycle.
@property (nonatomic, copy) void (^willStartDismissingCompletion)();

// Block gets called after dismiss animation finishes. Be sure to use weak reference for popup within the block to avoid retain cycle.
@property (nonatomic, copy) void (^didFinishDismissingCompletion)();

// Convenience method for creating popup with default values (mimics UIAlertView).
+ (KLCPopup*)popupWithContentView:(UIView*)contentView;

// Convenience method for creating popup with custom values.
+ (KLCPopup*)popupWithContentView:(UIView*)contentView
                         showType:(KLCPopupShowType)showType
                      dismissType:(KLCPopupDismissType)dismissType;

// Dismisses all the popups in the app. Use as a fail-safe for cleaning up.
+ (void)dismissAllPopups;

// Show popup with center layout. Animation determined by showType.
- (void)show;


// Show and then dismiss after duration. 0.0 or less will be considered infinity.
- (void)showWithDuration:(NSTimeInterval)duration;

// Dismiss popup. Uses dismissType if animated is YES.
- (void)dismiss:(BOOL)animated;


#pragma mark Subclassing
@property (nonatomic, strong, readonly) UIView *backgroundView;
@property (nonatomic, strong, readonly) UIView *containerView;
@property (nonatomic, assign, readonly) BOOL isBeingShown;
@property (nonatomic, assign, readonly) BOOL isShowing;
@property (nonatomic, assign, readonly) BOOL isBeingDismissed;

- (void)willStartShowing;
- (void)didFinishShowing;
- (void)willStartDismissing;
- (void)didFinishDismissing;

@end


#pragma mark - UIView Category
@interface UIView(KLCPopup)
- (void)forEachPopupDoBlock:(void (^)(KLCPopup* popup))block;
- (void)dismissPresentingPopup;
@end

