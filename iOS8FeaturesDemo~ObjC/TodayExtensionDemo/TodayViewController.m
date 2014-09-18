//
//  TodayViewController.m
//  TodayExtensionDemo
//
//  Created by Satheeshwaran on 9/17/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UIImageView *weatherConditionImage;
@property (weak, nonatomic) IBOutlet UILabel *weatherConditionLabel;

@end

@implementation TodayViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateWeatherValues)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
    [self updateWeatherValues];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encoutered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (void)updateWeatherValues
{
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.ios8featuredemo"];
    
    
    if([sharedDefaults objectForKey:@"weatherIcon"] && [sharedDefaults objectForKey:@"weatherDescription"])
    {
        
    NSString *iconName = [sharedDefaults objectForKey:@"weatherIcon"];
    
    NSString *weatherDesc =[sharedDefaults objectForKey:@"weatherDescription"];
    
    [self.weatherConditionImage setImage:[UIImage imageNamed:[[self imageMap] objectForKey:iconName]]];
    self.weatherConditionLabel.text = weatherDesc;
    }
    
}
- (NSDictionary *)imageMap
{
   return  @{
                      @"01d" : @"weather-clear",
                      @"02d" : @"weather-few",
                      @"03d" : @"weather-few",
                      @"04d" : @"weather-broken",
                      @"09d" : @"weather-shower",
                      @"10d" : @"weather-rain",
                      @"11d" : @"weather-tstorm",
                      @"13d" : @"weather-snow",
                      @"50d" : @"weather-mist",
                      @"01n" : @"weather-moon",
                      @"02n" : @"weather-few-night",
                      @"03n" : @"weather-few-night",
                      @"04n" : @"weather-broken",
                      @"09n" : @"weather-shower",
                      @"10n" : @"weather-rain-night",
                      @"11n" : @"weather-tstorm",
                      @"13n" : @"weather-snow",
                      @"50n" : @"weather-mist",
                      };
}

@end
