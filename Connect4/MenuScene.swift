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
    
    var background = SKSpriteNode(imageNamed: "blackback")
    var startButton = SKSpriteNode(imageNamed: "start")
    var threeButton = SKSpriteNode(imageNamed: "button3")
    var fiveButton = SKSpriteNode(imageNamed: "button5")
    var connectText = SKSpriteNode(imageNamed: "connect")
    var color1text = SKSpriteNode(imageNamed: "color1text")
    var color2text = SKSpriteNode(imageNamed: "color2text")
    var boardcolortext = SKSpriteNode(imageNamed: "boardcolortext")
    var myFrame = CGRect(x: 0, y: 0, width: 200, height: 50)
    var selectorFrame = CGRect(x: 0, y: 0, width: 450, height: 120)
    var colorFrame = CGRect(x: 0, y: 0, width: 550, height: 30)
    var textField = UITextField()
    var textField2 = UITextField()
    var selector = UISegmentedControl()
    var colorSelector = UISegmentedControl()
    var colorSelector2 = UISegmentedControl()
    var boardColor = UISegmentedControl()
    
    
    override func didMoveToView(view: SKView) {
        background.size = self.size
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        var enterName = UITextField(frame: myFrame)
        enterName.center = CGPoint(x: 160, y: 200)
        enterName.borderStyle = UITextBorderStyle.RoundedRect
        enterName.textColor = UIColor.blackColor()
        enterName.placeholder = "Player 1's Name"
        enterName.backgroundColor = UIColor.yellowColor()
        enterName.keyboardType = UIKeyboardType.Default
        textField = enterName
        var enterName2 = UITextField(frame: myFrame)
        enterName2.center = CGPoint(x: 600, y: 200)
        enterName2.borderStyle = UITextBorderStyle.RoundedRect
        enterName2.textColor = UIColor.blackColor()
        enterName2.placeholder = "Player 2's Name"
        enterName2.backgroundColor = UIColor.yellowColor()
        enterName2.keyboardType = UIKeyboardType.Default
        textField2 = enterName2
        var stringarray: [NSString] = ["3","4","5","6","7"]
        selector = UISegmentedControl(items: stringarray)
        selector.frame = selectorFrame
        selector.center = CGPoint(x: 374, y: 880)
        selector.tintColor = UIColor.redColor()
        selector.selectedSegmentIndex = 1
        //selector.backgroundColor = UIColor.whiteColor()
        selector.setTitleTextAttributes(NSDictionary(objects: [UIFont(name: "Helvetica", size: 66.0)], forKeys: [NSFontAttributeName]), forState: UIControlState.Normal)
        var colorArray = ["red","green","white","pink","black","yellow","orange","teal","purple","brown","blue"]
        colorSelector = UISegmentedControl(items: colorArray)
        colorSelector.frame = colorFrame
        colorSelector.center = CGPoint(x: 460, y: 255)
        colorSelector.backgroundColor = UIColor.blackColor()
        colorSelector.tintColor = UIColor.whiteColor()
        colorSelector.selectedSegmentIndex = 1
        colorSelector2 = UISegmentedControl(items: colorArray)
        colorSelector2.frame = colorFrame
        colorSelector2.center = CGPoint(x: 460, y: 300)
        colorSelector2.tintColor = UIColor.whiteColor()
        colorSelector2.backgroundColor = UIColor.blackColor()
        colorSelector2.selectedSegmentIndex = 0
        boardColor = UISegmentedControl(items: colorArray)
        boardColor.frame = colorFrame
        boardColor.center = CGPoint(x: 460, y: 350)
        boardColor.tintColor = UIColor.whiteColor()
        boardColor.backgroundColor = UIColor.blackColor()
        boardColor.selectedSegmentIndex = 10
        connectText.position = CGPoint(x: 513, y: 700)
        color1text.position = CGPoint(x: 290, y: 575)
        color1text.setScale(0.4)
        color2text.position = CGPoint(x: 290, y: 545)
        color2text.setScale(0.4)
        boardcolortext.position = CGPoint(x: 290, y: 507)
        boardcolortext.setScale(0.4)
        startButton.position = CGPoint(x: 513, y: 320)
        threeButton.position = CGPoint(x: 309, y: 100)
        threeButton.setScale(0.25)
        fiveButton.position = CGPoint(x: 700, y: 100)
        fiveButton.setScale(0.25)
        self.addChild(background)
        self.addChild(startButton)
        self.addChild(connectText)
        self.addChild(color1text)
        self.addChild(color2text)
        self.addChild(boardcolortext)
        self.view.addSubview(textField)
        self.view.addSubview(textField2)
        self.view.addSubview(selector)
        self.view.addSubview(colorSelector)
        self.view.addSubview(colorSelector2)
        self.view.addSubview(boardColor)
    }
    

    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        var transition = SKTransition.doorsCloseHorizontalWithDuration(1.0)
        var newScene = GameScene(size: self.scene.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        
        for touch: AnyObject in touches {
            
            if CGRectContainsPoint(startButton.frame, touch.locationInNode(self)) {
                if textField.text == "" {
                    newScene.player1 = "Player 1"
                } else {newScene.player1 = textField.text}
                if textField2.text == "" {
                    newScene.player2 = "Player 2"
                } else {newScene.player2 = textField2.text}
                
                textField.removeFromSuperview()
                textField2.removeFromSuperview()
                selector.removeFromSuperview()
                colorSelector.removeFromSuperview()
                colorSelector2.removeFromSuperview()
                boardColor.removeFromSuperview()
                self.runAction(SKAction.playSoundFileNamed("latch.mp3", waitForCompletion: false))
                
                newScene.mode = selector.selectedSegmentIndex + 3
                newScene.boardColor = stringToColor(boardColor.titleForSegmentAtIndex(boardColor.selectedSegmentIndex))
                newScene.player1Color = colorSelector.titleForSegmentAtIndex(colorSelector.selectedSegmentIndex) + "chip"
                newScene.player2Color = colorSelector2.titleForSegmentAtIndex(colorSelector2.selectedSegmentIndex) + "chip"
                
                self.scene.view.presentScene(newScene, transition: transition)
            }
            

        }
        
        
    }
    
    func stringToColor(thecolor: String) -> UIColor {
        switch thecolor {
        case "red":
            return UIColor.redColor()
        case "green":
            return UIColor.greenColor()
        case "white":
            return UIColor.whiteColor()
        case "pink":
            return UIColor.magentaColor()
        case "yellow":
            return UIColor.yellowColor()
        case "orange":
            return UIColor.orangeColor()
        case "teal":
            return UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case "purple":
            return UIColor.purpleColor()
        case "brown":
            return UIColor.brownColor()
        case "blue":
            return UIColor.blueColor()
        default:
            return UIColor.blackColor()
    
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        
    }
    
    
   
}
