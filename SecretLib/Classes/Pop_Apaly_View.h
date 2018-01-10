//
//  Pop_Apaly_View.h
//  Yun
//
//  Created by apple on 17/5/15.
//  Copyright © 2017年 孙晓东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Pop_Apaly_View : UIView
+ (void)pop_Apaly_viewBackColor:(UIColor *)backColor titleColor:(UIColor *)titleColor select_result:(void(^)(int select_index))select_result;
@end
