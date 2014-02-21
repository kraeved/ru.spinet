//
//  Draw2D.h
//  medicaldiary
//
//  Created by Краевед Василий on 04.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Draw2D;
@protocol Draw2DDelegate <NSObject>
@required
- (void) FunctionOne: (NSDictionary*)data;

@end

@interface Draw2D : UIView
//{
//   id <Draw2DDelegate> delegate;
//}


@property (nonatomic,weak)  id <Draw2DDelegate> delegate;
-(int)ShowInfoTwo;

@end
