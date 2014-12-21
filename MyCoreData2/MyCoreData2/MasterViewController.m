//
//  MasterViewController.m
//  MyCoreData2
//
//  Created by ASatish Kumar on 20/12/14.
//  Copyright (c) 2014 i3Tech. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

@synthesize  managedObjectContext, fetchedObjects;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // pull function from managed object context
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    // telling what we need
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"OrderInfo" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    // telling it to fetch it now
    fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return fetchedObjects.count;
}

-(void) didCancelEditingItem:(EditItemTableViewController *)editItemTableViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) didFinishEditingItem:(EditItemTableViewController *)editItemTableViewController itemData:(NSManagedObject *)item
{
    NSError *error;
    [self.managedObjectContext save:&error];
    if (error) {
        NSLog(@"Error updating record. Error is %@", error.localizedDescription);
    } else {
        NSUInteger position = [self.fetchedObjects indexOfObject:item];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:position inSection:0];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = [item valueForKey:@"ordername"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"orderinfocell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSManagedObject *info = (NSManagedObject *) [fetchedObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [info valueForKey:@"orderid"]];
    cell.detailTextLabel.text = [info valueForKeyPath:@"ordername"];
    NSSet *details = (NSSet *)[info valueForKeyPath:@"ordertodetails"];
    for (NSManagedObject *detail in details) {
        NSLog(@"%@", [detail valueForKey:@"productname"]);
    }
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *managedObject = [fetchedObjects objectAtIndex:indexPath.row];
    [self.managedObjectContext deleteObject:managedObject];
    NSError *error;
    [self.managedObjectContext save:&error];
    if(error)
    {
        NSLog(@"Error deleting record. Error is %@", error.localizedDescription);
    }
    else
    {
        NSArray *indexPaths = [NSArray arrayWithObjects:indexPath, nil];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"OrderInfo" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        NSError *error;
        fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
    /*
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   */
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navController =(UINavigationController* ) segue.destinationViewController;
    EditItemTableViewController *editorController = (EditItemTableViewController *) navController.topViewController;
    editorController.delegate = self;
    UITableViewCell *cell = (UITableViewCell *) sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    editorController.managedObject = (NSManagedObject *)[fetchedObjects objectAtIndex:(indexPath.row)];
}
- (IBAction)onSaveButtonPressed:(id)sender {
    NSError *error;
    [self.managedObjectContext save:&error];
}

- (IBAction)onAddButtonPressed:(id)sender {
    
}

@end
