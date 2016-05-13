//
//  FCFriendsListTableViewController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 5/12/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation

class FCFriendsListTableViewController: UITableViewController {
    
    var friends = [String]()
    
    override func viewDidLoad() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendsCell") as! FCFriendsListTableViewCell
        cell.backgroundColor = UIColor.greenColor()
        cell.friendsLabel.text = friends[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
}

class FCFriendsListTableViewCell: UITableViewCell {
    @IBOutlet weak var friendsLabel: UILabel!
    
}