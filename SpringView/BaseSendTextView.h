//
//  BaseSendTextView.h
//  vodSeal
//
//  Created by 王文科 on 2017/4/6.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BaseSendTextBlock)(id btnInfo,NSInteger index);

@interface BaseSendTextView : UIView

/** (NSArray<NSDictionary *> *) {"title":"btn title","iamge":"btn image",...} */
- (instancetype)initWithFrame:(CGRect)frame andButtonTitleAndImages:(NSArray<NSDictionary *> *)titleAndImages withColumnNums:(NSInteger)columnNum withBlock:(BaseSendTextBlock)block;

@property (nonatomic, assign, readonly) NSInteger columnNum;


@property (nonatomic, assign, readonly) CGFloat     animateTime;


- (void)showSendTextView;

- (void)hiddenSendTextView;

@end
