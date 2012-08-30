//
//  KMPullRefreshTableHeaderView.h
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  KMPullRefreshTableHeaderViewDefault,
  KMPullRefreshTableHeaderViewPulling,
  KMPullRefreshTableHeaderViewLoading
} KMPullRefreshTableHeaderViewStatus;

@interface KMPullRefreshTableHeaderView : UIView

@property (nonatomic) KMPullRefreshTableHeaderViewStatus status;

@property (nonatomic) UILabel                 *label;
@property (nonatomic) UIImageView             *imageView;
@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;

@end
