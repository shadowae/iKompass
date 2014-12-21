//
//  EditItemViewControllerDelegate.h
//  MyCoreData2
//
//  Created by ASatish Kumar on 21/12/14.
//  Copyright (c) 2014 i3Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EditItemTableViewController;
@class NSManagedObject;

@protocol EditItemViewControllerDelegate <NSObject>

-(void)didCancelEditingItem : (EditItemTableViewController *) editItemTableViewController;
-(void)didFinishAddingItem : (EditItemTableViewController *) editItemTableViewController itemData: (NSManagedObject *) item;
-(void)didFinishEditingItem: (EditItemTableViewController *) editItemTableViewController itemData: (NSManagedObject *) item;

@end
