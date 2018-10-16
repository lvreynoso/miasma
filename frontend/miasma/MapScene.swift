//
//  GameScene.swift
//  miasma
//
//  Created by Lucia Reynoso on 10/15/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MapScene: SKScene {
    
    private var plot: SKSpriteNode?
    private var map: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        // get nodes from the scene to store for later
        self.plot = self.childNode(withName: "plot_small") as? SKSpriteNode
        self.map = self.childNode(withName: "na") as? SKSpriteNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchedNode = self.atPoint(touch.location(in: self))
            if touchedNode.name == "plot_small" {
                guard let view  = self.view else {
                    return
                }
                guard let newScene = GraphScene(fileNamed: "CO2graph") else {
                    return
                }
                newScene.scaleMode = .aspectFill
                
                view.presentScene(newScene)
            } else if touchedNode.name == "usa" {
                guard let view  = self.view else {
                    return
                }
                guard let newScene = CountryScene(fileNamed: "CO2country") else {
                    return
                }
                newScene.scaleMode = .aspectFill
                newScene.countryCode = touchedNode.name
                view.presentScene(newScene)
            }
        }
    }

}
