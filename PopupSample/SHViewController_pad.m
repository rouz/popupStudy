
#import "SHViewController_pad.h"
#import "KLCPopup.h"
#import "PopupMessageTwoButton.h"


@interface SHViewController_pad ()
@property (weak, nonatomic) IBOutlet UILabel *labelTest;

@end

@implementation SHViewController_pad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    //interfaceOriaentationで識別子回転する方向であればYESを返す
    return YES;
}

- (IBAction)buttonTapped:(id)sender {
    
    PopupMessageTwoButton *profileView = [PopupMessageTwoButton loadFromNib];
    KLCPopup* popup = [KLCPopup popupWithContentView:profileView];
    __weak KLCPopup *weakPopup = popup;
    __weak SHViewController_pad *weakSelf = self;
    profileView.didFinishShowingCompletion = ^(BOOL isCanceled){
        if (isCanceled) {
            weakSelf.labelTest.text = @"いいえが押されました";
        } else {
            weakSelf.labelTest.text = @"はいが押されました";
        }
        [weakPopup dismiss];
    };
    [popup show];
    
}

@end
