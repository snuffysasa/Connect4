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
    var myLabel1 = SKLabelNode(text: "meow")
    var myLabel2 = SKLabelNode(text: "meow")
    var myLabel3 = SKLabelNode(text: "meow")
    var myLabel4 = SKLabelNode(text: "meow")
    var myLabel5 = SKLabelNode(text: "meow")
    var myLabel6 = SKLabelNode(text: "meow")
    var myLabel7 = SKLabelNode(text: "meow")
    var myLabel8 = SKLabelNode(text: "meow")
    var myLabel9 = SKLabelNode(text: "meow")
    
    
    
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
        
        myLabel1.position = CGPoint(x: 300, y: 700)
        myLabel2.position = CGPoint(x: 500, y: 700)
        myLabel3.position = CGPoint(x: 700, y: 700)
        myLabel4.position = CGPoint(x: 300, y: 630)
        myLabel5.position = CGPoint(x: 500, y: 630)
        myLabel6.position = CGPoint(x: 700, y: 630)
        myLabel7.position = CGPoint(x: 300, y: 530)
        myLabel8.position = CGPoint(x: 500, y: 530)
        myLabel9.position = CGPoint(x: 700, y: 530)
        
        
        self.addChild(background)
        self.addChild(win)
        self.addChild(board)
        self.addChild(myLabel1)
        self.addChild(myLabel2)
        self.addChild(myLabel3)
        self.addChild(myLabel4)
        self.addChild(myLabel5)
        self.addChild(myLabel6)
        self.addChild(myLabel7)
        self.addChild(myLabel8)
        self.addChild(myLabel9)
        
        
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
    
    func whatHeight(location: CGFloat) -> CGFloat {
        switch location {
        case location where (location > 340):
            return 394
        case location where (location > 270):
            return 322
        case location where (location > 190):
            return 250
        case location where (location > 130):
            return 177
        case location where (location > 60):
            return 105
        default:
            return 35
        }
        
    }
    
    
    func updateLabels(touchLocation: CGPoint) {
        //myLabel1.text = String(whatRow(touchLocation.x))
        //myLabel2.text = String(whatHeight(touchLocation.y))
        myLabel1.text = "empty"
        myLabel2.text = "empty"
        myLabel3.text = "empty"
        myLabel4.text = "empty"
        myLabel5.text = "empty"
        myLabel6.text = "empty"
        myLabel7.text = "empty"
        myLabel8.text = "empty"
        myLabel9.text = "emptY"
        for theChip in arrayChips {
            var correctColumn = whatRow(touchLocation.x)
            var correctRow = whatHeight(touchLocation.y)
            if correctColumn == theChip.position.x && correctRow == theChip.position.y {
                myLabel1.text = theChip.chipUpLeft
                myLabel2.text = theChip.chipUp
                myLabel3.text = theChip.chipUpRight
                myLabel4.text = theChip.chipLeft
                myLabel5.text = theChip.chipColor
                myLabel6.text = theChip.chipRight
                myLabel7.text = theChip.chipDownLeft
                myLabel8.text = theChip.chipDown
                myLabel9.text = theChip.chipDownRight
            }
            
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
            
            if touch.locationInNode(self).y < 400 {
                updateLabels(touch.locationInNode(self))
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
            var xDistance = centerChip.position.x - nearbyChip.position.x
            var yDistance = centerChip.position.y - nearbyChip.position.y
            var sameChip: Bool = nearbyChip == centerChip
            var sameRow: Bool = nearbyChip.position.y == centerChip.position.y
            var sameColumn: Bool = nearbyChip.position.x == centerChip.position.x
            var nearbyIsOneColumnLeft: Bool = xDistance >= 75 && xDistance <= 85
            var nearbyIsOneColumnRight: Bool = xDistance <= -75 && xDistance >= -85
            var nearbyIsOneRowDown: Bool = yDistance >= 70 && yDistance <= 75
            var nearbyIsOneRowUp: Bool = yDistance <= -70 && yDistance >= -75

            
            
            if sameColumn && !sameChip { // if the nearby chip is in the same column, and is not the same chip
                //myLabel.text = String((centerChip.position.y - nearbyChip.position.y))
                if nearbyIsOneRowDown {  //if the nearby chip is on the bottom
                    if nearbyChip.chipColor == "green" {
                        centerChip.chipDown = "green"
                    } else if nearbyChip.chipColor == "red" {centerChip.chipDown = "red"}
                    if centerChip.chipColor == "green" {
                        nearbyChip.chipUp = "green"
                    } else if centerChip.chipColor == "red" {nearbyChip.chipUp = "red"}
                }

            }
            
            if sameRow && !sameChip { // if nearbychip is in the same row
                //myLabel.text = String((centerChip.position.x - nearbyChip.position.x))
                if nearbyIsOneColumnLeft { //nearby is on the left
                    //myLabel.text = nearbyChip.chipColor
                    if nearbyChip.chipColor == "green" {
                        centerChip.chipLeft = "green"
                    } else if nearbyChip.chipColor == "red" {centerChip.chipLeft = "red"}
                    if centerChip.chipColor == "green" {
                        nearbyChip.chipRight = "green"
                    } else if centerChip.chipColor == "red" {nearbyChip.chipRight = "red"}
                }
                
                if nearbyIsOneColumnRight {
                    if nearbyChip.chipColor == "green" {
                        centerChip.chipRight = "green"
                    } else if nearbyChip.chipColor == "red" {centerChip.chipRight = "red"}
                    if centerChip.chipColor == "green" {
                        nearbyChip.chipLeft = "green"
                    } else if centerChip.chipColor == "red" {nearbyChip.chipLeft = "red"}
                }
                
            }
            
            if nearbyIsOneColumnLeft && nearbyIsOneRowDown {
                //myLabel.text = nearbyChip.chipColor
                if nearbyChip.chipColor == "green" {
                    centerChip.chipDownLeft = "green"
                } else if nearbyChip.chipColor == "red" {centerChip.chipDownLeft = "red"}
                if centerChip.chipColor == "green" {
                    nearbyChip.chipUpRight = "green"
                } else if centerChip.chipColor == "red" {nearbyChip.chipUpRight = "red"}
            }
            
            if nearbyIsOneColumnRight && nearbyIsOneRowDown {
                //myLabel.text = nearbyChip.chipColor
                if nearbyChip.chipColor == "green" {
                    centerChip.chipDownRight = "green"
                } else if nearbyChip.chipColor == "red" {centerChip.chipDownRight = "red"}
                if centerChip.chipColor == "green" {
                    nearbyChip.chipUpLeft = "green"
                } else if centerChip.chipColor == "red" {nearbyChip.chipUpLeft = "red"}
                
            }
            
            if nearbyIsOneColumnLeft && nearbyIsOneRowUp {
                //myLabel.text = nearbyChip.chipColor
                if nearbyChip.chipColor == "green" {
                    centerChip.chipUpLeft = "green"
                } else if nearbyChip.chipColor == "red" {centerChip.chipUpLeft = "red"}
                if centerChip.chipColor == "green" {
                    nearbyChip.chipDownRight = "green"
                } else if centerChip.chipColor == "red" {nearbyChip.chipDownRight = "red"}
            }
            
            if nearbyIsOneColumnRight && nearbyIsOneRowUp {
                //myLabel.text = nearbyChip.chipColor
                if nearbyChip.chipColor == "green" {
                    centerChip.chipUpRight = "green"
                } else if nearbyChip.chipColor == "red" {centerChip.chipUpRight = "red"}
                if centerChip.chipColor == "green" {
                    nearbyChip.chipDownLeft = "green"
                } else if centerChip.chipColor == "red" {nearbyChip.chipDownLeft = "red"}
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
                    //myLabel.text = "the chip below me is \(theChip.chipDown) "
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
