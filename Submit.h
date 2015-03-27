//
//  SubmitViewController.h
//  iPentestCTF
//
//  Created by Daniel on 16/03/2015.
//  Copyright (c) 2015 Daniel Reece. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *flagField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UILabel *NoticationLabel;

- (IBAction)pasteButton:(id)sender;
- (IBAction)submitButton:(id)sender;

@end

UIPasteboard *appPasteBoard;
