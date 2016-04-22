//
//  FCVideoController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/21/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation

class FCVideoController: NSObject {
    
    static let store: KCSStore = KCSLinkedAppdataStore.storeWithOptions([
        KCSStoreKeyCollectionName : "Video",
        KCSStoreKeyCollectionTemplateClass : FCVideo.self
        ])

    
    class func create(video: NSData) {
        
        let store = KCSAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName : "Video",
            KCSStoreKeyCollectionTemplateClass : FCVideo.self
            ])
        
        KCSFileStore.uploadData(
            video,
            options: [KCSFileFileName: "video", KCSFileMimeType: "video/mp4", KCSFileACL: KCSMetadata()],
            completionBlock: { (uploadInfo: KCSFile!, error: NSError?) -> Void in
                if let uploadInfo = uploadInfo {
                    NSLog("Upload finished. File id='%@'.", uploadInfo.fileId)
                    self.saveVideoObject(uploadInfo.fileId)
                } else if let error = error {
                    print("there was an error! File id = '%@'.", error)
                }
            },
            progressBlock: nil
        )
        
        

    }
    
    class func saveVideoObject(videoId: String) {
        let video = FCVideo()
        video.videoId = videoId
        video.author = KCSUser.activeUser().username
        
        store.saveObject(
            video,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil != nil {
                    //save failed
                    NSLog("Save failed, with error: %@", errorOrNil.localizedFailureReason!)
                } else {
                    //save was successful
                    NSLog("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
                    let video = objectsOrNil[0] as! FCVideo
                    FCVideoCollectionController.addVideoToCollection(video.videoId, collection: nil)
                }
            },
            withProgressBlock: nil
        )
    }
    
    class func fetchVideoURL(video: FCVideo, success: (videoURL: NSURL)->Void, error: (error: NSError) -> Void) {
        print(video)
        KCSFileStore.getStreamingURL(
            video.videoId,
            completionBlock: { (streamingResource: KCSFile!, error: NSError!) -> Void in
                if error != nil { return }
                print("hello!")
//                print(streamingResource.remoteURL)
                success(videoURL: streamingResource.remoteURL)
                
            }
        )
    }
}
