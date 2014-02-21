//
//  DairyViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 03.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "DairyViewController.h"
#import "Functions.h"
#import "AppDelegate.h"
#import "Draw2D.h"
#import "CustomScrollView.h"


@interface DairyViewController ()



@end

@implementation DairyViewController



float AdvSearchViewY=0;
float AdvSearchViewPath=0;
int AdvSearchViewOpen=0;
NSTimer *timer;
UITextField *text1;
UITextField *text2;
float scrollheight;
CustomScrollView* mainScroll;
Draw2D *grafview;
UIButton *start_button, *end_button;
FPPopoverController *popover;
UIScrollView *instrscroll;

- (void) FunctionOne: (NSDictionary*)data
{
    //Put your finction code here
    
    //NSLog(@"first %@",data);
    NSDictionary* name = [data objectForKey:@"grafik_data"];
    NSDictionary* legend = [data objectForKey:@"grafik_legend"];
    int i=0;
    if(legend.count && name.count)
    {
        
    NSDictionary* colors = [legend objectForKey:@"color"];
    NSDictionary* legenda = [legend objectForKey:@"legenda"];
    mainScroll.contentSize = CGSizeMake(self.view.frame.size.width, grafview.frame.origin.y+grafview.frame.size.height+20 + (colors.count*40)+80);
    scrollheight=grafview.frame.origin.y+grafview.frame.size.height+20 + (colors.count*40)+80;
    
    for(id key in [legenda allKeys])
    {
        //NSLog(@"%@ - %@ - %@",key,[legenda objectForKey:key],[colors objectForKey:key]);
        NSArray *c1=[colors objectForKey:key];
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, grafview.frame.origin.y+grafview.frame.size.height+20 + (i*40),20,20)];
        view1.layer.masksToBounds=YES;
        view1.layer.cornerRadius = 3.0;
        view1.backgroundColor = [UIColor colorWithRed:[c1[0] floatValue] / 255.0f
                                                green:[c1[1] floatValue] / 255.0f
                                                 blue:[c1[2] floatValue] / 255.0f
                                                alpha:1.0f];
        [mainScroll addSubview:view1];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, grafview.frame.origin.y+grafview.frame.size.height+10 + (i*40),self.view.frame.size.width-60,40)];
        label.text = [NSString stringWithFormat:@"%@", [legenda objectForKey:key]];
        label.font = [UIFont fontWithName:@"Arial" size:(12.0)];
        label.numberOfLines=0;
        //label.textAlignment = NSTextAlignmentCenter;
        [mainScroll addSubview:label];
        view1.layer.zPosition=0;
        label.layer.zPosition=0;
        
        i++;
    }
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[data objectForKey:@"start_date"] forKey:@"start_date"];
    [userDefaults setObject:[data objectForKey:@"end_date"] forKey:@"end_date"];
    [userDefaults synchronize];
    
    text1.text = [data objectForKey:@"start_date"];
    text2.text = [data objectForKey:@"end_date"];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(36, grafview.frame.origin.y+grafview.frame.size.height+20 + (i*40)+ 20-1,124,50)];
    view2.layer.masksToBounds=YES;
    view2.layer.cornerRadius = 10.0;
    view2.layer.borderColor = [[UIColor whiteColor] CGColor];
    view2.layer.borderWidth = 0.0;
    view2.backgroundColor = [Functions colorWithRGBHex:0x569195];
    [mainScroll addSubview:view2];

    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(37, grafview.frame.origin.y+grafview.frame.size.height+20 + (i*40)+ 20,122,48)];
    button2.layer.masksToBounds=YES;
    button2.layer.cornerRadius = 10.0;
    [button2 setTitle:@"Добавить фактор" forState: UIControlStateNormal];
    button2.titleLabel.numberOfLines=2;
    button2.titleLabel.textAlignment = NSTextAlignmentCenter;
    //button1.titleLabel.text = @"Send";
    button2.layer.borderColor = [[UIColor whiteColor] CGColor];
    button2.layer.borderWidth = 3.0;
    button2.backgroundColor = [Functions colorWithRGBHex:0x6caa45];
    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [button2 addTarget:self action:@selector(addfactorfun) forControlEvents:UIControlEventTouchUpInside];
    button2.userInteractionEnabled=YES;
    
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mainScroll addSubview:button2];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(162, grafview.frame.origin.y+grafview.frame.size.height+20 + (i*40)+ 20-1,124,50)];
    view1.layer.masksToBounds=YES;
    view1.layer.cornerRadius = 10.0;
    view1.layer.borderColor = [[UIColor whiteColor] CGColor];
    view1.layer.borderWidth = 0.0;
    view1.backgroundColor = [Functions colorWithRGBHex:0x569195];
    [mainScroll addSubview:view1];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(163, grafview.frame.origin.y+grafview.frame.size.height+20 + (i*40)+ 20,122,48)];
    button1.layer.masksToBounds=YES;
    button1.layer.cornerRadius = 10.0;
    [button1 setTitle:@"Изменить" forState: UIControlStateNormal];
    button1.titleLabel.numberOfLines=2;
    button1.titleLabel.textAlignment = NSTextAlignmentCenter;
    //button1.titleLabel.text = @"Send";
    button1.layer.borderColor = [[UIColor whiteColor] CGColor];
    button1.layer.borderWidth = 3.0;
    button1.backgroundColor = [Functions colorWithRGBHex:0x6caa45];
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [button1 addTarget:self action:@selector(ReplaceData:) forControlEvents:UIControlEventTouchUpInside];
    button1.userInteractionEnabled=YES;
    
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mainScroll addSubview:button1];
    NSLog(@"button=%f",button2.frame.origin.y);
}

