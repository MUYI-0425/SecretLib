//
//  Pop_Apaly_View.m
//  Yun
//
//  Created by apple on 17/5/15.
//  Copyright © 2017年 孙晓东. All rights reserved.
//

#import "Pop_Apaly_View.h"
#import "POP_Slide_type.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
static Pop_Apaly_View *pop;
static POP_Slide_type *pop_slide;
@implementation Pop_Apaly_View
+ (void)pop_Apaly_viewBackColor:(UIColor *)backColor titleColor:(UIColor *)titleColor select_result:(void(^)(int select_index))select_result {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    pop = [[Pop_Apaly_View alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    pop.backgroundColor = [UIColor blackColor];
    pop.alpha = 0.5;
    [keyWindow addSubview:pop];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissApaly:)];
    [pop addGestureRecognizer:tap];

    pop_slide = [[POP_Slide_type alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 200) backColor:backColor titleColor:titleColor selectResult:^(int selectIndex) {
        [Pop_Apaly_View dismissApaly:nil];
        select_result(selectIndex);
    }];
    [keyWindow addSubview:pop_slide];
    [UIView animateWithDuration:0.3 animations:^{
        pop_slide.transform = CGAffineTransformMakeTranslation(0,-200);
    }];
    
}

+ (void)dismissApaly:(UITapGestureRecognizer *)tap {
    pop.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        pop_slide.transform = CGAffineTransformMakeTranslation(0,200);
    } completion:^(BOOL finished) {
        [pop_slide removeFromSuperview];
        [pop removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
