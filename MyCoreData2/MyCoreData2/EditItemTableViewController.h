//
//  EditItemTableViewController.h
//  MyCoreData2
//
//  Created by ASatish Kumar on 21/12/14.
//  Copyright (c) 2014 i3Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "EditItemViewControllerDelegate.h"

@interface EditItemTableViewController : UITableViewController

@property (nonatomic, strong) NSManagedObject *managedObject;

@property id<EditItemViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITextField *itemTextField;


@end
