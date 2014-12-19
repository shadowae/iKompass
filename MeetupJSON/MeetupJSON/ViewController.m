//
//  ViewController.m
//  MeetupJSON
//
//  Created by ASatish Kumar on 13/12/14.
//  Copyright (c) 2014 i3Tech. All rights reserved.
//

#import "ViewController.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)
#define kJSONURL [NSURL URLWithString:@"http://api.meetup.com/2/categories?order=shortname&desc=false&offset=0&photo-host=public&format=json&page=20&sig_id=182961571&sig=5dccc0f6bfd09a975473b1f2e4843c12813e3d52"]

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(kBgQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:kJSONURL];
        [self performSelectorOnMainThread:@selector(jsonData:)
                withObject:data waitUntilDone:YES];
    });
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)jsonData:(NSData *) fetchMeetupData{

    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:fetchMeetupData options:kNilOptions error:&error];
    NSArray *eventResults = [json objectForKey:@"results"];
    
    NSMutableString *stringV = [[NSMutableString alloc] initWithCapacity:5];
    
    for (NSDictionary *result in eventResults) {
            [stringV appendFormat:@"%@", [result objectForKey:@"id"]];
        
    }
    NSDictionary *result =[eventResults objectAtIndex:0];
    self.resultsTextView.text = stringV;
    //self.resultsTextView.text = [NSString stringWithFormat:@"%@", [eventResults objectAtIndex:0] ];
    
    //1 Get the latest loan
    //NSDictionary* result = [eventResults objectAtIndex:0];
    //_resultsTextView.text = [NSString stringWithFormat:@"%@", result];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
