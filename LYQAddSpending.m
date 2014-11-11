//
//  LYQAddSpending.m
//  test
//
//  Created by Emily Liu on 2014-05-28.
//  Copyright (c) 2014 Emily Liu. All rights reserved.
//

#import "LYQAddSpending.h"

@implementation LYQAddSpending

@synthesize add;
@synthesize SetCategory;
@synthesize AddDate;
LYQAddSpending * AddSpending;


- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self != nil) {
        [self setAddDate:[decoder decodeObjectForKey:@"AddDate"]];
        [self setAdd:[decoder decodeFloatForKey:@"Add"]];
        [self setSetCategory:[decoder decodeIntegerForKey:@"SetCategory"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeFloat:self.add forKey:@"Add"];
    [encoder encodeInteger:self.add forKey:@"SetCategory"];
    [encoder encodeObject:self.AddDate  forKey:@"AddDate"];
}


+ (LYQAddSpending *)InitAddSpending
{
        AddSpending = [[super alloc] init];
   
    return AddSpending;
}

- (id)init {
    if ( (self = [super init]) ) {
        add = 0;
        SetCategory = 10;
        
    }
    
    return self;
}

@end
