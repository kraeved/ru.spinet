//
//  ResultOprosViewController.h
//  medicaldiary
//
//  Created by Краевед Василий on 05.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

@interface ResultOprosViewController : UIViewController <XYPieChartDelegate, XYPieChartDataSource, UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UILabel *QuesText;
@property (weak, nonatomic) IBOutlet UITabBar *BottomView;
@end