- (void)addfactorfun
{
    //AddFactorViewController
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"AddFactorViewController"];
    [self presentViewController:viewController animated:NO completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)KeyboardHide:(id)sender
{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    NSLog(@"sc=%f",mainScroll.contentSize.height);
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if(item.tag==0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
        [self presentViewController:viewController animated:NO completion:nil];
        
    }
    if(item.tag==2)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"OprosViewController"];
        [self presentViewController:viewController animated:NO completion:nil];
    }
    if(item.tag==3)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"PedometrViewController"];
        viewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentViewController:viewController animated:NO completion:nil];
    }
}

-(void)increaseTimerCount
{
    Draw2D *play = [[Draw2D alloc] init];
    play.delegate=self;
    [play setDelegate:self];
    if([play ShowInfoTwo]) {[timer invalidate];}

}

- (void)viewWillAppear:(BOOL)animated
{

    timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(increaseTimerCount) userInfo:nil repeats:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    mainScroll = [[CustomScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.BottomView.frame.origin.y-20)];
    
    [self.view addSubview:mainScroll];
    
    grafview = [[Draw2D alloc] initWithFrame:CGRectMake(20,82, 280,240)];
    grafview.backgroundColor = [Functions colorWithRGBHex:0xc2dcdd];
    [mainScroll addSubview:grafview];
    
    
    start_button = [[UIButton alloc] initWithFrame:CGRectMake(118, 47,21,22)];
    UIImage *btnImage = [UIImage imageNamed:@"ico_k"];
    [start_button setImage:btnImage forState:UIControlStateNormal];
    start_button.userInteractionEnabled=YES;
    start_button.tag=1;
    [mainScroll addSubview:start_button];
    
    end_button = [[UIButton alloc] initWithFrame:CGRectMake(243, 47,21,22)];
    
    [end_button setImage:btnImage forState:UIControlStateNormal];
    end_button.userInteractionEnabled=YES;
    end_button.tag=2;
    [mainScroll addSubview:end_button];
    
    UIButton *OkButton = [[UIButton alloc] initWithFrame:CGRectMake(270, 43, 30, 30)];
    OkButton.layer.masksToBounds=YES;
    OkButton.layer.cornerRadius = 3.0;
    [OkButton setTitle:@"OK" forState: UIControlStateNormal];
    OkButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    //button2.layer.borderColor = [[UIColor whiteColor] CGColor];
    //button2.layer.borderWidth = 3.0;
    OkButton.backgroundColor = [Functions colorWithRGBHex:0x6caa45];
    OkButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [mainScroll addSubview:OkButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 18, 280, 21)];
    label.text = @"Медицинский дневник";
    label.font = [UIFont fontWithName:@"Arial" size:(15.0)];
    label.numberOfLines=0;
    label.textAlignment = NSTextAlignmentCenter;
    [mainScroll addSubview:label];
    
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(20, 43,97,30)];
    text1.layer.masksToBounds=YES;
    text1.layer.cornerRadius = 5.0;
    
    text1.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
    text1.backgroundColor = [UIColor whiteColor];
    text1.layer.borderWidth = 1.0;
    text1.font = [UIFont systemFontOfSize:12];
    text1.userInteractionEnabled=YES;
    text1.textAlignment = NSTextAlignmentCenter;
    
    [mainScroll addSubview:text1];
    [text1 addTarget:self action:@selector(popover:) forControlEvents:UIControlEventEditingDidBegin];
    [text1 addTarget:self action:@selector(KeyboardHide:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(145, 43,97,30)];
    text2.layer.masksToBounds=YES;
    text2.layer.cornerRadius = 5.0;
    
    text2.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
    text2.backgroundColor = [UIColor whiteColor];
    text2.layer.borderWidth = 1.0;
    text2.font = [UIFont systemFontOfSize:12];
    text2.userInteractionEnabled=YES;
    text2.textAlignment = NSTextAlignmentCenter;
    [mainScroll addSubview:text2];
    [text2 addTarget:self action:@selector(popover:) forControlEvents:UIControlEventEditingDidBegin];
    [text2 addTarget:self action:@selector(KeyboardHide:) forControlEvents:UIControlEventEditingDidEndOnExit];

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"" forKey:@"readylegend"];
    [userDefaults synchronize];
    [Functions MyGradient:self.view];

    [self.BottomView setSelectedItem:[self.BottomView.items objectAtIndex:1]];
    self.BottomView.delegate = self;
    
    self.InstrView.layer.zPosition=15;
    self.InstrViewBack.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
    self.InstrViewBack.layer.borderWidth = 0.5;
    
    self.InstrButton.highlighted = NO;
    
    CGRect newFrame = self.InstrView.frame;
    newFrame.size.height = self.BottomView.frame.origin.y;
    self.InstrView.frame = newFrame;
    
    newFrame = self.InstrViewBack.frame;
    newFrame.size.height = self.BottomView.frame.origin.y;
    self.InstrViewBack.frame = newFrame;

    self.InstrButton.layer.zPosition=20;
    self.InstrView.layer.zPosition=18;
    self.InstrViewBack.layer.zPosition=19;
    
    [self.view sendSubviewToBack:mainScroll];
    mainScroll.delegate=self;
    mainScroll.layer.zPosition=2;
    grafview.layer.zPosition=2;
    
    mainScroll.userInteractionEnabled=YES;
    
    [self.BottomView.items[0] setFinishedSelectedImage:[UIImage imageNamed:@"help_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"help"]];
    
    [self.BottomView.items[1] setFinishedSelectedImage:[UIImage imageNamed:@"dnevnik_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"dnevnik"]];
    
    [self.BottomView.items[2] setFinishedSelectedImage:[UIImage imageNamed:@"opros_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"opros"]];
    
    [self.BottomView.items[3] setFinishedSelectedImage:[UIImage imageNamed:@"shagomer_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"shagomer"]];
    
    NSString *session = [userDefaults objectForKey:@"session"];
    NSLog(@"%@",session);
    if ([session length]) {
        
    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    [start_button addTarget:self action:@selector(popover:) forControlEvents:UIControlEventTouchUpInside];
    
    [end_button addTarget:self action:@selector(popover:) forControlEvents:UIControlEventTouchUpInside];
    
    [OkButton addTarget:self action:@selector(SendDate) forControlEvents:UIControlEventTouchUpInside];
    
    instrscroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, self.InstrViewBack.frame.size.width, self.InstrViewBack.frame.size.height-35)];
    
    instrscroll.delegate=self;
    instrscroll.layer.zPosition=30;
    instrscroll.userInteractionEnabled=YES;
    
    [self.InstrViewBack addSubview:instrscroll];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, self.InstrViewBack.frame.size.width-20, 40)];
    label3.text = @"Выберите любой отрезок времени, за который хотите изучить кривые ваших факторов.";
    label3.font = [UIFont fontWithName:@"Arial" size:(12.0)];
    label3.numberOfLines=0;
    //label3.textAlignment = NSTextAlignmentCenter;
    [instrscroll addSubview:label3];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:
                          CGRectMake(10, 70, self.InstrViewBack.frame.size.width-20,
                                     300)];
    image.image = [UIImage imageNamed:@"image_1"];
    image.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *img = [UIImage imageNamed:@"image_1"];
    [image setImage:img];
    [instrscroll addSubview:image];
    
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 380, self.InstrViewBack.frame.size.width-20, 40)];
    label3.text = @"После выбора отрезка времени нажмите кнопку \"OK\"";
    label3.font = [UIFont fontWithName:@"Arial" size:(12.0)];
    label3.numberOfLines=0;
    //label3.textAlignment = NSTextAlignmentCenter;
    [instrscroll addSubview:label3];
    
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 430, self.InstrViewBack.frame.size.width-20, 40)];
    label3.text = @"Для добавления новых факторов нажмите кнопку \"Добавить фактор\".";
    label3.font = [UIFont fontWithName:@"Arial" size:(12.0)];
    label3.numberOfLines=0;
    //label3.textAlignment = NSTextAlignmentCenter;
    [instrscroll addSubview:label3];
    
    image = [[UIImageView alloc] initWithFrame:
                          CGRectMake(10, 480, self.InstrViewBack.frame.size.width-20,
                                     300)];
    image.image = [UIImage imageNamed:@"image_4"];
    image.contentMode = UIViewContentModeScaleAspectFit;
    img = [UIImage imageNamed:@"image_4"];
    [image setImage:img];
    [instrscroll addSubview:image];
    
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 790, self.InstrViewBack.frame.size.width-20, 40)];
    label3.text = @"На этом экране Вы можете добавить новый фактор, либо изменить название уже существующего.";
    label3.font = [UIFont fontWithName:@"Arial" size:(12.0)];
    label3.numberOfLines=0;
    //label3.textAlignment = NSTextAlignmentCenter;
    [instrscroll addSubview:label3];
    
    image = [[UIImageView alloc] initWithFrame:
             CGRectMake(10, 840, self.InstrViewBack.frame.size.width-20,
                        300)];
    image.image = [UIImage imageNamed:@"image_2"];
    image.contentMode = UIViewContentModeScaleAspectFit;
    img = [UIImage imageNamed:@"image_2"];
    [image setImage:img];
    [instrscroll addSubview:image];
    
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 1150, self.InstrViewBack.frame.size.width-20, 40)];
    label3.text = @"Для оценивания факторов нажмите кнопку \"Изменить\".";
    label3.font = [UIFont fontWithName:@"Arial" size:(12.0)];
    label3.numberOfLines=0;
    //label3.textAlignment = NSTextAlignmentCenter;
    [instrscroll addSubview:label3];
    
    image = [[UIImageView alloc] initWithFrame:
             CGRectMake(10, 1200, self.InstrViewBack.frame.size.width-20,
                        300)];
    image.image = [UIImage imageNamed:@"image_4"];
    image.contentMode = UIViewContentModeScaleAspectFit;
    img = [UIImage imageNamed:@"image_4"];
    [image setImage:img];
    [instrscroll addSubview:image];
    
    
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 1510, self.InstrViewBack.frame.size.width-20, 60)];
    label3.text = @"Для оценивания факторов выберите соответствующий фактор и проскролите колесико до соответствующего значения оценки фактора.";
    label3.font = [UIFont fontWithName:@"Arial" size:(12.0)];
    label3.numberOfLines=0;
    //label3.textAlignment = NSTextAlignmentCenter;
    [instrscroll addSubview:label3];
    
    image = [[UIImageView alloc] initWithFrame:
             CGRectMake(10, 1580, self.InstrViewBack.frame.size.width-20,
                        300)];
    image.image = [UIImage imageNamed:@"image_3"];
    image.contentMode = UIViewContentModeScaleAspectFit;
    img = [UIImage imageNamed:@"image_3"];
    [image setImage:img];
    [instrscroll addSubview:image];
    
    instrscroll.contentSize = CGSizeMake(instrscroll.frame.size.width, image.frame.origin.y+image.frame.size.height+20);
    
}

