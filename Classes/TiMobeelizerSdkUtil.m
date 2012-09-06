// 
// TiMobeelizerSdkUtil.m
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

#import "TiMobeelizerSdkUtil.h"
#import "TiMobeelizerSdkFileProxy.h"

@implementation TiMobeelizerSdkUtil

+(NSString *)syncStatusToString:(MobeelizerSyncStatus)status {
    switch (status) {
        case MobeelizerSyncStatusFinishedWithSuccess:
            return SyncFinishedWithSuccess;
        case MobeelizerSyncStatusNone:
            return SyncNone;            
        case MobeelizerSyncStatusStarted:
            return SyncStarted;
        case MobeelizerSyncStatusFileCreated:
            return SyncFileCreated;
        case MobeelizerSyncStatusTaskCreated:
            return SyncTaskCreated;
        case MobeelizerSyncStatusFileReceived:
            return SyncFileReceived;
        case MobeelizerSyncStatusTaskPerformed:
            return SyncTaskPerformed;
        default:
            return SyncFinishedWithFailure;
    }    
}

+ (NSString *)errorCodeToString:(MobeelizerErrorCode)code {
    switch (code) {
        case MobeelizerErrorCodeGreaterThan:
            return ValidationErrorGreaterThan;
        case MobeelizerErrorCodeGreaterThanOrEqualsTo:
            return ValidationErrorGreaterThanOrEqualsTo;
        case MobeelizerErrorCodeLessThan:
            return ValidationErrorLessThan;
        case MobeelizerErrorCodeLessThanOrEqualsTo:
            return ValidationErrorLessThanOrEqualsTo;
        case MobeelizerErrorCodeNotFound:
            return ValidationErrorNotFound;
        case MobeelizerErrorCodeTooLong:
            return ValidationErrorTooLong;
        default:
            return ValidationErrorEmpty;
    }        
}

+ (MobeelizerMatchMode)stringToMatchMode:(NSString *)mode {
    if([mode isEqualToString:MatchModeAnywhere]) {
        return MobeelizerMatchModeAnywhere;
    } else if([mode isEqualToString:MatchModeEnd]) {
        return MobeelizerMatchModeEnd;
    } else if([mode isEqualToString:MatchModeStart]) {
        return MobeelizerMatchModeStart;
    } else {
        return MobeelizerMatchModeExact;
    }
}

@end
