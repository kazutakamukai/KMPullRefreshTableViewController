//
//  KMPullRefreshTableView.m
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import "KMPullRefreshTableView.h"
#import "KMPullRefreshTableHeaderView.h"
#import "KMPullRefreshTableFooterView.h"

@implementation KMPullRefreshTableView

- (id)initWithFrame:(CGRect)frame
              style:(UITableViewStyle)style {
  self = [super initWithFrame:frame
                        style:style];
  if (self) {
    CGRect tableHeaderFrame = CGRectMake(0.0f, -TABLE_HEADER_VIEW_HEIGHT, CGRectGetWidth(self.frame), TABLE_HEADER_VIEW_HEIGHT);
    self.pullRefreshTableHeaderView = [[KMPullRefreshTableHeaderView alloc] initWithFrame:tableHeaderFrame];
    [self addSubview:self.pullRefreshTableHeaderView];
  }
  
  return self;
}

- (void)setLoadMoreEnabled:(BOOL)loadMoreEnabled {
  if (loadMoreEnabled) {
    if (!self.pullRefreshTableFooterView) {
      CGRect tableFooterFrame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), TABLE_FOOTER_VIEW_HEIGHT);
      self.pullRefreshTableFooterView = [[KMPullRefreshTableFooterView alloc] initWithFrame:tableFooterFrame];
    }
    
    self.tableFooterView = self.pullRefreshTableFooterView;
  } else {
    self.tableFooterView = nil;
  }
  
  _loadMoreEnabled = loadMoreEnabled;
}

- (void)reloadData {
  id<KMPullRefreshTableViewDelegate> delegate = self.delegate;
  if ([delegate respondsToSelector:@selector(pullRefreshTableViewWillReloadData:)]) {
    [delegate pullRefreshTableViewWillReloadData:self];
  }
  [super reloadData];
}

@end
