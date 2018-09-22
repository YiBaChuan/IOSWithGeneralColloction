//
//  NaviSetting.m
//  IOS-GeneralCollection
//
//  Created by apple on 18/9/16.
//  Copyright © 2018年 LuXing. All rights reserved.
//

#import "NaviSetting.h"

@interface NaviSetting ()

@end

@implementation NaviSetting

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)naviSettting{
    //1、改变导航栏背景颜色
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    //  navigationController?.navigationBar.barTintColor = UIColor.red
    
    //2、改变导航栏字体
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //    self.navigationController?self.navigationController.navigationBar.barStyle = .black
    
    //任意颜色、字体大小
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:25]}];
    
    //3、改变导航栏背景为图片
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"image"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    //1、导航栏设置
    
    //导航栏颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    
    
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
