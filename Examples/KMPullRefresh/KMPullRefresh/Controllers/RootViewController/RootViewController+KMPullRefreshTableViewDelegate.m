//
//  RootViewController+KMPullRefreshTableViewDelegate.m
//  KMPullRefresh
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import "RootViewController+KMPullRefreshTableViewDelegate.h"

@implementation RootViewController (KMPullRefreshTableViewDelegate)

- (void)pullRefreshTableViewWillRefresh:(UITableView *)tableView {
  [tableView performSelector:@selector(reloadData)
                  withObject:nil
                  afterDelay:1.0f];
}

- (void)pullRefreshTableViewWillLoadMore:(UITableView *)tableView {
  [self performSelector:@selector(suspendLoadMore)
             withObject:nil
             afterDelay:1.0f];
}

/*
- (void)pullRefreshTableViewDidLoad:(UITableView *)tableView {
}
*/

/*
- (void)pullRefreshTableViewWillReload:(UITableView *)tableView {
  [super pullRefreshTableViewWillReload:tableView];
}
*/

/*
- (void)pullRefreshTableViewDidReload:(UITableView *)tableView {
  [super pullRefreshTableViewDidReload:tableView];
}
*/

@end
