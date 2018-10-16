//
//  graphScene.swift
//  miasma
//
//  Created by Lucia Reynoso on 10/15/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class GraphScene: SKScene {
    
    private var graph: SKSpriteNode?
    private var littleGlobe: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        // get nodes from the scene to store for later
        self.littleGlobe = self.childNode(withName: "globe") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchedNode = self.atPoint(touch.location(in: self))
            if touchedNode.name == "globe" {
                guard let view  = self.view else {
                    return
                }
                guard let newScene = SKScene(fileNamed: "CO2map") else {
                    return
                }
                newScene.scaleMode = .aspectFill
                view.presentScene(newScene)
            }
        }
        
    }
    
}
