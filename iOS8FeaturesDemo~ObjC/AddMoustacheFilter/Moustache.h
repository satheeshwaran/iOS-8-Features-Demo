//
//  Moustache.h
//  iOS8FeaturesDemo
//
//  Created by Satheeshwaran on 9/26/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Moustache : NSObject

@property (nonatomic,assign) CGRect frame;
@property (nonatomic,assign) CGFloat angle;

-(instancetype)initWithFrame:(CGRect)frame andAngle:(CGFloat)angle;

@end
