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
            if let _ = collection.authors where !collection.authors!.contains(KCSUser.activeUser().username){
                    collection.authors!.append(KCSUser.activeUser().username)
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
    
    class func convertSetToNSURL(set: [String]) -> [NSURL] {
        return set.map({ (clip) -> NSURL in NSURL(string: clip)!})
    }
    
    class func fetchCollection(user: String, success: ([FCVideoCollection])-> Void, failiure: (error: NSError)-> Void) {
        let query = KCSQuery(onField: "authors", usingConditional: .KCSAll, forValue: user)
        
        var queryResult = [FCVideoCollection]()
        
        self.collectionStore.queryWithQuery(
            query,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                //handle error or results...
                queryResult = objectsOrNil as! [FCVideoCollection]
                var videoCollection = [FCVideoCollection]()
                for video in queryResult {
                    if let videoData: FCVideoCollection = FCVideoCollection(data: video) {
                        videoCollection.append(videoData)
                    }
                }
                success(videoCollection)
            },
            withProgressBlock: nil
        )
    }
    
    class func fetchSetURLs(set: [FCVideo]) -> [NSURL] {
//        gets streaming url to store as just getting remoteurl does not work for some reason in kcsfilestore.uploaddata...
        var videoURLS = [NSURL]()
        for videos in set {
            KCSFileStore.getStreamingURL(
                videos.videoId,
                completionBlock: { (streamingResource: KCSFile!, error: NSError!) -> Void in
                    if error != nil { return }
                    videoURLS.append(streamingResource.remoteURL)
                }
            )
        }
        return videoURLS
    }
    
    
    
    
    
}