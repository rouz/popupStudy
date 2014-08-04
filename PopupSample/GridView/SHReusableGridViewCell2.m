//

#import "SHReusableGridViewCell2.h"
#import "MyPlayManager.h"

@implementation SHReusableGridViewCell2

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}


- (void)setup
{

    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    self.numberFormatter = numberFormatter;
    numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
    numberFormatter.locale = NSLocale.currentLocale;
    
    self.progressView.layer.cornerRadius = 6;
    self.progressView.layer.masksToBounds = YES;
    self.progressView.layer.shouldRasterize = YES;   // パフォーマンス対策
    self.progressView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self registerForKVO];
}

- (void)dealloc
{
    [self unregisterFromKVO];
}

- (void)registerForKVO {
	[[MyPlayManager sharedManager] addObserver:self forKeyPath:@"state"
                                       options:NSKeyValueObservingOptionNew
                                       context:nil];
	[[MyPlayManager sharedManager] addObserver:self forKeyPath:@"progress"
                                       options:NSKeyValueObservingOptionNew
                                       context:nil];
}

- (void)unregisterFromKVO {
    
	[[MyPlayManager sharedManager] removeObserver:self forKeyPath:@"state"];
	[[MyPlayManager sharedManager] removeObserver:self forKeyPath:@"progress"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    
    NSLog(@"vc1.observeValueForKeyPath");
    
	if ([keyPath isEqualToString:@"state"]) {
        NSLog(@"vc1.observeValueForKeyPath.state");
        
	} else if([keyPath isEqualToString:@"progress"]) {
        NSLog(@"vc1.observeValueForKeyPath.progress = %f", [MyPlayManager sharedManager].progress);
        
        __weak SHReusableGridViewCell2 *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            float prog = [MyPlayManager sharedManager].progress;
            [weakSelf.progressView setProgress:prog animated:YES];
            
            weakSelf.progressLabel.text = [self.numberFormatter stringFromNumber:@(prog)];
        });
    }
}


@end
