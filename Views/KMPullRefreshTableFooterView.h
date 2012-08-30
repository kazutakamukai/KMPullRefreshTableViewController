//
//  KMPullRefreshTableFooterView.h
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  KMPullRefreshTableFooterViewDefault,
  KMPullRefreshTableFooterViewLoading,
  KMPullRefreshTableFooterViewSuspending
} KMPullRefreshTableFooterViewStatus;

@interface KMPullRefreshTableFooterView : UIView

@property (nonatomic) KMPullRefreshTableFooterViewStatus status;

@property (nonatomic) BOOL loadMoreTapEnabled;

@property (nonatomic) UIButton                *loadMoreButton;
@property (nonatomic) UIImageView             *imageView;
@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;

@end
