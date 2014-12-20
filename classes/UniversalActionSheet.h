//
//  UniversalActionSheet.h
//
//  Created by Sergey Evseev on 27/11/14.
//
//

#import <Foundation/Foundation.h>
@import UIKit;

@protocol UniversalActionSheetDelegate;

@interface UniversalActionSheet : NSObject


@property (nonatomic, weak) id<UniversalActionSheetDelegate> delegate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly) NSInteger numberOfButtons;
@property (nonatomic) NSInteger cancelButtonIndex;
@property (nonatomic) NSInteger destructiveButtonIndex;
@property (nonatomic, readonly) NSInteger firstOtherButtonIndex;
@property (nonatomic, readonly, getter=isVisible) BOOL visible;
@property (nonatomic, retain) UIView *parentView;


- (instancetype)initWithTitle:(NSString *)title delegate:(id<UniversalActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (NSInteger)addButtonWithTitle:(NSString *)title;
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;
- (void)showFromToolbar:(UIToolbar *)view;
- (void)showFromTabBar:(UITabBar *)view;
- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;
- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated;
- (void)showInView:(UIView *)view;
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

- (void)setTag:(NSInteger)tag;
- (NSInteger)tag;

@end


@protocol UniversalActionSheetDelegate <NSObject>

@optional

- (void)actionSheet:(UniversalActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)actionSheetCancel:(UniversalActionSheet *)actionSheet;
- (void)willPresentActionSheet:(UniversalActionSheet *)actionSheet;
- (void)didPresentActionSheet:(UniversalActionSheet *)actionSheet;
- (void)actionSheet:(UniversalActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)actionSheet:(UniversalActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end