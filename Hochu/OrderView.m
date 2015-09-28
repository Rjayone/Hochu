//
//  OrderView.m
//  Hochu
//
//  Created by Andrew Medvedev on 28/09/15.
//  Copyright © 2015 Andew Medvedev. All rights reserved.
//

#import "OrderView.h"
#import "OrderItem.h"
#import "SDWebImageDownloader.h"

@implementation OrderView

//---------------------------------------------------------------------
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"OrderView"
//                                                          owner:self
//                                                        options:nil];
//        
//        UIView* mainView = (UIView*)[nibViews objectAtIndex:0];
//        
//        [self addSubview:mainView];
//    }
//    return self;
//}
//
////---------------------------------------------------------------------
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        
//        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"OrderView"
//                                                          owner:self
//                                                        options:nil];
//        
//        UIView* mainView = (UIView*)[nibViews objectAtIndex:0];
//        
//        [self addSubview:mainView];
//    }
//    return self;
//}

//---------------------------------------------------------------------
- (void)configureViewWithOrderItem:(OrderItem*)item {
    self.itemLabel.text = item.itemTitle;
    self.countLabel.text = [NSString stringWithFormat:@"x %ld", (long)item.count];
    self.summaryLabel.text = [NSString stringWithFormat:@"= %ld", (long)item.price * item.count];
    
    __weak typeof (self) wself = self;
//    __unused SDWebImageDownloader* dowloader = [[SDWebImageDownloader alloc]
//        downloadImageWithURL:item.image
//        options:SDWebImageDownloaderProgressiveDownload
//        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            
//        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//            wself.previewImage.image = image;
//        }];
}

@end
