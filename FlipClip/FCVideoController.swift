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
        video.author = KCSUser.activeUser().userId
        
        store.saveObject(
            video,
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
    
    class func fetchVideo() {
        
    }
}
