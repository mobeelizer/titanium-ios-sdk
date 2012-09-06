// 
// TiMobeelizerSdkUtil.h
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

#import <Foundation/Foundation.h>
#import <MobeelizerSDK/MobeelizerSDK.h>

#define SyncNone @"NONE"
#define SyncStarted @"STARTER"
#define SyncFileCreated @"FILE_CREATED" 
#define SyncTaskCreated @"TASK_CREATED" 
#define SyncTaskPerformed @"TASK_PERFORMED"
#define SyncFileReceived @"FILE_RECEIVED" 
#define SyncFinishedWithSuccess @"FINISHED_WITH_SUCCESS" 
#define SyncFinishedWithFailure @"FINISHED_WITH_FAILURE" 

#define ValidationErrorEmpty @"EMPTY";
#define ValidationErrorTooLong @"TOO_LONG";
#define ValidationErrorGreaterThan @"GREATER_THAN";
#define ValidationErrorGreaterThanOrEqualsTo @"GREATER_THAN_OR_EQUALS_TO";
#define ValidationErrorLessThan @"LESS_THAN";
#define ValidationErrorLessThanOrEqualsTo @"LESS_THAN_OR_EQUALS_TO";
#define ValidationErrorNotFound @"NOT_FOUND";

#define MatchModeAnywhere @"ANYWHERE"
#define MatchModeEnd @"END"
#define MatchModeExact @"EXACT"
#define MatchModeStart @"START"

@interface TiMobeelizerSdkUtil : NSObject

+(NSString *)syncStatusToString:(MobeelizerSyncStatus)status;

+(NSString *)errorCodeToString:(MobeelizerErrorCode)code;

+(MobeelizerMatchMode)stringToMatchMode:(NSString *)mode;

@end
