//
//  StringsLoader.m
//  LoadLocalizableStrings
//
//  Created by Vasilev Oleg on 22.07.15.
//  Copyright (c) 2015 SmediaLink. All rights reserved.
//

#import "StringsLoader.h"

@implementation StringsLoader

#define kGetLocales @"https://localise.biz/api/locales?key=%@"
#define kGetLocaleFile @"https://localise.biz/api/export/locale/%@.strings?key=%@"

-(void)runWithProjKey:(NSString*)projKey
{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager new];
    
    // -- languages --
    NSString *reqStr = [NSString stringWithFormat:kGetLocales, projKey];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: reqStr]];
    [request setHTTPMethod:@"GET"];
    NSData *fileData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSMutableArray *jsonArr = [NSJSONSerialization JSONObjectWithData:fileData options:kNilOptions error:&error];
    
    for (NSDictionary *lang in jsonArr) {
        NSString *loc = [lang objectForKey:@"code"];
        loc = [loc componentsSeparatedByString:@"_"].firstObject;
        
        NSString *reqStr = [NSString stringWithFormat:kGetLocaleFile, loc, projKey];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: reqStr]];
        [request setHTTPMethod:@"GET"];
        NSData *fileData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        // write To File
        NSString *filepath = [[NSFileManager new] currentDirectoryPath];
        filepath = [filepath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.lproj", loc]];
        [fileManager createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error:&error];
        filepath = [filepath stringByAppendingPathComponent:@"Localizable.strings"];
        [fileData writeToFile:filepath atomically:YES];
    }
}


@end
