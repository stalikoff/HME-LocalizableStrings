//
//  StringsLoader.m
//  LoadLocalizableStrings
//
//  Created by Vasilev Oleg on 22.07.15.
//  Copyright (c) 2015 SmediaLink. All rights reserved.
//

#import "StringsLoader.h"

@implementation StringsLoader

-(void)runWithKey:(NSString*)key andProjID:(NSString*)projID
{
    NSError *error;
    // -- languages --
    NSDictionary *parameters = @{
                                 @"api_token": key,
                                 @"action": @"list_languages",
                                 @"id": projID
                                 };
    
    NSMutableString *parameterString = [NSMutableString string];
    for (NSString *key in [parameters allKeys]) {
        if ([parameterString length]) {
            [parameterString appendString:@"&"];
        }
        [parameterString appendFormat:@"%@=%@", key, parameters[key]];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://poeditor.com/api/"]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[parameterString dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *fileData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if (fileData != nil) {
        NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:fileData options:kNilOptions error:&error];
        NSArray *arr = [jsonDict objectForKey:@"list"];
        if (arr != nil) {
            [self getLangFiles:arr apiKey:key projID:projID];
        }
    }
}

-(void)getLangFiles:(NSArray*)langArr apiKey:(NSString*)apiKey projID:(NSString*)projID
{
    NSError *error;
    
    for (NSDictionary *lanDict in langArr) {
        
        NSString *langCode = [lanDict objectForKey:@"code"];
        
        NSDictionary *parameters = @{
                                     @"api_token": apiKey,
                                     @"action": @"export",
                                     @"id": projID,
                                     @"type": @"apple_strings",
                                     @"language": langCode
                                     };
        
        NSMutableString *parameterString = [NSMutableString string];
        for (NSString *key in [parameters allKeys]) {
            if ([parameterString length]) {
                [parameterString appendString:@"&"];
            }
            [parameterString appendFormat:@"%@=%@", key, parameters[key]];
        }
        
        NSFileManager *fileManager = [NSFileManager new];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://poeditor.com/api/"]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[parameterString dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *fileData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];

        if (fileData != nil) {
            NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:fileData options:kNilOptions error:&error];
            
            NSString *fileurl = [jsonDict objectForKey:@"item"];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fileurl]];
            [request setHTTPMethod:@"GET"];

            NSData *fileData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
            
            // write To File
            NSString *filepath = [[NSFileManager new] currentDirectoryPath];
            
            filepath = [filepath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.lproj", langCode]];
            [fileManager createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error:&error];
            
            filepath = [filepath stringByAppendingPathComponent:@"Localizable.strings"];
            [fileData writeToFile:filepath atomically:YES];
        }
    }
}

@end
