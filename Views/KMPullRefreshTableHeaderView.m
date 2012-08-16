//
//  KMPullRefreshTableHeaderView.m
//  KMPullRefreshTableViewController
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import "KMPullRefreshTableHeaderView.h"

@interface KMPullRefreshTableHeaderView ()

- (void)_animateRotationToUpper:(BOOL)Upper
                         hidden:(BOOL)hidden;
- (void)_startIndicator;
- (void)_stopIndicator;

@end

@implementation KMPullRefreshTableHeaderView {
 @private
  UIImageView             *_imageView;
  UILabel                 *_label;
  UIActivityIndicatorView *_activityIndicatorView;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGPoint center = self.center;
    CGFloat centerX = center.x - CGRectGetMinX(frame);
    CGFloat centerY = center.y - CGRectGetMinY(frame);
    CGPoint imageCenter = CGPointMake(CGRectGetWidth(frame) / 7.5f, centerY);
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 30.0f)];
    _label.font            = [UIFont boldSystemFontOfSize:14.0f];
    _label.textColor       = [UIColor grayColor];
    _label.backgroundColor = [UIColor clearColor];
    _label.shadowColor     = [UIColor whiteColor];
    _label.shadowOffset    = CGSizeMake(0.0f, 1.0f);
    _label.center          = CGPointMake(centerX + 20.0f, centerY);
    [self addSubview:_label];
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Arrow.png"]];
    _imageView.center = imageCenter;
    [self addSubview:_imageView];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.center = imageCenter;
    [self addSubview:_activityIndicatorView];
    
    self.status = KMPullRefreshTableHeaderViewDefault;
  }
  
  return self;
}

- (void)setStatus:(KMPullRefreshTableHeaderViewStatus)status {
  switch (status) {
    case KMPullRefreshTableHeaderViewDefault:
      _label.text = NSLocalizedString(@"Pull down to refresh...", @"Header Default Status Text");
      if (_status == KMPullRefreshTableHeaderViewPulling || _status == KMPullRefreshTableHeaderViewLoading) {
        [self _stopIndicator];
        if (_status == KMPullRefreshTableHeaderViewPulling) {
          [self _animateRotationToUpper:NO
                                 hidden:NO];
        }
        _imageView.hidden = NO;
      }
      
      break;
      
    case KMPullRefreshTableHeaderViewPulling:
      _label.text = NSLocalizedString(@"Release to refresh...", @"Header Pulling Status Text");
      if (_status == KMPullRefreshTableHeaderViewDefault) {
        [self _stopIndicator];
        [self _animateRotationToUpper:YES
                               hidden:NO];
        _imageView.hidden = NO;
      }
      
      break;
      
    case KMPullRefreshTableHeaderViewLoading:
      _label.text = NSLocalizedString(@"Loading...", @"Header Loading Status Text");
      if (_status == KMPullRefreshTableHeaderViewPulling) {
        [self _startIndicator];
        [self _animateRotationToUpper:NO
                               hidden:YES];
      }
      
      break;
  }
  
  _status = status;
}

#pragma mark - Private

- (void)_animateRotationToUpper:(BOOL)Upper
                         hidden:(BOOL)hidden {
  CGFloat beginAngle = Upper ? 0.0f : M_PI;
  CGFloat endAngle   = Upper ? M_PI : 0.0f;
  
  _imageView.transform = CGAffineTransformMakeRotation(beginAngle);
  [UIView animateWithDuration:0.2f
                        delay:0.0f
                      options:UIViewAnimationOptionAllowUserInteraction
                   animations:^{
                     _imageView.transform = CGAffineTransformMakeRotation(endAngle);
                     if (hidden) {
                       _imageView.alpha = 0.0f;
                     }
                   }
                   completion:^(BOOL finished) {
                     if (hidden) {
                       _imageView.hidden = hidden;
                       _imageView.alpha  = 1.0f;
                     }
                   }];
}

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
