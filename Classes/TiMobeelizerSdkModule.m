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
    
    NSMutableDictionary *configuration = [NSMutableDictionary dictionary];
    [configuration setValue:@"mobile" forKey:@"device"];
    [configuration setValue:@"test" forKey:@"mode"];
    [configuration setValue:@"users-mobile" forKey:@"developmentRole"];
    [configuration setValue:@"application.xml" forKey:@"definitionAsset"];
    
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

-(id)LOGIN_OK {
    return LoginOk;
}

-(id)LOGIN_AUTHENTICATION_FAILURE {
    return LoginAuthenticationFailure;
}

-(id)LOGIN_CONNECTION_FAILURE {
    return LoginConnectionFailure;
}

-(id)LOGIN_MISSING_CONNECTION_FAILURE {
    return LoginMissingConnectionFailure;
}

-(id)LOGIN_OTHER_FAILURE {
    return LoginOtherFailure;
}

-(id)COMMUNICATION_SUCCESS {
    return CommunicationSuccess;
}

-(id)COMMUNICATION_FAILURE {
    return CommunicationFailure;
}

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
    return [TiMobeelizerSdkUtil loginStatusToString:[Mobeelizer loginUser:user andPassword:password]];
}

-(void)login:(id)args {
    NSString *user;
    NSString *password;
    KrollCallback *callback;
    ENSURE_ARG_AT_INDEX(user, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(password, args, 1, NSString);    
    ENSURE_ARG_AT_INDEX(callback, args, 2, KrollCallback);
    [Mobeelizer loginUser:user andPassword:password withCallback:[[TiMobeelizerSdkCallback alloc] initWithCallback:callback]];
}

-(id)loginToInstanceAndWait:(id)args {
    NSString *instance;
    NSString *user;
    NSString *password;
    ENSURE_ARG_AT_INDEX(instance, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(user, args, 1, NSString);
    ENSURE_ARG_AT_INDEX(password, args, 2, NSString);
    return [TiMobeelizerSdkUtil loginStatusToString:[Mobeelizer loginToInstance:instance withUser:user andPassword:password]];
}

-(void)loginToInstance:(id)args {
    NSString *instance;
    NSString *user;
    NSString *password;
    KrollCallback *callback;
    ENSURE_ARG_AT_INDEX(instance, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(user, args, 1, NSString);
    ENSURE_ARG_AT_INDEX(password, args, 2, NSString);
    ENSURE_ARG_AT_INDEX(callback, args, 3, KrollCallback);
    [Mobeelizer loginToInstance:instance withUser:user andPassword:password withCallback:[[TiMobeelizerSdkCallback alloc] initWithCallback:callback]];
}

-(void)logout:(id)args {
    [Mobeelizer logout];
}

-(id)isLoggedIn:(id)args {
    return NUMBOOL([Mobeelizer isLoggedIn]);
}

-(id)syncAndWait:(id)args {
    return [TiMobeelizerSdkUtil syncStatusToString:[Mobeelizer sync]];
}

-(id)syncAllAndWait:(id)args {
    return [TiMobeelizerSdkUtil syncStatusToString:[Mobeelizer syncAll]];
}

-(void)sync:(id)args {
    ENSURE_SINGLE_ARG(args, KrollCallback);
    [Mobeelizer syncWithCallback:[[TiMobeelizerSdkCallback alloc] initWithCallback:args]];
}

-(void)syncAll:(id)args {
    ENSURE_SINGLE_ARG(args, KrollCallback);
    [Mobeelizer syncAllWithCallback:[[TiMobeelizerSdkCallback alloc] initWithCallback:args]];
}

-(id)checkSyncStatus:(id)args {
    return [TiMobeelizerSdkUtil syncStatusToString:[Mobeelizer checkSyncStatus]];
}

-(void)registerSyncStatusListener:(id)args {
    ENSURE_SINGLE_ARG(args, KrollCallback);
    [Mobeelizer registerSyncStatusListener:[[TiMobeelizerSdkCallback alloc] initWithCallback:args]];
}

-(id)registerForRemoteNotifications:(id)args {
    ENSURE_SINGLE_ARG(args, NSString);
    return [TiMobeelizerSdkUtil communicationStatusToString:[Mobeelizer registerForRemoteNotificationsWithDeviceToken:[args dataUsingEncoding:NSUTF8StringEncoding]]];
}

-(id)unregisterForRemoteNotifications:(id)args {
    return [TiMobeelizerSdkUtil communicationStatusToString:[Mobeelizer unregisterForRemoteNotifications]];
}

-(id)sendRemoteNotification:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    return [TiMobeelizerSdkUtil communicationStatusToString:[Mobeelizer sendRemoteNotification:args]];
}

-(id)sendRemoteNotificationToDevice:(id)args {
    NSDictionary *notification;
    NSString *device;
    ENSURE_ARG_AT_INDEX(notification, args, 0, NSDictionary);
    ENSURE_ARG_AT_INDEX(device, args, 1, NSString);
    return [TiMobeelizerSdkUtil communicationStatusToString:[Mobeelizer sendRemoteNotification:notification toDevice:device]];
}

-(id)sendRemoteNotificationToUsers:(id)args {
    NSDictionary *notification;
    NSArray *users;
    ENSURE_ARG_AT_INDEX(notification, args, 0, NSDictionary);
    ENSURE_ARG_AT_INDEX(users, args, 1, NSArray);
    return [TiMobeelizerSdkUtil communicationStatusToString:[Mobeelizer sendRemoteNotification:notification toUsers:users]];
}

-(id)sendRemoteNotificationToUsersOnDevice:(id)args {
    NSDictionary *notification;
    NSArray *users;
    NSString *device;
    ENSURE_ARG_AT_INDEX(notification, args, 0, NSDictionary);
    ENSURE_ARG_AT_INDEX(users, args, 1, NSArray);
    ENSURE_ARG_AT_INDEX(device, args, 2, NSString);
    return [TiMobeelizerSdkUtil communicationStatusToString:[Mobeelizer sendRemoteNotification:notification toUsers:users onDevice:device]];
}

-(id)sendRemoteNotificationToGroup:(id)args {
    NSDictionary *notification;
    NSString *group;
    ENSURE_ARG_AT_INDEX(notification, args, 0, NSDictionary);
    ENSURE_ARG_AT_INDEX(group, args, 1, NSString);
    return [TiMobeelizerSdkUtil communicationStatusToString:[Mobeelizer sendRemoteNotification:notification toGroup:group]];
}

-(id)sendRemoteNotificationToGroupOnDevice:(id)args {
    NSDictionary *notification;
    NSString *group;
    NSString *device;
    ENSURE_ARG_AT_INDEX(notification, args, 0, NSDictionary);
    ENSURE_ARG_AT_INDEX(group, args, 1, NSString);
    ENSURE_ARG_AT_INDEX(device, args, 2, NSString);
    return [TiMobeelizerSdkUtil communicationStatusToString:[Mobeelizer sendRemoteNotification:notification toGroup:group onDevice:device]];
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

-(id)ddddd:(id)args {
    ENSURE_SINGLE_ARG(args, KrollCallback);    
    [self _fireEventToListener:@"eventName" withObject:[NSDictionary dictionaryWithObject:@"v" forKey:@"k"] listener:args thisObject:self];
}


@end
