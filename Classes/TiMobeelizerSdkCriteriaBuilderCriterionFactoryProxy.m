// 
// TiMobeelizerSdkCriteriaBuilderCriterionFactoryProxy.m
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

#import "TiMobeelizerSdkCriteriaBuilderCriterionFactoryProxy.h"
#import "TiMobeelizerSdkCriteriaBuilderCriterionProxy.h"
#import "TiMobeelizerSdkUtil.h"

@implementation TiMobeelizerSdkCriteriaBuilderCriterionFactoryProxy

-(TiMobeelizerSdkCriteriaBuilderCriterionProxy *)wrap:(MobeelizerCriterion *)criterion {
    return [[[TiMobeelizerSdkCriteriaBuilderCriterionProxy alloc] initWithCriterion:criterion] autorelease];
}

-(id)MATCH_MODE_ANYWHERE {
    return MatchModeAnywhere;
}

-(id)MATCH_MODE_END {
    return MatchModeEnd;
}

-(id)MATCH_MODE_EXACT {
    return MatchModeExact;
}

-(id)MATCH_MODE_START {
    return MatchModeStart;
}

-(id)createOr:(id)args {
    ENSURE_ARRAY(args);    
    MobeelizerDisjunction *disjunction = [MobeelizerCriterion disjunction];    
    for(id arg in args) {
        TiMobeelizerSdkCriteriaBuilderCriterionProxy *criterion = arg;
        [disjunction add:[criterion criterion]];
    }
    return [self wrap:disjunction];    
}

-(id)createAnd:(id)args {
    ENSURE_ARRAY(args);
    MobeelizerConjunction *conjunction = [MobeelizerCriterion conjunction];    
    for(id arg in args) {
        TiMobeelizerSdkCriteriaBuilderCriterionProxy *criterion = arg;
        [conjunction add:[criterion criterion]];
    }
    return [self wrap:conjunction];        
}

-(id)createNot:(id)args {
    ENSURE_SINGLE_ARG(args, TiMobeelizerSdkCriteriaBuilderCriterionProxy);
    return [self wrap:[MobeelizerCriterion not:[args criterion]]];
}

-(id)guidEq:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    return [self wrap:[MobeelizerCriterion guidEq:args]];
}

-(id)ownerEq:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    return [self wrap:[MobeelizerCriterion ownerEq:args]];
}

-(id)guidNe:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    return [self wrap:[MobeelizerCriterion guidNe:args]];
}

-(id)ownerNe:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    return [self wrap:[MobeelizerCriterion ownerNe:args]];
}

-(id)isConflicted:(id)args {
    return [self wrap:[MobeelizerCriterion isConflicted]];
}

-(id)isNotConflicted:(id)args {
    return [self wrap:[MobeelizerCriterion isNotConflicted]];
}

-(id)allEq:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    return [self wrap:[MobeelizerCriterion allEq:args]];
}

-(id)like:(id)args {
    NSString *field;
    NSString *like;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(like, args, 1, NSString);
    ENSURE_ARRAY(args);
    if([args count] == 2) {
        return [self wrap:[MobeelizerCriterion field:field like:like]]; 
    } else {
        return [self wrap:[MobeelizerCriterion field:field like:like withMatchMode:[TiMobeelizerSdkUtil stringToMatchMode:[args objectAtIndex:2]]]];    
    }
}

-(id)le:(id)args {
    NSString *field;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARRAY(args);
    return [self wrap:[MobeelizerCriterion field:field le:[args objectAtIndex:1]]];
}

-(id)lt:(id)args {
    NSString *field;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARRAY(args);
    return [self wrap:[MobeelizerCriterion field:field lt:[args objectAtIndex:1]]];
}

-(id)ge:(id)args {
    NSString *field;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARRAY(args);
    return [self wrap:[MobeelizerCriterion field:field ge:[args objectAtIndex:1]]];
}

-(id)gt:(id)args {
    NSString *field;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARRAY(args);
    return [self wrap:[MobeelizerCriterion field:field gt:[args objectAtIndex:1]]];
}

-(id)ne:(id)args {
    NSString *field;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARRAY(args);
    return [self wrap:[MobeelizerCriterion field:field ne:[args objectAtIndex:1]]];
}

-(id)eq:(id)args {
    NSString *field;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARRAY(args);
    return [self wrap:[MobeelizerCriterion field:field eq:[args objectAtIndex:1]]];
}

-(id)leField:(id)args {
    NSString *field;
    NSString *otherField;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(otherField, args, 1, NSString);
    return [self wrap:[MobeelizerCriterion field:field leField:otherField]];
}

-(id)ltField:(id)args {
    NSString *field;
    NSString *otherField;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(otherField, args, 1, NSString);
    return [self wrap:[MobeelizerCriterion field:field ltField:otherField]];
}

-(id)geField:(id)args {
    NSString *field;
    NSString *otherField;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(otherField, args, 1, NSString);
    return [self wrap:[MobeelizerCriterion field:field geField:otherField]];
}

-(id)gtField:(id)args {
    NSString *field;
    NSString *otherField;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(otherField, args, 1, NSString);
    return [self wrap:[MobeelizerCriterion field:field gtField:otherField]];
}

-(id)neField:(id)args {
    NSString *field;
    NSString *otherField;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(otherField, args, 1, NSString);
    return [self wrap:[MobeelizerCriterion field:field neField:otherField]];
}

-(id)eqField:(id)args {
    NSString *field;
    NSString *otherField;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(otherField, args, 1, NSString);
    return [self wrap:[MobeelizerCriterion field:field eqField:otherField]];
}

-(id)between:(id)args {
    NSString *field;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARRAY(args);
    return [self wrap:[MobeelizerCriterion field:field between:[args objectAtIndex:1] and:[args objectAtIndex:2]]];
}

-(id)inArray:(id)args {
    NSString *field;
    NSArray *array;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(array, args, 1, NSArray);
    return [self wrap:[MobeelizerCriterion field:field inArray:array]];
}

-(id)belongsTo:(id)args {
    NSString *field;
    NSString *model;
    NSString *guid;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(model, args, 1, NSString);
    ENSURE_ARG_AT_INDEX(guid, args, 2, NSString);
    return [self wrap:[MobeelizerCriterion field:field belongsToEntityWithModel:model withGuid:guid]];
}

-(id)belongsToObject:(id)args {
    NSString *field;
    ENSURE_ARG_AT_INDEX(field, args, 0, NSString);
    ENSURE_ARRAY(args);
    return [self wrap:[MobeelizerCriterion field:field belongsToEntity:[args objectAtIndex:1]]];
}

-(id)isNotNull:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    return [self wrap:[MobeelizerCriterion fieldIsNotNull:args]];
}

-(id)isNull:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    return [self wrap:[MobeelizerCriterion fieldIsNull:args]];
}

-(id)disjunction:(id)args {
    return [self wrap:[MobeelizerCriterion disjunction]];
}

-(id)conjunction:(id)args {
    return [self wrap:[MobeelizerCriterion conjunction]];
}

@end