- (void) SendDate
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"yes" forKey:@"senddate"];
    [userDefaults synchronize];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"DairyViewController"];
    [self presentViewController:viewController animated:NO completion:nil];
    
}

- (IBAction)AdvSearchDragOutside:(UIButton *)sender forEvent:(UIEvent *)event {
    
    UITouch *touch = [[event touchesForView:sender] anyObject];
    CGPoint previousLocation = [touch previousLocationInView:sender];
    CGPoint location = [touch locationInView:sender];
    
    CGFloat delta_y = location.y - previousLocation.y;
    //NSLog(@"%f-%f %f-%f",location.y,delta_y,location.x,delta_x);
    AdvSearchViewPath=AdvSearchViewPath+delta_y;
}

- (IBAction)AdvSearchDragInside:(UIButton *)sender forEvent:(UIEvent *)event {
    
    UITouch *touch = [[event touchesForView:sender] anyObject];
    CGPoint previousLocation = [touch previousLocationInView:sender];
    CGPoint location = [touch locationInView:sender];
    
    CGFloat delta_y = location.x - previousLocation.x;
    
    //NSLog(@"%f-%f %f",self.InstrView.frame.origin.x,delta_y,location.x);
    if(self.InstrView.frame.origin.x<=0.0)
    {
        [self.InstrView setFrame:CGRectMake(self.InstrView.frame.origin.x+delta_y,0,self.InstrView.frame.size.width,self.InstrView.frame.size.height)];//= yy+delta_y;
        AdvSearchViewPath=AdvSearchViewPath+fabsf(delta_y);
    }
    
    //CGSize size = CGSizeMake(self.InstrView.frame.size.width,self.InstrView.frame.size.height);
}

