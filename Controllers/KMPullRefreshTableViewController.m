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

@interface KMPullRefreshTableViewController ()

- (void)_setTableHeaderViewHidden:(BOOL)hidden;
- (void)_refresh;
- (void)_loadMore;

@end

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

- (void)dealloc {
  [self.pullRefreshTableFooterView.loadMoreButton removeTarget:self
                                                        action:@selector(_loadMore)
                                              forControlEvents:UIControlEventTouchDown];
}

- (void)loadView {
  [super loadView];
  
  UITableView *tableView = self.tableView;
  KMPullRefreshTableView *pullRefreshTableView = [[KMPullRefreshTableView alloc] initWithFrame:tableView.frame
                                                                                         style:tableView.style];
  BOOL loadMoreEnabled = self.loadMoreEnabled;
  pullRefreshTableView.loadMoreEnabled = loadMoreEnabled;
  pullRefreshTableView.delegate        = (id<KMPullRefreshTableViewDelegate>)tableView.delegate;
  pullRefreshTableView.dataSource      = tableView.dataSource;
  
  self.pullRefreshTableHeaderView = pullRefreshTableView.pullRefreshTableHeaderView;
  if (loadMoreEnabled) {
    self.pullRefreshTableFooterView = pullRefreshTableView.pullRefreshTableFooterView;
    self.pullRefreshTableFooterView.loadMoreTapEnabled = self.loadMoreTapEnabled;
  }
  
  self.tableView = pullRefreshTableView;
}

- (void)viewDidLoad {
  if (self.loadMoreTapEnabled) {
    [self.pullRefreshTableFooterView.loadMoreButton addTarget:self
                                                       action:@selector(_loadMore)
                                             forControlEvents:UIControlEventTouchDown];
  }
}

- (BOOL)isRefreshing {
  return self.pullRefreshTableHeaderView.status != KMPullRefreshTableHeaderViewDefault ? YES : NO;
}

- (BOOL)isLoadingMore {
  return self.pullRefreshTableFooterView.status != KMPullRefreshTableFooterViewDefault ? YES : NO;
}

- (BOOL)isSuspendedLoadMore {
  return self.pullRefreshTableFooterView.status == KMPullRefreshTableFooterViewSuspending ? YES : NO;
}

- (void)stopRefresh {
  self.pullRefreshTableHeaderView.status = KMPullRefreshTableHeaderViewDefault;
  [self _setTableHeaderViewHidden:YES];
}

- (void)stopLoadMore {
  self.pullRefreshTableFooterView.status = KMPullRefreshTableFooterViewDefault;
}

- (void)suspendLoadMore {
  self.pullRefreshTableFooterView.status = KMPullRefreshTableFooterViewSuspending;
}

- (void)resumeLoadMore {
  self.pullRefreshTableFooterView.status = KMPullRefreshTableFooterViewDefault;
}

#pragma mark - Private

- (void)_setTableHeaderViewHidden:(BOOL)hidden {
  CGFloat topOffset = 0.0f;
  if (!hidden) {
    topOffset = CGRectGetHeight(self.pullRefreshTableHeaderView.frame);
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
  self.pullRefreshTableHeaderView.status = KMPullRefreshTableHeaderViewLoading;
  if ([delegate respondsToSelector:@selector(pullRefreshTableViewWillRefresh:)]) {
    [delegate pullRefreshTableViewWillRefresh:self.tableView];
  }
}

- (void)_loadMore {
  id<KMPullRefreshTableViewDelegate> delegate = (id<KMPullRefreshTableViewDelegate>)self.tableView.delegate;
  self.pullRefreshTableFooterView.status = KMPullRefreshTableFooterViewLoading;
  if ([delegate respondsToSelector:@selector(pullRefreshTableViewWillLoadMore:)]) {
    [delegate pullRefreshTableViewWillLoadMore:self.tableView];
  }
}

@end
