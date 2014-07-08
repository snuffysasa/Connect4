//
//  GameScene.swift
//  Connect4
//
//  Created by Matthew Linder on 7/8/14.
//  Copyright (c) 2014 Matthew Linder. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    var previousTime: CFTimeInterval = 0
    var timeCounter: CFTimeInterval = 0
    
    
    var greenTurn: Bool = true
    var arrayChips: [Chip] = []
    
    var background = SKSpriteNode(imageNamed: "wall1.png")
    var win = SKSpriteNode(imageNamed: "youwin.png")
    var board = SKSpriteNode(imageNamed: "Board.png")
    var myLabel = SKLabelNode(text: "meow")
    
    
    
    
    override func didMoveToView(view: SKView) {
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.size = self.size
        
        board.anchorPoint = CGPoint(x: 0, y: 0)
        board.position = CGPoint(x: 223, y: 0)
        board.setScale(0.9)
        
        win.position = CGPoint(x: 500, y: 630)
        win.hidden = true
        win.setScale(0.5)
        
        myLabel.position = CGPoint(x: 300, y: 630)
        
        
        self.addChild(background)
        self.addChild(win)
        self.addChild(board)
        self.addChild(myLabel)
        
        
    }
    
    func whatRow(location: CGFloat) -> CGFloat {
        // 268 349 431 513 592 673 755
        switch location {
        case location where (location < 308):
            return 268
        case location where (location < 390):
            return 349
        case location where (location < 472):
            return 431
        case location where (location < 552):
            return 512
        case location where (location < 632):
            return 592
        case location where (location < 714):
            return 673
        default:
            return 755
        }
    }
    
    
    
    func addChip(position: CGPoint) {
        var newChip = Chip(imageNamed: "greenchip")
        if greenTurn {
            newChip.texture = SKTexture(imageNamed: "greenchip")
            newChip.chipColor = "green"
            greenTurn = false
        }
        else if greenTurn == false {
            newChip.texture = SKTexture(imageNamed: "redchip")
            newChip.chipColor = "red"
            greenTurn = true
        }
        
        newChip.position = CGPoint(x: whatRow(position.x), y: position.y)
        newChip.setScale(0.32)
        self.addChild(newChip)
        arrayChips += newChip
    }
    
    func noChipFalling() -> Bool {
        for chip in arrayChips {
            if chip.falling {
                return false
            }
        }
        return true
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            if touch.locationInNode(self).y > 450 {
                addChip(touch.locationInNode(self))
            }
            
        }
    }
    
    func aboveChip(position: CGPoint) -> Bool {
        for bottomChip in arrayChips {
            if ((position.y - bottomChip.position.y) < 75) && (position.x ==  bottomChip.position.x) && (position.y != bottomChip.position.y) && !bottomChip.falling {
                return true
            }
        }
        return false
    }
    
    func updateNearChips (centerChip: Chip) {
        for nearbyChip in arrayChips {
            if nearbyChip.position.x == centerChip.position.x && nearbyChip != centerChip { // if the nearby chip is in the same column, and is not the same chip
                myLabel.text = String((centerChip.position.y - nearbyChip.position.y))
                if (centerChip.position.y - nearbyChip.position.y) >= 70 && (centerChip.position.y - nearbyChip.position.y) <= 75 {  //if the nearby chip is directly on top
                    //win.hidden = false
                    if nearbyChip.chipColor == "green" {
                        win.hidden = false
                        centerChip.chipUp = "green"
                    } else if nearbyChip.chipColor == "red" {centerChip.chipUp = "red"}
                    if centerChip.chipColor == "red" {
                        nearbyChip.chipDown = "green"
                    } else if centerChip.chipColor == "red" {nearbyChip.chipDown = "red"}
                }
            }
        }
        
    }
    
    func allignChip(theChip: Chip) {
        theChip.falling = false
        var height = theChip.position.y
        switch height {
        case height where (height > 340):
            theChip.position.y = 394
        case height where (height > 270):
            theChip.position.y = 322
        case height where (height > 190):
            theChip.position.y = 250
        case height where (height > 130):
            theChip.position.y = 177
        case height where (height > 60):
            theChip.position.y = 105
        default:
            theChip.position.y = 35
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if previousTime == 0 {
            previousTime = currentTime
        }
        timeCounter += currentTime - previousTime
        if timeCounter > 0.0166667 {
            timeCounter = 0
            
        }
        previousTime = currentTime
        
        for theChip in arrayChips {
            
            if theChip.falling {
                
                if aboveChip(theChip.position) {
                    allignChip(theChip)
                    updateNearChips(theChip)
                }
                if theChip.position.y <= 35 {
                    allignChip(theChip)
                    updateNearChips(theChip)
                }
                if theChip.falling {
                    theChip.position.y += -10
                    theChip.zRotation += 3
                }
                
            }
            
        }
        
    }
}
