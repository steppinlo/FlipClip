//
//  FCVideoCollectionController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/21/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation

class FCVideoCollectionController: NSObject {
    static let store: KCSStore = KCSLinkedAppdataStore.storeWithOptions([
        KCSStoreKeyCollectionName : "VideoCollection",
        KCSStoreKeyCollectionTemplateClass : FCVideo.self
        ])
    
    
}