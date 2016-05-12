//
//  FCFriendsListTableViewController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 5/12/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation

class FCFriendsListTableViewController: UITableViewController {
    override func viewDidLoad() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}