
#import "SHViewController.h"
#import "KLCPopup.h"
#import "PopupMessageTwoButton.h"
#import "SHViewController2.h"

@interface SHViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelTest;

@end

@implementation SHViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"sakai");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender {
    
    PopupMessageTwoButton *profileView = [PopupMessageTwoButton loadFromNib];
    KLCPopup* popup = [KLCPopup popupWithContentView:profileView];
    
    __weak KLCPopup *weakPopup = popup;
    __weak SHViewController *weakSelf = self;
    
    profileView.didFinishShowingCompletion = ^(BOOL isCanceled){

        [weakPopup dismiss];
        
        if (isCanceled) {
            weakSelf.labelTest.text = @"いいえが押されました";
        } else {
            weakSelf.labelTest.text = @"はいが押されました";
        }

    };
    [popup show];
}


@end
