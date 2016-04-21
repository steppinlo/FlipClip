//
//  AVCamPreviewView.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/21/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//
import Foundation
import UIKit
import AVFoundation


class AVCamPreviewView: UIView{
    
    var session: AVCaptureSession? {
        get{
            return (self.layer as! AVCaptureVideoPreviewLayer).session;
        }
        set(session){
            (self.layer as! AVCaptureVideoPreviewLayer).session = session;
        }
    };
    
    
    
    override class func layerClass() ->AnyClass{
        return AVCaptureVideoPreviewLayer.self;
    }
}