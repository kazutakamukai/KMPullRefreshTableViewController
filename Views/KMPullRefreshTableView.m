//
//  KMPullRefreshTableView.m
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import "KMPullRefreshTableView.h"
#import "KMPullRefreshTableViewDelegate.h"

@implementation KMPullRefreshTableView

- (void)reloadData {
  id delegate = self.delegate;
  if ([delegate respondsToSelector:@selector(pullRefreshTableViewWillReloadData:)]) {
    [delegate pullRefreshTableViewWillReloadData:self];
  }
  [super reloadData];
}

@end
