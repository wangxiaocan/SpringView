//
//  BaseSendTextView.m
//  vodSeal
//
//  Created by 王文科 on 2017/4/6.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import "BaseSendTextView.h"
#import "BaseSendBtnView.h"
#import "UIImageView+WebCache.h"

#define RGB(r, g, b, a)                     [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)]

#define BTN_WIDTH           60//按钮宽度

#define BTN_FRAME_X         10.0//按钮x开始坐标(距父视图左边距)
#define BTN_MINI_SPACE      5.0//按钮之间最小间距

@interface BaseSendTextView()

@property (nonatomic, assign, readwrite) NSInteger      columnNum;/**< 按钮列数 */
@property (nonatomic, assign, readwrite) CGFloat        animateTime;
@property (nonatomic, assign)  CGSize       btnViewSize;/**< 按钮视图大小 */
@property (nonatomic, assign)  CGFloat      btnFrameX;//按钮起始X坐标（以此为准）
@property (nonatomic, assign)  CGFloat      btnFrameY;//按钮起始Y坐标
@property (nonatomic, assign)  CGFloat      btnItemSpace;//按钮间距（与btnFrameX相同）
@property (nonatomic, assign)  NSInteger    btnRowNum;//按钮行数

@property (nonatomic, copy)  BaseSendTextBlock    myBlock;

@property (nonatomic, strong)  NSMutableArray<BaseSendBtnView *>    *btnViewArray;

@end

@implementation BaseSendTextView

- (NSMutableArray<BaseSendBtnView *> *)btnViewArray{
    if (!_btnViewArray) {
        self.btnViewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _btnViewArray;
}

/** (NSArray<NSDictionary *> *) {"title":"btn title","iamge":"btn image",...} */
- (instancetype)initWithFrame:(CGRect)frame andButtonTitleAndImages:(NSArray<NSDictionary *> *)titleAndImages withColumnNums:(NSInteger)columnNum withBlock:(BaseSendTextBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        self.myBlock = block;
        self.alpha = 0.f;
        self.animateTime = 0.7;
        self.backgroundColor = RGB(0, 0, 0, 0.7);
        if (titleAndImages.count > 0) {
            NSInteger columnMaxNum = ((frame.size.width - BTN_FRAME_X * 2.0 - BTN_MINI_SPACE * 2.0) / BTN_WIDTH);
            self.columnNum = (columnNum >= 3)?columnNum:3;
            self.columnNum = (columnNum <= columnMaxNum)?columnNum:columnMaxNum;
            _btnViewSize = CGSizeMake(BTN_WIDTH, BTN_WIDTH + 40.0);
            _btnRowNum = (titleAndImages.count + self.columnNum - 1) / self.columnNum;
            _btnFrameX = (frame.size.width - BTN_WIDTH * self.columnNum) / (self.columnNum + 1);
            _btnFrameY = frame.size.height / 2.0 - _btnViewSize.height * _btnRowNum / 2.0;
            _btnItemSpace = _btnFrameX;
            for (int i = 0; i < titleAndImages.count; i++) {
                NSString *titleStr = [[titleAndImages objectAtIndex:i] objectForKey:@"title"];
                NSString *imageStr = [[titleAndImages objectAtIndex:i] objectForKey:@"image"];
                BaseSendBtnView *btnView = [[BaseSendBtnView alloc]initWithFrame:CGRectMake(_btnFrameX + (_btnViewSize.width + _btnItemSpace) * (i % self.columnNum), frame.size.height + (i / self.columnNum) * _btnViewSize.height, _btnViewSize.width, _btnViewSize.height)];
                btnView.viewInfo = [titleAndImages objectAtIndex:i];
                //[btnView.btnImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
                btnView.btnImageView.image = [UIImage imageNamed:imageStr];
                btnView.btnTitleLabel.text = titleStr;
                btnView.sendViewButton.tag = i;
                [btnView.sendViewButton addTarget:self action:@selector(sendViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btnView];
                [self.btnViewArray addObject:btnView];
            }
        }
    }
    return self;
}


- (void)sendViewButtonClicked:(UIButton *)sender{
    if (self.myBlock) {
        BaseSendBtnView *btnView = (BaseSendBtnView *)sender.superview;
        self.myBlock(btnView.viewInfo, btnView.sendViewButton.tag);
    }
    [self hiddenSendTextView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.myBlock) {
        self.myBlock(nil, -1);
    }
    [self hiddenSendTextView];
}

- (void)showSendTextView{
    self.alpha = 1.0f;
    CGFloat delyTime = 0.08;
    for (int i = 0; i < self.btnViewArray.count; i++) {
        __strong BaseSendBtnView *btnView = [self.btnViewArray objectAtIndex:i];
        if (i == self.btnViewArray.count - 1) {
            [UIView animateWithDuration:self.animateTime delay:delyTime * i usingSpringWithDamping:0.6 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                btnView.frame = CGRectMake(_btnFrameX + (_btnViewSize.width + _btnItemSpace) * (i % self.columnNum), _btnFrameY + (i / self.columnNum) * _btnViewSize.height, _btnViewSize.width, _btnViewSize.height);
            } completion:^(BOOL finished) {
                
            }];
        }else{
            [UIView animateWithDuration:self.animateTime delay:delyTime * i usingSpringWithDamping:0.6 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                btnView.frame = CGRectMake(_btnFrameX + (_btnViewSize.width + _btnItemSpace) * (i % self.columnNum), _btnFrameY + (i / self.columnNum) * _btnViewSize.height, _btnViewSize.width, _btnViewSize.height);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

- (void)hiddenSendTextView{
    CGFloat delyTime = 0.08;
    for (int i = 0; i < self.btnViewArray.count; i++) {
        __strong BaseSendBtnView *btnView = [self.btnViewArray objectAtIndex:i];
        if (i == self.btnViewArray.count - 1) {
            [UIView animateWithDuration:self.animateTime delay:delyTime * (self.btnViewArray.count - i - 1) usingSpringWithDamping:0.7 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                btnView.frame = CGRectMake(_btnFrameX + (_btnViewSize.width + _btnItemSpace) * (i % self.columnNum), self.frame.size.height + (i / self.columnNum) * _btnViewSize.height, _btnViewSize.width, _btnViewSize.height);
            } completion:^(BOOL finished) {
                self.alpha = 0.f;
            }];
        }else{
            [UIView animateWithDuration:self.animateTime delay:delyTime * (self.btnViewArray.count - i - 1) usingSpringWithDamping:0.7 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                btnView.frame = CGRectMake(_btnFrameX + (_btnViewSize.width + _btnItemSpace) * (i % self.columnNum), self.frame.size.height + (i / self.columnNum) * _btnViewSize.height, _btnViewSize.width, _btnViewSize.height);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

@end
