//
//  WHLoopScrollView.m
//  LoopScrollView
//
//  Created by wenHao Qiu on 2018/4/4.
//  Copyright © 2018年 文豪. All rights reserved.
//  github下载地址 https://github.com/QiuWenHao/WHLoopScrollView
//  QQ：664952091
//

#import "WHLoopScrollView.h"

@interface WHLoopScrollView ()

@property (nonatomic, weak) UIView * firstView;

//重置self.contentOffset的位置
@property (nonatomic, assign) CGFloat  displayX;

//记录开始位置
@property (nonatomic, assign) CGFloat  startX_Flag;

@end

@implementation WHLoopScrollView

- (CADisplayLink *)timer{
    
    if (_timer == nil) {
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(moveInCircle)];
        [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)moveInCircle{
    
    if (self.contentOffset.x >= self.displayX ) {
        [self setContentOffset:CGPointMake(_startX, 0)];
    }
    self.contentOffset = CGPointMake(self.contentOffset.x + 1 * self.speed, 0);
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;
        self.isCenterVertical = YES;
        self.startX = frame.size.width;
        self.margin = 10;
        self.speed = 1;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    //max height
    CGFloat maxHeight = 0.0;
    
    NSAssert(self.views.count >= 2, @"count of views must > 1");
    
    
    for (NSInteger i = 0; i < self.views.count; i++) {
        
        if ([self.views[i] isKindOfClass:[UIView class]]) {
            UIView * view = self.views[i];
            if (i == 0) {
                maxHeight = view.frame.size.height;
                if (self.isSingle) {
                    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, view.frame.size.width, view.frame.size.height);
                }
            }else{
                if (maxHeight < view.frame.size.height) {
                    maxHeight = view.frame.size.height;
                }
            }
            CGFloat v_width = view.frame.size.width;
            CGFloat v_height = view.frame.size.height;
            CGFloat v_y = 0.0;
            if (self.isCenterVertical) {
                
                v_y = (self.frame.size.height - v_height) * 0.5;
            }
            else {
                
                v_y = view.frame.origin.y;
            }
            view.frame = CGRectMake(_startX, v_y, v_width, v_height);
            [self addSubview:view];
            _startX += view.frame.size.width + self.margin;
            if (self.views.count - 2 == i) {
                self.displayX = _startX;
            }
        }
        
    }
    
    [self setContentSize:CGSizeMake(_startX, maxHeight)];
    _startX = _startX_Flag;
}

- (void)setViews:(NSMutableArray *)views{
    
    if (views == nil || views.count == 0) {
        return;
    }
    
    _views = views;
    
    if ([views[0] isKindOfClass:[UIView class]]) {
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:_views[0]];
        self.firstView = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [_views addObject:self.firstView];
        
    }
    
}
- (void)setStartX:(CGFloat)startX {
    _startX = startX;
    self.startX_Flag = _startX;
}
- (void)setIsUserInteraction:(BOOL)isUserInteraction{
    
    _isUserInteraction = isUserInteraction;
    self.userInteractionEnabled = isUserInteraction;
}

- (void)fire{
    
    [self timer];
}

- (void)stop{
    
    [self.timer invalidate];
}

@end
