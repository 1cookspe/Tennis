//
//  ViewController.swift
//  AR Tennis!
//
//  Created by Spencer Cook on 2018-07-04.
//  Copyright © 2018 Spencer Cook. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    

    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        print("Found new anchor1")
        var node: SCNNode?
        
        // add node to new determined scene
        if let planeAnchor = anchor as? ARPlaneAnchor {
            //node = self.sceneView.scene.rootNode.childNode(withName: "shipMesh", recursively: true)!
            node = SCNNode()
            
            // court
            let courtPlane = SCNPlane(width: 8.23, height: 23.78)
            courtPlane.firstMaterial?.diffuse.contents = UIColor.blue
            let courtNode = SCNNode(geometry: courtPlane)
            courtNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            courtNode.scale = SCNVector3(0.1,0.1,0.1)
            courtNode.eulerAngles.x = -.pi/2
            
            // net
            let netPlane = SCNPlane(width: courtPlane.width, height: 1.08)
            netPlane.firstMaterial?.diffuse.contents = UIColor.white
            let netNode = SCNNode(geometry: netPlane)
            netNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            netNode.scale = SCNVector3(0.1,0.1,0.1)
            
            //courtNode.addChildNode(netNode)
            node?.addChildNode(courtNode)
            node?.addChildNode(netNode)
            node?.scale = SCNVector3(0.1,0.1,0.1)
            
        }
        
        return node
    }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
