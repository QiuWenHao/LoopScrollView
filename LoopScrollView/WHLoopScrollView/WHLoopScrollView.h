//
//  WHLoopScrollView.h
//  LoopScrollView
//
//  Created by wenHao Qiu on 2018/4/4.
//  Copyright © 2018年 文豪. All rights reserved.
//  github下载地址 https://github.com/QiuWenHao/WHLoopScrollView
//  QQ：664952091
//

#import <UIKit/UIKit.h>

/*
 想循环滚动，必须用"initWithFrame"来创建
 */
@interface WHLoopScrollView : UIScrollView

//Timer
@property (nonatomic, strong) CADisplayLink * timer;

//把一些view放到这个数组中, 将会被显示(注意：Views不能是空)
@property (nonatomic, strong) NSMutableArray * views;

//默认是no
@property (nonatomic, assign) BOOL isUserInteraction;

//默认是垂直方向居中
@property (nonatomic, assign) BOOL  isCenterVertical;

//direction
//@property (nonatomic, copy) NSString * direction;

//开始滚动的位置，默认从视图最右边开始
@property (nonatomic, assign) CGFloat startX;

//view与view之间的空白部分
@property (nonatomic, assign) CGFloat  margin;

//速度的倍数
@property(nonatomic, assign)int speed;

//是否和第一个view等宽，默认是no
@property (nonatomic, assign) BOOL  isSingle;

-(void)fire;
-(void)stop;

@end
