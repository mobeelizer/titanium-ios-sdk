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
    KrollCallback *successCallback;
    KrollCallback *failureCallback;
}
@end

@implementation TiMobeelizerSdkCallback

- (id)initWithSuccessCallback:(KrollCallback *)krollSuccessCallback {
    if(self = [super init]) {
        [krollSuccessCallback retain];
        successCallback = krollSuccessCallback;
        failureCallback = nil;
    }
    return self;
}

- (id)initWithSuccessCallback:(KrollCallback *)krollSuccessCallback andFailureCallback:(KrollCallback *)krollFailureCallback {
    if(self = [super init]) {
        [krollSuccessCallback retain];
        [krollFailureCallback retain];        
        successCallback = krollSuccessCallback;
        failureCallback = krollFailureCallback;
    }
    return self;
}

-(void)dealloc {
    [successCallback release];
    [failureCallback release];
    [super dealloc];
}

- (void)onFailure:(MobeelizerOperationError*)error {
    ENSURE_UI_THREAD(onFailure, error);
    KrollContext* context = [failureCallback context];
    id<TiEvaluator> evaluator = (id<TiEvaluator>)context.delegate;
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:error.code, @"code", error.message, @"message", error.arguments, @"arguments", self, @"source", nil];
    [evaluator fireEvent:failureCallback withObject:dictionary remove:NO thisObject:nil];
}

- (void)onSuccess {
    KrollContext* context = [successCallback context];
    id<TiEvaluator> evaluator = (id<TiEvaluator>)context.delegate;
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:self, @"source", nil];
    [evaluator fireEvent:successCallback withObject:dictionary remove:NO thisObject:nil];
}

-(void)syncStatusHasBeenChangedTo:(MobeelizerSyncStatus)status {
    ENSURE_UI_THREAD(syncStatusHasBeenChangedTo, status);
    NSString *string = [TiMobeelizerSdkUtil syncStatusToString:status];    
    KrollContext* context = [successCallback context];
    id<TiEvaluator> evaluator = (id<TiEvaluator>)context.delegate;
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:string, @"status", self, @"source", nil];
    [evaluator fireEvent:successCallback withObject:dictionary remove:NO thisObject:nil];
}

@end
