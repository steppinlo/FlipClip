//
//  FCSignInViewController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/20/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation

class FCSignInViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var headerCell: UITableViewCell!
    @IBOutlet weak var usernameCell: UITableViewCell!
    @IBOutlet weak var submitCell: UITableViewCell!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var createAccountCell: UITableViewCell!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var passwordCell: UITableViewCell!
    
    let kSignInHeader = 0
    let kSignInUsername = 1
    let kSignInPassword = 2
    let kSignInSubmit = 3
    let kSignInCreateAccount = 4
    
    override func viewDidLoad() {
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        
        let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:Selector("dismissKeyboard"))
        gestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(gestureRecognizer)
        UIScrollViewKeyboardDismissMode .OnDrag
        
        setupTextField(self, field: self.usernameTextField, placeholder: "Username")
        setupTextField(self, field: self.passwordTextField, placeholder: "Password")
        
        self.headerCell.contentView.backgroundColor = UIColor.orangeColor(); self.usernameCell.backgroundColor = UIColor.orangeColor(); self.submitCell.backgroundColor = UIColor.orangeColor(); self.createAccountCell.backgroundColor = UIColor.orangeColor(); self.passwordCell.contentView.backgroundColor = UIColor.orangeColor()
        
        self.usernameTextField.backgroundColor = UIColor.whiteColor()
        self.passwordTextField.backgroundColor = UIColor.whiteColor()
        
        
        self.tableView.separatorStyle = .None
        self.tableView.scrollEnabled = false
        self.tableView.backgroundColor = UIColor.orangeColor()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == self.usernameTextField {
            self.passwordTextField.becomeFirstResponder()
        }
        return true
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        let setUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SignUp") as! FCCreateAccountTableViewController
        self.navigationController?.pushViewController(setUp, animated: true)
        //self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case kSignInHeader:
            return 200
        case kSignInCreateAccount:
            return 100
        default:
            return 50
        }
    }
    
}