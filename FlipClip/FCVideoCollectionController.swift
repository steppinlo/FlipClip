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
    
    class func createNewCollection(videoId: String!) {
        
    }
    
    class func addVideoToCollection(videoId: String!, var collection: FCVideoCollection?, video: FCVideo) {
        //after saving video. update or create new collection
        
//        let saveCollection = FCVideoCollection()
        if let collection = collection {
            collection.videoSet?.append(videoId)
            if let authors = collection.authors {
                if collection.authors!.contains(KCSUser.activeUser().username) {
                    collection.authors!.append(KCSUser.activeUser().username)
                }
            }
            
        } else {
            collection = FCVideoCollection()
            collection!.videoSet = [videoId]
            collection?.authors = [KCSUser.activeUser().username]
        }
        
        collection?.videoURL = video
        
        
        
        collectionStore.saveObject(
            collection,
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