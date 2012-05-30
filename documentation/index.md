# Mobeelizer SDK Module

## Description

The Mobeelizer SDK is a module to connect Titanium application with [Mobeelizer](http://www.mobeelizer.com/) platform. See [Mobeelizer SDK reference](http://mobeelizer.com/docs/titanium/titanium-references) for more information.

## Accessing the Mobeelizer SDK Module

To access this module from JavaScript, you would do the following:

	var Mobeelizer = require("ti.mobeelizer.sdk");

The Mobeelizer variable is a reference to the Module object.	

## User Session

### string LOGIN_OK

Login status. The user session has been successfully created.

### string LOGIN_AUTHENTICATION_FAILURE

Login status. Login, password and instance do not match to any existing users.

### string LOGIN_CONNECTION_FAILURE

Login status. Connection error. Look for the explanation in the application logs.

### string LOGIN_MISSING_CONNECTION_FAILURE

Login status. Missing connection. First login requires active Internet connection.

### string LOGIN_OTHER_FAILURE

Login status. Unknown error. Look for the explanation in the instance logs and the application logs.

### void login(string user, string password, function callback)

Create a user session for the given login, password and instance equal to the mode ("test" or "production"). Callback will be invoked on finish and will receive the login status as "status" event's element.

### void loginToInstance(string instance, string user, string password, function callback)

Create a user session for the given login, password and instance. Callback will be invoked on finish and will receive the login status as "status" event's element.

### string loginAndWait(string user, string password)

Create a user session for the given login, password and instance equal to the mode ("test" or "production"). Return login status. This version of method is synchronous and lock the invoker thread. Do not call this method in UI thread.

### string loginToInstanceAndWait(string instance, string user, string password)

Create a user session for the given login, password and instance. Return login status. This version of method is synchronous and lock the invoker thread. Do not call this method in UI thread.

### boolean isLoggedIn()

Check if the user session is active.

### void logout()

Close the user session.

## Synchronization

### string SYNC_NONE

Sync status. Sync has not been executed in the existing user session.

### string SYNC_STARTER

Sync status. Sync is in progress. The file with local changes is being prepared.

### string SYNC_FILE_CREATED

Sync status. Sync is in progress. The file with local changes has been prepared and now is being transmitted to the cloud.

### string SYNC_TASK_CREATED

Sync status. Sync is in progress. The file with local changes has been transmitted to the cloud. Waiting for the cloud to finish processing sync.

### string SYNC_TASK_PERFORMED

Sync status. Sync is in progress. The file with cloud changes has been prepared and now is being transmitted to the device.

### string SYNC_FILE_RECEIVED

Sync status. Sync is in progress. The file with cloud changes has been transmitted to the device cloud and now is being inserted into local database.

### string SYNC_FINISHED_WITH_SUCCESS

Sync status. Sync has been finished successfully.

### string SYNC_FINISHED_WITH_FAILURE

Sync status. Sync has not been finished successfully. Look for the explanation in the application logs.

### void sync(function callback)

Start a differential sync. Callback will be invoked on finish and will receive the sync status as "status" event's element.

### void syncAll(function callback)

Start a full sync. Callback will be invoked on finish and will receive the sync status as "status" event's element.

### string syncAndWait()

Start a differential sync. Return sync status. This version of method is synchronous and lock the invoker thread. Do not call this method in UI thread.

### string syncAllAndWait()

Start a full sync. Return sync status. This version of method is synchronous and lock the invoker thread. Do not call this method in UI thread.

### string checkSyncStatus()

Check and return the status of current sync.

### void registerSyncStatusListener(function callback)

Register listener that will be notified if sync status is changed. Callback will receive the sync status as "status" event's element.

## Database

### [MobeelizerDatabase](database.html) getDatabase()

Database for the active user session.

## Remote Notifications

### string COMMUNICATION_SUCCESS

Communication status. The operation has finished successfully.

### string COMMUNICATION_FAILURE

Communication status. The operation has failed.

### string registerForRemoteNotifications(string token)

Register the token received from Apple Push Notification Service or Google C2DM. Return communication status.

### string unregisterForRemoteNotifications()

Unregister device from push notification service. Return communication status.

### string sendRemoteNotification(dictionary notification)

Broadcast the remote notification. Return communication status.

### string sendRemoteNotificationToDevice(dictionary notification, string device)

Broadcast the remote notification to given device. Return communication status.

### string sendRemoteNotificationToUsers(dictionary notification, string[] users)

Send the remote notification to given users. Return communication status.

### string sendRemoteNotificationToUsersOnDevice(dictionary notification, string[] users, string device)

Send the remote notification to given users and device. Return communication status.

### string sendRemoteNotificationToGroup(dictionary notification, string group)

Send the remote notification to given users' group. Return communication status.

### string sendRemoteNotificationToGroupOnDevice(dictionary notification, string group, string device)

Send the remote notification to given group and device. Return communication status.

## Files

### [MobeelizerFile](file.html) createFile(string name, Titanium.Blob blob)

Create a new file with a given name and content.

### [MobeelizerFile](file.html) getExistingFile(string name, string guid)

Create a file with a given name that points to a file with a given guid.

## Usage

See example/app.js.

## Copyright

Copyright 2012 Mobeelizer Ltd

Mobeelizer SDK is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
 
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
 
You should have received a copy of the GNU Affero General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
