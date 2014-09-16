//
//  ViewController.m
//  iOS8FeaturesDemo
//
//  Created by Satheeshwaran on 9/15/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSDictionary *demoViewControllers;
}

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS 8 Features";
    
    demoViewControllers = @{@"Interactive Notifications":@{@"identifier":@"localNotification",@"feature":@"Interactive Notifications",@"description":@"Helps you display notifications with quick respond buttons below the notification only- UIMutableUserNotificationAction, UIMutableUserNotificationCategory"},@"AlertViews and ActionSheets":@{@"identifier":@"alertController",@"feature":@"AlertViews and ActionSheets",@"description":@"Changes that have happened to UIAlertView and UIActionSheet- UIAlertController, UIAlertAction"}
                            };
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return demoViewControllers.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Get list of local notifications
    
    // Display notification info
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.textLabel setText:[[demoViewControllers objectForKey:[demoViewControllers.allKeys objectAtIndex:indexPath.row]]objectForKey:@"feature"]];
    [cell.detailTextLabel setText:[[demoViewControllers objectForKey:[demoViewControllers.allKeys objectAtIndex:indexPath.row]]objectForKey:@"description"]];
    [cell.detailTextLabel setNumberOfLines:0];
    NSLog(@"%@", [[demoViewControllers objectForKey:[demoViewControllers.allKeys objectAtIndex:indexPath.row]]objectForKey:@"feature"]);
    
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *target = [self.storyboard instantiateViewControllerWithIdentifier:[[demoViewControllers objectForKey:[demoViewControllers.allKeys objectAtIndex:indexPath.row]]objectForKey:@"identifier"]];
    [self.navigationController pushViewController:target animated:YES];
    
    //[self performSegueWithIdentifier:[[demoViewControllers objectForKey:[demoViewControllers.allKeys objectAtIndex:indexPath.row]]objectForKey:@"identifier"] sender:self];
}
@end
