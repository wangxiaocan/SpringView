//
//  BaseSendBtnView.m
//  vodSeal
//
//  Created by 王文科 on 2017/4/6.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import "BaseSendBtnView.h"
#import "Masonry.h"

@implementation BaseSendBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = NO;
        
        _btnImageView = [[UIImageView alloc]init];
        [self addSubview:_btnImageView];
        
        _btnTitleLabel = [[UILabel alloc]init];
        _btnTitleLabel.textColor = [UIColor whiteColor];
        _btnTitleLabel.textAlignment = NSTextAlignmentCenter;
        _btnTitleLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_btnTitleLabel];
        
        _sendViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_sendViewButton];
        
        [_btnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(_btnImageView.mas_width);
        }];
        
        [_btnTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btnImageView.mas_bottom);
            make.bottom.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [_sendViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

@end
