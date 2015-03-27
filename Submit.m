//
//  SubmitViewController.m
//  iPentestCTF
//
//  Created by Daniel on 16/03/2015.
//  Copyright (c) 2015 Daniel Reece. All rights reserved.
//

#import "SubmitViewController.h"

@interface SubmitViewController ()
@end

@implementation SubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    _flagField.tag = 0;
    _usernameField.tag = 1;
    _passwordField.tag = 2;
    
    _flagField.delegate = self;
    _usernameField.delegate = self;
    _passwordField.delegate = self;

}


- (IBAction)pasteButton:(id)sender {
    
    //copy clipboard contents
    UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];
    NSString *string = [appPasteBoard string];
    //log clipboard
    NSLog(string, nil);
    
    [_flagField setText:string];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    switch(textField.tag) {
        case 0:
            if ([_flagField.text  isEqual: @"flag"]){
                _flagField.text = @"";
             }
            _flagField.secureTextEntry = YES;
            break;
        case 1:
            if ([_usernameField.text  isEqual: @"username"]){
                _usernameField.text = @"";
            }
            _usernameField.secureTextEntry = NO;
            break;
        case 2:
            if ([_passwordField.text  isEqual: @"password"]){
                _passwordField.text = @"";
            }
            _passwordField.secureTextEntry = YES;
            break;
        default:
            break;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([_flagField.text  isEqual: @""]){
        _flagField.text = @"flag";
        _flagField.secureTextEntry = NO;
    }
    if ([_usernameField.text  isEqual: @""]){
        _usernameField.text = @"username";
    }
    if ([_passwordField.text  isEqual: @""]){
        _passwordField.text = @"password";
        _passwordField.secureTextEntry = NO;
    }
}


- (IBAction)submitButton:(id)sender {
    
    NSString *flag = _flagField.text;
    NSString *username = _usernameField.text;
    NSString *password = _passwordField.text;
    
    NSString *barcodeURL = [[NSString alloc] initWithFormat:@"http://localhost/xampp/ctf/api.php?submit&flag=%@&username=%@&password=%@", flag, username, password];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:barcodeURL]];
    [request setHTTPMethod:@"GET"];
    
    
    //  [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *respData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *notification = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
    
    _NoticationLabel.text = notification;
}
@end
