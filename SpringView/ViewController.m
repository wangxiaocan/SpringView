//
//  ViewController.m
//  SpringView
//
//  Created by 王文科 on 2017/4/6.
//  Copyright © 2017年 xiaocan. All rights reserved.
//

#import "ViewController.h"
#import "BaseSendTextView.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) BaseSendTextView  *textView;
@property (nonatomic, strong) UIButton          *showOrHidBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak typeof(self) weakSelf = self;
    _textView = [[BaseSendTextView alloc]initWithFrame:self.view.bounds andButtonTitleAndImages:@[@{@"title":@"QQ",@"image":@"QQ"},@{@"title":@"QQ空间",@"image":@"QQZone"},@{@"title":@"微信",@"image":@"WeiChat"},@{@"title":@"朋友圈",@"image":@"WeiChatline"},@{@"title":@"微博",@"image":@"WeiBo"}] withColumnNums:3 withBlock:^(id btnInfo, NSInteger index) {
        
        [UIView animateWithDuration:weakSelf.textView.animateTime / 2.0 animations:^{
            weakSelf.showOrHidBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
        } completion:^(BOOL finished) {
            [weakSelf.showOrHidBtn setImage:[UIImage imageNamed:@"D_Cn_Order_Add"] forState:UIControlStateNormal];
            [weakSelf.showOrHidBtn setImage:[UIImage imageNamed:@"D_Cn_Order_Add"] forState:UIControlStateNormal];
            weakSelf.showOrHidBtn.transform = CGAffineTransformMakeRotation(0);
        }];
    }];
    [self.view addSubview:_textView];
    
    _showOrHidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_showOrHidBtn setImage:[UIImage imageNamed:@"D_Cn_Order_Add"] forState:UIControlStateNormal];
    [_showOrHidBtn setImage:[UIImage imageNamed:@"D_Cn_Order_Add"] forState:UIControlStateNormal];
    [_showOrHidBtn addTarget:self action:@selector(showOrHiddenTextView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_showOrHidBtn];
    
    [_showOrHidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20.0);
        make.width.and.height.mas_equalTo(35.0);
    }];
}

- (void)showOrHiddenTextView:(UIButton *)sender{
    if (_textView.alpha == 1.0) {
        [_textView hiddenSendTextView];
        [UIView animateWithDuration:_textView.animateTime / 2.0 animations:^{
            _showOrHidBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
        } completion:^(BOOL finished) {
            [_showOrHidBtn setImage:[UIImage imageNamed:@"D_Cn_Order_Add"] forState:UIControlStateNormal];
            [_showOrHidBtn setImage:[UIImage imageNamed:@"D_Cn_Order_Add"] forState:UIControlStateNormal];
            _showOrHidBtn.transform = CGAffineTransformMakeRotation(0);
        }];
    }else{
        [_textView showSendTextView];
        [UIView animateWithDuration:_textView.animateTime / 2.0 animations:^{
            _showOrHidBtn.transform = CGAffineTransformMakeRotation(M_PI_4);
        } completion:^(BOOL finished) {
            _showOrHidBtn.transform = CGAffineTransformMakeRotation(0);
            [_showOrHidBtn setImage:[UIImage imageNamed:@"D_Cn_Order_Delete"] forState:UIControlStateNormal];
            [_showOrHidBtn setImage:[UIImage imageNamed:@"D_Cn_Order_Delete"] forState:UIControlStateNormal];
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
