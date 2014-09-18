//
//  AlertViewAndActionSheetViewController.m
//  iOS8FeaturesDemo
//
//  Created by Satheeshwaran on 9/16/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "AlertViewAndActionSheetViewController.h"

@interface AlertViewAndActionSheetViewController ()

@end

@implementation AlertViewAndActionSheetViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    self.title = @"Alert Controller";

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showAlertViewDeprecated:(id)sender {
    UIAlertView *deprecatedAlertView = [[UIAlertView alloc]initWithTitle:@"Deprecated Alert view" message:@"Oops it is deprecated" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [deprecatedAlertView show];
}
- (IBAction)showAlertControlleralertView:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"UIAlertController" message:@"Say Hi to the new way of displaying alerts" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"You clicked OK");
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];

}
- (IBAction)showAlertControllerActionSheet:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"UIAlertController" message:@"Say Hi to the new way of displaying action sheets" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *item1Action = [UIAlertAction actionWithTitle:@"Item 1" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"You clicked Item1");
        
    }];
    
    
    UIAlertAction *item2Action = [UIAlertAction actionWithTitle:@"Item 2" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"You clicked Item2");
        
    }];
    
    
    UIAlertAction *item3Action = [UIAlertAction actionWithTitle:@"Item 3" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"You clicked Item3");
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }];
    
    [alertController addAction:item1Action];
    [alertController addAction:item2Action];
    [alertController addAction:item3Action];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];}


- (IBAction)showPopOver:(id)sender {
    
    UIViewController *contentController = [[UIViewController alloc]init];
    contentController.view.backgroundColor = [UIColor redColor];
    
    contentController.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popPC =
    contentController.popoverPresentationController;
    popPC.permittedArrowDirections = UIPopoverArrowDirectionAny;
    [self presentViewController:contentController animated:YES completion:nil];
}

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
