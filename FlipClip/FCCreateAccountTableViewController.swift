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
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameField.becomeFirstResponder()
        setupTextField(self, field: self.nameField, placeholder: "Username")
        setupTextField(self, field: self.emailField, placeholder: "Email")
        setupTextField(self, field: self.passwordField, placeholder: "Password (min 6 characters)")

        self.createButton.backgroundColor = UIColor.orangeColor()
        self.createButton.setTitle("Create Account", forState: .Normal)
        self.createButton.setTitleColor(UIColor.init(white: 1, alpha: 0.5), forState: .Disabled)
        self.createButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.createButton.layer.cornerRadius = 14
        self.createButton.enabled = false
        self.createButton.addTarget(self, action: #selector(FCCreateAccountTableViewController.createUser), forControlEvents: .TouchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(FCCreateAccountTableViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text?.characters.count > 0 {
            switch textField {
            case self.nameField:
                if textField.text!.characters.count > 3 {
                    self.name = textField.text
                }
            case self.emailField:
                if textField.text!.validEmail {
                    self.email = textField.text
                }
            case self.passwordField:
                if textField.text?.characters.count > 6 {
                    self.password = textField.text
                }
            default:
                break
            }
        }
        self.createButton.enabled = self.checkValidForm()
    }
    
    func checkValidForm() -> Bool {
        if let _ = self.name, let _ = self.email, let _ = self.password {
            return true
        }
        return false
    }
    
    func createUser() {
        KCSUser.userWithUsername(
            self.name,
            password: self.password,
            fieldsAndValues: [
                KCSUserAttributeEmail : self.email,
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
                    self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
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