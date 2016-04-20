//
//  FCCreateAccountTableViewController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/20/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation
import QuartzCore

class FCCreateAccountTableViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    var name: String!
    var email: String!
    var password: String!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField.becomeFirstResponder()
        setupTextField(self.nameField, placeholder: "Username")
        setupTextField(self.emailField, placeholder: "Email")
        setupTextField(self.passwordField, placeholder: "Password")

        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
    }
    
    func setupTextField(field: UITextField, placeholder: String) {
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 5
        field.placeholder = placeholder
        field.contentVerticalAlignment = .Center
        field.delegate = self
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text?.characters.count > 0 {
            switch textField {
            case self.nameField:
                self.nameField.text = textField.text
            case self.emailField:
                if self.emailField.text!.validEmail {
                    print("hey it's valid!")
                }
            default:
                print("hello")
            }
        }
    }
    
    func createUser() {
        KCSUser.userWithUsername(
            "kinvey",
            password: "12345",
            fieldsAndValues: [
                KCSUserAttributeEmail : "kinvey@kinvey.com",
                KCSUserAttributeGivenname : "Arnold",
                KCSUserAttributeSurname : "Kinvey"
            ],
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    //was successful!
                    let alert = UIAlertView(
                        title: NSLocalizedString("Account Creation Successful", comment: "account success note title"),
                        message: NSLocalizedString("User created. Welcome!", comment: "account success message body"),
                        delegate: nil,
                        cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                    )
                    alert.show()
                } else {
                    //there was an error with the update save
                    let message = errorOrNil.localizedDescription
                    let alert = UIAlertView(
                        title: NSLocalizedString("Create account failed", comment: "Create account failed"),
                        message: message,
                        delegate: nil,
                        cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                    )
                    alert.show()
                }
            }
        )
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case self.nameField:
            self.emailField.becomeFirstResponder()
        case self.emailField:
            self.passwordField.becomeFirstResponder()
        default:
            dismissKeyboard()
        }
        return true
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}