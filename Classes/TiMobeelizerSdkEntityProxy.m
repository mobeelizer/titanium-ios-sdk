// 
// TiMobeelizerSdkEntityProxy.m
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

#import "TiMobeelizerSdkEntityProxy.h"
#import "TiMobeelizerSdkFileProxy.h"

@implementation TiMobeelizerSdkEntityProxy{
    @private NSMutableDictionary *_fields;
}

@synthesize model=_model, guid=_guid, deleted=_deleted, conflicted=_conflicted, modified=_modified, owner=_owner;

-(id)initWithModel:(NSString *)model {
    if(self = [super self]) {
        _fields = [[[NSMutableDictionary alloc] init] retain];
        _model = [model retain];
        _guid = nil;
        _deleted = NUMBOOL(FALSE);
        _conflicted = NUMBOOL(FALSE);
        _modified = NUMBOOL(FALSE);
        _owner = nil;
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dictionary {
    if(self = [super self]) {
        [self fromDictionary:dictionary];
    }
    return self;
}

-(NSDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    for(NSString *key in [_fields allKeys]) {
        id value = [_fields objectForKey:key];
        if([value isKindOfClass:[TiMobeelizerSdkFileProxy class]]) {
            value = [((TiMobeelizerSdkFileProxy *)value) toFile];
        }
        [dictionary setObject:value forKey:key];        
    }
    
    if(_model != nil) { [dictionary setObject:_model forKey:@"model"]; }
    if(_guid != nil) { [dictionary setObject:_guid forKey:@"guid"]; }
    if(_conflicted != nil) { [dictionary setObject:_conflicted forKey:@"conflicted"]; }
    if(_deleted != nil) { [dictionary setObject:_deleted forKey:@"deleted"]; }
    if(_modified != nil) { [dictionary setObject:_modified forKey:@"modified"]; }   
    if(_owner != nil) { [dictionary setObject:_owner forKey:@"owner"]; }   

    return dictionary;
}

-(void)dealloc {
    RELEASE_TO_NIL(_model);
    RELEASE_TO_NIL(_guid);
    RELEASE_TO_NIL(_owner);
    RELEASE_TO_NIL(_conflicted);
    RELEASE_TO_NIL(_deleted);
    RELEASE_TO_NIL(_modified);
    RELEASE_TO_NIL(_fields);
    [super dealloc];
}

-(void)fromDictionary:(NSDictionary *)dictionary {
    _model = [[dictionary objectForKey:@"model"] retain];
    _guid = [[dictionary objectForKey:@"guid"] retain];
    _conflicted = [[dictionary objectForKey:@"conflicted"] retain];
    _modified = [[dictionary objectForKey:@"modified"] retain];
    _deleted = [[dictionary objectForKey:@"deleted"] retain];
    _owner = [[dictionary objectForKey:@"owner"] retain];
    _fields = [[[NSMutableDictionary alloc] init] retain];
    
    for(NSString *key in [dictionary allKeys]) {
        if([key isEqualToString:@"model"] || [key isEqualToString:@"guid"] || [key isEqualToString:@"conflicted"] || [key isEqualToString:@"modified"] || [key isEqualToString:@"deleted"] || [key isEqualToString:@"owner"]) {
            continue;
        }
        id value = [dictionary objectForKey:key];
        if([value isKindOfClass:[MobeelizerFile class]]) {
            value = [[TiMobeelizerSdkFileProxy alloc] initWithFile:value];
        }
        [_fields setObject:value forKey:key];        
    }
}

-(void)putField:(id)args {
    NSString *key;
    ENSURE_ARG_AT_INDEX(key, args, 0, NSString);
    ENSURE_ARRAY(args);            
    [_fields setObject:[args objectAtIndex:1] forKey:key];
}


-(id)field:(id)args {
    ENSURE_SINGLE_ARG(args, NSString)
    return [_fields objectForKey:args];
}

-(id)isConflicted:(id)args {
    return self.conflicted;
}

-(id)isDeleted:(id)args {
    return self.deleted;
}

-(id)isModified:(id)args {
    return self.modified;
}

@end
