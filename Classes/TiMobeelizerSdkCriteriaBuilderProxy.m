// 
// TiMobeelizerSdkCriteriaBuilderProxy.m
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

#import "TiMobeelizerSdkCriteriaBuilderProxy.h"
#import "TiMobeelizerSdkUtil.h"
#import "TiMobeelizerSdkEntityProxy.h"
#import "TiMobeelizerSdkCriteriaBuilderCriterionFactoryProxy.h"
#import "TiMobeelizerSdkCriteriaBuilderOrderFactoryProxy.h"
#import "TiMobeelizerSdkCriteriaBuilderCriterionProxy.h"
#import "TiMobeelizerSdkCriteriaBuilderOrderProxy.h"

@interface TiMobeelizerSdkCriteriaBuilderProxy() {
    MobeelizerCriteriaBuilder *criteriaBuilder;
}
@end

@implementation TiMobeelizerSdkCriteriaBuilderProxy

- (id)initWithCriteriaBuilder:(MobeelizerCriteriaBuilder *)mobeelizerCriteriaBuilder {
    if(self = [super init]) {
        [mobeelizerCriteriaBuilder retain];
        criteriaBuilder = mobeelizerCriteriaBuilder;
    }
    return self;
}

-(void)dealloc {
    [criteriaBuilder release];
    [super dealloc];
}

-(id)uniqueResult:(id)args {
    NSDictionary *dictionary = [criteriaBuilder uniqueResult];
    if(dictionary == nil) {
        return [NSNull null];
    }    
    return [[[TiMobeelizerSdkEntityProxy alloc] initWithDictionary:dictionary] autorelease];
}

-(id)list:(id)args {
    NSArray *list = [criteriaBuilder list];
    NSMutableArray *array = [NSMutableArray array];            
    for(id dictionary in list) {
        [array addObject:[[TiMobeelizerSdkEntityProxy alloc] initWithDictionary:dictionary]];
    }
    return array;
}

-(id)count:(id)args {
    return NUMINT([criteriaBuilder count]);    
}

-(id)setMaxResults:(id)args {
    ENSURE_SINGLE_ARG(args, NSNumber);
    [criteriaBuilder maxResults:[args intValue]];
    return self;
}

-(id)setFirstAndMaxResults:(id)args {
    NSNumber *firstResult;
    NSNumber *maxResults;
    ENSURE_ARG_AT_INDEX(firstResult, args, 0, NSNumber);
    ENSURE_ARG_AT_INDEX(maxResults, args, 1, NSNumber);
    [criteriaBuilder firstResult:[firstResult intValue] maxResults:[maxResults intValue]];
    return self;
}

-(id)addOrder:(id)args {
    ENSURE_SINGLE_ARG(args, TiMobeelizerSdkCriteriaBuilderOrderProxy);
    [criteriaBuilder addOrder:[args order]];
    return self;
}

-(id)add:(id)args {
    ENSURE_SINGLE_ARG(args, TiMobeelizerSdkCriteriaBuilderCriterionProxy);
    [criteriaBuilder add:[args criterion]];
    return self;
}

@end
