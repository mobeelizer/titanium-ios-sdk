// 
// TiMobeelizerSdkErrorsProxy.m
// 
// Copyright (C) 2012 Mobeelizer Ltd. All Rights Reserved.
//
// Mobeelizer SDK is free software; you can redistribute it and/or modify it 
// under the terms of the GNU Affero General Public License as published by 
// the Free Software Foundation; either version 3 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License
// for more details.
//
// You should have received a copy of the GNU Affero General Public License 
// along with this program; if not, write to the Free Software Foundation, Inc., 
// 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
// 

#import "TiMobeelizerSdkErrorsProxy.h"
#import "TiMobeelizerSdkUtil.h"

@interface TiMobeelizerSdkErrorsProxy() {
    MobeelizerErrors *errors;
}
@end

@implementation TiMobeelizerSdkErrorsProxy

- (id)initWithErrors:(MobeelizerErrors *)mobeelizerErrors {
    if(self = [super init]) {
        [mobeelizerErrors retain];
        errors = mobeelizerErrors;
    }
    return self;
}

-(void)dealloc {
    [errors release];
    [super dealloc];
}

-(id)isValid:(id)args {
    return NUMBOOL([errors isValid]);
}

-(id)isFieldValid:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    return NUMBOOL([errors isFieldValid:args]);
}

-(id)getErrors:(id)args {
    NSMutableArray *array = [NSMutableArray array];
    for (MobeelizerError *error in [errors errors]) {
        [array addObject:[self errorToDictionary:error]];
    };   
    return array;
}

-(id)getFieldErrors:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    NSMutableArray *array = [NSMutableArray array];
    for (MobeelizerError *error in [errors fieldErrors:args]) {
        [array addObject:[self errorToDictionary:error]];
    };   
    return array;
}

-(NSDictionary *)errorToDictionary:(MobeelizerError *)error {
    NSString *code = [TiMobeelizerSdkUtil errorCodeToString:[error code]];
    return [NSDictionary dictionaryWithObjectsAndKeys:[error message], @"message", [error arguments], @"args", code, @"code", nil];
}

@end
