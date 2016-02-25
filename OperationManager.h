//
//  OperationManager.h
//  test
//
//  Created by Raz Elkayam on 2/21/16.
//  Copyright © 2016 Raz Elkayam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Operation.h"

@interface OperationManager : NSObject

/*!
 * Add an operation.
 */
- (void)addOperation:(Operation *)operation;

/*!
 * Execute added operations.
 */
- (void)executeOperationsSerially:(BOOL)isSerially;

@end
