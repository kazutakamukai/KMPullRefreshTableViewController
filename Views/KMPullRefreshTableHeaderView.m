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

@implementation KMPullRefreshTableHeaderView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGPoint center      = self.center;
    CGFloat centerX     = center.x - CGRectGetMinX(frame);
    CGFloat centerY     = center.y - CGRectGetMinY(frame);
    CGPoint imageCenter = CGPointMake(CGRectGetWidth(frame) / 7.5f, centerY);
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 30.0f)];
    UILabel *label = self.label;
    label.font            = [UIFont boldSystemFontOfSize:14.0f];
    label.textColor       = [UIColor grayColor];
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor     = [UIColor whiteColor];
    label.shadowOffset    = CGSizeMake(0.0f, 1.0f);
    label.center          = CGPointMake(centerX + 20.0f, centerY);
    [self addSubview:label];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Arrow.png"]];
    UIImageView *imageView = self.imageView;
    imageView.center = imageCenter;
    [self addSubview:imageView];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIActivityIndicatorView *activityIndicatorView = self.activityIndicatorView;
    activityIndicatorView.center = imageCenter;
    [self addSubview:activityIndicatorView];
    
    self.status = KMPullRefreshTableHeaderViewDefault;
  }
  
  return self;
}

- (void)setStatus:(KMPullRefreshTableHeaderViewStatus)status {
  UILabel     *label     = self.label;
  UIImageView *imageView = self.imageView;
  
  switch (status) {
    case KMPullRefreshTableHeaderViewDefault:
      label.text = NSLocalizedString(@"Pull down to refresh...", @"Header Default Status Text");
      if (_status == KMPullRefreshTableHeaderViewPulling || _status == KMPullRefreshTableHeaderViewLoading) {
        [self _stopIndicator];
        if (_status == KMPullRefreshTableHeaderViewPulling) {
          [self _animateRotationToUpper:NO
                                 hidden:NO];
        }
        imageView.hidden = NO;
      }
      
      break;
      
    case KMPullRefreshTableHeaderViewPulling:
      label.text = NSLocalizedString(@"Release to refresh...", @"Header Pulling Status Text");
      if (_status == KMPullRefreshTableHeaderViewDefault) {
        [self _stopIndicator];
        [self _animateRotationToUpper:YES
                               hidden:NO];
        imageView.hidden = NO;
      }
      
      break;
      
    case KMPullRefreshTableHeaderViewLoading:
      label.text = NSLocalizedString(@"Loading...", @"Header Loading Status Text");
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
  
  UIImageView *imageView = self.imageView;
  imageView.transform = CGAffineTransformMakeRotation(beginAngle);
  [UIView animateWithDuration:0.2f
                        delay:0.0f
                      options:UIViewAnimationOptionAllowUserInteraction
                   animations:^{
                     imageView.transform = CGAffineTransformMakeRotation(endAngle);
                     if (hidden) {
                       imageView.alpha = 0.0f;
                     }
                   }
                   completion:^(BOOL finished) {
                     if (hidden) {
                       imageView.hidden = hidden;
                       imageView.alpha  = 1.0f;
                     }
                   }];
}

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
