//
//  LYQTodaySpendingViewController.h
//  test
//
//  Created by Emily Liu on 2014-05-25.
//  Copyright (c) 2014 Emily Liu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LYQTodaySpendingViewController;

@protocol LYQTodaySpendingViewControlDelegate

-(void) todaySpendingViewControllerDidFinish:
(LYQTodaySpendingViewController *) controller;

@end


@interface LYQTodaySpendingViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id <LYQTodaySpendingViewControlDelegate> delegate;



@end
