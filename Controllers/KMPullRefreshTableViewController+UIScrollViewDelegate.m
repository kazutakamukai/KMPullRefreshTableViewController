//
//  KMPullRefreshTableViewController+UIScrollViewDelegate.m
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import "KMPullRefreshTableViewController+UIScrollViewDelegate.h"
#import "KMPullRefreshTableViewDelegate.h"
#import "KMPullRefreshTableHeaderView.h"
#import "KMPullRefreshTableFooterView.h"

@implementation KMPullRefreshTableViewController (UIScrollViewDelegate)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  UITableView                  *tableView       = self.tableView;
  KMPullRefreshTableHeaderView *tableHeaderView = self.tableHeaderView;
  KMPullRefreshTableFooterView *tableFooterView = self.tableFooterView;
  
  CGFloat topOffset    = scrollView.contentOffset.y;
  CGFloat headerHeight = CGRectGetHeight(tableHeaderView.frame);
  CGFloat threshold    = -(headerHeight + 15.0f);
  
  if (tableHeaderView.status == KMPullRefreshTableHeaderViewLoading) {
    if (tableView.dragging &&
        threshold <= topOffset && topOffset < headerHeight) {
      CGFloat offset = MAX(-tableView.contentOffset.y, 0.0f);
      offset = MIN(offset, TABLE_HEADER_VIEW_HEIGHT);
      tableView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		}
    return;
  }
  
  if (topOffset < threshold) {
    tableHeaderView.status = KMPullRefreshTableHeaderViewPulling;
  } else if (threshold <= topOffset && topOffset < headerHeight) {
    tableHeaderView.status = KMPullRefreshTableHeaderViewDefault;
  }
  
  if (tableFooterView.status != KMPullRefreshTableFooterViewDefault) {
    return;
  }
  
  CGFloat contentHeight   = CGRectGetMinY(tableFooterView.frame) - CGRectGetHeight(tableView.frame);
  CGFloat thresholdOffset = contentHeight - 250.0f;
  
  if (!self.loadMoreTapEnabled &&
      0.0f < thresholdOffset && thresholdOffset <= topOffset &&
      topOffset < contentHeight) {
    [self _loadMore];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
  KMPullRefreshTableHeaderView *tableHeaderView = self.tableHeaderView;
  if (tableHeaderView.status == KMPullRefreshTableHeaderViewPulling) {
    [self _refresh];
    [self _setTableHeaderViewHidden:NO];
  }
}

@end
