//
//  ViewController.swift
//  AR--加载视频
//
//  Created by gz on 2017/12/20.
//  Copyright © 2017年 gz. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let scene = SCNScene.init()
        
        // 创建节点
        let planeNode = SCNNode()
        // 创建模型(plane平面模型)
        let plane = SCNPlane(width: 16, height: 9)
        // 把模型添加到节点上
        planeNode.geometry = plane;
        // 是否支持双面
        planeNode.geometry?.firstMaterial?.isDoubleSided = false
        // 节点的位置
        planeNode.position = SCNVector3Make(0, 0, -30);
        // 把节点添加到根节点上
        scene.rootNode.addChildNode(planeNode);
        
        // 创建video节点
        let videoNode = SKVideoNode.init(url: URL.init(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!)
        // video节点的大小
        videoNode.size = CGSize(width: 1600, height: 900)
        // video节点的位置
        videoNode.position = CGPoint(x: videoNode.size.width/2, y: videoNode.size.height/2)
        // 不加这一句加载出来的界面是反的(可以尝试一下)
        videoNode.zRotation = CGFloat.init(Double.pi)
        let skScene = SKScene()
        skScene.addChild(videoNode)
        skScene.size = videoNode.size
        
        plane.firstMaterial?.diffuse.contents = skScene
        // 播放
        videoNode.play()
        
        sceneView.allowsCameraControl = true
        sceneView.scene = scene;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

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
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
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
