//
//  OperationManager.m
//  test
//
//  Created by Raz Elkayam on 2/21/16.
//  Copyright © 2016 Raz Elkayam. All rights reserved.
//

#import "OperationManager.h"

@interface OperationManager ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, strong) NSMutableArray <Operation *> *pendingOperations;

@end

@implementation OperationManager

- (id)init
{
    self = [super init];
    
    if (self) {
        
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    
    return self;
}

- (void)addOperation:(Operation *)operation
{
    if (operation) {
     
        [self.pendingOperations addObject:operation];
    }
}

- (void)executeOperationsSerially:(BOOL)isSerially
{
    if (isSerially) {
        
        [self.pendingOperations enumerateObjectsUsingBlock:^(NSOperation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx > 0) {
                
                NSOperation *previousOperation = self.pendingOperations[(idx - 1)];
                [obj addDependency:previousOperation];
            }
            
        }];
    }
    
    NSArray *operations = [self.pendingOperations copy];
    [self setPendingOperations:nil];

    [self.operationQueue addOperations:operations waitUntilFinished:NO];
}

- (NSMutableArray *)pendingOperations
{
    if (!_pendingOperations) _pendingOperations = [[NSMutableArray alloc] init];
    return _pendingOperations;
}

@end
