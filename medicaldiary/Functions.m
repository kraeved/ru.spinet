//
//  Functions.m
//  medicaldiary
//
//  Created by Краевед Василий on 30.01.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "Functions.h"

@implementation Functions

+ (void) MyGradient:(UIView*)myview
{
UIColor *darkOp = [UIColor colorWithRed:175.0f/255.0f green:209.0f/255.0f blue:211.0f/255.0f alpha:1.0];
UIColor *lightOp = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0];
CAGradientLayer *gradient = [CAGradientLayer layer];
gradient.colors = [NSArray arrayWithObjects:(id)darkOp.CGColor,(id)lightOp.CGColor,nil];
gradient.frame = myview.bounds;
[myview.layer insertSublayer:gradient atIndex:0];
}

+ (void) MyGradientForView:(UIView*)myview
{
    UIColor *darkOp = [UIColor colorWithRed:175.0f/255.0f green:209.0f/255.0f blue:211.0f/255.0f alpha:1.0];
    UIColor *lightOp = [UIColor colorWithRed:217.0f/255.0f green:233.0f/255.0f blue:233.0f/255.0f alpha:1.0];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects:(id)darkOp.CGColor,(id)lightOp.CGColor,nil];
    gradient.frame = myview.bounds;
    [myview.layer insertSublayer:gradient atIndex:0];
}

+ (NSDictionary*) SendGetRequest:(NSString*) url
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"1");
    NSURLResponse *response;
    NSDictionary* cookie;
    NSData *GETReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    //NSString *responseString=[[NSString alloc] initWithData:GETReply encoding:NSUTF8StringEncoding];
    //NSLog(@"yyyyyy %@",responseString);
    if(GETReply)
    {
        cookie = [NSJSONSerialization JSONObjectWithData:GETReply options:nil error:nil];
        
    }
    return cookie;
}

+ (NSDictionary*) SendPostRequest:(NSString*) url POST:(NSData*)postData
{

    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"1");
    NSURLResponse *response;
    NSDictionary* cookie;
    NSData *GETReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    //NSString *responseString=[[NSString alloc] initWithData:GETReply encoding:NSUTF8StringEncoding];
    //NSLog(@"yyyyyy %@",responseString);
    if(GETReply)
    {
        cookie = [NSJSONSerialization JSONObjectWithData:GETReply options:nil error:nil];
        
    }
    //NSDictionary *cookie;
    return cookie;
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

@end
