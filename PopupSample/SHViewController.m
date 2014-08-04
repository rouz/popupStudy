
#import "SHViewController.h"
#import "KLCPopup.h"
#import "UIView+WM.h"
#import "PopupMessageTwoButton.h"
#import "SHViewController2.h"
#import "SHGridViewController.h"

@interface SHViewController ()

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
    
    SHGridViewController *v = [[SHGridViewController alloc] initWithNibName:@"SHGridViewController" bundle:nil];
    [self.navigationController pushViewController:v animated:YES];
    /*
    PopupMessageTwoButton *profileView = [PopupMessageTwoButton loadFromNib];
    KLCPopup* popup = [KLCPopup popupWithContentView:profileView];
    __weak KLCPopup *weakPopup = popup;
    profileView.didFinishShowingCompletion = ^(BOOL isCanceled){
        [weakPopup dismiss:YES];
    };
    [popup show];*/
}


@end
