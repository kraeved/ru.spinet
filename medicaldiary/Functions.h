//
//  Functions.h
//  medicaldiary
//
//  Created by Краевед Василий on 30.01.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Functions : NSObject
+ (void) MyGradient:(UIView*)myview;
+ (void) MyGradientForView:(UIView*)myview;
+ (NSDictionary*) SendGetRequest:(NSString*) url;
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
@end
