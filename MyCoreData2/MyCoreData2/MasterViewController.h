//
//  MasterViewController.h
//  MyCoreData2
//
//  Created by ASatish Kumar on 20/12/14.
//  Copyright (c) 2014 i3Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData/CoreData.h"
#import "EditItemTableViewController.h"

@interface MasterViewController : UITableViewController<EditItemViewControllerDelegate>

@property(nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property(nonatomic, strong) NSArray *fetchedObjects;

@end
