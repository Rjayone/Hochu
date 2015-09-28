//
//  CheckTableViewCell.h
//  Hochu
//
//  Created by Andew Medvedev on 20.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckItem;
@protocol CheckTableViewCellDelegate;

//---------------------------------------------------------------------
@interface CheckTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView   *background;
@property (weak, nonatomic) IBOutlet UILabel  *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel  *orderDateLabel;
@property (weak, nonatomic) IBOutlet UILabel  *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel  *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel  *summaryLabel;
@property (weak, nonatomic) IBOutlet UIView   *orderItemsContentView;
@property (weak, nonatomic) IBOutlet UIButton *noButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmOrderButton;
@property (weak, nonatomic) id<CheckTableViewCellDelegate> delegate;


- (void)configureCellWithCheckItem:(CheckItem*)item;

@end


//---------------------------------------------------------------------
@protocol CheckTableViewCellDelegate <NSObject>
@optional
- (void)didContantViewHeightCalculated:(CGFloat)height;
- (void)didNoButtonClickedForCheck:(CheckItem*)check;
- (void)didConfirmButtonClickedForCheck:(CheckItem*)check;

@end