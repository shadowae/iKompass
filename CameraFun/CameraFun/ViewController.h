//
//  ViewController.h
//  CameraFun
//
//  Created by ASatish Kumar on 21/12/14.
//  Copyright (c) 2014 i3Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Social/Social.h>


@interface ViewController : UIViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) NSURL *videoURL;


@end

