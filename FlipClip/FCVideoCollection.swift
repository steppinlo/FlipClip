//
//  FCVideoCollection.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/21/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation

class FCVideoCollection: NSObject {
    var entityId: String?
    var videoSet: [String]?
    var authors: [String]?
    var metadata: KCSMetadata?
    
    internal override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId": KCSEntityKeyId,
            "videoSet": "videoSet",
            "authors": "authors",
            "metadata": KCSEntityKeyMetadata
        ]
    }
    
}
