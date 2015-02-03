//
//  UniversalActionSheet.m
//
//  Created by Sergey Evseev on 27/11/14.
//
//

#import "UniversalActionSheet.h"

@interface UniversalActionSheet () <UniversalActionSheetDelegate, NSCopying> {
    
    UIActionSheet *actionSheet;
    UIAlertController *alertController;
    NSUInteger tag;
    
    // UIAlertController
    NSString *alertTitle;
    NSString *destructiveTitle;
    NSString *cancelTitle;
    NSMutableArray *otherTitles;
    
    UIViewController *topController;
    
    BOOL isIOS8;
    
    
}

@end


@implementation UniversalActionSheet


- (instancetype)initWithTitle:(NSString *)title delegate:(id<UniversalActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
  
  if (self = [super init]) {
    
    self.delegate = delegate;
    otherTitles = [[NSMutableArray alloc] init];
    
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 8)
        isIOS8 = YES;
      
    if (isIOS8) {

      alertTitle = title;
      destructiveTitle = destructiveButtonTitle;
      cancelTitle = cancelButtonTitle;
      
      va_list args;
      va_start(args, otherButtonTitles);
      for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*))
      {
        if (arg) {
          [otherTitles addObject:arg];
        }
      }
      va_end(args);
      
    } else {
      actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:(id <UIActionSheetDelegate>)delegate cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];

      if (destructiveButtonTitle)
        actionSheet.destructiveButtonIndex = [actionSheet addButtonWithTitle:destructiveButtonTitle];
      
      va_list args;
      va_start(args, otherButtonTitles);
      for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
        [actionSheet addButtonWithTitle:arg];
      }
      va_end(args);
      
      if (cancelButtonTitle)
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:cancelButtonTitle];

    }
    
  }
  
  return self;
  
}


- (NSInteger)addButtonWithTitle:(NSString *)title {
  
  NSInteger index = -1;
  
  if (isIOS8) {
    NSLog(@"%s is not implemented", __PRETTY_FUNCTION__);
    [NSException raise:@"NotImplemented" format:@"Method not implemented"];
  } else {
    index = [actionSheet addButtonWithTitle:title];
  }
  
  return index;
  
}


- (NSString *)buttonTitleAtIndex:(NSInteger)_buttonIndex {
  
  NSString *title;
  
  if (isIOS8) {
    
  } else {
    title = [actionSheet buttonTitleAtIndex:_buttonIndex];
  }
  
  return title;
  
}


- (void)showFromToolbar:(UIToolbar *)view {
  
  NSLog(@"%s is not implemented", __PRETTY_FUNCTION__);
  [NSException raise:@"NotImplemented" format:@"Method not implemented"];
  
}


- (void)showFromTabBar:(UITabBar *)view {
  
  NSLog(@"%s is not implemented", __PRETTY_FUNCTION__);
  [NSException raise:@"NotImplemented" format:@"Method not implemented"];
  
}


- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated {
  
  NSLog(@"%s is not implemented", __PRETTY_FUNCTION__);
  [NSException raise:@"NotImplemented" format:@"Method not implemented"];
  
}


- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated {
  
  NSLog(@"%s is not implemented", __PRETTY_FUNCTION__);
  [NSException raise:@"NotImplemented" format:@"Method not implemented"];
  
}


- (void)showInView:(UIView *)view {
  
  if (isIOS8) {
    
    [self p_initAlertController];
    
    topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [topController presentViewController:alertController animated:YES completion:^{
      //
    }];
  } else {
    [actionSheet showInView:view];
  }
  
}


- (void)dismissWithClickedButtonIndex:(NSInteger)_buttonIndex animated:(BOOL)animated {
 
  if (isIOS8) {
    
    for(int i=0; i<alertController.actions.count; i++) {
      id obj = [alertController.actions objectAtIndex:i];
      obj = nil;
    }
    
    [alertController dismissViewControllerAnimated:YES completion:^{
      //
    }];
    
  } else {
    [actionSheet dismissWithClickedButtonIndex:_buttonIndex animated:animated];
  }
  
}


- (void)setTag:(NSInteger)_tag {
  
  if (isIOS8)
    tag = _tag;
  
  actionSheet.tag = _tag;
  
}


- (NSInteger)tag {
  
  if (isIOS8)
    return tag;
  
  return actionSheet.tag;
  
}


- (void)dealloc {
    
    topController = nil;
    
}


#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  
  if (isIOS8) {
    UniversalActionSheet *copy = [[UniversalActionSheet allocWithZone:zone] init];
    [copy setTag:self.tag];
    return copy;
  }
  return nil;
  
}



#pragma mark - private methods

- (void)p_initAlertController {
    
    int buttonIndex = -1;
    
    alertController = [UIAlertController alertControllerWithTitle:alertTitle message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self.delegate) wdelegate = self.delegate;
    __weak typeof(self) wself = self;
    
    // Set destructive button
    if (destructiveTitle) {
        buttonIndex++;
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            if ([wdelegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)])
                [wdelegate actionSheet:wself clickedButtonAtIndex:buttonIndex];
        }];
        [alertController addAction:destructiveAction];
    }
    
    // Set other buttons
    if (otherTitles.count) {
        for(NSString *buttonTitle in otherTitles) {
            buttonIndex++;
            UIAlertAction *otherButton = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if ([wdelegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)])
                    [wdelegate actionSheet:wself clickedButtonAtIndex:buttonIndex];
            }];
            [alertController addAction:otherButton];
        }
    }
    
    // Set cancel button
    if (cancelTitle) {
        buttonIndex++;
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if ([wdelegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)])
                [wdelegate actionSheet:wself clickedButtonAtIndex:buttonIndex];
        }];
        [alertController addAction:cancelAction];
    }
    
}


@end
