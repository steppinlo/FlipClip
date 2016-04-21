//
//  VideoListTableViewController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/14/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation
import UIKit

class VideoListTableViewController: UITableViewController {
    override func viewDidLoad() {
        let query = KCSQuery(onField: "author", usingConditional: .KCSAll, forValue: KCSUser.activeUser().userId)
        let store: KCSStore = KCSLinkedAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName : "Video",
            KCSStoreKeyCollectionTemplateClass : FCVideo.self
            ])
        
        store.queryWithQuery(
            query,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                //handle error or results...
                print(objectsOrNil)
            },
            withProgressBlock: nil
        )
     }
}