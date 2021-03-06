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
//    
//    var collection: PFObject?
//    let captureSession = AVCaptureSession()
//    var previewLayer : AVCaptureVideoPreviewLayer?
//    var captureDevice : AVCaptureDevice?
//    var selectedObject: PFObject?
//    var selectedCollection: NSString = ""
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        self.delegate = self
        self.sourceType = .Camera
        self.mediaTypes = [kUTTypeMovie as String]
        self.allowsEditing = false
        self.showsCameraControls = true
    }
    
    
    func showCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            
            print("captureVideoPressed and camera available.")
            
            var imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera;
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            imagePicker.showsCameraControls = true

            self.tabBarController?.presentViewController(imagePicker, animated: true, completion: nil)
        }
            
        else {
            print("Camera not available.")
        }
        
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        let tempImage = info[UIImagePickerControllerMediaURL] as! NSURL!
//        let pathString = tempImage.relativePath
//        
//        // TODO: check if we need this
//        self.dismissViewControllerAnimated(true, completion: {})
//        
//        let videoData = NSData(contentsOfURL: tempImage)
//        let videoFile = PFFile(name:"move.mov", data:videoData!)
//        
//        let video = PFObject(className: "Videos")
//        print(video)
//        video["video"] = videoFile
//        video["creator"] = PFUser.currentUser()!
//        
//        let currentUser = video["creator"]
//        video.saveInBackground()
        
        /*
        self.holderArray = [unwrappedObject, unwrappedCollectionID, doubleUnwrapped, collectionCollaborators, collectionVideos]
        */
        
        // TODO: I feel like this could be Swiftier.
//        let col = (collection != nil) ? collection! : PFObject(className: "Collection")
//        
//        if !(self.selectedCollection == "") {
//            let query = PFQuery(className: "Collection")
//            let selectCollection = (query.getObjectWithId(self.selectedCollection as String))!
//            print(selectCollection)
//            var collaborators = (selectCollection["collaborators"])!
//            var videos = (selectCollection["videos"])!
//            selectCollection.addObject(currentUser!, forKey: "collaborators")
//            selectCollection.addObject(video, forKey: "videos")
//            print(selectCollection)
//            self.collection = selectCollection
//            selectCollection.saveInBackground()
//            
//            
//        } else {
//            col.addObject(PFUser.currentUser()!, forKey: "collaborators")
//            col.addObject(video, forKey: "videos")
//            col.saveInBackgroundWithBlock {
//                (success, error) -> Void in
//                if let err = error {
//                    NSLog("Error saving collection: %@", err)
//                }
//            }
//            self.collection = col
//            
//        }
//        self.selectedCollection = ""
//        redirect()
    }
    
    func redirect(){
        self.performSegueWithIdentifier("sendFriends", sender: self)
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
