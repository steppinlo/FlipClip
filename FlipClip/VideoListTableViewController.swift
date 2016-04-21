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

class VideoListTableViewController: UITableViewController {
    
    @IBOutlet weak var cellLabel: UILabel!
    var videoList = [FCVideo]()
    var videoURL: NSURL!
    
    override func viewDidLoad() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let query = KCSQuery(onField: "author", usingConditional: .KCSAll, forValue: KCSUser.activeUser().userId)
        let store: KCSStore = KCSLinkedAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName : "Video",
            KCSStoreKeyCollectionTemplateClass : FCVideo.self
            ])
        
        store.queryWithQuery(
            query,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                //handle error or results...
                self.videoList = objectsOrNil as! [FCVideo]
                self.tableView.reloadData()
            },
            withProgressBlock: nil
        )
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
     }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FCVideoListTableViewCell
        cell.backgroundColor = UIColor.orangeColor()
        cell.cellLabel.text = self.videoList[indexPath.row].videoId
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let video = self.videoList[indexPath.row]
//        
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewControllerWithIdentifier("CameraVC")
//                self.navigationController?.pushViewController(vc, animated: true)
        
        KCSFileStore.getStreamingURL(
            video.videoId,
            completionBlock: { (streamingResource: KCSFile!, error: NSError!) -> Void in
                if error != nil { return }
                self.videoURL = streamingResource.remoteURL
                let destination = AVPlayerViewController()
                let player = AVPlayer(URL: self.videoURL)
                destination.player = player
                let view = UIView()
                view.backgroundColor = UIColor.clearColor()
                destination.view.addSubview(view)
                destination.videoGravity = AVLayerVideoGravityResizeAspectFill
                
                self.presentViewController(destination, animated: true) { () -> Void in
                    destination.player!.play()
                }
            }
        )
        
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


class FCVideoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!

    
}