//
//  LYQGlobalVariable.h
//  test
//
//  Created by Emily Liu on 2014-05-25.
//  Copyright (c) 2014 Emily Liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LYQGlobalVariable : NSObject<NSCoding>
{
    //set private variables
    float todaySpending;
    float addSpending;
    int Category;
    int instantCate;
    float todaySpendingLimit;
    NSMutableArray *item;
    NSDate * SpendingDate;//stores the latest transection date
   // NSNumber *temp;
    
}


@property (nonatomic) float todaySpending;
@property (nonatomic) float addSpending;
@property (nonatomic) int Category;//
@property (nonatomic) int instantCate;
@property (nonatomic) float todaySpendingLimit;
@property (nonatomic) NSMutableArray *item;
@property (nonatomic) NSDate * SpendingDate;
//@property (nonatomic) NSNumber * temp;

//@property (nonatomic) NSNumber * temp;

-(NSString *)GetFilePath;
-(void) SaveDate;
-(void) LoadDate;
-(void) calculateTodaySpending;
-(void) calculateMonthSpending;
+ (LYQGlobalVariable *) sharedGlobal;
@end