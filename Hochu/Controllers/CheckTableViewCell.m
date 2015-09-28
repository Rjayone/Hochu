//
//  CheckTableViewCell.m
//  Hochu
//
//  Created by Andew Medvedev on 20.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import "CheckTableViewCell.h"
#import "CheckItem.h"
#import "OrderView.h"

@interface CheckTableViewCell ()
@property (strong, nonatomic) CheckItem* check;
@property (strong, nonatomic) NSArray* orderItems;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@end



@implementation CheckTableViewCell

- (void)awakeFromNib {
    self.background.layer.cornerRadius = 5.f;
    self.background.layer.borderColor = [[UIColor redColor]CGColor];
    self.background.layer.borderWidth = 0.5f;
    [[NSBundle mainBundle] loadNibNamed:@"OrderView" owner:self options:nil];
}



#pragma mark - Configurator
//---------------------------------------------------------------------
- (void)configureCellWithCheckItem:(CheckItem*)item {
    self.orderNumberLabel.text  = [NSString stringWithFormat:@"Ваш заказ #%ld", (long)item.ID];
    self.orderDateLabel.text    = [NSDateFormatter localizedStringFromDate:item.date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    self.addressLabel.text      = [NSString stringWithFormat:@"Доставка по адресу: %@",item.address];
    self.phoneLabel.text        = [NSString stringWithFormat:@"Тел:%@", item.phone];
    self.summaryLabel.text      = [NSString stringWithFormat:@"Всего к оплате: %ld", (long)item.totalPrice];
    
    self.check      = item;
    self.orderItems = item.orderItems;   
    
    for(OrderItem* order in item.orderItems) {
        OrderView* view = [[OrderView alloc]init];
        [view configureViewWithOrderItem:order];
    }
    
    self.contentViewHeightConstraint.constant = [self calculateContainerViewHeight];
}



#pragma mark - IBActions
//---------------------------------------------------------------------
- (IBAction)noButtonClicked:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(didNoButtonClickedForCheck:)])
        [self.delegate didNoButtonClickedForCheck:self.check];
}

//---------------------------------------------------------------------
- (IBAction)confirmButtonClicked:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(didConfirmButtonClickedForCheck:)])
        [self.delegate didConfirmButtonClickedForCheck:self.check];
}



#pragma mark - Helpers
//---------------------------------------------------------------------
- (CGFloat)calculateContainerViewHeight {
    OrderView* view = [[OrderView alloc]init];
    CGFloat height = CGRectGetHeight(view.bounds);
    
    if([self.delegate respondsToSelector:@selector(didContantViewHeightCalculated:)])
        [self.delegate didContantViewHeightCalculated:height];
    
    return height * self.orderItems.count;
}

@end
