//
//  AddNewLocalNotificationViewController.m
//  iOS8FeaturesDemo
//
//  Created by Satheeshwaran on 9/15/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "AddNewLocalNotificationViewController.h"

@interface AddNewLocalNotificationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *notificationTitleField;
@property (weak, nonatomic) IBOutlet UIDatePicker *notificationFireDatePicker;

@end

@implementation AddNewLocalNotificationViewController

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
- (IBAction)saveNotification:(id)sender {
    
    [self scheduleNotificationOn:self.notificationFireDatePicker.date text:self.notificationTitleField.text action:self.notificationTitleField.text sound:nil launchImage:nil andInfo:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (UILocalNotification*) scheduleNotificationOn:(NSDate*) fireDate
                                           text:(NSString*) alertText
                                         action:(NSString*) alertAction
                                          sound:(NSString*) soundfileName
                                    launchImage:(NSString*) launchImage
                                        andInfo:(NSDictionary*) userInfo
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = fireDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotification.alertBody = alertText;
    localNotification.alertAction = alertAction;
    
    if(soundfileName == nil)
    {
        localNotification.soundName = UILocalNotificationDefaultSoundName;
    }
    else
    {
        localNotification.soundName = soundfileName;
    }
    
    localNotification.alertLaunchImage = launchImage;
    NSInteger badgeCount=[[[UIApplication sharedApplication] scheduledLocalNotifications] count];
    localNotification.applicationIconBadgeNumber = badgeCount;
    localNotification.userInfo = userInfo;
    localNotification.category = @"INVITE_CATEGORY";
    
    // Schedule it with the app
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    return localNotification;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
