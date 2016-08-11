//
//  SceneManager.swift
//  PBROrbs
//
//  Created by temporary on 8/10/16.
//  Copyright © 2016 MediumBlog. All rights reserved.
//

import UIKit
import SceneKit

class SceneManager {
    static let shared = SceneManager()
    
    let materialPrefixes : [String] = ["bamboo-wood-semigloss",
                                       "oakfloor2",
                                       "scuffed-plastic",
                                       "rustediron-streaks"]
    var currentMaterialIndex = 0
    var material: SCNMaterial?
    
    var scene: SCNScene {
        
        // create a new scene
        let scene = SCNScene(named: "sphere.obj")!
        
        // select the sphere node - As we know we only loaded one object
        // we select the first item on the children list
        let sphereNode = scene.rootNode.childNodes[0]
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        material = sphereNode.geometry?.firstMaterial
        
        // Declare that you intend to work in PBR shading mode
        // Note that this requires iOS 10 and up
        material?.lightingModelName = SCNLightingModelPhysicallyBased
        
        // Setup the material maps for your object
        loadMaterial()
        
        // Setup background - This will be the beautiful blurred background
        // that assist the user understand the 3D envirnoment
        let bg = UIImage(named: "sphericalBlurred.png")
        scene.background.contents = bg;
        
        // Setup Image Based Lighting (IBL) map
        let env = UIImage(named: "spherical.jpg")
        scene.lightingEnvironment.contents = env
        scene.lightingEnvironment.intensity = 2.0
        
        /*
         * The following was not a part of my blog post but are pretty easy to understand:
         * To make the Orb cool, we'll add rotation animation to it
         */
        
        sphereNode.run(SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 10)))
        
        return scene
    }
    
    func newMaterial() {
        currentMaterialIndex += 1
        if currentMaterialIndex >= materialPrefixes.count {
            currentMaterialIndex = 0
        }
        loadMaterial()
    }
    
    func loadMaterial() {
        let materialFilePrefix = materialPrefixes[currentMaterialIndex]
        material?.diffuse.contents = UIImage(named: "\(materialFilePrefix)-albedo.png")
        material?.roughness.contents = UIImage(named: "\(materialFilePrefix)-roughness.png")
        material?.metalness.contents = UIImage(named: "\(materialFilePrefix)-metal.png")
        material?.normal.contents = UIImage(named: "\(materialFilePrefix)-normal.png")
    }
}
