//
//  DragonView.h
//  Assignment02
//
//  Created by JihoonPark on 12/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DragonView;

#pragma mark - Declaration of <DragonViewDelegate> Protocol
@protocol DragonViewDelegate

-(int) dragonOrder: (DragonView *) requestor;
-(NSArray *) dragonPath: (DragonView*) requester;
-(BOOL) singleDrawing:(DragonView*) requester;
-(BOOL) stepByStepDrawingEnabled:(DragonView *) requestor;
-(int) stepPathLength:(DragonView *)requestor;

@end

@interface DragonView : UIView

@property (nonatomic) id<DragonViewDelegate> delegate;

@end
