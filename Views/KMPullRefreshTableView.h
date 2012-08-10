//
//  KMPullRefreshTableView.h
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMPullRefreshTableViewDelegate.h"

@interface KMPullRefreshTableView : UITableView

@property(weak, nonatomic) id<KMPullRefreshTableViewDelegate> delegate;

@end
