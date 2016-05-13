//
//  GlobalUtils.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/21/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation

func setupTextField(sender: UITextFieldDelegate, field: UITextField, placeholder: String) {
    field.layer.borderWidth = 1
    field.layer.cornerRadius = 14
    field.placeholder = placeholder
    field.contentVerticalAlignment = .Center
    field.delegate = sender
}

var GlobalMainQueue: dispatch_queue_t {
    return dispatch_get_main_queue()
}

var GlobalUserInteractiveQueue: dispatch_queue_t {
    return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
}

var GlobalUserInitiatedQueue: dispatch_queue_t {
    return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
}

var GlobalUtilityQueue: dispatch_queue_t {
    return dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)
}

var GlobalBackgroundQueue: dispatch_queue_t {
    return dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
}

func dispatchAsyncMain(block: () -> ()) {
    dispatch_async(dispatch_get_main_queue(), block)
}

func dispatchAsyncGlobal(block: () -> ()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
}

var currentUser: FCUser!