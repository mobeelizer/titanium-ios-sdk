// 
// TiMobeelizerSdkCallback.m
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

#import "TiMobeelizerSdkCallback.h"
#import "TIMobeelizerSdkUtil.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@interface TiMobeelizerSdkCallback() {
    KrollCallback *callback;
}
@end

@implementation TiMobeelizerSdkCallback

- (id)initWithCallback:(KrollCallback *)krollCallback {
    if(self = [super init]) {
        [krollCallback retain];
        callback = krollCallback;
    }
    return self;
}

-(void)dealloc {
    [callback release];
    [super dealloc];
}

- (void)onLoginFinished:(MobeelizerSyncStatus)status {
    ENSURE_UI_THREAD(onLoginFinished, status);
    NSString *string = [TiMobeelizerSdkUtil loginStatusToString:status];    
    [self callEvent:@"onLoginFinished" withStatus:string];
}

-(void)onSyncFinished:(MobeelizerSyncStatus)status {
    ENSURE_UI_THREAD(onSyncFinished, status);
    NSString *string = [TiMobeelizerSdkUtil syncStatusToString:status];
    [self callEvent:@"onSyncFinished" withStatus:string];
}

-(void)syncStatusHasBeenChangedTo:(MobeelizerSyncStatus)status {
    ENSURE_UI_THREAD(syncStatusHasBeenChangedTo, status);
    NSString *string = [TiMobeelizerSdkUtil syncStatusToString:status];
    [self callEvent:@"syncStatusHasBeenChangedTo" withStatus:string];
}

-(void)callEvent:(NSString *)type withStatus:(NSString *)status {
    KrollContext* context = [callback context];
    id<TiEvaluator> evaluator = (id<TiEvaluator>)context.delegate;        
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:status, @"status", self, @"source", type, @"type", nil];
    [evaluator fireEvent:callback withObject:dictionary remove:NO thisObject:nil];
}

@end
