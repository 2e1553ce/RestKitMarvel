//
//  NSString+MD5.h
//  Marvel
//
//  Created by aiuar on 10.02.17.
//  Copyright © 2017 A.V. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

- (NSString *)MD5String;

@end
