//
//  Moustache.m
//  iOS8FeaturesDemo
//
//  Created by Satheeshwaran on 9/26/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "Moustache.h"
#import <UIKit/UIGeometry.h>

@implementation Moustache

-(instancetype)initWithFrame:(CGRect)frame andAngle:(CGFloat)angle
{
    self = [super init];
    if (self) {
        
        self.frame = frame;
        self.angle = angle;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeCGRect:self.frame forKey:@"rect"];
    [coder encodeFloat:self.angle forKey:@"angle"];
}
@end
