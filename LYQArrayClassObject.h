//
//  LYQArrayClassObject.h
//  test
//
//  Created by Ruoyang Wang on 2014-07-12.
//  Copyright (c) 2014 Emily Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYQArrayClassObject : NSObject
{
    NSMutableArray * DailyTransection;
    NSMutableArray * MonthTransection;
    NSMutableArray * YearTransection;
}

@property (nonatomic) NSMutableArray * DailyTransection;
@property (nonatomic) NSMutableArray * MonthTransection;
@property (nonatomic) NSMutableArray * YearTransection;

-(void) PrepareForDailyTransectionArray;
-(void) PrepareForMonthTransectionArray;
-(void) PrepareForYearTransectionArray;

@end
