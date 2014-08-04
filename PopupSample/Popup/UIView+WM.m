
#import "UIView+WM.h"

@implementation UIView (WM)

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
