//
//  DetailViewController.h
//  MyCoreData
//
//  Created by ASatish Kumar on 20/12/14.
//  Copyright (c) 2014 i3Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

