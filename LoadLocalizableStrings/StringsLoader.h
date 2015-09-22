//
//  StringsLoader.h
//  LoadLocalizableStrings
//
//  Created by Vasilev Oleg on 22.07.15.
//  Copyright (c) 2015 SmediaLink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringsLoader : NSObject

-(void)runWithKey:(NSString*)key andProjID:(NSString*)projID;

@end
