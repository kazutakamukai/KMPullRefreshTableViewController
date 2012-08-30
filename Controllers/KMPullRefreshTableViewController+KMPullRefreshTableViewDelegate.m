//
//  KMPullRefreshTableViewController+KMPullRefreshTableViewDelegate.m
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import "KMPullRefreshTableViewController+KMPullRefreshTableViewDelegate.h"
#import "KMPullRefreshTableFooterView.h"

@implementation KMPullRefreshTableViewController (KMPullRefreshTableViewDelegate)

- (void)pullRefreshTableViewWillReloadData:(UITableView *)tableView {
  [self stopRefresh];
  if (self.pullRefreshTableFooterView.status != KMPullRefreshTableFooterViewSuspending) {
    [self stopLoadMore];
  }
}

@end
