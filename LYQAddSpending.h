//
//  LYQAddSpending.h
//  test
//
//  Created by Emily Liu on 2014-05-28.
//  Copyright (c) 2014 Emily Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYQAddSpending : NSObject <NSCoding>
{

    float add;
    int SetCategory;
    NSDate * AddDate;
}

@property (nonatomic) float add;
@property (nonatomic) int SetCategory;// 0-FOOD, 1-Transportation, 2-Bills, 3-Shopping, 4-Travel, 5-Other
@property (nonatomic) NSDate * AddDate;

@end
