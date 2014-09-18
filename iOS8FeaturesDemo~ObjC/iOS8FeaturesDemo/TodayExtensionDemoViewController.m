//
//  TodayExtensionDemoViewController.m
//  iOS8FeaturesDemo
//
//  Created by Satheeshwaran on 9/17/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "TodayExtensionDemoViewController.h"

@interface TodayExtensionDemoViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingWeather;
@property (weak, nonatomic) IBOutlet UILabel *weatherConditionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherConditionImage;

@end

@implementation TodayExtensionDemoViewController

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
    
    self.title = @"Weather Update";
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)refereshWeatherPressed:(id)sender {
    
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/find?q=chennai&type=like&mode=json&units=metric"]];
    
    [self.loadingWeather startAnimating];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self.loadingWeather stopAnimating];

        NSError *err;
        
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
        
        NSString *iconName = [[[[[responseDict objectForKey:@"list"] objectAtIndex:0] objectForKey:@"weather"] objectAtIndex:0]objectForKey:@"icon"];
        
        NSString *weatherDesc =[NSString stringWithFormat:@"%@°C %@",[[[[responseDict objectForKey:@"list"] objectAtIndex:0] objectForKey:@"main"]  objectForKey:@"temp"],[[[[[responseDict objectForKey:@"list"] objectAtIndex:0] objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"description"]];
        
        [self.weatherConditionImage setImage:[UIImage imageNamed:[[self imageMap] objectForKey:iconName]]];
        self.weatherConditionLabel.text = weatherDesc;
        
        NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.ios8featuredemo"];
        [sharedDefaults setObject:iconName forKey:@"weatherIcon"];
        [sharedDefaults setObject:weatherDesc forKey:@"weatherDescription"];
        [sharedDefaults synchronize];

    }];

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
