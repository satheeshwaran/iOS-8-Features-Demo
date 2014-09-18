//
//  ToucIDDemoViewController.m
//  iOS8FeaturesDemo
//
//  Created by Satheeshwaran on 9/17/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "ToucIDDemoViewController.h"

@interface ToucIDDemoViewController ()

@end

@implementation ToucIDDemoViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)authenticateMEPressed:(id)sender {
    
    /* LAContext *myContext = [[LAContext alloc] init];
     NSError *authError = nil;
     NSString *myLocalizedReasonString = @"Authenticate using your finger";
     if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
     
     [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
     localizedReason:myLocalizedReasonString
     reply:^(BOOL succes, NSError *error) {
     
     if (succes) {
     
     NSLog(@"User is authenticated successfully");
     } else {
     
     switch (error.code) {
     case LAErrorAuthenticationFailed:
     NSLog(@"Authentication Failed");
     break;
     
     case LAErrorUserCancel:
     NSLog(@"User pressed Cancel button");
     break;
     
     case LAErrorUserFallback:
     NSLog(@"User pressed \"Enter Password\"");
     break;
     
     default:
     NSLog(@"Touch ID is not configured");
     break;
     }
     
     NSLog(@"Authentication Fails");
     }
     }];
     } else {
     NSLog(@"Can not evaluate Touch ID");
     
     }
*/

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
