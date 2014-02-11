//
//  Draw2D.m
//  medicaldiary
//
//  Created by Краевед Василий on 04.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "Draw2D.h"
#import "Functions.h"

@implementation Draw2D

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    //получение легенды графика
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *session = [userDefaults objectForKey:@"session"];
    NSString* myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=grafik_data&session=%@", session];
    /*if ([start length]) {
        myurl = [NSString stringWithFormat:@"%@&start_date=%@",myurl, start];
    }
    if ([end length]) {
        myurl = [NSString stringWithFormat:@"%@&end_date=%@",myurl, end];
    }*/
    //отступ слева
    CGFloat lof = 0.2f;//15.0f;
    //отступ снизу
    CGFloat dof = 0.2f;//15.0f;
    //ширина view
    CGFloat wid = 280.0f;
    //высота view
    CGFloat hei = 240.0f;
    
    //расстояние между строками
    CGFloat middle = (hei-dof)/10;
    
    NSDictionary* cookie = [Functions SendGetRequest:myurl];
     if(cookie)
     {
         NSString *result = cookie[@"result"];
         NSLog(@"result: %@", result);
         if(result.boolValue)
         {
             //рисование осей
             NSArray* dates = [cookie objectForKey:@"dates"];
             CGContextSetLineWidth(context, 0.2f);
             CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
             CGFloat components[] = {82.0f/255.0f, 145.0f/255.0f, 149.0f/255.0f, 1.0f};
             CGColorRef color = CGColorCreate(colorspace, components);
             CGContextSetStrokeColorWithColor(context, color);
             CGContextSetLineWidth(context, 1.5f);
             CGContextMoveToPoint(context, lof, 10*middle);
             CGContextAddLineToPoint(context, wid, 10*middle);
             CGContextStrokePath(context);
             CGContextSetLineWidth(context, 0.2f);
             //горизонтальные
             for(int i=0;i<10;i++)
             {
                 CGContextMoveToPoint(context, lof, i*middle);
                 CGContextAddLineToPoint(context, wid, i*middle);
                 CGContextStrokePath(context);
                 /*CGContextSetTextMatrix(context, CGAffineTransformMake(1.0,0.0, 0.0, -1.0, 0.0, 0.0));
                 CGContextSelectFont(context, "Arial", 10, kCGEncodingMacRoman);
                 CGContextSetTextPosition(context, 0, 5+i*middle);
                 NSString *intString = [NSString stringWithFormat:@"%d", 10-i];
                 CGContextShowText(context, [intString UTF8String], strlen([intString UTF8String]));*/

             }
             //вертикальные
             CGContextSetLineWidth(context, 1.5f);
             CGContextMoveToPoint(context, lof+0*((wid-lof)/(dates.count-1)), 0);
             CGContextAddLineToPoint(context, lof+0*((wid-lof)/(dates.count-1)), hei-dof);
             CGContextStrokePath(context);
             CGContextSetLineWidth(context, 0.2f);
             for(int i=1;i<dates.count-1;i++)
             {
                 CGContextMoveToPoint(context, lof+i*((wid-lof)/(dates.count-1)), 0);
                 CGContextAddLineToPoint(context, lof+i*((wid-lof)/(dates.count-1)), hei-dof);
                 CGContextStrokePath(context);
             }
             CGContextMoveToPoint(context, wid, hei-dof);
             CGContextAddLineToPoint(context, wid, 0);
             CGContextStrokePath(context);
             
             CGColorSpaceRelease(colorspace);
             CGColorRelease(color);
             
             //рисование графиков
             NSDictionary* name = [cookie objectForKey:@"grafik_data"];
             NSDictionary* legend = [cookie objectForKey:@"grafik_legend"];
             if(legend.count)
             {
                 NSDictionary* colors = [legend objectForKey:@"color"];
                 for (id key in [name allKeys]) {
                     //NSLog(@"%@ - %@",key,[name objectForKey:key]);
                     NSArray* point = [name objectForKey:key];
                     CGContextSetLineWidth(context, 1.5f);
                     NSArray *c1 = [colors objectForKey:key];
                     CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
                     CGFloat components[] = {[c1[0] floatValue]/255.0f, [c1[1] floatValue]/255.0f, [c1[2] floatValue]/255.0f, 1.0f};
                     CGColorRef color = CGColorCreate(colorspace, components);
                     CGContextSetStrokeColorWithColor(context, color);
                     NSString *dd = [point[0] objectForKey:@"date"];
                     int i1=0;
                     while(![dd isEqualToString:dates[i1]])
                     {
                         i1++;
                     }
                     
                     //CGContextMoveToPoint(context, lof + (i1*(wid-lof)/(dates.count-1)), middle*10 - ([[point[0] objectForKey:@"value"] intValue]*middle));
                     
                     //NSLog(@"%@ - %d",[point[0] objectForKey:@"date"],[[point[0] objectForKey:@"value"] intValue]);
                     for(int i=1;i<point.count;i++)
                     {
                         i1=0;
                         dd = [point[i] objectForKey:@"date"];
                         
                         while(![dd isEqualToString:dates[i1]])
                         {
                             i1++;
                         }
                         CGContextMoveToPoint(context, lof + ((i1-1)*(wid-lof)/(dates.count-1)), middle*10 - ([[point[i-1] objectForKey:@"value"] intValue]*middle));
                         CGContextAddLineToPoint(context, lof+(i1*(wid-lof)/(dates.count-1)), middle*10 - ([[point[i] objectForKey:@"value"] intValue]*middle));
                         //CGContextAddLineToPoint(context, 270.0f, 5.0f);
                         CGContextStrokePath(context);
                     }
                     CGColorSpaceRelease(colorspace);
                     CGColorRelease(color);
                 }
             }
         }
         else {
         UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
         [alert show];
         }
     }
     else{
         UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка соединения!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
         [alert show];
     }

}


@end
