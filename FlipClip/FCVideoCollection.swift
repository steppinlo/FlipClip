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
    var thumbnail: UIImage!
    
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
//        dispatchAsyncMain { 
            self.unload(data)
//        }
        
    }
    
    private func unload(video: FCVideoCollection) {
        self.videoSet = video.videoSet
        self.authors = video.authors
        if let _ = video.videoSet {
            FCVideoCollectionController.fetchSetURLs(video.videoSet!, success: { (videos) in
                self.videoURLS = videos
                }, failure: { (error) in
                    //error report
            })
        }
    }
    
}
