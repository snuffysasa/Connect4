//
//  GameScene.swift
//  Connect4
//
//  Created by Matthew Linder on 7/8/14.
//  Copyright (c) 2014 Matthew Linder. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var counter = 1
    var gameover = false
    var mode = 4
    var player1 = ""
    var player2 = ""
    var player1Color = ""
    var player2Color = ""
    
    var greenTurn: Bool = true
    var arrayChips: [Chip] = []
    
    var background = SKSpriteNode(imageNamed: "wall1.png")
    var turnlight = SKSpriteNode(imageNamed: "greenlight")
    var turnLabel = SKLabelNode(text: "It is 's turn")
    var winLabel = SKLabelNode(text: "")
    
    var redback = SKTexture(imageNamed: "red.jpg")
    var greenback = SKTexture(imageNamed: "green.jpg")
    var redlight = SKTexture(imageNamed: "redlight.png")
    var greenlight = SKTexture(imageNamed: "greenlight.png")


    var greenwins = SKSpriteNode(imageNamed: "greenwins.png")
    var redwins = SKSpriteNode(imageNamed: "redwins.png")
    var reset = SKSpriteNode(imageNamed: "reset.png")
    var board = SKSpriteNode(imageNamed: "Board.png")

    
    
    
    override func didMoveToView(view: SKView) {
        
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.size = self.size
        background.zPosition = -100
        
        board.anchorPoint = CGPoint(x: 0, y: 0)
        board.position = CGPoint(x: 223, y: 0)
        board.setScale(0.9)
        
        turnlight.position = CGPoint(x: 513, y: 720)
        turnlight.setScale(0.25)
        turnLabel.position = CGPoint(x: 513, y: 660)
        winLabel.position = CGPoint(x: 513, y: 620)
        winLabel.fontColor = UIColor.redColor()
        winLabel.fontSize = 66
        winLabel.fontName = "Chalkduster"
        
        greenwins.position = CGPoint(x: 500, y: 630)
        greenwins.hidden = true
        greenwins.setScale(0.5)
        
        redwins.position = CGPoint(x: 500, y: 630)
        redwins.hidden = true
        redwins.setScale(0.5)
        
        reset.position = CGPoint(x: 511, y: 500)
        reset.setScale(0.25)
        reset.hidden = true
        
        turnLabel.text = "It is " + player1 + "'s turn"
        
        
        self.addChild(background)
        self.addChild(greenwins)
        self.addChild(redwins)
        self.addChild(reset)
        self.addChild(board)
        self.addChild(turnlight)
        self.addChild(turnLabel)
        self.addChild(winLabel)

        
        
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
    
    
    
    
    func addChip(position: CGPoint) {
        var topFilled = false
        var chipsInRow = 0
        
        for anychip in arrayChips {
            if anychip.position.x == whatRow(position.x) {
                chipsInRow++
                if chipsInRow >= 6 {
                    topFilled = true
                }
            }
            if anychip.position.x == whatRow(position.x) && (position.y - anychip.position.y) < 90 {
                topFilled = true
            }
        }
        
        if !topFilled {
            self.runAction(SKAction.playSoundFileNamed("Tink.caf", waitForCompletion: false))
            var newChip = Chip(imageNamed: "greenchip")
        
        if greenTurn {
            newChip.texture = SKTexture(imageNamed: player1Color)
            newChip.chipColor = "green"
            greenTurn = false
            turnlight.texture = redlight
            turnLabel.text = "It is " + player2 + "'s turn"
        }
        else if !greenTurn {
            newChip.texture = SKTexture(imageNamed: player2Color)
            newChip.chipColor = "red"
            greenTurn = true
            turnlight.texture = greenlight
            turnLabel.text = "It is " + player1 + "'s turn"
        }
        
        newChip.position = CGPoint(x: whatRow(position.x), y: position.y)
        newChip.setScale(0.32)
        self.addChild(newChip)
        arrayChips += newChip
        }
    }
    
    func resetGame() {
        gameover = false
        reset.hidden = true
        redwins.hidden = true
        greenwins.hidden = true
        turnLabel.hidden = false
        winLabel.hidden = true
        for eachChip in arrayChips {
            eachChip.removeFromParent()
        }
        arrayChips = []
        
    }
    
    func noChipFalling() -> Bool {
        for chip in arrayChips {
            if chip.falling {
                return false
            }
        }
        return true
    }
    
    func checkforWinHelper(location: CGPoint, direction: String) {
        //myLabel1.text = String(counter)
        if counter == mode {
            gameover = true
        }
        for theChip in arrayChips {
            var correctColumn = whatRow(location.x)
            var correctRow = whatHeight(location.y)
            var correctChip: Bool = correctColumn == theChip.position.x && correctRow == theChip.position.y
            
            if correctChip && direction == "Left" {
                if theChip.chipColor == theChip.chipLeft {
                    counter++
                    checkforWinHelper(CGPoint(x: (theChip.position.x - 80), y: theChip.position.y), direction: "Left")
                }
            }
            
            if correctChip && direction == "Right" {
                if theChip.chipColor == theChip.chipRight {
                    counter++
                    checkforWinHelper(CGPoint(x: (theChip.position.x + 80), y: theChip.position.y), direction: "Right")
                }
            }
            
            if correctChip && direction == "Down" {
                if theChip.chipColor == theChip.chipDown {
                    counter++
                    checkforWinHelper(CGPoint(x: (theChip.position.x), y: (theChip.position.y - 72)), direction: "Down")
                }
            }
            
            if correctChip && direction == "UpLeft" {
                if theChip.chipColor == theChip.chipUpLeft {
                    counter++
                    checkforWinHelper(CGPoint(x: (theChip.position.x - 80), y: (theChip.position.y + 72)), direction: "UpLeft")
                }
            }
            
            if correctChip && direction == "UpRight" {
                if theChip.chipColor == theChip.chipUpRight {
                    counter++
                    checkforWinHelper(CGPoint(x: (theChip.position.x + 80), y: (theChip.position.y + 72)), direction: "UpRight")
                }
            }
            
            if correctChip && direction == "DownRight" {
                if theChip.chipColor == theChip.chipDownRight {
                    counter++
                    checkforWinHelper(CGPoint(x: (theChip.position.x + 80), y: (theChip.position.y - 72)), direction: "DownRight")
                }
            }
            
            if correctChip && direction == "DownLeft" {
                if theChip.chipColor == theChip.chipDownLeft {
                    counter++
                    checkforWinHelper(CGPoint(x: (theChip.position.x - 80), y: (theChip.position.y - 72)), direction: "DownLeft")
                }
            }
        }
        
    }
    
    func checkforWin(theChip: Chip) {
        //counter = 1
        
//            var xDistance = centerChip.position.x - nearbyChip.position.x
//            var yDistance = centerChip.position.y - nearbyChip.position.y
//            var sameChip: Bool = nearbyChip == centerChip
//            var sameRow: Bool = nearbyChip.position.y == centerChip.position.y
//            var sameColumn: Bool = nearbyChip.position.x == centerChip.position.x
//            var nearbyIsOneColumnLeft: Bool = xDistance >= 75 && xDistance <= 85
//            var nearbyIsOneColumnRight: Bool = xDistance <= -75 && xDistance >= -85
//            var nearbyIsOneRowDown: Bool = yDistance >= 70 && yDistance <= 75
//            var nearbyIsOneRowUp: Bool = yDistance <= -70 && yDistance >= -75
            
        if theChip.chipColor == theChip.chipLeft {
            counter = 1
            checkforWinHelper(CGPoint(x: (theChip.position.x), y: theChip.position.y), direction: "Left")
            checkforWinHelper(CGPoint(x: (theChip.position.x), y: theChip.position.y), direction: "Right")
        }
        if theChip.chipColor == theChip.chipRight {
            counter = 1
            checkforWinHelper(CGPoint(x: (theChip.position.x), y: theChip.position.y), direction: "Right")
        }
        
        if theChip.chipColor == theChip.chipDown {
            counter = 1
            checkforWinHelper(CGPoint(x: (theChip.position.x), y: theChip.position.y), direction: "Down")
        }
        
        if theChip.chipColor == theChip.chipUpLeft {
            counter = 1
            checkforWinHelper(CGPoint(x: (theChip.position.x), y: theChip.position.y), direction: "UpLeft")
            checkforWinHelper(CGPoint(x: (theChip.position.x), y: theChip.position.y), direction: "DownRight")
        }
        
        if theChip.chipColor == theChip.chipDownRight {
            counter = 1
            checkforWinHelper(CGPoint(x: (theChip.position.x), y: theChip.position.y), direction: "DownRight")
        }
        
        if theChip.chipColor == theChip.chipUpRight {
            counter = 1
            checkforWinHelper(CGPoint(x: (theChip.position.x), y: theChip.position.y), direction: "UpRight")
            checkforWinHelper(CGPoint(x: (theChip.position.x), y: theChip.position.y), direction: "DownLeft")
        }
        
        if theChip.chipColor == theChip.chipDownLeft {
            counter = 1
            checkforWinHelper(CGPoint(x: (theChip.position.x), y: theChip.position.y), direction: "DownLeft")
        }
    }
    
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            

            if touch.locationInNode(self).y > 450 && !gameover {
                addChip(touch.locationInNode(self))
            }
            
            if CGRectContainsPoint(reset.frame, touch.locationInNode(self)) && gameover {
                resetGame()
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
        self.runAction(SKAction.playSoundFileNamed("thud.mp3", waitForCompletion: false))
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
        
        for theChip in arrayChips {
            
            if theChip.falling {
                
                theChip.position.y += -10
                theChip.zRotation += 3
                
                if aboveChip(theChip.position) || theChip.position.y <= 35 {
                    allignChip(theChip)
                    updateNearChips(theChip)
                    checkforWin(theChip)
                    if gameover {
                        if theChip.chipColor == "green" {
                            winLabel.text = player1 + " Wins!!!"
                            winLabel.hidden = false
                            turnLabel.hidden = true
                            //greenwins.hidden = false
                        } else {
                            winLabel.text = player2 + " Wins!!!"
                            winLabel.hidden = false
                            turnLabel.hidden = true
                            //redwins.hidden = false 
                        }
                        reset.hidden = false
                        self.runAction(SKAction.playSoundFileNamed("claps.mp3", waitForCompletion: false))
                        for anyChip in arrayChips {
                            if anyChip.falling {
                                anyChip.removeFromParent()
                                anyChip.falling = false
                            }
                        }
                    }

                }

                
            }

            
        }
        
    }
}
