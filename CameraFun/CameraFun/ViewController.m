//
//  ViewController.m
//  CameraFun
//
//  Created by ASatish Kumar on 21/12/14.
//  Copyright (c) 2014 i3Tech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize imageView, image, videoURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCameraButtonPressed:(id)sender {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Close" destructiveButtonTitle:nil otherButtonTitles:@"Take photo", @"Load photo from gallery", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}
- (IBAction)onSaveButtonPressed:(id)sender {
    if(image)
    {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
        image = nil;
        return;
    }
}
- (IBAction)onSharedButtonPressed:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Social Share" delegate:self cancelButtonTitle:@"Close" destructiveButtonTitle:nil otherButtonTitles:@"Twitter", @"Facebook", @"Email", nil];
    actionSheet.tag = 2;
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 1)
    {
        switch (buttonIndex) {
            case 0:
                [self takePhoto];
                break;
            case 1:
                [self loadPhoto];
                break;
        }
    }
    else
    {
        switch (buttonIndex) {
            case 0:
                [self shareOnTwitter];
                break;
            case 1:
                [self shareOnFacebook];
                break;
            case 2:
                [self shareViaEmail];
                break;
        }
    }
}

-(void) takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // init the controller
        UIImagePickerController *imagePicker =[[UIImagePickerController alloc]init];
        
        imagePicker.delegate = (id)self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
}

-(void) loadPhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        // init the controller
        UIImagePickerController *imagePicker =[[UIImagePickerController alloc]init];
        
        imagePicker.delegate = (id)self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

-(void) shareOnTwitter
{
    
}

-(void) shareOnFacebook
{
    
}

-(void) shareViaEmail
{
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        image = info[UIImagePickerControllerEditedImage];
        imageView.image = image;
    } else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        //NSURL *url= info[UIImagePickerControllerMediaURL];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *) error contextInfo:(void *)contextInfo
{
    if(error)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Save Failed" message:@"Failed to save media" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                              [alert show];
    }
                              self.image = nil;
}

@end
