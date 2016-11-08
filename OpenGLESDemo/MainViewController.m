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

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
