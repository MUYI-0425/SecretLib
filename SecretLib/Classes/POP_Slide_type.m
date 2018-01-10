//
//  POP_Slide_type.m
//  Yun
//
//  Created by apple on 17/5/15.
//  Copyright © 2017年 孙晓东. All rights reserved.
//

#import "POP_Slide_type.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
typedef void(^selectResult)(int selectIndex);
@interface POP_Slide_type()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)UIButton *sureBtn;
@property (nonatomic,strong)UILabel *title_lable;
@property (nonatomic,strong)UIPickerView *pick_view;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,copy)selectResult select_result;
@property (nonatomic)int select_case;

@property (nonatomic,strong)UIColor *backColor;
@property (nonatomic,strong)UIColor *titleColor;
@end


@implementation POP_Slide_type

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
        _backView.backgroundColor = _backColor;
    }
    return _backView;
}

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(5, 5, 60, 30);
        [_cancleBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.layer.borderWidth = 1;
        _cancleBtn.layer.borderColor = self.titleColor.CGColor;
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_cancleBtn addTarget:self action:@selector(cancle_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(WIDTH - 65, 5, 60, 30);
        [_sureBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _sureBtn.layer.borderWidth = 1;
        _sureBtn.layer.borderColor = self.titleColor.CGColor;
        [_sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
- (UILabel *)title_lable {
    if (!_title_lable) {
        _title_lable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 90, 0, 180, 40)];
        _title_lable.font = [UIFont systemFontOfSize:17.0];
        _title_lable.textColor = self.titleColor;
        _title_lable.text = @"请选择模式";
        _title_lable.textAlignment = NSTextAlignmentCenter;
    }
    return _title_lable;
}
- (UIPickerView *)pick_view {
    if (!_pick_view) {
        _pick_view = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, 160)];
        _pick_view.showsSelectionIndicator = YES;
        _pick_view.delegate = self;
        _pick_view.dataSource = self;
    }
    return _pick_view;
}

- (instancetype)initWithFrame:(CGRect)frame backColor:(UIColor *)backColor titleColor:(UIColor *)titleColor selectResult:(void(^)(int selectIndex))selectIndex {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.backColor = backColor;
        self.titleColor = titleColor;
        
        self.frame = frame;
        [self addSubview:self.backView];
        [self.backView addSubview:self.cancleBtn];
        [self.backView addSubview:self.sureBtn];
        [self.backView addSubview:self.title_lable];
        [self addSubview:self.pick_view];
        self.select_result = selectIndex;
        
        self.dataSource = [NSMutableArray arrayWithObjects:@"5分钟",@"10分钟",@"半小时",@"1小时",@"2小时",@"4小时",@"8小时",@"1次", nil];
        
        [self.pick_view selectRow:0 inComponent:0 animated:YES];
        
        self.select_case = 0;
    }
    return self;
}

- (void)cancle_action:(id)sender {
    if (self.select_result) {
        self.select_result(-1);
    }
}

- (void)sureAction:(id)sender {
    if (self.select_result) {
        self.select_result(self.select_case);
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return WIDTH;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *mycom1 = [[UILabel alloc] init];
    mycom1.textAlignment = NSTextAlignmentCenter;
    mycom1.backgroundColor = [UIColor whiteColor];
    mycom1.frame = CGRectMake(0, 0, self.frame.size.width/5.0, 50);
    mycom1.font = [UIFont systemFontOfSize:15.0];
    mycom1.text = [NSString stringWithFormat:@"%@",self.dataSource[row]];
    return mycom1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.select_case = (int)row;
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
