//
//  BaseSendBtnView.h
//  vodSeal
//
//  Created by 王文科 on 2017/4/6.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**< BaseSendTextView 界面按钮 */
@interface BaseSendBtnView : UIView

@property (nonatomic, strong) UIImageView   *btnImageView;/**< image */
@property (nonatomic, strong) UILabel       *btnTitleLabel;/**< bottom title */
@property (nonatomic, strong) UIButton      *sendViewButton;/**< view button */

@property (nonatomic, strong) id            viewInfo;

@end
