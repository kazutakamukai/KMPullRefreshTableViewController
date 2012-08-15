//
//  KMPullRefreshTableViewDelegate.h
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KMPullRefreshTableViewDelegate<NSObject, UITableViewDelegate>

@optional
- (void)pullRefreshTableViewWillRefresh:(UITableView *)tableView;
- (void)pullRefreshTableViewWillLoadMore:(UITableView *)tableView;
- (void)pullRefreshTableViewWillReloadData:(UITableView *)tableView;

@end
