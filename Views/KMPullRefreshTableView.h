//
//  KMPullRefreshTableView.h
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMPullRefreshTableViewDelegate.h"

#define TABLE_HEADER_VIEW_HEIGHT 60.0f
#define TABLE_FOOTER_VIEW_HEIGHT 44.0f

@class KMPullRefreshTableHeaderView, KMPullRefreshTableFooterView;

@interface KMPullRefreshTableView : UITableView

@property (weak, nonatomic) id<KMPullRefreshTableViewDelegate> delegate;

@property (nonatomic) BOOL loadMoreEnabled;

@property (nonatomic) KMPullRefreshTableHeaderView *pullRefreshTableHeaderView;
@property (nonatomic) KMPullRefreshTableFooterView *pullRefreshTableFooterView;

@end
