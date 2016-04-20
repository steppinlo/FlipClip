//
//  FCSignInViewController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/20/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation

class FCSignInViewController: UIViewController {
    
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        print("HEY WE ARE HERE!")
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        let setUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SignUp") as! FCCreateAccountTableViewController
        self.navigationController?.pushViewController(setUp, animated: true)
        //self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}