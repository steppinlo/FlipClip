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
        view.endEditing(true)
    }
}