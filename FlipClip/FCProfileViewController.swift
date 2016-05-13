//
//  FCProfileViewController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 5/12/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation

class FCProfileViewController: UIViewController {
    
    @IBOutlet weak var friendsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.friendsButton.addTarget(self, action: #selector(FCProfileViewController.tappedFriendsButton(_:)), forControlEvents: .TouchUpInside)
    }
    
    func tappedFriendsButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let friendsVC = storyboard.instantiateViewControllerWithIdentifier("FriendsList") as! FCFriendsListTableViewController
        friendsVC.friends = currentUser.friends
        self.navigationController?.pushViewController(friendsVC, animated: true)
    }
}