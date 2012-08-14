//
//  KMPullRefreshTableFooterView.m
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import "KMPullRefreshTableFooterView.h"

@implementation KMPullRefreshTableFooterView {
 @private
  UIImageView             *_imageView;
  UIActivityIndicatorView *_activityIndicatorView;
}

- (id)initWithFrame:(CGRect)frame
 loadMoreTapEnabled:(BOOL)loadMoreTapEnabled {
  self = [super initWithFrame:frame];
  if (self) {
    CGPoint center = self.center;
    CGPoint imageCenter = CGPointMake(center.x - CGRectGetMinX(frame), center.y - CGRectGetMinY(frame));
    
    if (loadMoreTapEnabled) {
      UIButton *loadMoreButton = self.loadMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
      loadMoreButton.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(frame), CGRectGetHeight(frame));
      [loadMoreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
      [loadMoreButton setTitle:NSLocalizedString(@"Load more...", @"Footer Default Status Text")
              forState:UIControlStateNormal];
      [[loadMoreButton titleLabel] setFont:[UIFont boldSystemFontOfSize:14.0f]];
      [self addSubview:loadMoreButton];
    }
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Diamond.png"]];
    _imageView.frame  = CGRectMake(0.0f, 0.0f, 16.0f, 16.0f);
    _imageView.center = imageCenter;
    [self addSubview:_imageView];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.center = imageCenter;
    [self addSubview:_activityIndicatorView];
    
    self.status = KMPullRefreshTableFooterViewDefault;
  }
  
  return self;
}

- (void)setStatus:(KMPullRefreshTableFooterViewStatus)status {
  UIButton *loadMoreButton = self.loadMoreButton;
  
  switch (status) {
    case KMPullRefreshTableFooterViewDefault:
      [self _stopIndicator];
      loadMoreButton.hidden = NO;
      _imageView.hidden = YES;
      
      break;
      
    case KMPullRefreshTableFooterViewLoading:
      [self _startIndicator];
      loadMoreButton.hidden = YES;
      _imageView.hidden = YES;
      
      break;
      
    case KMPullRefreshTableFooterViewSuspending:
      [self _stopIndicator];
      loadMoreButton.hidden = YES;
      _imageView.hidden = NO;
      
      break;
  }
  
  _status = status;
}

#pragma mark - Private

- (void)_startIndicator {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  [_activityIndicatorView startAnimating];
}

- (void)_stopIndicator {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  [_activityIndicatorView performSelectorInBackground:@selector(stopAnimating)
                                           withObject:nil];
}

@end
