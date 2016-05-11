//
//  VideoListTableViewController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/14/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class VideoListTableViewController: UITableViewController, FCVideoListTableViewCellDelegate {
    
    @IBOutlet weak var cellLabel: UILabel!
    var videoList = [FCVideoCollection]()
    var videoURL: NSURL!
    
    override func viewDidLoad() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
//        let query = KCSQuery(onField: "authors", usingConditional: .KCSAll, forValue: KCSUser.activeUser().username)
//        let store: KCSStore = KCSLinkedAppdataStore.storeWithOptions([
//            KCSStoreKeyCollectionName : "VideoCollection",
//            KCSStoreKeyCollectionTemplateClass : FCVideoCollection.self
//            ])
//        
//        store.queryWithQuery(
//            query,
//            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
//                //handle error or results...
//                self.videoList = objectsOrNil as! [FCVideoCollection]
//                self.tableView.reloadData()
//            },
//            withProgressBlock: nil
//        )
        
        FCVideoCollectionController.fetchCollection(KCSUser.activeUser().username, success: { (collection) in
            self.videoList = collection
            self.tableView.reloadData()
            }) { (error) in
                //figure out something with this...
        }
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
     }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FCVideoListTableViewCell
        if self.videoList.count > 0 {
            cell.videoCollection = self.videoList[indexPath.row]
        }
        cell.backgroundColor = UIColor.orangeColor()
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let video = self.videoList[indexPath.row]
        
        let destination = AVPlayerViewController()
        let items = video.videoSet?.map({ (clip) -> NSURL in NSURL(string: clip)!
        })
        let videoPlaylist = items!.map({ clip in AVPlayerItem(URL: clip)})
        destination.player = AVQueuePlayer(items: videoPlaylist)
        destination.player?.actionAtItemEnd = .Pause
        destination.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        self.presentViewController(destination, animated: true) { () -> Void in
            destination.player!.play()
        }
        
    }
    
    func addVideo(collection: FCVideoCollection) {
        let videoController = self.storyboard?.instantiateViewControllerWithIdentifier("Camera") as! CameraController
        videoController.videoCollection = collection.videoSet
        self.navigationController?.presentViewController(videoController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! AVPlayerViewController
        let player = AVPlayer(URL: self.videoURL)
        destination.player = player
        self.presentViewController(destination, animated: true) { () -> Void in
            destination.player!.play()
        }
    }
}

protocol FCVideoListTableViewCellDelegate {
    func addVideo(collection: FCVideoCollection)
}


class FCVideoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var collabLabel: UILabel!
    var videoCollection: FCVideoCollection! {
        didSet {
            self.videoSet = FCVideoCollectionController.convertSetToNSURL(self.videoCollection.videoSet!)
            print(self.videoSet)
        }
    }
    var delegate: FCVideoListTableViewCellDelegate!
    var videoSet = [NSURL]() {
        didSet {
            self.thumbnail = FCVideoController.generateThumbnail(self.videoSet.first!)
        }
    }
    var thumbnail: UIImage? {
        didSet {
            self.thumbnailImageView.image = thumbnail
        }
    }
    
    override func layoutSubviews() {
        self.thumbnailImageView.contentMode = .ScaleAspectFit
        self.thumbnailImageView.backgroundColor = UIColor.blackColor()
    }


    @IBAction func addButton(sender: AnyObject) {
//        self.delegate?.addVideo(self.videoCollection)
        print("hello!")
    }
    
}