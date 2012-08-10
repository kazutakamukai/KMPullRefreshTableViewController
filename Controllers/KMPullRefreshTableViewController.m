//
//  KMPullRefreshTableViewController.m
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import "KMPullRefreshTableViewController.h"
#import "KMPullRefreshTableView.h"
#import "KMPullRefreshTableHeaderView.h"
#import "KMPullRefreshTableFooterView.h"

@implementation KMPullRefreshTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    self.loadMoreEnabled                       = YES;
    self.loadMoreTapEnabled                    = NO;
    self.animateReturnAfterRefreshWithDuration = 0.2f;
  }
  
  return self;
}

- (void)loadView {
  [super loadView];
  
  UITableView *tableView = self.tableView;
  UITableView *pullRefreshTableView = [[KMPullRefreshTableView alloc] initWithFrame:tableView.frame
                                                                              style:tableView.style];
  pullRefreshTableView.delegate   = tableView.delegate;
  pullRefreshTableView.dataSource = tableView.dataSource;
  
  CGFloat tableWidth = CGRectGetWidth(pullRefreshTableView.frame);
  _tableHeaderView = [[KMPullRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, -60.0f, tableWidth, 60.0f)];
  [pullRefreshTableView addSubview:_tableHeaderView];
  if (self.loadMoreEnabled) {
    pullRefreshTableView.tableFooterView = _tableFooterView = [[KMPullRefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableWidth, 44.0f)
                                                                                               loadMoreTapEnabled:self.loadMoreTapEnabled];
    [_tableFooterView.loadMoreButton addTarget:self
                                        action:@selector(_loadMore)
                              forControlEvents:UIControlEventTouchDown];
  }
  
  self.tableView = pullRefreshTableView;
}

- (void)stopRefresh {
  self.tableHeaderView.status = KMPullRefreshTableHeaderViewDefault;
  [self _setTableHeaderViewHidden:YES];
}

- (void)stopLoadMore {
  self.tableFooterView.status = KMPullRefreshTableFooterViewDefault;
}

- (void)suspendLoadMore {
  self.tableFooterView.status = KMPullRefreshTableFooterViewSuspending;
}

#pragma mark -
#pragma mark Private

- (void)_setTableHeaderViewHidden:(BOOL)hidden {
  CGFloat topOffset = 0.0f;
  if (!hidden) {
    topOffset = CGRectGetHeight(self.tableHeaderView.frame);
  }
  
  [UIView animateWithDuration:self.animateReturnAfterRefreshWithDuration
                        delay:0.0f
                      options:UIViewAnimationOptionAllowUserInteraction
                   animations:^{
                     self.tableView.contentInset = UIEdgeInsetsMake(topOffset, 0.0f, 0.0f, 0.0f);
                   }
                   completion:nil];
}

- (void)_refresh {
  id<KMPullRefreshTableViewDelegate> delegate = (id<KMPullRefreshTableViewDelegate>)self.tableView.delegate;
  self.tableHeaderView.status = KMPullRefreshTableHeaderViewLoading;
  if ([delegate respondsToSelector:@selector(pullRefreshTableViewWillRefresh:)]) {
    [delegate pullRefreshTableViewWillRefresh:self.tableView];
  }
}

- (void)_loadMore {
  id<KMPullRefreshTableViewDelegate> delegate = (id<KMPullRefreshTableViewDelegate>)self.tableView.delegate;
  self.tableFooterView.status = KMPullRefreshTableFooterViewLoading;
  if ([delegate respondsToSelector:@selector(pullRefreshTableViewWillLoadMore:)]) {
    [delegate pullRefreshTableViewWillLoadMore:self.tableView];
  }
}

@end
