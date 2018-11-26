//
//  Level1.swift
//  Christmas2016
//
//  Created by Jared Stevens2 on 11/18/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import SpriteKit
import GameplayKit

class Level1: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Instance Variables
    
    let playerSpeed: CGFloat = 150.0
    let zombieSpeed: CGFloat = 75.0
    
    var goal: SKSpriteNode?
    var player: SKSpriteNode?
    var zombies: [SKSpriteNode] = []
    var toys: [SKSpriteNode] = []
    
    var lastTouch: CGPoint? = nil
    
    
    // MARK: - SKScene
    
    override func didMove(to view: SKView) {
        // Setup physics world's contact delegate
        physicsWorld.contactDelegate = self
        
        
        print("DID MOVE TO VIEW")
        // Setup player
        player = self.childNode(withName: "player") as? SKSpriteNode
        self.listener = player
        
        
        // Setup zombies
        for child in self.children {
            if child.name == "zombie" {
                if let child = child as? SKSpriteNode {
                    // Add SKAudioNode to zombie
                    let audioNode: SKAudioNode = SKAudioNode(fileNamed: "fear_moan.wav")
                    // child.addChild(audioNode)
                    
                    zombies.append(child)
                }
            }
            
            
            if child.name == "toy" {
                if let child = child as? SKSpriteNode {
                    // Add SKAudioNode to zombie
                    let audioNode: SKAudioNode = SKAudioNode(fileNamed: "fear_moan.wav")
                    // child.addChild(audioNode)
                  //  child.physicsBody?.contactTestBitMask = child.physicsBody?.collisionBitMask
                    print("Toy Contact Test Bit Mask: \(child.physicsBody?.contactTestBitMask)")
                    print("Toy Contact Collision Bit Mask: \(child.physicsBody?.collisionBitMask)")
                    toys.append(child)
                }
            }
 
        }
        
        // Setup goal
        goal = self.childNode(withName: "goal") as? SKSpriteNode
        
        // Setup initial camera position
        updateCamera()
    }
    
    
    // MARK: Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }
    
    fileprivate func handleTouches(_ touches: Set<UITouch>) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            lastTouch = touchLocation
        }
    }
    
    
    // MARK - Updates
    
    override func didSimulatePhysics() {
        if let _ = player {
            updatePlayer()
            updateZombies()
            updateToys()
        }
    }
    
    // Determines if the player's position should be updated
    fileprivate func shouldMove(currentPosition: CGPoint, touchPosition: CGPoint) -> Bool {
        return abs(currentPosition.x - touchPosition.x) > player!.frame.width / 2 ||
            abs(currentPosition.y - touchPosition.y) > player!.frame.height/2
    }
    
    // Updates the player's position by moving towards the last touch made
    func updatePlayer() {
        if let touch = lastTouch {
            let currentPosition = player!.position
            if shouldMove(currentPosition: currentPosition, touchPosition: touch) {
                
                let angle = atan2(currentPosition.y - touch.y, currentPosition.x - touch.x) + CGFloat(M_PI)
                let rotateAction = SKAction.rotate(toAngle: angle + CGFloat(M_PI*0.5), duration: 0)
                
                player!.run(rotateAction)
                
                let velocotyX = playerSpeed * cos(angle)
                let velocityY = playerSpeed * sin(angle)
                
                let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
                player!.physicsBody!.velocity = newVelocity;
                updateCamera()
            } else {
                player!.physicsBody!.isResting = true
            }
        }
    }
    
    func updateCamera() {
        if let camera = camera {
            camera.position = CGPoint(x: player!.position.x, y: player!.position.y)
        }
    }
    
    func updateToys() {
        //print("Updating Toys")
        
        let targetPosition = player!.position
        
        for toy in toys {
          let currentPosition = toy.position
            
            
            
        }
        
        
    }
    
    // Updates the position of all zombies by moving towards the player
    func updateZombies() {
        let targetPosition = player!.position
        
        for zombie in zombies {
            let currentPosition = zombie.position
            
            let angle = atan2(currentPosition.y - targetPosition.y, currentPosition.x - targetPosition.x) + CGFloat(M_PI)
            let rotateAction = SKAction.rotate(toAngle: angle + CGFloat(M_PI*0.5), duration: 0.0)
            zombie.run(rotateAction)
            
            let velocotyX = zombieSpeed * cos(angle)
            let velocityY = zombieSpeed * sin(angle)
            
            let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
            zombie.physicsBody!.velocity = newVelocity;
        }
    }
    
    
    // MARK: - SKPhysicsContactDelegate
    
   
    
    func didBegin(_ contact: SKPhysicsContact) {
        // 1. Create local variables for two physics bodies
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        var toy : SKNode? = nil
        
        print("Did Begin Contact A: \(contact.bodyA.categoryBitMask)")
        print("Did Begin Contact B: \(contact.bodyB.categoryBitMask)")
        // 2. Assign the two physics bodies so that the one with the lower category is always stored in firstBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 3. react to the contact between the two nodes
        if firstBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == zombies[0].physicsBody?.categoryBitMask {
            
            print("Touched a zombie")
            // Player & Zombie
            gameOver(false)
        } else if firstBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == goal?.physicsBody?.categoryBitMask {
            // Player & Goal
            
            print("Touched finish line")
            
            gameOver(true)
        } else if firstBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == toys[0].physicsBody?.categoryBitMask {
            // Player & Zombie
             toy = secondBody.node
            print("You picked up a toy!")
            
           // gameOver(false)
        }
        
        toy?.removeFromParent()
            
    }
    
    
    // MARK: Helper Functions
    
    fileprivate func gameOver(_ didWin: Bool) {
        print("- - - Game Ended - - -")
        let menuScene = MenuScene(size: self.size)
        menuScene.soundToPlay = didWin ? "fear_win.mp3" : "Dad_GoToYourRoom.m4a"
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        menuScene.scaleMode = SKSceneScaleMode.aspectFill
        self.scene!.view?.presentScene(menuScene, transition: transition)
    }
    
}


