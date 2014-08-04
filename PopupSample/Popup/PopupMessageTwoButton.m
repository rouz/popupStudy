
#import "PopupMessageTwoButton.h"

@implementation PopupMessageTwoButton

- (IBAction)buttonTapped:(id)sender {
    if (self.didFinishShowingCompletion) {
        self.didFinishShowingCompletion(NO);
    }
}


@end
