// 
// TiMobeelizerSdkDatabaseProxy.m
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

#import "TiMobeelizerSdkDatabaseProxy.h"
#import "TiMobeelizerSdkErrorsProxy.h"
#import "TiMobeelizerSdkCriteriaBuilderProxy.h"
#import "TiMobeelizerSdkEntityProxy.h"
#import "TiMobeelizerSdkUtil.h"
#import "TiMobeelizerSdkCriteriaBuilderCriterionFactoryProxy.h"
#import "TiMobeelizerSdkCriteriaBuilderOrderFactoryProxy.h"

@interface TiMobeelizerSdkDatabaseProxy() {
    MobeelizerDatabase *database;
}
@end

@implementation TiMobeelizerSdkDatabaseProxy

- (id)initWithDatabase:(MobeelizerDatabase *)mobeelizerDatabase {
    if(self = [super init]) {
        [mobeelizerDatabase retain];
        database = mobeelizerDatabase;
    }
    return self;
}

-(void)dealloc {
    [database release];
    [super dealloc];
}

-(id)count:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    return NUMINT([database countByModel:args]);
}

-(void)remove:(id)args {
    NSString *model;
    NSString *guid;
    ENSURE_ARG_AT_INDEX(model, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(guid, args, 1, NSString);
    [database removeByModel:model withGuid:guid];
}

-(void)removeAll:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    [database removeAllByModel:args];
}

-(void)removeObject:(id)args {
    ENSURE_SINGLE_ARG(args, TiMobeelizerSdkEntityProxy);
    NSDictionary *dictionary = [args toDictionary];
    [database remove:dictionary];
}

-(id)exists:(id)args {
    NSString *model;
    NSString *guid;
    ENSURE_ARG_AT_INDEX(model, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(guid, args, 1, NSString);
    return NUMBOOL([database existsByModel:model withGuid:guid]);
}

-(id)findOne:(id)args {
    NSString *model;
    NSString *guid;
    ENSURE_ARG_AT_INDEX(model, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(guid, args, 1, NSString);    
    NSDictionary *dictionary = [database getByModel:model withGuid:guid];
    if(dictionary == nil) {
        return [NSNull null];
    }    
    return [[[TiMobeelizerSdkEntityProxy alloc] initWithDictionary:dictionary] autorelease];
}

-(id)list:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    NSArray *list = [database listByModel:args];
    NSMutableArray *array = [NSMutableArray array];            
    for(id dictionary in list) {
        [array addObject:[[TiMobeelizerSdkEntityProxy alloc] initWithDictionary:dictionary]];    
    }
    return array;
}

-(id)find:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    return [[[TiMobeelizerSdkCriteriaBuilderProxy alloc] initWithCriteriaBuilder:[database findByModel:args]] autorelease];
}

-(id)entity:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    return [[[TiMobeelizerSdkEntityProxy alloc] initWithModel:[args retain]] autorelease];
}

-(id)save:(id)args {
    ENSURE_SINGLE_ARG(args, TiMobeelizerSdkEntityProxy);
    NSDictionary *dictionary = [args toDictionary];
    MobeelizerErrors *errors = [database save:dictionary];    
    [args fromDictionary:dictionary];
    return [[[TiMobeelizerSdkErrorsProxy alloc] initWithErrors:errors] autorelease];
}

-(id)Restriction {
    return [[[TiMobeelizerSdkCriteriaBuilderCriterionFactoryProxy alloc] init] autorelease];
}

-(id)Order {
    return [[[TiMobeelizerSdkCriteriaBuilderOrderFactoryProxy alloc] init] autorelease];
}

@end
