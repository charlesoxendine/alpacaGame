//
//  GameController.swift
//  alpacaGame Shared
//
//  Created by Charlie Oxendine on 5/12/23.
//

import SceneKit

#if os(macOS)
    typealias SCNColor = NSColor
#else
    typealias SCNColor = UIColor
#endif

class GameController: NSObject, SCNSceneRendererDelegate {

    let scene: SCNScene
    let sceneRenderer: SCNSceneRenderer
    
    init(sceneRenderer renderer: SCNSceneRenderer) {
        sceneRenderer = renderer
        scene = SCNScene(named: "Art.scnassets/mainScene.scn")!
        
        super.init()
        
        sceneRenderer.delegate = self
        sceneRenderer.scene = scene
        
        renderFieldSheep()
    }
    
    // TODO: Feedback for tapping the factory
    func highlightNodes(atPoint point: CGPoint) {
        let hitResults = self.sceneRenderer.hitTest(point, options: [:])
        for result in hitResults {
            if result.node.name == "factory" {
                GameManager.shared.handleProcessorTap()
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func renderFieldSheep() {
        for _ in 1...30 {
            let node = SCNNode(named: "Art.scnassets/llama.dae")
            let randomX:Float = Float.random(in: -1.5 ..< 1.5)
            let randomY:Float = 0
            let randomZ:Float = Float.random(in: -1 ..< 1)
            
            node.eulerAngles = SCNVector3Make(0, Float.random(in: 1 ..< 180), 0)
            node.position = SCNVector3(x: -0.436 + randomX, y: 0.042 + randomY, z: -1.766 + randomZ)
            scene.rootNode.addChildNode(node)
        }
    }
}

// TODO: MOVE THIS
extension SCNNode {
    convenience init(named name: String) {
        self.init()

        guard let scene = SCNScene(named: name) else {
            return
        }

        for childNode in scene.rootNode.childNodes {
            addChildNode(childNode)
        }
    }
}
