//
//  MenuScene.swift
//  Christmas2016
//
//  Created by Jared Stevens2 on 11/18/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    var soundToPlay: String?
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 0, green:0, blue:0, alpha: 1)
        
        print("Should have presented menu Scene")
        
         NotificationCenter.default.post(name: Notification.Name(rawValue: "ToggleMusic"), object: nil, userInfo: ["update":"yes"])
        
        
        // Setup label
        let label = SKLabelNode(text: "Press anywhere to play again!")
        label.fontName = "AvenirNext-Bold"
        label.fontSize = 55
        label.fontColor = UIColor.white
        label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        // Play sound
        if let soundToPlay = soundToPlay {
            self.run(SKAction.playSoundFileNamed(soundToPlay, waitForCompletion: false))
        }
        
        self.addChild(label)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       // let gameScene = GameScene(fileNamed: "Level1")
        let gameScene = LevelHome(fileNamed: "LevelHome")
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        let skView = self.view as SKView!
        gameScene?.scaleMode = .aspectFill
        skView?.presentScene(gameScene!, transition: transition)
    }
    
}
