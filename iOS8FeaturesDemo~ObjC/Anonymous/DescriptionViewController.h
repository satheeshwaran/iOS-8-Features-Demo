//
//  DescriptionViewController.h
//  iOS8FeaturesDemo
//
//  Created by Satheeshwaran on 9/23/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DescriptionDelegate <NSObject>
- (void)descriptionCompleted:(NSString *)text;
@end

@interface DescriptionViewController : UIViewController
@property (nonatomic,weak)id<DescriptionDelegate> delegate;
@end
