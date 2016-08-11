//
//  InterfaceController.swift
//  PBROrbs WatchKit Extension
//
//  Created by temporary on 8/10/16.
//  Copyright © 2016 MediumBlog. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    let sceneManager = SceneManager.shared

    @IBOutlet var scnInterface: WKInterfaceSCNScene!
    
    override func awake(withContext context: AnyObject?) {
        super.awake(withContext: context)
        
        // Set the scene to the interface
        scnInterface.scene = sceneManager.scene
        
        print(scnInterface.renderingAPI == .metal ? "Metal" : "OpenGL")
        
        // Allow the user to manipulate the camera
//        scnInterface.allowsCameraControl = true
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func tapRecognized(_ sender: AnyObject) {
        sceneManager.newMaterial()
    }
}
