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
    var videoURL: FCVideo?
    var authors: [String]?
    var metadata: KCSMetadata?
    var videoURLS: [NSURL]?
    var thumbnail = UIImage()
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId": KCSEntityKeyId,
            "videoSet": "videoSet",
            "authors": "authors",
            "videoURL": "videoURL",
            "metadata": KCSEntityKeyMetadata
        ]
    }
    
    static override func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        return [
//            "authors": KCSUserCollectionName,
            "videoURL": "Video"
        ]
    }
    
    static override func referenceKinveyPropertiesOfObjectsToSave() -> [AnyObject]! {
        return ["videoURL"]
    }
    
    override init() {
        super.init()
    }
    
    convenience init(data: FCVideoCollection) {
        self.init()
        self.unload()
    }
    
    private func unload() {
        if let _ = self.videoSet {
            self.videoURLS = FCVideoCollectionController.convertSetToNSURL(self.videoSet!)
            self.thumbnail = FCVideoController.generateThumbnail(self.videoURLS!.first!)!
        }
    }
    
}
