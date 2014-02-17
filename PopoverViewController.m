//
//  PopoverViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 13.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "PopoverViewController.h"
#import "Functions.h"
#import "DairyViewController.h"

@interface PopoverViewController ()

@end

@implementation PopoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    //UIDatePicker* datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 100, 162)];
    UIDatePicker* datePicker = [[UIDatePicker alloc] init];
    datePicker.frame = CGRectMake(0, 0, self.view.frame.size.width, datePicker.frame.size.height);
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = NO;
    datePicker.date = [NSDate date];
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
    //DairyViewController.StartDateEdit.text=@"ffff";
    //DairyViewController.sta
    NSLog(@"click");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DairyViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"DairyViewController"];
    //viewController.delegate=self;
    viewController.StartDateEdit1.text=@"fffffff";
    [viewController.StartDateEdit1 setText:@"jjjjjj"];
    
    DairyViewController *dview = [[DairyViewController alloc] init];
    //dview.StartDateEdit.delegate=self;
    dview.StartDateEdit1.text=@"kkkkk";
    NSLog(@"%@",viewController.StartDateEdit1.text);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
