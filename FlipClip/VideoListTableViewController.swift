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
    var activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50))
    var zeroView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.backgroundColor = UIColor.clearColor()
        self.tableView.backgroundColor = UIColor.whiteColor()
//        
//        KCSUser.activeUser().logout()
        
        if let _ = KCSUser.activeUser(){
            self.refreshControl = UIRefreshControl()
            self.refreshControl?.beginRefreshing()
            self.tableView.addSubview(refreshControl!)
            self.fetchTableItems()
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signIn = storyboard.instantiateViewControllerWithIdentifier("SignIn") as! FCSignInViewController
            print(self)
            self.presentViewController(signIn, animated: true, completion: nil)
        }
        
        
        
        
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func onRefresh(sender: AnyObject) {
        self.fetchTableItems()
    }
    
    func fetchTableItems() {
        print(KCSUser.activeUser().username)
        FCVideoCollectionController.fetchCollection(KCSUser.activeUser().username, success: { (collection) in
            self.videoList = collection
            
            
            //fetch the urls of the collection. refactor for later.
            for collection in self.videoList {
                print(collection.videoSet)
                FCVideoCollectionController.fetchSetURLs(collection.videoSet!, success: { (videoURLS) in
                    collection.videoURLS = videoURLS
//                    dispatchAsyncMain({
                        collection.thumbnail = FCVideoController.generateThumbnail(collection.videoURLS!.first!)
//                    })
                    
                    if collection == self.videoList.last {
                        self.refreshControl?.performSelector(#selector(UIRefreshControl.endRefreshing), withObject: nil, afterDelay: 0.3)
                        
                        self.tableView.reloadData()
                    }
                    }, failure: { (error) in
                        //figure out error.
                })
            }
            
            self.tableView.reloadData()
        }) { (error) in
            //figure out something with this...
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FCVideoListTableViewCell

        if self.videoList.count > 0 {
            cell.videoCollection = self.videoList[indexPath.row]
            if let _ = self.videoList[indexPath.row].videoURLS {
                cell.videoURLS = self.videoList[indexPath.row].videoURLS! }
        }
        cell.delegate = self
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
        print(video.videoURLS!.count)
        let videoPlaylist = video.videoURLS!.map({ clip in AVPlayerItem(URL: clip)})
        print(videoPlaylist.count)
        destination.player = AVQueuePlayer(items: videoPlaylist)
        //TO DO: add to last item of array
//        destination.player?.actionAtItemEnd = .Pause
        
        destination.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        self.presentViewController(destination, animated: true) { () -> Void in
            destination.player!.play()
        }
        
    }
    
    func addVideo(collection: FCVideoCollection) {
        let videoController = self.storyboard?.instantiateViewControllerWithIdentifier("Camera") as! CameraController
        videoController.videoCollection = collection
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
            if let _ = videoCollection.thumbnail {
                self.thumbnail = videoCollection.thumbnail
            }
        }
    }
    var delegate: FCVideoListTableViewCellDelegate!
    var videoURLS = [NSURL]()
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
        self.delegate?.addVideo(self.videoCollection)
    }
    
}