//
//  KMPullRefreshTableFooterView.m
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import "KMPullRefreshTableFooterView.h"

@interface KMPullRefreshTableFooterView ()

- (void)_startIndicator;
- (void)_stopIndicator;

@end

@implementation KMPullRefreshTableFooterView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGPoint center = self.center;
    CGPoint imageCenter = CGPointMake(center.x - CGRectGetMinX(frame), center.y - CGRectGetMinY(frame));
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Diamond.png"]];
    UIImageView *imageView = self.imageView;
    imageView.center = imageCenter;
    [self addSubview:imageView];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIActivityIndicatorView *activityIndicatorView = self.activityIndicatorView;
    activityIndicatorView.center = imageCenter;
    [self addSubview:activityIndicatorView];
    
    self.status = KMPullRefreshTableFooterViewDefault;
  }
  
  return self;
}

- (void)setStatus:(KMPullRefreshTableFooterViewStatus)status {
  UIButton    *loadMoreButton = self.loadMoreButton;
  UIImageView *imageView      = self.imageView;
  
  switch (status) {
    case KMPullRefreshTableFooterViewDefault:
      [self _stopIndicator];
      loadMoreButton.hidden = NO;
      imageView.hidden      = YES;
      
      break;
      
    case KMPullRefreshTableFooterViewLoading:
      [self _startIndicator];
      loadMoreButton.hidden = YES;
      imageView.hidden      = YES;
      
      break;
      
    case KMPullRefreshTableFooterViewSuspending:
      [self _stopIndicator];
      loadMoreButton.hidden = YES;
      imageView.hidden      = NO;
      
      break;
  }
  
  _status = status;
}

- (void)setLoadMoreTapEnabled:(BOOL)loadMoreTapEnabled {
  UIButton *loadMoreButton = self.loadMoreButton;
  if (loadMoreTapEnabled) {
    if (!loadMoreButton) {
      self.loadMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
      loadMoreButton = self.loadMoreButton;
      CGRect frame = self.frame;
      loadMoreButton.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(frame), CGRectGetHeight(frame));
      [loadMoreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
      [loadMoreButton setTitle:NSLocalizedString(@"Load more...", @"Footer Default Status Text")
                      forState:UIControlStateNormal];
      [[loadMoreButton titleLabel] setFont:[UIFont boldSystemFontOfSize:14.0f]];
    }
    
    [self addSubview:loadMoreButton];
  } else {
    [loadMoreButton removeFromSuperview];
  }
  
  _loadMoreTapEnabled = loadMoreTapEnabled;
}

#pragma mark - Private

- (void)_startIndicator {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  [self.activityIndicatorView startAnimating];
}

- (void)_stopIndicator {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  [self.activityIndicatorView performSelectorInBackground:@selector(stopAnimating)
                                               withObject:nil];
}

@end
