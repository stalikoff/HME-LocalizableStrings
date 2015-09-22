//
//  main.m
//  LoadLocalizableStrings
//
//  Created by Vasilev Oleg on 22.07.15.
//  Copyright (c) 2015 SmediaLink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringsLoader.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        char *par1 = argv[1];
        char *par2 = argv[2];
        
        StringsLoader *loader = [StringsLoader new];
        [loader runWithKey: [NSString stringWithUTF8String:par1] andProjID: [NSString stringWithUTF8String:par2]];
    }
    return 0;
}
