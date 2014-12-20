//
//  ViewController.h
//  UniversalActionSheetDemo
//
//  Created by Evseev Sergey on 20/12/14.
//  Copyright (c) 2014 Sergey Evseev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversalActionSheet.h"

@protocol UniversalActionSheetDelegate;

@interface ViewController : UIViewController <UniversalActionSheetDelegate>

- (IBAction)showActionSheet:(id)sender;


@end

