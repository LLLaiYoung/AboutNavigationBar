//
//  LYNavigaitonViewController.m
//  Navigation
//
//  Created by chairman on 16/4/26.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "LYNavigaitonViewController.h"

@interface LYNavigaitonViewController ()

@end

@implementation LYNavigaitonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//* 子视图控制器状态栏风格 毛玻璃 */
- (UIViewController *)childViewControllerForStatusBarStyle {
    //* 返回栈顶部的Controller */
    return self.topViewController;
}
////* 首选状态栏样式 毛玻璃 和上面效果一样 */
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    UIViewController *topVC = self.topViewController;
//    return [topVC preferredStatusBarStyle];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
