//
//  ViewController.m
//  UniversalActionSheetDemo
//
//  Created by Evseev Sergey on 20/12/14.
//  Copyright (c) 2014 Sergey Evseev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showActionSheet:(id)sender {
    
    UniversalActionSheet *actionSheet = [[UniversalActionSheet alloc] initWithTitle:@"UniversalActionSheet demo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:@"Other_1", @"Other_2", nil];
    
    [actionSheet showInView:self.view];
    
}


#pragma mark - UniversalActionSheetDelegate


- (void)actionSheet:(UniversalActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"Delete");
            break;
            
        case 1:
            NSLog(@"Other_1");
            break;
            
        case 2:
            NSLog(@"Other_2");
            break;
            
        case 3:
            NSLog(@"Cancel");
            break;
            
        default:
            break;
    }
    
}


#pragma mark - private methods

- (void)initAndShowActionSheet {
    
}


@end
