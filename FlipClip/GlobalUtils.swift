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