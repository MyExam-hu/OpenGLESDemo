//
//  MainViewController.m
//  OpenGLESDemo
//
//  Created by huweidong on 2/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "MainViewController.h"
#import "OpenGLES1ViewController.h"
#import "OpenGLES_Ch3_1ViewController.h"
#import "clsExam.h"
#import <objc/runtime.h>

static void *EOCMYAlertViewKey=@"EOCMYAlertViewKey";

@interface MainViewController ()<UIAlertViewDelegate>

@property (nonatomic, readwrite, copy) NSString *myName;

@end

@implementation MainViewController

-(void)setMyName:(NSString *)myName{
    _myName=myName;
    NSLog(@"23333");
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.myName=@"233333";
    //不会调用set方法，慎用
    _myName=@"233333";
    
    NSString *foo=@"2333";
    NSString *bar=[NSString stringWithFormat:@"233%@",@"3"];
    BOOL equalA=(foo == bar);
    BOOL equalB=[foo isEqualToString:bar];
    BOOL equalC=[foo isEqual:bar];
    NSLog(@"equalA=%d,equalB=%d,equalC=%d",equalA,equalB,equalC);
    
    clsExam *cls1=[[clsExam alloc] init];
    cls1.youName=@"233";
    clsExam *cls2=[[clsExam alloc] init];
    cls2.youName=@"233";
    NSLog(@"%d",[cls1 isEqual:cls2]);
    
    NSMutableSet *set=[NSMutableSet new];
    NSMutableArray *arrayA=[@[@1,@2] mutableCopy];
    [set addObject:arrayA];
    NSLog(@"set=%@",set);
    
    NSMutableArray *arrayB=[@[@1,@2] mutableCopy];
    [set addObject:arrayB];
    NSLog(@"set=%@",set);
    
    NSMutableArray *arrayC=[@[@1] mutableCopy];
//    [set addObject:[arrayC copy]];
    [set addObject:arrayC];
    NSLog(@"set=%@",set);
    
    [arrayC addObject:@2];
    NSLog(@"set=%@",set);
    
    NSSet *setB=[set copy];
    NSLog(@"setB=%@",setB);
    
    //关联对象的使用,慎用,需要注意循环引用环
    [self loadAlertView];
    
}

-(void)loadAlertView{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Question" message:@"2333" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
    void (^block)(NSInteger) = ^(NSInteger btnIndex){
        if (btnIndex==0) {
            NSLog(@"0000");
        }else{
            NSLog(@"other");
        }
    };
    objc_setAssociatedObject(alert, EOCMYAlertViewKey, block, OBJC_ASSOCIATION_COPY);
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    void (^block)(NSInteger)=objc_getAssociatedObject(alertView, EOCMYAlertViewKey);
    block(buttonIndex);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OpenGLES1Click:(UIButton *)sender {
    if (sender.tag==1) {
        OpenGLES1ViewController *vc=[[OpenGLES1ViewController alloc] initWithNibName:@"OpenGLES1ViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag==2){
        OpenGLES_Ch3_1ViewController *vc=[[OpenGLES_Ch3_1ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
