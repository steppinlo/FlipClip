//
//  FCVideoCollectionController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/21/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation

class FCVideoCollectionController: NSObject {
    static let collectionStore: KCSStore = KCSLinkedAppdataStore.storeWithOptions([
        KCSStoreKeyCollectionName : "VideoCollection",
        KCSStoreKeyCollectionTemplateClass : FCVideoCollection.self
        ])
    
    class func addVideoToCollection(videoId: String!, collection: FCVideoCollection?) {
        //after saving video. update or create new collection
        
        let saveCollection = FCVideoCollection()
        if let _ = collection {
            saveCollection.videoSet?.append(videoId)
        } else {
            saveCollection.videoSet = [videoId]
        }
        collectionStore.saveObject(
            saveCollection,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil != nil {
                    //save failed
                    NSLog("Save failed, with error: %@", errorOrNil.localizedFailureReason!)
                } else {
                    //save was successful
                    NSLog("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
                }
            },
            withProgressBlock: nil
        )
    }
    
}