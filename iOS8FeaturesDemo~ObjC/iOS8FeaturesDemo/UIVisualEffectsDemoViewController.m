//
//  UIVisualEffectsDemoViewController.m
//  iOS8FeaturesDemo
//
//  Created by Satheeshwaran on 9/16/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "UIVisualEffectsDemoViewController.h"

@interface UIVisualEffectsDemoViewController ()
{
    UIBlurEffect *visualEffect;
    UIVisualEffectView *visualEffectView;
}
@property (weak, nonatomic) IBOutlet UIImageView *effectView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *effectSegment;

@end

@implementation UIVisualEffectsDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)effectChanged:(id)sender {
    
    [visualEffectView removeFromSuperview];
    visualEffectView = nil;
    visualEffect = nil;
    
    if(self.effectSegment.selectedSegmentIndex==0)
    {
        visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    }
    
    else if(self.effectSegment.selectedSegmentIndex == 1)
    {
        visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    }
    else if(self.effectSegment.selectedSegmentIndex == 2)
    {
        visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    }
    
    visualEffectView = [[UIVisualEffectView alloc]initWithEffect:visualEffect];
    
    visualEffectView.frame=self.effectView.frame;
    
    [self.view addSubview:visualEffectView];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
