//
//  POP_Slide_type.h
//  Yun
//
//  Created by apple on 17/5/15.
//  Copyright © 2017年 孙晓东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POP_Slide_type : UIView
- (instancetype)initWithFrame:(CGRect)frame backColor:(UIColor *)backColor titleColor:(UIColor *)titleColor selectResult:(void(^)(int selectIndex))selectIndex;
@end
