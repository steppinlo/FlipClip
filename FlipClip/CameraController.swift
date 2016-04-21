//
//  CameraController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 2/22/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices
import AVFoundation

class CameraController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var video = FCVideo()
    var videoCollection: [String]!
    
    override func viewDidLoad() {
        self.delegate = self
        self.sourceType = .Camera
        self.mediaTypes = [kUTTypeMovie as String]
        self.allowsEditing = false
        self.showsCameraControls = true
        
        let screenSize = UIScreen.mainScreen().bounds.size
        let cameraAspectRatio: CGFloat = 4.0/3.0
        let imageWidth = ceil(screenSize.width*cameraAspectRatio)
        let scale = ceil((screenSize.height/imageWidth)*10)/10
        self.cameraViewTransform = CGAffineTransformMakeScale(scale, scale)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //gets nsdata of the object and sends it to the controller
        let recordedVideo = info[UIImagePickerControllerMediaURL] as! NSURL
        let videoData = NSData(contentsOfURL: recordedVideo)
        self.video.author = KCSUser.activeUser().userId
        FCVideoController.create(videoData!)
        
        //create collection if it doesnt already exist. add on to it.
        
        if let _ = self.videoCollection {
            self.videoCollection = [String]()
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let friendsList : FriendsListController = segue.destinationViewController as! FriendsListController
//        friendsList.collection = self.collection
//        self.collection = nil
    }
    
    func redirectPage(){
        tabBarController!.selectedViewController = (tabBarController?.viewControllers!.first)! as UIViewController
    }
    
}
