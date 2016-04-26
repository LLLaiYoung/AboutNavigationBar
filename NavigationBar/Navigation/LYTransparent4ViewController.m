//
//  LYTransparent4ViewController.m
//  Navigation
//
//  Created by chairman on 16/4/26.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "LYTransparent4ViewController.h"

@interface LYTransparent4ViewController ()
@property (nonatomic, assign) CGFloat previousY;
@end

@implementation LYTransparent4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"仿简书NavBar";
    self.navigationItem.rightBarButtonItem = nil;
}
#pragma mark - 滑动隐藏导航栏
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y + self.tableView.contentInset.top;//注意
//    NSLog(@"offsetY = %f",offsetY);
    //* 每次重新计算值 */
    CGFloat panTranslationY = [scrollView.panGestureRecognizer translationInView:self.tableView].y;
//    NSLog(@"panTranslationY = %f",panTranslationY);
    
    if (offsetY > 64) {
        if (panTranslationY > 0) { //下滑趋势，显示
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        else {  //上滑趋势，隐藏
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }
    else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
