
#import "SHGridViewController.h"
#import "ProgressView.h"
#import "MyPlayManager.h"
#import "SHReusableGridViewCell2.h"

@interface SHGridViewController ()
@property (nonatomic, retain) NSArray *names;
@property (nonatomic, retain) AQGridView *gridView;
@property (nonatomic, retain) ReusableGridViewCell *gridViewCellContent;

@end


@implementation SHGridViewController

@synthesize gridView, gridViewCellContent, names;

- (void)viewDidLoad
{
	// http://www.chinesenames.org/chinese-name/girls.htm
	// http://www.chinesenames.org/chinese-name/boys.htm
	self.names = [NSArray arrayWithObjects:
				  @"Bao", 
				  @"Cai", 
				  @"Cheng", 
				  @"Feng", 
				  @"Hong", 
				  @"Hu", 
				  @"Hui", 
				  @"Jie", 
				  @"Juan", 
				  @"Liang", 
				  @"Peng", 
				  @"Qiao", 
				  @"Qing", 
				  @"Shan", 
				  @"Tian", 
				  @"Wen", 
				  @"Xue",
				  @"Yi", 
				  nil];
    
    [[MyPlayManager sharedManager] startPlaying:^(bool success) {
        NSLog(@"vc2.startPlaying.complete.success = %d", success);
    }];
    
	gridView.dataSource = self;
	[gridView reloadData];
}



- (NSUInteger)numberOfItemsInGridView:(AQGridView *)aGridView
{
    return [names count];
}

- (AQGridViewCell *)gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index
{

//    if ( index == 3 ) {
        AQGridViewCell *cell = [self createCell2];
        
        SHReusableGridViewCell2 *content = (SHReusableGridViewCell2 *)[cell.contentView viewWithTag:1];

        
        return cell;
//    } else {
//
//        AQGridViewCell *cell = [self createCell1];
//        
//        ReusableGridViewCell *content = (ReusableGridViewCell *)[cell.contentView viewWithTag:1];
//        NSString *name = [names objectAtIndex:index];
//        NSString *imageName = [[name lowercaseString] stringByAppendingString:@".gif"];
//        content.imageView.image = [UIImage imageNamed:imageName];
//        content.textLabel.text = name;
//        
//        return cell;
//    }

}

- (AQGridViewCell*)createCell1
{
    static NSString *CellIdentifier = @"ReusableGridViewCell";
    
    AQGridViewCell *cell = (AQGridViewCell *)[gridView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		[[NSBundle mainBundle] loadNibNamed:@"ReusableGridViewCell" owner:self options:nil];
        
		cell = [[AQGridViewCell alloc] initWithFrame:gridViewCellContent.frame
                                     reuseIdentifier:CellIdentifier];
		[cell.contentView addSubview:gridViewCellContent];
		
		cell.selectionStyle = AQGridViewCellSelectionStyleNone;
	}
    return cell;
}

- (AQGridViewCell*)createCell2
{
    static NSString *CellIdentifier2 = @"SHReusableGridViewCell2";
    
    AQGridViewCell *cell = (AQGridViewCell *)[gridView dequeueReusableCellWithIdentifier:CellIdentifier2];
	if (cell == nil)
	{
        UINib *nib = [UINib nibWithNibName:@"SHReusableGridViewCell2" bundle:nil];
        SHReusableGridViewCell2 *content= [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
        
		cell = [[AQGridViewCell alloc] initWithFrame:content.frame
                                     reuseIdentifier:CellIdentifier2];
		[cell.contentView addSubview:content];
		
		cell.selectionStyle = AQGridViewCellSelectionStyleNone;
	}
    return cell;
}

- (CGSize)portraitGridCellSizeForGridView:(AQGridView *)aGridView
{
	[[NSBundle mainBundle] loadNibNamed:@"ReusableGridViewCell" owner:self options:nil];
	return gridViewCellContent.frame.size;
}


#pragma mark - SHPlay



@end
