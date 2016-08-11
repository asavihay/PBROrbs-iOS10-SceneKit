//
//  GameViewController.swift
//  PBROrbs
//
//  Created by Avihay Assouline on 23/07/2016.
//  Copyright © 2016 MediumBlog. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    let sceneManager = SceneManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let view = self.view as? SCNView else {
            return
        }
        
        // Set the scene to the view
        view.scene = sceneManager.scene
        
        print(view.renderingAPI == .metal ? "Metal" : "OpenGL")
        
        // Allow the user to manipulate the camera
        view.allowsCameraControl = true
    }
    
    @IBAction func tapRecognized(_ sender: AnyObject) {
        sceneManager.newMaterial()
    }
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}
