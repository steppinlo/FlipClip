//
//  FCVideoController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/21/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation
import AVFoundation

class FCVideoController: NSObject {
    
    static let store: KCSStore = KCSLinkedAppdataStore.storeWithOptions([
        KCSStoreKeyCollectionName : "Video",
        KCSStoreKeyCollectionTemplateClass : FCVideo.self
        ])

    
    class func create(video: NSData, collection: FCVideoCollection?) {
        KCSFileStore.uploadData(
            video,
            options: [KCSFileFileName: "video", KCSFileMimeType: "video/mp4", KCSFileACL: KCSMetadata()],
            completionBlock: { (uploadInfo: KCSFile!, error: NSError?) -> Void in
                if let uploadInfo = uploadInfo {
                    NSLog("Upload finished. File id='%@'.", uploadInfo.fileId)
                } else if let error = error {
                    print("there was an error! File id = '%@'.", error)
                }
            },
            progressBlock: nil
        )
    }
    
    class func saveVideoObject(videoId: String, collection: FCVideoCollection?) {
        let video = FCVideo()
        video.videoId = videoId
        video.author = KCSUser.activeUser()
        
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
                    FCVideoCollectionController.addVideoToCollection(video.videoId, collection: collection, video: video)
                }
            },
            withProgressBlock: nil
        )
    }
    
    class func fetchVideoURL(video: [String], success: (videoURL: [NSURL])->Void, error: (error: NSError) -> Void) {
        var clips = [NSURL]()
        for clip in video {
        KCSFileStore.getStreamingURL(
            clip,
            completionBlock: { (streamingResource: KCSFile!, error: NSError!) -> Void in
                if error != nil { return }
                clips.append(streamingResource.remoteURL)
                if clip == video.last { success(videoURL: clips) }
            }
        )
        }
    }
    
    class func generateThumbnail(url: NSURL) -> UIImage? {
        let asset = AVAsset(URL: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        var time = asset.duration
        //If possible - take not the first frame (it could be completely black or white on camara's videos)
        time.value = min(time.value, 2)
        
        do {
            let imageRef = try imageGenerator.copyCGImageAtTime(time, actualTime: nil)
            return UIImage(CGImage: imageRef)
        }
        catch let error as NSError
        {
            print("Image generation failed with error \(error)")
            return nil
        }
    }
}
