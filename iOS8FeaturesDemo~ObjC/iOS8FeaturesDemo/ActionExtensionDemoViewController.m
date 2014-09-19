//
//  ActionExtensionDemoViewController.m
//  iOS8FeaturesDemo
//
//  Created by Satheeshwaran on 9/19/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "ActionExtensionDemoViewController.h"

@interface ActionExtensionDemoViewController ()

@property (weak, nonatomic) IBOutlet UITextView *sourceTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *sourceLanguagePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *targetLanguagePicker;
@property (nonatomic, strong) NSMutableArray *languages;
@end

@implementation ActionExtensionDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.languages = [[NSMutableArray alloc]initWithArray:[NSLocale preferredLanguages]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)translatePressed:(id)sender {
    
    NSError *jsonWritingError;
    
    NSData *activtityPostData = [NSJSONSerialization dataWithJSONObject:@{@"sourceText":self.sourceTextView.text,@"sourceLanguage":[self.languages objectAtIndex:[self.sourceLanguagePicker selectedRowInComponent:0]],@"targetLanguage":[self.languages objectAtIndex:[self.targetLanguagePicker selectedRowInComponent:0]]} options:NSJSONWritingPrettyPrinted error:&jsonWritingError];
    
    UIActivityViewController *acitvityVC = [[UIActivityViewController alloc]initWithActivityItems:@[[[NSString alloc]initWithData:activtityPostData encoding:NSUTF8StringEncoding]] applicationActivities:nil];
    
    [acitvityVC setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError){
        
        NSLog(@"returned Items: %@",returnedItems);
        
        
    
    }];

    [self presentViewController:acitvityVC animated:YES completion:^{
        
    }];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
return  self.languages.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@-%@",[self.languages objectAtIndex:row],[[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:[self.languages objectAtIndex:row]]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
