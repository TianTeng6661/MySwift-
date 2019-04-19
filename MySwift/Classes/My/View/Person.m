//
//  Person.m
//  MySwift
//
//  Created by yinhe on 2019/4/16.
//  Copyright © 2019 yinhe. All rights reserved.
//

#import "Person.h"
#import "Cat.h"

@implementation Person

-(void)test{
    NSLog(@"hahahah");
}
+(void)play{
    NSLog(@"playyyyy");
}

-(instancetype)init{
    if(self = [super init]){
        Cat * cat = [[Cat alloc] init];
        [Cat play];
    }
    return self;
}

@end
