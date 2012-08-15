//
//  KMPullRefreshTableHeaderView.h
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  KMPullRefreshTableHeaderViewDefault,
  KMPullRefreshTableHeaderViewPulling,
  KMPullRefreshTableHeaderViewLoading
} KMPullRefreshTableHeaderViewStatus;

@interface KMPullRefreshTableHeaderView : UIView

@property (nonatomic) KMPullRefreshTableHeaderViewStatus status;

@end

@interface KMPullRefreshTableHeaderView ()

- (void)_animateRotationToUpper:(BOOL)Upper
                         hidden:(BOOL)hidden;
- (void)_startIndicator;
- (void)_stopIndicator;

@end
