//
//  MenuScene.swift
//  Connect4
//
//  Created by Matthew Linder on 7/9/14.
//  Copyright (c) 2014 Matthew Linder. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    var startButton = SKSpriteNode(imageNamed: "start")
    
    
    
    override func didMoveToView(view: SKView) {
        startButton.position = CGPoint(x: 513, y: 400)
        self.addChild(startButton)
        
    }
    

    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        var transition = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.5)
        var newScene = GameScene(size: self.scene.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        
        for touch: AnyObject in touches {
            if CGRectContainsPoint(startButton.frame, touch.locationInNode(self)) {
                self.scene.view.presentScene(newScene, transition: transition)
            }

        }
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        
    }
    
    
   
}
