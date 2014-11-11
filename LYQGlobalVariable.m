//
//  LYQGlobalVariable.m
//  test
//
//  Created by Emily Liu on 2014-05-25.
//  Copyright (c) 2014 Emily Liu. All rights reserved.
//

#import "LYQGlobalVariable.h"
#import "LYQAddSpending.h"
#import "LYQArrayClassObject.h"



//


@implementation LYQGlobalVariable

@synthesize todaySpending;
@synthesize addSpending;
@synthesize Category;
@synthesize item;
@synthesize instantCate;
@synthesize SpendingDate;
@synthesize todaySpendingLimit;
static  LYQGlobalVariable *sharedGlobalObj = nil;    // static instance variable

//initialize this class as singleton class, also initialize properties


//encoding and decoding the mutablearray
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self != nil) {
        [self setItem:[decoder decodeObjectForKey:@"item"]];
        return self;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.item   forKey:@"item"];
}




+ (LYQGlobalVariable *)sharedGlobal
{
    if (sharedGlobalObj == nil) {
        sharedGlobalObj = [[super alloc] init];
    }
    return sharedGlobalObj;
}

- (id)init {
    if ( (self = [super init]) ) {
        todaySpending = 0;
        addSpending = 0;
        Category = 10; //10 represent first time use, empty
        instantCate =10;
        todaySpendingLimit = 100;
        item = [[NSMutableArray alloc]init];    //initialize the mutable array of the singleton class，dynamically
        
        SpendingDate = [NSDate date];
        [self LoadDate];
    }
    return self;
}

-(NSString *)GetFilePath
{
    NSArray *filepath = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    return [[filepath objectAtIndex:0] stringByAppendingPathComponent:@"saved.plist"];
}

-(void) SaveDate
{
    //write to file for the global array, however now having issue creating file
   /* NSData* itemData = [NSKeyedArchiver archivedDataWithRootObject:self.item];
   // NSArray * value = [[NSArray alloc] initWithObjects:self.item, nil];
    [[NSUserDefaults standardUserDefaults] setObject:itemData forKey:@"saveddata"];
    [itemData writeToFile:[self GetFilePath] atomically:YES];*/
   
    [NSKeyedArchiver archiveRootObject:self.item toFile:[self GetFilePath]];

}

-(void) LoadDate
{
    NSString * path = [self GetFilePath];
    bool FileExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    
    if(FileExist)
    {
        
       // NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveddata"];
        self.item = [NSKeyedUnarchiver unarchiveObjectWithFile:[self GetFilePath]];
 

    }
    
}


-(void)calculateMonthSpending
{
    //get current day component
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger month = [components month];
    NSInteger year = [components year];
    //calculate spending for UserMainUI use
    
    for(LYQAddSpending * temp in item)
    {
        //get the global array object day component and do comparison
        NSDateComponents *tempcomponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:temp.AddDate];
        NSInteger tempmonth = [tempcomponents month];
        NSInteger tempyear = [tempcomponents year];
        
        //
        //if(tempday != day || tempmonth!= month || tempyear!= year)
        if(tempmonth==month && tempyear==year)
        {
            //self.todaySpending += temp.add;
            //store according objects into a new array or just do operation of main user view here
            
        }
    }
}

-(void)calculateTodaySpending
{
    //get current day component
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    //calculate spending for UserMainUI use
    
    for(LYQAddSpending * temp in item)
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
            self.todaySpending += temp.add;
            //might also need to store according objects into anoter array for future use
        }
    }

}



//getting info for main user view controller

-(void)dealloc {
    //should not be called, just for clarity
}

@end
