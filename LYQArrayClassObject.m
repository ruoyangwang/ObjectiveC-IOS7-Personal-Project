//
//  LYQArrayClassObject.m
//  test
//
//  Created by Ruoyang Wang on 2014-07-12.
//  Copyright (c) 2014 Emily Liu. All rights reserved.
//

#import "LYQArrayClassObject.h"
#import "LYQGlobalVariable.h"
#import "LYQAddSpending.h"
LYQGlobalVariable * GlobalObj;

@implementation LYQArrayClassObject
@synthesize DailyTransection;
@synthesize MonthTransection;
@synthesize YearTransection;


- (id)init {
    if ( (self = [super init]) ) {
       
        DailyTransection = [[NSMutableArray alloc]init];
        MonthTransection = [[NSMutableArray alloc]init];
        YearTransection = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void) PrepareForDailyTransectionArray
{
    GlobalObj= [LYQGlobalVariable sharedGlobal];
    //get current day component
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    //calculate spending for UserMainUI use
    
    for(LYQAddSpending * temp in GlobalObj.item)
    {
        //get the global array object day component and do comparison
        NSDateComponents *tempcomponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:temp.AddDate];
        NSInteger tempday = [tempcomponents day];
        NSInteger tempmonth = [tempcomponents month];
        NSInteger tempyear = [tempcomponents year];
        
        //
        //if(tempday != day || tempmonth!= month || tempyear!= year)
        if(tempday==day&& tempmonth==month && tempyear==year)
        {
            [DailyTransection addObject:temp];  //adding daily transaction to array
        }
    }
    
    
}

-(void) PrepareForMonthTransectionArray
{
    GlobalObj= [LYQGlobalVariable sharedGlobal];
    //get current day component
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger month = [components month];
    NSInteger year = [components year];
    //calculate spending for UserMainUI use
    
    for(LYQAddSpending * temp in GlobalObj.item)
    {
        //get the global array object day component and do comparison
        NSDateComponents *tempcomponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:temp.AddDate];
        NSInteger tempmonth = [tempcomponents month];
        NSInteger tempyear = [tempcomponents year];
        
        //
        //if(tempday != day || tempmonth!= month || tempyear!= year)
        if(tempmonth==month && tempyear==year)
        {
            
            [MonthTransection addObject:temp];  //adding month transection object from gloabl singleton class
        }
    }
}

-(void) PrepareForYearTransectionArray
{
    GlobalObj= [LYQGlobalVariable sharedGlobal];
    //get current day component
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
      NSInteger year = [components year];
    //calculate spending for UserMainUI use
    
    for(LYQAddSpending * temp in GlobalObj.item)
    {
        //get the global array object day component and do comparison
        NSDateComponents *tempcomponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:temp.AddDate];
        NSInteger tempyear = [tempcomponents year];
        
        //
        //if(tempday != day || tempmonth!= month || tempyear!= year)
        if(tempyear==year)
        {
            
            [YearTransection addObject:temp];  //adding month transection object from gloabl singleton class
        }
    }
    
}

@end
