// 
// TiMobeelizerSdkModule.m
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

#import "TiMobeelizerSdkModule.h"
#import "TiMobeelizerSdkDatabaseProxy.h"
#import "TiMobeelizerSdkFileProxy.h"
#import "TiMobeelizerSdkCallback.h"
#import "TiMobeelizerSdkOperationErrorProxy.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiBlob.h"

@implementation TiMobeelizerSdkModule

#pragma mark Internal

-(id)moduleGUID {
	return @"a4387b9f-faf2-4651-aa50-264089c9c05e";
}

-(NSString*)moduleId {
	return @"ti.mobeelizer.sdk";
}

#pragma mark Lifecycle

-(void)startup {
	[super startup];
    
    NSString* properties = [[NSBundle mainBundle] pathForResource:@"mobeelizer" ofType:@"properties"];    
    NSString* contents = [NSString stringWithContentsOfFile:properties encoding:NSUTF8StringEncoding error:nil];    
    NSArray* lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableDictionary *configuration = [NSMutableDictionary dictionary];
    
    for (NSString* line in lines) {
        NSArray* property = [line componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"="]];
        NSString* propertyName = [[property objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if([propertyName hasPrefix:@"#"]) {
            continue;
        }
        
        NSString* propertyValue = [[[property subarrayWithRange:NSMakeRange(1,property.count - 1)] componentsJoinedByString:@"="] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        
        NSLog(@"[INFO] %@ configuration: %@ = %@", self, propertyName, propertyValue);
        [configuration setObject:propertyValue forKey:propertyName];        
    }
        
    [Mobeelizer createWithConfiguration:configuration];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender {
    [Mobeelizer destroy];
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc {
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification {
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)SYNC_NONE {
    return SyncNone;
}

-(id)SYNC_STARTER {
    return SyncStarted;
}

-(id)SYNC_FILE_CREATED {
    return SyncFileCreated ;
}

-(id)SYNC_TASK_CREATED {
    return SyncTaskCreated;
}

-(id)SYNC_TASK_PERFORMED {
    return SyncTaskPerformed;
}

-(id)SYNC_FILE_RECEIVED {
    return SyncFileReceived;
}

-(id)SYNC_FINISHED_WITH_SUCCESS {
    return SyncFinishedWithSuccess;
}

-(id)SYNC_FINISHED_WITH_FAILURE {
    return SyncFinishedWithFailure;
}

-(id)loginAndWait:(id)args {
    NSString *user;
    NSString *password;
    ENSURE_ARG_AT_INDEX(user, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(password, args, 1, NSString);
    return [[TiMobeelizerSdkOperationErrorProxy alloc] initWithError:[Mobeelizer loginUser:user andPassword:password]];
}

-(void)login:(id)args {
    NSString *user;
    NSString *password;
    KrollCallback *successCallback;
    KrollCallback *failureCallback;
    ENSURE_ARG_AT_INDEX(user, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(password, args, 1, NSString);    
    ENSURE_ARG_OR_NIL_AT_INDEX(successCallback, args, 2, KrollCallback);
    ENSURE_ARG_OR_NIL_AT_INDEX(failureCallback, args, 3, KrollCallback);
    [Mobeelizer loginUser:user andPassword:password withCallback:[[TiMobeelizerSdkCallback alloc] initWithSuccessCallback:successCallback andFailureCallback:failureCallback]];
}

-(id)loginToInstanceAndWait:(id)args {
    NSString *instance;
    NSString *user;
    NSString *password;
    ENSURE_ARG_AT_INDEX(instance, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(user, args, 1, NSString);
    ENSURE_ARG_AT_INDEX(password, args, 2, NSString);
    return [[TiMobeelizerSdkOperationErrorProxy alloc] initWithError:[Mobeelizer loginToInstance:instance withUser:user andPassword:password]];
}

-(void)loginToInstance:(id)args {
    NSString *instance;
    NSString *user;
    NSString *password;
    KrollCallback *successCallback;
    KrollCallback *failureCallback;
    ENSURE_ARG_AT_INDEX(instance, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(user, args, 1, NSString);
    ENSURE_ARG_AT_INDEX(password, args, 2, NSString);
    ENSURE_ARG_OR_NIL_AT_INDEX(successCallback, args, 3, KrollCallback);
    ENSURE_ARG_OR_NIL_AT_INDEX(failureCallback, args, 4, KrollCallback);
    [Mobeelizer loginToInstance:instance withUser:user andPassword:password withCallback:[[TiMobeelizerSdkCallback alloc] initWithSuccessCallback:successCallback andFailureCallback:failureCallback]];
}

-(void)logout:(id)args {
    [Mobeelizer logout];
}

-(id)isLoggedIn:(id)args {
    return NUMBOOL([Mobeelizer isLoggedIn]);
}

-(id)syncAndWait:(id)args {
    return [[TiMobeelizerSdkOperationErrorProxy alloc] initWithError:[Mobeelizer sync]];
}

-(id)syncAllAndWait:(id)args {
    return [[TiMobeelizerSdkOperationErrorProxy alloc] initWithError:[Mobeelizer syncAll]];
}

-(void)sync:(id)args {
    KrollCallback *successCallback;
    KrollCallback *failureCallback;
    ENSURE_ARG_OR_NIL_AT_INDEX(successCallback, args, 0, KrollCallback);
    ENSURE_ARG_OR_NIL_AT_INDEX(failureCallback, args, 1, KrollCallback);
    [Mobeelizer syncWithCallback:[[TiMobeelizerSdkCallback alloc] initWithSuccessCallback:successCallback andFailureCallback:failureCallback]];
}

-(void)syncAll:(id)args {
    KrollCallback *successCallback;
    KrollCallback *failureCallback;
    ENSURE_ARG_OR_NIL_AT_INDEX(successCallback, args, 0, KrollCallback);
    ENSURE_ARG_OR_NIL_AT_INDEX(failureCallback, args, 1, KrollCallback);
    [Mobeelizer syncAllWithCallback:[[TiMobeelizerSdkCallback alloc] initWithSuccessCallback:successCallback andFailureCallback:failureCallback]];
}

-(id)checkSyncStatus:(id)args {
    return [TiMobeelizerSdkUtil syncStatusToString:[Mobeelizer checkSyncStatus]];
}

-(void)registerSyncStatusListener:(id)args {
    ENSURE_SINGLE_ARG(args, KrollCallback);
    [Mobeelizer registerSyncStatusListener:[[TiMobeelizerSdkCallback alloc] initWithSuccessCallback:args]];
}

-(id)registerForRemoteNotifications:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    return [[TiMobeelizerSdkOperationErrorProxy alloc] initWithError:[Mobeelizer registerForRemoteNotificationsWithDeviceToken:[args dataUsingEncoding:NSUTF8StringEncoding]]];
}

-(id)unregisterForRemoteNotifications:(id)args {
    return [[TiMobeelizerSdkOperationErrorProxy alloc] initWithError:[Mobeelizer unregisterForRemoteNotifications]];
}

-(id)sendRemoteNotification:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    return [[TiMobeelizerSdkOperationErrorProxy alloc] initWithError:[Mobeelizer sendRemoteNotification:args]];
}

-(id)sendRemoteNotificationToDevice:(id)args {
    NSDictionary *notification;
    NSString *device;
    ENSURE_ARG_AT_INDEX(notification, args, 0, NSDictionary);
    ENSURE_ARG_AT_INDEX(device, args, 1, NSString);
    return [[TiMobeelizerSdkOperationErrorProxy alloc] initWithError:[Mobeelizer sendRemoteNotification:notification toDevice:device]];
}

-(id)sendRemoteNotificationToUsers:(id)args {
    NSDictionary *notification;
    NSArray *users;
    ENSURE_ARG_AT_INDEX(notification, args, 0, NSDictionary);
    ENSURE_ARG_AT_INDEX(users, args, 1, NSArray);
    return [[TiMobeelizerSdkOperationErrorProxy alloc] initWithError:[Mobeelizer sendRemoteNotification:notification toUsers:users]];
}

-(id)sendRemoteNotificationToUsersOnDevice:(id)args {
    NSDictionary *notification;
    NSArray *users;
    NSString *device;
    ENSURE_ARG_AT_INDEX(notification, args, 0, NSDictionary);
    ENSURE_ARG_AT_INDEX(users, args, 1, NSArray);
    ENSURE_ARG_AT_INDEX(device, args, 2, NSString);
    return [[TiMobeelizerSdkOperationErrorProxy alloc] initWithError:[Mobeelizer sendRemoteNotification:notification toUsers:users onDevice:device]];
}

-(id)sendRemoteNotificationToGroup:(id)args {
    NSDictionary *notification;
    NSString *group;
    ENSURE_ARG_AT_INDEX(notification, args, 0, NSDictionary);
    ENSURE_ARG_AT_INDEX(group, args, 1, NSString);
    return [[TiMobeelizerSdkOperationErrorProxy alloc] initWithError:[Mobeelizer sendRemoteNotification:notification toGroup:group]];
}

-(id)sendRemoteNotificationToGroupOnDevice:(id)args {
    NSDictionary *notification;
    NSString *group;
    NSString *device;
    ENSURE_ARG_AT_INDEX(notification, args, 0, NSDictionary);
    ENSURE_ARG_AT_INDEX(group, args, 1, NSString);
    ENSURE_ARG_AT_INDEX(device, args, 2, NSString);
    return [[TiMobeelizerSdkOperationErrorProxy alloc] initWithError:[Mobeelizer sendRemoteNotification:notification toGroup:group onDevice:device]];
}

-(id)createFile:(id)args {
    NSString *name;
    TiBlob *data;
    ENSURE_ARG_AT_INDEX(name, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(data, args, 1, TiBlob);    
    return [[[TiMobeelizerSdkFileProxy alloc] initWithFile:[Mobeelizer createFile:name withData:[data data]]] autorelease];
}

-(id)getExistingFile:(id)args {
    NSString *name;
    NSString *guid;
    ENSURE_ARG_AT_INDEX(name, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(guid, args, 1, NSString);
    return [[[TiMobeelizerSdkFileProxy alloc] initWithFile:[Mobeelizer createFile:name withGuid:guid]] autorelease];
}

-(id)getDatabase:(id)args {
    return [[[TiMobeelizerSdkDatabaseProxy alloc] initWithDatabase:[Mobeelizer database]] autorelease];
}

@end