- (IBAction)AdvSearchTouchDown:(UIButton *)sender forEvent:(UIEvent *)event {
    //NSLog(@"Path=%f",AdvSearchViewPath);
    AdvSearchViewY=self.InstrView.frame.origin.x;
}

- (IBAction)AdvSearchTouchUpInside:(UIButton *)sender forEvent:(UIEvent *)event {
    //NSLog(@"Path=%f",AdvSearchViewPath);
    if(!AdvSearchViewOpen)
    {
        if(AdvSearchViewPath<50.0)
        {
            CGRect newFrame = self.InstrView.frame;
            newFrame.origin.x = AdvSearchViewY;
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.InstrView.frame = newFrame;
                             }
                             completion:^(BOOL finished){
                                 
                                 AdvSearchViewOpen=0;
                                 AdvSearchViewPath=0;
                             }];
        }
        else
        {
            CGRect newFrame = self.InstrView.frame;
            newFrame.origin.x = 0;
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.InstrView.frame = newFrame;
                             }
                             completion:^(BOOL finished){
                                 
                                 AdvSearchViewOpen=1;
                                 AdvSearchViewPath=0;
                             }];
        }
    }
    else
    {
        if(AdvSearchViewPath<20.0)
        {
            CGRect newFrame = self.InstrView.frame;
            newFrame.origin.x = AdvSearchViewY;
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.InstrView.frame = newFrame;
                             }
                             completion:^(BOOL finished){
                                 
                                 AdvSearchViewOpen=1;
                                 AdvSearchViewPath=0;
                             }];
        }
        else
        {
            CGRect newFrame = self.InstrView.frame;
            newFrame.origin.x = -285;
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.InstrView.frame = newFrame;
                             }
                             completion:^(BOOL finished){
                                 
                                 AdvSearchViewOpen=0;
                                 AdvSearchViewPath=0;
                             }];
        }
        
    }
    
}

