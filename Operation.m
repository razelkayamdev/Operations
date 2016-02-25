//
//  Operation.m
//  test
//
//  Created by Raz Elkayam on 2/23/16.
//  Copyright © Raz Elkayam. All rights reserved.
//

#import "Operation.h"

@interface Operation ()

// Overriding NSOperation
@property (readwrite, getter=isExecuting) BOOL executing;
@property (readwrite, getter=isFinished) BOOL finished;

@end

@implementation Operation

@synthesize executing = _executing, finished = _finished;

- (void)main
{
    [self setExecuting:YES];
    dispatch_queue_t bg = dispatch_queue_create("Some Background Queue", NULL);
    
    dispatch_async(bg, ^{
       
        NSLog(@"Started");
        sleep(2);
        NSLog(@"Finished");
        [self completeOperation];
    });
}

- (void)start
{
    if (self.isCancelled) {
    
        [self setFinished:YES];
        
        return;
    }
    
    [self main];
}

- (void)completeOperation
{
    [self setExecuting:NO];
    [self setFinished:YES];
}

#pragma mark - Gettres & Setters

- (void)setExecuting:(BOOL)executing
{
    @synchronized(self) {
     
        [self willChangeValueForKey:@"isExecuting"];
        _executing = executing;
        [self didChangeValueForKey:@"isExecuting"];
    }
}

- (void)setFinished:(BOOL)finished
{
    @synchronized(self) {
     
        [self willChangeValueForKey:@"isFinished"];
        _finished = finished;
        [self didChangeValueForKey:@"isFinished"];
    }
}

- (BOOL)isExecuting
{
    BOOL isExexuting = NO;
    
    @synchronized(self) {
        
        isExexuting = _executing;
    }
    
    return isExexuting;
}

- (BOOL)isFinished
{
    BOOL finished = NO;
    
    @synchronized(self) {
        
        finished = _finished;
    }
    
    return finished;
}

- (BOOL)isConcurrent
{
    return YES;
}

@end