/*
 
 //
 //  LevelHome.swift
 //  Christmas2016
 //
 //  Created by Jared Stevens2 on 11/21/16.
 //  Copyright © 2016 Claven Solutions. All rights reserved.
 //
 
 //import UIKit
 import SpriteKit
 import GameplayKit
 
 class LevelHome: SKScene, SKPhysicsContactDelegate {
 
 // MARK: - Instance Variables
 
 let playerSpeed: CGFloat = 150.0
 let zombieSpeed: CGFloat = 75.0
 
 let damping: CGFloat = 0.98
 
 var goal: SKSpriteNode?
 var player: SKSpriteNode?
 var zombies: [SKSpriteNode] = []
 var toys: [SKSpriteNode] = []
 
 var lastTouch: CGPoint? = nil
 
 
 // MARK: - SKScene
 
 override func didMove(to view: SKView) {
 // Setup physics world's contact delegate
 physicsWorld.contactDelegate = self
 
 
 print("DID MOVE TO VIEW")
 // Setup player
 player = self.childNode(withName: "player") as? SKSpriteNode
 self.listener = player
 
 
 // Setup zombies
 for child in self.children {
 if child.name == "zombie" {
 if let child = child as? SKSpriteNode {
 // Add SKAudioNode to zombie
 let audioNode: SKAudioNode = SKAudioNode(fileNamed: "fear_moan.wav")
 child.addChild(audioNode)
 print("Added Zombie")
 zombies.append(child)
 }
 }
 
 
 
 
 if child.name == "toy" {
 if let child = child as? SKSpriteNode {
 // Add SKAudioNode to zombie
 let audioNode: SKAudioNode = SKAudioNode(fileNamed: "fear_moan.wav")
 // child.addChild(audioNode)
 //  child.physicsBody?.contactTestBitMask = child.physicsBody?.collisionBitMask
 print("Toy Contact Test Bit Mask: \(child.physicsBody?.contactTestBitMask)")
 print("Toy Contact Collision Bit Mask: \(child.physicsBody?.collisionBitMask)")
 toys.append(child)
 }
 }
 
 
 
 }
 
 // Setup goal
 goal = self.childNode(withName: "goal") as? SKSpriteNode
 
 // Setup initial camera position
 updateCamera()
 }
 
 
 // MARK: Touch Handling
 
 override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
 handleTouches(touches)
 }
 
 override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
 handleTouches(touches)
 }
 
 override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
 handleTouches(touches)
 }
 
 fileprivate func handleTouches(_ touches: Set<UITouch>) {
 for touch in touches {
 let touchLocation = touch.location(in: self)
 lastTouch = touchLocation
 }
 }
 
 
 // MARK - Updates
 
 override func didSimulatePhysics() {
 if let _ = player {
 updatePlayer()
 updateZombies()
 updateToys()
 }
 }
 
 // Determines if the player's position should be updated
 fileprivate func shouldMove(currentPosition: CGPoint, touchPosition: CGPoint) -> Bool {
 return abs(currentPosition.x - touchPosition.x) > player!.frame.width / 2 ||
 abs(currentPosition.y - touchPosition.y) > player!.frame.height/2
 }
 
 // Updates the player's position by moving towards the last touch made
 func updatePlayer() {
 
 // print("Updating Player position")
 if let touch = lastTouch {
 let currentPosition = player!.position
 if shouldMove(currentPosition: currentPosition, touchPosition: touch) {
 
 let angle = atan2(currentPosition.y - touch.y, currentPosition.x - touch.x) + CGFloat(M_PI)
 let rotateAction = SKAction.rotate(toAngle: angle + CGFloat(M_PI*0.5), duration: 0)
 
 player!.run(rotateAction)
 
 let velocotyX = playerSpeed * cos(angle)
 let velocityY = playerSpeed * sin(angle)
 
 let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
 player!.physicsBody!.velocity = newVelocity;
 
 // print("Player Position is: \(newVelocity)")
 updateCamera()
 } else {
 player!.physicsBody!.isResting = true
 }
 }
 }
 
 func updateCamera() {
 if let camera = camera {
 // print("updating camera")
 camera.position = CGPoint(x: player!.position.x, y: player!.position.y)
 }
 }
 
 func updateToys() {
 //print("Updating Toys")
 
 let targetPosition = player!.position
 
 for toy in toys {
 let currentPosition = toy.position
 
 
 
 }
 
 
 }
 
 // Updates the position of all zombies by moving towards the player
 func updateZombies() {
 let targetPosition = player!.position
 
 for zombie in zombies {
 let currentPosition = zombie.position
 
 let angle = atan2(currentPosition.y - targetPosition.y, currentPosition.x - targetPosition.x) + CGFloat(M_PI)
 let rotateAction = SKAction.rotate(toAngle: angle + CGFloat(M_PI*0.5), duration: 0.0)
 zombie.run(rotateAction)
 
 let velocotyX = zombieSpeed * cos(angle)
 let velocityY = zombieSpeed * sin(angle)
 
 let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
 zombie.physicsBody!.velocity = newVelocity;
 }
 }
 
 
 // MARK: - SKPhysicsContactDelegate
 
 
 
 func didBegin(_ contact: SKPhysicsContact) {
 // 1. Create local variables for two physics bodies
 var firstBody: SKPhysicsBody
 var secondBody: SKPhysicsBody
 
 
 
 var toy : SKNode? = nil
 
 print("Did Begin Contact A: \(contact.bodyA.categoryBitMask)")
 print("Did Begin Contact B: \(contact.bodyB.categoryBitMask)")
 
 //print("Contact A Name = \(contact.bodyA.node?.name)")
 //print("Contact B Name = \(contact.bodyB.node?.name)")
 // 2. Assign the two physics bodies so that the one with the lower category is always stored in firstBody
 if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
 firstBody = contact.bodyA
 secondBody = contact.bodyB
 } else {
 firstBody = contact.bodyB
 secondBody = contact.bodyA
 }
 
 // 3. react to the contact between the two nodes
 if firstBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
 secondBody.categoryBitMask == zombies[0].physicsBody?.categoryBitMask {
 
 print("Touched a zombie")
 // Player & Zombie
 gameOver(false)
 } else if firstBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
 secondBody.categoryBitMask == goal?.physicsBody?.categoryBitMask {
 // Player & Goal
 
 print("Touched finish line")
 
 gameOver(true)
 } else if firstBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
 secondBody.categoryBitMask == toys[0].physicsBody?.categoryBitMask {
 // Player & Zombie
 toy = secondBody.node
 print("You picked up a toy!")
 
 // gameOver(false)
 } else {
 // print("FirstBody Name = \(firstBody.node?.name)")
 
 // print("SecodBody Name = \(secondBody.node?.name)")
 
 
 
 let Bdx = firstBody.velocity.dx * damping
 let Bdy = firstBody.velocity.dy * damping
 
 
 
 let pA = CGPoint(x: firstBody.velocity.dx, y: firstBody.velocity.dy) // Point A(2, 3)
 let pB = CGPoint(x: Bdx, y: Bdy) // Point B(7, 8)
 let vecAB = CGVector(dx: pB.x - pA.x, dy: pB.y - pA.y)
 
 //firstBody.velocity = CGVectorMake(dx, dy)
 firstBody.velocity = vecAB
 
 
 
 }
 
 toy?.removeFromParent()
 
 }
 
 
 // MARK: Helper Functions
 
 fileprivate func gameOver(_ didWin: Bool) {
 print("- - - Game Ended - - -")
 let menuScene = MenuScene(size: self.size)
 menuScene.soundToPlay = didWin ? "fear_win.mp3" : "Dad_GoToYourRoom.m4a"
 let transition = SKTransition.flipVertical(withDuration: 1.0)
 menuScene.scaleMode = SKSceneScaleMode.aspectFill
 self.scene!.view?.presentScene(menuScene, transition: transition)
 }
 
 }

 
 */
