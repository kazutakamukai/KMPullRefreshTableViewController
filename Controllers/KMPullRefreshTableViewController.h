//
//  KMPullRefreshTableViewController.h
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KMPullRefreshTableViewDelegate.h"

@class KMPullRefreshTableHeaderView, KMPullRefreshTableFooterView;

@interface KMPullRefreshTableViewController : UITableViewController<KMPullRefreshTableViewDelegate>

@property (nonatomic) BOOL    loadMoreEnabled;
@property (nonatomic) BOOL    loadMoreTapEnabled;
@property (nonatomic) CGFloat animateReturnAfterRefreshWithDuration;

@property (nonatomic, readonly) KMPullRefreshTableHeaderView *tableHeaderView;
@property (nonatomic, readonly) KMPullRefreshTableFooterView *tableFooterView;

- (void)stopRefresh;
- (void)stopLoadMore;
- (void)suspendLoadMore;

@end
