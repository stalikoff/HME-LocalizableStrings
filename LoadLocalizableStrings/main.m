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
        
//        NSString *projKey = @"73963765423833cc3045ce25267952b8";
        
        StringsLoader *loader = [StringsLoader new];

      
        [loader runWithProjKey:[NSString stringWithUTF8String:par1]];
        
//        [loader runWithProjKey:projKey];
        
        
    }
    return 0;
}
