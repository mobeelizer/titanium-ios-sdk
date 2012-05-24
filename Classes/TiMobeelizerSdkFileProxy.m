// 
// TiMobeelizerSdkFileProxy.m
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

#import "TiMobeelizerSdkFileProxy.h"
#import "TiBlob.h"

@interface TiMobeelizerSdkFileProxy()
    
@property(nonatomic, readonly, assign) NSString *name;
@property(nonatomic, readonly, assign) NSString *guid;
@property(nonatomic, readonly, assign) TiBlob *stream;

@end

@implementation TiMobeelizerSdkFileProxy

@synthesize name=_name, guid=_guid, stream=_stream;

- (id)initWithFile:(MobeelizerFile *)mobeelizerFile {
    if(self = [super init]) {
        _name = [[mobeelizerFile name] retain];
        _guid = [[mobeelizerFile guid] retain];
        _stream = [[TiBlob alloc] initWithData:[mobeelizerFile data] mimetype:@"application/octet-stream"];
    }
    return self;
}

- (MobeelizerFile *)toFile {
    return [Mobeelizer createFile:self.name withGuid:self.guid];
}

-(void)dealloc {
    [self.name release];
    [self.guid release];
    [self.stream release];
    [super dealloc];
}

@end