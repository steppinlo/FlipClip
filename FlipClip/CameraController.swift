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
