//
//  PopoverViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 13.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//


#import "Functions.h"
#import "DairyViewController.h"
#import "PopoverViewController.h"

@interface PopoverViewController ()

@end

@implementation PopoverViewController

@synthesize delegate=_delegate;
UIDatePicker* datePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (int) ShowInfoTwo
{
    return 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    //UIDatePicker* datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 100, 162)];
    datePicker = [[UIDatePicker alloc] init];
    datePicker.frame = CGRectMake(0, 0, self.view.frame.size.width, datePicker.frame.size.height);
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = NO;

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *click = [userDefaults objectForKey:@"click_button"];
    NSDate *dateFromString;
    if([click isEqualToString:@"start_button"])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:[userDefaults objectForKey:@"start_date"]];
        datePicker.date = dateFromString;
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:[userDefaults objectForKey:@"end_date"]];
        datePicker.maximumDate = [dateFromString dateByAddingTimeInterval: -86400.0];
    }
    else if([click isEqualToString:@"end_button"])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:[userDefaults objectForKey:@"end_date"]];
        datePicker.date = dateFromString;
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:[userDefaults objectForKey:@"start_date"]];
        datePicker.minimumDate = [dateFromString dateByAddingTimeInterval: 86400.0];
    }
    
    datePicker.transform = CGAffineTransformMake(0.8, 0, 0, 1.0, -self.view.frame.size.width*0.05, 0);
    //[datePicker addTarget:self action:@selector(LabelChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    //[Functions MyGradient:self.view];
    
    UIView* vi1 = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-162)/2, datePicker.frame.origin.y+datePicker.frame.size.height+10,162,38)];
    vi1.layer.masksToBounds=YES;
    vi1.layer.cornerRadius = 10.0;
    vi1.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];;
    vi1.layer.borderWidth = 0.0;
    vi1.backgroundColor = [Functions colorWithRGBHex:0x569195];
    [self.view addSubview:vi1];
    
    UIButton* button1 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-162)/2+1, datePicker.frame.origin.y+datePicker.frame.size.height+11,160,36)];
    button1.layer.masksToBounds=YES;
    button1.layer.cornerRadius = 10.0;
    //button1.titleLabel.text = @"Добавить фактор";
    [button1 setTitle:@"Изменить" forState:UIControlStateNormal];
    button1.layer.borderColor = [[UIColor whiteColor] CGColor];
    button1.layer.borderWidth = 3.0;
    button1.titleLabel.font = [UIFont systemFontOfSize:13];
    button1.tintColor = [UIColor whiteColor];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor = [Functions colorWithRGBHex:0x569195];
    button1.userInteractionEnabled=YES;
    [self.view addSubview:button1];

}

- (void)changeDate:(UIButton*)button
{
    NSDate *myDate = datePicker.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    NSLog(@"click %@", [dateFormat stringFromDate:myDate]);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *click = [userDefaults objectForKey:@"click_button"];
    if([click isEqualToString:@"start_button"])
        [userDefaults setObject:[dateFormat stringFromDate:myDate] forKey:@"start_date"];
    else if([click isEqualToString:@"end_button"])
        [userDefaults setObject:[dateFormat stringFromDate:myDate] forKey:@"end_date"];
    [userDefaults synchronize];
    [_delegate ClosePopover];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
