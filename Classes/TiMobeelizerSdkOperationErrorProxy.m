//
// TiMobeelizerSdkOperationErrorProxy.m
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

#import "TiMobeelizerSdkOperationErrorProxy.h"

@interface TiMobeelizerSdkOperationErrorProxy() {
    MobeelizerOperationError *error;
}
@end

@implementation TiMobeelizerSdkOperationErrorProxy

- (id)initWithError:(MobeelizerOperationError *)operationError {
    if(operationError == nil) {
        return nil;
    }
    if(self = [super init]) {
        [operationError retain];
        error = operationError;
    }
    return self;
}

-(void)dealloc {
    [error release];
    [super dealloc];
}

-(id)message:(id)args {
    return [error message];
}

-(id)code:(id)args {
    return [error code];
}

-(id)arguments:(id)args {
    return [error arguments];
}

-(id)toString:(id)args {
    return [error description];
}

@end