- (IBAction)buttonclick:(id)sender {
    
    //NSLog(@"fffff");
}

-(void)popover:(UIButton*)sender
{
    if(sender.tag==1)
    {
        NSLog(@"start_button");
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"start_button" forKey:@"click_button"];
        [userDefaults synchronize];
    }
    else if(sender.tag==2)
    {
        NSLog(@"end_button");
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"end_button" forKey:@"click_button"];
        [userDefaults synchronize];
    }
    //the controller we want to present as a popover
    PopoverViewController *controller = [[PopoverViewController alloc] init];
    controller.delegate=self;
    
    popover = [[FPPopoverController alloc] initWithViewController:controller];
    
    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    popover.tint = FPPopoverDefaultTint;
    
    //if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        popover.contentSize = CGSizeMake(self.view.frame.size.width, 320);
    }
    popover.arrowDirection = FPPopoverArrowDirectionUp;
    popover.tint=FPPopoverGreenTint;
    popover.view.layer.zPosition=20;
    popover.delegate=self;
    //sender is the UIButton view
    [popover presentPopoverFromView:sender];
    
    //[popover presentPopoverFromPoint:CGPointMake(sender.frame.origin.x + sender.frame.size.width/2.0, sender.frame.origin.x + sender.frame.size.width/2.0)];
    
}

- (void) ClosePopover
{
    NSLog(@"close");
    [popover dismissPopoverAnimated:NO];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *start = [userDefaults objectForKey:@"start_date"];
    NSString *end = [userDefaults objectForKey:@"end_date"];
    [text1 setText:start];
    [text2 setText:end];
    [userDefaults setObject:@"" forKey:@"click_button"];
    [userDefaults synchronize];
}

- (void)popoverControllerDidDismissPopover:(FPPopoverController *)popoverController
{
    mainScroll.contentSize = CGSizeMake(self.view.frame.size.width, scrollheight);
    [mainScroll setContentSize:CGSizeMake(self.view.frame.size.width, scrollheight)];
    NSLog(@"dismissfffff=%f-%f",scrollheight,mainScroll.contentSize.height);
}

//добавить фактор
- (IBAction)ReplaceData:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"EnterDairyViewController"];
    [self presentViewController:viewController animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
