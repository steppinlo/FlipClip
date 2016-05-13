//
//  FCUser.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/20/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation

class FCUser: KCSUser {
    var friends: [String]!
    
    override init() {
        super.init()
    }
    
    convenience init(data: KCSUser) {
        self.init()
        self.userId = data.userId
        self.username = data.username
        self.email = data.email
        self.friends = data.getValueForAttribute("friends") as! [String]
    }
}

