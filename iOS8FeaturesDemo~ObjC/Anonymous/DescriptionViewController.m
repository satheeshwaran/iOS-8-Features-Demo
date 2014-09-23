//
//  DescriptionViewController.m
//  iOS8FeaturesDemo
//
//  Created by Satheeshwaran on 9/23/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "DescriptionViewController.h"
#import "ShareViewController.h"

@interface DescriptionViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate=self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(![viewController isKindOfClass:[self class]])
    {
        [self.delegate descriptionCompleted:self.descriptionTextView.text];
    }
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
