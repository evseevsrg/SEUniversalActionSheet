# UniversalActionSheet

Universal ActionSheet class for both iOS7 and iOS8, that implements UIActionSheet interface.


## Example Usage

Import UniversalActionSheet header
``` objective-c
#import "UniversalActionSheet.h"
```

Create UniversalActionSheet object and use it as usual UIActionSheet object
``` objective-c
UniversalActionSheet *actionSheet = [[UniversalActionSheet alloc] initWithTitle:@"UniversalActionSheet demo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:@"Other_1", @"Other_2", nil];
[actionSheet showInView:self.view];

#pragma mark - UniversalActionSheetDelegate
- (void)actionSheet:(UniversalActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex { 
... 
}

```
