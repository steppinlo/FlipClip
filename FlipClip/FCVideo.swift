//
//  FCVideo.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/21/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation

class FCVideo: NSObject {
    var entityId: String?
    var name: String?
    var videoId: String?
    var author: KCSUser?
    var collection: FCVideoCollection?
    var metadata: KCSMetadata?
    
    internal override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId": KCSEntityKeyId,
            "name":"name",
            "videoId": "videoId",
            "collection": "collection",
            "author": "author",
            "metadata": KCSEntityKeyMetadata
        ]
    }
    
    internal static override func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        return [
            "author" : KCSUserCollectionName,
            "collection": "VideoCollection"
        ]
    }
    
    internal override func referenceKinveyPropertiesOfObjectsToSave() -> [AnyObject]! {
        return ["collection"]
    }
    
    
}