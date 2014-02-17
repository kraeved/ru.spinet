//
//  EnterDairyViewController.m
//  medicaldiary
//
//  Created by Краевед Василий on 05.02.14.
//  Copyright (c) 2014 spinet.ru. All rights reserved.
//

#import "EnterDairyViewController.h"
#import "AppDelegate.h"
#import "Functions.h"

@interface EnterDairyViewController ()

@end

@implementation EnterDairyViewController

NSMutableArray *dataArray;
NSMutableDictionary *mydata, *mycomm;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if(item.tag==0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
        [self presentViewController:viewController animated:NO completion:nil];
    }
    if(item.tag==1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"DairyViewController"];
        [self presentViewController:viewController animated:NO completion:nil];
    }
    if(item.tag==2)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"OprosViewController"];
        viewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
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

-(void) getfactors
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *session = [userDefaults objectForKey:@"session"];
    if ([session length]) {
        NSLog(@"session = %@", [userDefaults objectForKey:@"session"]);
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [dateFormat stringFromDate:date];
        
        NSString* myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=gettodaydata&session=%@&date=%@", session, dateString];
        
        NSDictionary* cookie = [Functions SendGetRequest:myurl];
        if(cookie)
        {
            NSString *result = cookie[@"result"];
            NSLog(@"result: %@", result);
            if(result.boolValue)
            {
                
                
                NSArray* legend = [cookie objectForKey:@"gettodaydata"];
                NSString *empty = [cookie objectForKey:@"empty"];
                NSNumber *count = [cookie objectForKey:@"count"];
                self.MainScroll.contentSize = CGSizeMake(self.view.frame.size.width,[count intValue]*250+80+100);
                
                dataArray = [[NSMutableArray alloc] init];
                
                // Add some data for demo purposes.
                for(int i=1;i<11;i++) [dataArray addObject:[NSString stringWithFormat:@"%i", i]];
                
                {
                    //int i=0;
                    mydata = [[NSMutableDictionary alloc] initWithCapacity:[count intValue]];
                    mycomm = [[NSMutableDictionary alloc] initWithCapacity:[count intValue]];
                    //for (id key in [legend1 allKeys])
                    for(int i=0;i<[count intValue];i++)
                    {
                        //NSLog(@"%@ - %@",key,[legend1 objectForKey:key]);
                        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(30, 40+40+250*i, self.view.frame.size.width-60, 150)];
                        [picker setDataSource: self];
                        [picker setDelegate: self];
                        
                        picker.showsSelectionIndicator = YES;
                        [self.MainScroll addSubview:picker];
                        [picker reloadAllComponents];
                        if([[legend[i] objectForKey:@"value"] intValue]) [picker selectRow:([[legend[i] objectForKey:@"value"] intValue]-1) inComponent:0 animated:YES];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 40+250*i,self.view.frame.size.width-60,50)];
                        label.text = [NSString stringWithFormat:@"%@", [legend[i] objectForKey:@"text"]];
                        label.font = [UIFont fontWithName:@"Arial" size:(12.0)];
                        label.numberOfLines=0;
                        label.textAlignment = NSTextAlignmentCenter;
                        [self.MainScroll addSubview:label];
                        
                        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(29, 40+200+250*i-1,(self.view.frame.size.width-60)/2-10+2,40+2)];
                        view1.layer.masksToBounds=YES;
                        view1.layer.cornerRadius = 10.0;
                        view1.layer.borderColor = [[UIColor whiteColor] CGColor];
                        view1.layer.borderWidth = 0.0;
                        view1.backgroundColor = [Functions colorWithRGBHex:0x569195];
                        [self.MainScroll addSubview:view1];
                        
                        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 40+200+250*i,(self.view.frame.size.width-60)/2-10,40)];
                        button1.layer.masksToBounds=YES;
                        button1.layer.cornerRadius = 10.0;
                        [button1 setTitle:@"Удалить фактор" forState: UIControlStateNormal];
                        button1.layer.borderColor = [[UIColor whiteColor] CGColor];
                        button1.layer.borderWidth = 3.0;
                        button1.titleLabel.font = [UIFont systemFontOfSize:12];
                        button1.userInteractionEnabled=YES;
                        
                        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        
                        [button1 addTarget:self action:@selector(deletefactor:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [self.MainScroll addSubview:button1];
                        
                        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-30-((self.view.frame.size.width-60)/2-10)-1, 40+200+250*i-1,(self.view.frame.size.width-60)/2-10+2,40+2)];
                        view2.layer.masksToBounds=YES;
                        view2.layer.cornerRadius = 10.0;
                        view2.layer.borderColor = [[UIColor whiteColor] CGColor];
                        view2.layer.borderWidth = 0.0;
                        view2.backgroundColor = [Functions colorWithRGBHex:0x569195];
                        [self.MainScroll addSubview:view2];
                        
                        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-30-((self.view.frame.size.width-60)/2-10), 40+200+250*i,(self.view.frame.size.width-60)/2-10,40)];
                        button2.layer.masksToBounds=YES;
                        button2.layer.cornerRadius = 10.0;
                        [button2 setTitle:@"Добавить комментарий" forState: UIControlStateNormal];
                        button2.layer.borderColor = [[UIColor whiteColor] CGColor];
                        button2.layer.borderWidth = 3.0;
                        button2.titleLabel.font = [UIFont systemFontOfSize:12];
                        button2.titleLabel.numberOfLines=2;
                        button2.titleLabel.textAlignment = NSTextAlignmentCenter;
                        button2.userInteractionEnabled=YES;
                        
                        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        
                        [button2 addTarget:self action:@selector(addcommfactor:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [self.MainScroll addSubview:button2];
                        
                        button1.tag= [[legend[i] objectForKey:@"tip"] intValue];
                        button2.tag= [[legend[i] objectForKey:@"tip"] intValue];
                        label.tag= [[legend[i] objectForKey:@"tip"] intValue];
                        picker.tag= [[legend[i] objectForKey:@"tip"] intValue];
                        NSNumber *x;
                        x=[legend[i] objectForKey:@"value"];//[NSNumber numberWithInt:[[legend[i] objectForKey:@"value"] intValue]];
                        
                        [mydata setValue:x forKey:[legend[i] objectForKey:@"tip"]];
                        x=[legend[i] objectForKey:@"comment"];
                        [mycomm setValue:x forKey:[legend[i] objectForKey:@"tip"]];
                        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mydata];
                        //NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                        //NSLog(@"%@",[mydata objectForKey:key]);
                        
                        UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 46+40+200+250*i-1,self.view.frame.size.width,1)];
                        view3.backgroundColor = [Functions colorWithRGBHex:0x569195];
                        [self.MainScroll addSubview:view3];
                        
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:data forKey:@"factor"];
                        data = [NSKeyedArchiver archivedDataWithRootObject:mycomm];
                        [userDefaults setObject:data forKey:@"comments"];
                        [userDefaults synchronize];
                        
                        
                        [view1 setUserInteractionEnabled:YES];
                        [button1 setUserInteractionEnabled:YES];
                        [view2 setUserInteractionEnabled:YES];
                        [button2 setUserInteractionEnabled:YES];
                        
                    }
                    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(29, 40+30+250*[count intValue]-1,self.view.frame.size.width-60+2,40+2)];
                    view1.layer.masksToBounds=YES;
                    view1.layer.cornerRadius = 10.0;
                    view1.layer.borderColor = [[UIColor whiteColor] CGColor];
                    view1.layer.borderWidth = 0.0;
                    view1.backgroundColor = [Functions colorWithRGBHex:0x569195];
                    [self.MainScroll addSubview:view1];
                    
                    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 40+30+250*[count intValue],self.view.frame.size.width-60,40)];
                    button1.layer.masksToBounds=YES;
                    button1.layer.cornerRadius = 10.0;
                    [button1 setTitle:@"Добавить фактор" forState: UIControlStateNormal];
                    //button1.titleLabel.text = @"Send";
                    button1.layer.borderColor = [[UIColor whiteColor] CGColor];
                    button1.layer.borderWidth = 3.0;
                    button1.backgroundColor = [Functions colorWithRGBHex:0x6caa45];
                    button1.titleLabel.font = [UIFont systemFontOfSize:14];
                    
                    [button1 addTarget:self action:@selector(addfactor:) forControlEvents:UIControlEventTouchUpInside];
                    button1.userInteractionEnabled=YES;
                    
                    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.MainScroll addSubview:button1];
                    
                    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(29, 50+40+30+250*[count intValue]-1,self.view.frame.size.width-60+2,40+2)];
                    view2.layer.masksToBounds=YES;
                    view2.layer.cornerRadius = 10.0;
                    view2.layer.borderColor = [[UIColor whiteColor] CGColor];
                    view2.layer.borderWidth = 0.0;
                    view2.backgroundColor = [Functions colorWithRGBHex:0x569195];
                    [self.MainScroll addSubview:view2];
                    
                    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(30, 50+40+30+250*[count intValue],self.view.frame.size.width-60,40)];
                    button2.layer.masksToBounds=YES;
                    button2.layer.cornerRadius = 10.0;
                    [button2 setTitle:@"Отправить данные" forState: UIControlStateNormal];
                    //button1.titleLabel.text = @"Send";
                    button2.layer.borderColor = [[UIColor whiteColor] CGColor];
                    button2.layer.borderWidth = 3.0;
                    button2.backgroundColor = [Functions colorWithRGBHex:0x6caa45];
                    button2.titleLabel.font = [UIFont systemFontOfSize:14];
                    
                    [button2 addTarget:self action:@selector(senddata:) forControlEvents:UIControlEventTouchUpInside];
                    button2.userInteractionEnabled=YES;
                    
                    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.MainScroll addSubview:button2];
                    
                }
                
            }
            else {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
        else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка соединения!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
    else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"stop");
    [self.CommentEdit resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [Functions MyGradient:self.view];
    
	// Do any additional setup after loading the view.
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [self.BottomView setSelectedItem:[self.BottomView.items objectAtIndex:1]];
    self.BottomView.delegate = self;
    
    [self.BottomView.items[0] setFinishedSelectedImage:[UIImage imageNamed:@"help_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"help"]];
    
    [self.BottomView.items[1] setFinishedSelectedImage:[UIImage imageNamed:@"dnevnik_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"dnevnik"]];
    
    [self.BottomView.items[2] setFinishedSelectedImage:[UIImage imageNamed:@"opros_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"opros"]];
    
    [self.BottomView.items[3] setFinishedSelectedImage:[UIImage imageNamed:@"shagomer_a"] withFinishedUnselectedImage:[UIImage imageNamed:@"shagomer"]];
    
    self.OkButton.layer.masksToBounds=YES;
    self.OkButton.layer.cornerRadius = 10.0;
    self.OkButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.OkButton.layer.borderWidth = 3.0;
    
    self.OkButtonView.layer.masksToBounds=YES;
    self.OkButtonView.layer.cornerRadius = 10.0;
    self.OkButtonView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.OkButtonView.layer.borderWidth = 0.0;
    
    self.CommentView.layer.zPosition=10;
    self.CommentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.CommentView.layer.shadowOpacity = 0.5;
    self.CommentView.layer.shadowRadius = 3;
    self.CommentView.layer.masksToBounds = NO;
    self.CommentView.layer.shadowOffset = CGSizeMake(4.0f,4.0f);
    
    self.CommentEdit.layer.masksToBounds=YES;
    self.CommentEdit.layer.cornerRadius = 10.0;
    self.CommentEdit.layer.borderColor = [[Functions colorWithRGBHex:0x569195] CGColor];
    self.CommentEdit.layer.borderWidth = 1.0;
    
    [Functions MyGradient:self.CommentView];
    
    self.MainScroll.layer.zPosition=1;
    
    CGRect newFrame = self.MainScroll.frame;
    newFrame.size.height = self.BottomView.frame.origin.y;
    self.MainScroll.frame = newFrame;
    
    self.MainScroll.pagingEnabled = YES;
    self.MainScroll.scrollEnabled = YES;
    [self.MainScroll setUserInteractionEnabled:YES];
    [self.view sendSubviewToBack:self.MainScroll];
    
    //mainScroll.contentSize = CGSizeMake(self.view.frame.size.width, mainScroll.contentSize.height+(((name.count%2) + name.count)*205/2));
    [self getfactors];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"ssss");
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.nextResponder touchesMoved:touches withEvent:event];
    //[super touchesMoved:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if([touch view].tag)
    {

    }
    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // NSLog(@"ssssssssss");
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [dataArray count];
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [dataArray objectAtIndex: row];
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"You selected this: %@ %d", [dataArray objectAtIndex: row], pickerView.tag);
    [mydata setValue:[dataArray objectAtIndex: row] forKey:[NSString stringWithFormat:@"%i", pickerView.tag]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mydata];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:@"factor"];
    [userDefaults synchronize];
    /*
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
     NSString *session = [userDefaults objectForKey:@"session"];
     */
}

-(void)deletefactor:(UIButton*)sender
{
    NSLog(@"delete factor #%i",sender.tag);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *session = [userDefaults objectForKey:@"session"];
    if ([session length]) {
        NSLog(@"session = %@", [userDefaults objectForKey:@"session"]);

        
        NSString* myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=deletefactor&session=%@&id=%i", session, sender.tag];
        
        NSDictionary* cookie = [Functions SendGetRequest:myurl];
        if(cookie)
        {
            NSString *result = cookie[@"result"];
            NSLog(@"result: %@", result);
            if(result.boolValue)
            {
                
                for (UIView *subview in self.MainScroll.subviews) {
                    [subview removeFromSuperview];
                }
                [self getfactors];
            }
            else {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
        else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка соединения!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
    else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}

-(void)addcommfactor:(UIButton*)sender
{
    NSLog(@"add comment for factor #%i",sender.tag);
    self.OkButton.tag=sender.tag;
    self.CommentEdit.text = [mycomm objectForKey:[NSString stringWithFormat:@"%i",sender.tag]];
    self.CommentView.hidden=NO;
    
}

- (IBAction)KeyboardHide:(id)sender {
    [self.CommentEdit resignFirstResponder];
}


-(void)addfactor:(UIButton*)sender
{
    NSLog(@"add comment for factor #%i",sender.tag);
    
}

- (IBAction)AddCommentClick:(UIButton*)sender {
    self.CommentView.hidden=YES;
    [mycomm setValue:self.CommentEdit.text forKey:[NSString stringWithFormat:@"%i",sender.tag ]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mycomm];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:@"comments"];
    [userDefaults synchronize];
    [self.CommentEdit resignFirstResponder];
}

-(void)senddata:(UIButton*)sender
{
    //NSLog(@"HTllo %i",sender.tag);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"factor"];
    NSDictionary *items = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    //NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *session = [userDefaults objectForKey:@"session"];
    if ([session length]) {
        NSLog(@"session = %@", [userDefaults objectForKey:@"session"]);
        //NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mydata options:NSJSONWritingPrettyPrinted error:Nil];
        //return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
        //for (id key in [items allKeys]) NSLog(@"%@",key);
        //NSString *dat=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //NSString *responseString=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString *ur=@"";
        for (id key in [mydata allKeys])
        {
            ur = [NSString stringWithFormat:@"%@&data[%@]=%@",ur, key, [mydata objectForKey:key]];
        }
        for (id key in [mycomm allKeys])
        {
            ur = [NSString stringWithFormat:@"%@&comm[%@]=%@",ur, key, [[mycomm objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
        }
        NSString* myurl = [NSString stringWithFormat:@"http://spinet.ru/mobile/index.php?p=changefactors&session=%@%@", session, ur];
        NSLog(@"%@",myurl);
        NSDictionary* cookie= [Functions SendGetRequest:myurl];
        //NSDictionary* cookie = [Functions SendPostRequest:myurl POST:jsonData];
        NSLog(@"cookie: %@", cookie);
        if(cookie)
        {
            NSString *result = cookie[@"result"];
            NSLog(@"result: %@", result);
            NSLog(@"cookie: %@", cookie);
            if(result.boolValue)
            {
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"DairyViewController"];
                [self presentViewController:viewController animated:NO completion:nil];
                
            }
            else {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
        else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка соединения!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
    else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"spinet.ru" message:@"Ошибка авторизации!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}
@end
