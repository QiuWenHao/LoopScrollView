//
//  ViewController.m
//  LoopScrollView
//
//  Created by wenHao Qiu on 2018/4/4.
//  Copyright © 2018年 文豪. All rights reserved.
//

#import "ViewController.h"
#import "WHLoopScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createLoopScrollView];
}

- (void)createLoopScrollView {
    
    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1000 , 35)];
    
    /**如果字体是动态的，label的宽度可以用系统的sizeWithAttribute动态计算，防止字体显示不全*/
    promptLabel.font = [UIFont systemFontOfSize:15];
    
    promptLabel.text = @"死亡如风常伴吾身，面对疾风吧，无心之刃最为致命，lol比尔吉沃特，账号：都是因为我丶，QQ:664952091，你对代码有什么意见或改进的找我";
    WHLoopScrollView *promptView = [[WHLoopScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    
    promptView.backgroundColor = [UIColor orangeColor];
    
    promptView.margin = 66;
    
    promptView.views = [NSMutableArray arrayWithArray:@[promptLabel]];
    
    [self.view addSubview:promptView];
    
    /*启动后将永远不会停止，即使控制器销毁也不会停止，只有程序退出才会停止*/
    [promptView fire];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
