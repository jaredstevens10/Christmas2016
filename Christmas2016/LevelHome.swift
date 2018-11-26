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


struct PhysicsCategory: OptionSet {
    let rawValue: UInt32
    init(rawValue: UInt32) { self.rawValue = rawValue }
    
    static let player  = PhysicsCategory(rawValue: 0b00100101)

    static let parent = PhysicsCategory(rawValue: 0b010)
    static let candy = PhysicsCategory(rawValue: 0b100)
    static let friend = PhysicsCategory(rawValue: 0b1001)
    static let roomBase  = PhysicsCategory(rawValue: 0b00100100)
    static let toys_pickup = PhysicsCategory(rawValue: 0b00100110)
    static let box = PhysicsCategory(rawValue: 0b00100111)
    static let map = PhysicsCategory(rawValue: 0b00101000)

}

extension SKPhysicsBody {
    var category: PhysicsCategory {
        get {
            return PhysicsCategory(rawValue: self.categoryBitMask)
        }
        set(newValue) {
            self.categoryBitMask = newValue.rawValue
        }
    }
}



class LevelHome: SKScene, SKPhysicsContactDelegate, Alerts {
    
    
    var CandyPoints = [CGPoint]()
    
   
    
    var GameType = String()
    var HasMap = Bool()
   // let date = NSDate()
   // let calender = NSCalendar.current
   
   // var start: CFAbsoluteTime!

    var AvoidContact = Bool()
    
    var levelSelected = String()
    
    var backgroundMusic: SKAudioNode!
    
     let MessageImage = UIImage(named: "HeadJared.png")!
    
    var ViewingMessage = Bool()
    
    // MARK: - Instance Variables
    
    var charactername = String()
    
    let prefs:UserDefaults = UserDefaults.standard
    
    var CandiesFound: [SKSpriteNode] = []
    
    var CanCollectCandy = Bool()
    var CanDropCandy = Bool()
    
    var CandyCount = 0
    
   // var parentArray = ["Dad","Mom"]
    
    var GameIsPaused = Bool()
    
    var PickingUpCandy = Bool()

    var ParentsMoving = Bool()
    
    var friendsListArray = [String]()
    
    var friendlyMessageArray = ["Oh hi there","whatcha doing?","let's play","Wanna play?","hi","hey"]
    
    var myResponseArray = ["Not now","later","maybe later","....","see ya"]
    
    
    /*
    let Ember = FriendInfo(name: "Ember", image: UIImage(named: "FriendEmber")!, speed: 55.0, ResetTime: nil, canTouchPlayer: true)
    let Lilly = FriendInfo(name: "Lilly", image: UIImage(named: "FriendLilly")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
    let Ben = FriendInfo(name: "Ben", image: UIImage(named: "FriendBen")!, speed: 90.0, ResetTime: nil, canTouchPlayer: true)
    let Colton = FriendInfo(name: "Colton", image: UIImage(named: "FriendColton")!, speed: 100.0, ResetTime: nil, canTouchPlayer: true)
    let Cory = FriendInfo(name: "Cory", image: UIImage(named: "FriendCory")!, speed: 100.0, ResetTime: nil, canTouchPlayer: true)
    let Eisley = FriendInfo(name: "Eisley", image: UIImage(named: "FriendEisley")!, speed: 85.0, ResetTime: nil, canTouchPlayer: true)
    */
    
    var friendsInfoArray = [FriendInfo]()
    
    var playerSpeed: CGFloat = 200.0
    var zombieSpeed: CGFloat = 75.0
    var momSpeed: CGFloat = 100.0
    var momSpeedMax: CGFloat = 250.0
    var momSpeedSlow: CGFloat = 70.0
    let damping: CGFloat = 0.98
    
    var goal: SKSpriteNode?
    var player: SKSpriteNode?
    var zombies: [SKSpriteNode] = []
    var ToysToPickUp: [SKSpriteNode] = []
    var toys: [SKSpriteNode] = []
    var candies: [SKSpriteNode] = []
    var parents: [SKSpriteNode] = []
    var friends: [SKSpriteNode] = []
    
    let CandyCategoryMask: UInt32 = 5
    let ToyCategoryMask: UInt32 = 4
    let MomCategoryMask: UInt32 = 6
    let ZombieCategoryMask: UInt32 = 2
    
    
    var candyCountInt = Int()
    var friendsCountInt = Int()
    var parentsCountInt = Int()
    
    
    var lastTouch: CGPoint? = nil
    
    
    var PlayerImage : UIImage!
        {
        didSet
        {
            updatePlayerImage()
        }
    }
    
    func updatePlayerImage()
    {
       // print("Updating Player Image to \(PlayerImage.description//)")
        
        //var playerTexture = SKSpriteNode()
        //playerTexture.texture = SKTexture(image: PlayerImage)
        
       // self.player?.texture = SKTexture(image: PlayerImage)
        
       // self.player?.texture = SKTexture(image: PlayerImage)
        
        
        let playerTexture = SKTexture(image: PlayerImage)
        let playerSize = CGSize(width: 1, height: 1)
        
        
      //  let newPlayer = SKSpriteNode(texture: playerTexture, color: UIColor.clear, size: playerSize)
        player = self.childNode(withName: "player") as? SKSpriteNode
        
        self.player?.texture = SKTexture(image: PlayerImage)
        
        //self.player?.scale(to: playerSize)
        
        //self.player?.size = playerSize
        self.player?.physicsBody = SKPhysicsBody(texture: playerTexture, size: playerSize)
        
        //physicsBody = SKPhysicsBody(texture: CandyTexture, size: CandySize)
        
        self.player?.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
        
        
        // print("Player Category: \(PhysicsCategory.player.rawValue)")
        // print("Candy Category: \(PhysicsCategory.candy.rawValue)")
        // print("parent Category: \(PhysicsCategory.parent.rawValue)")
        //self.player?.physicsBody?.contactTestBitMask = PhysicsCategory.candy.rawValue
        self.player?.physicsBody?.contactTestBitMask = 0
        self.player?.physicsBody?.fieldBitMask = 4294967295
        self.player?.physicsBody?.collisionBitMask = 4294967295
        self.player?.physicsBody?.affectedByGravity = false
        self.player?.physicsBody?.mass = 1.0
        
        let PlayerAudio = self.player?.childNode(withName: "SKAudioNode_0")
        
        //PlayerAudio?.run(SKAction.changeVolume(to: 0.3, duration: 60))
        
        self.listener = player
        
        
        switch charactername {
             case "tripp":
            
            self.player?.position = CGPoint(x: 2704, y: 4513)
            case "piper":
            
            self.player?.position = CGPoint(x: 1809, y: 4616)
            
            
            case "mom":
            
            self.player?.position = CGPoint(x: 4850, y: 3100)
            
            
            
        default:
            self.player?.position = CGPoint(x: 2704, y: 4513)
        }
        /*
        if charactername == "tripp" {
        self.player?.position = CGPoint(x: 2704, y: 4513)
        } else {
            
        self.player?.position = CGPoint(x: 1809, y: 4616)
        //self.player?.position = CGPoint(x: 2704, y: 4513)
        }
        */
        
        
        /*
        for child in self.children {
            if child.name == "camera" {
                if let child = child as? SKSpriteNode {
                    // Add SKAudioNode to zombie
                   // let audioNode: SKAudioNode = SKAudioNode(fileNamed: "fear_moan.wav")
                    // child.addChild(audioNode)
                    //print("Added Zombie")
                    //zombies.append(child)
                    newPlayer.addChild(child)
                }
            }

        }
        */
        // self.player?.addChild(playerTexture)
        /*
         var birdTexture = SKTexture(image: imageToPass)
        bird?.removeFromParent()
        bird = SKSpriteNode(texture: birdTexture)
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        self.addChild(bird)
         */
    }
    
    
    // MARK: - SKScene
    
    
    
    
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        // Setup physics world's contact delegate
        physicsWorld.contactDelegate = self
        
         //let components = calender.component([.Hour, .Minute], from: date)
        
        print("did move loaded")
        
        if charactername == "mom" {
            
            GameType = "parent"
            //HairUp
            if let musicURL = Bundle.main.url(forResource: "fear_bg", withExtension: "mp3") {
                backgroundMusic = SKAudioNode(url: musicURL)
                backgroundMusic.run(SKAction.changeVolume(to: 0.2, duration: 0))
                backgroundMusic.autoplayLooped = true
                addChild(backgroundMusic)
            }
          
            /*
            friendsInfoArray.append(Ember)
            friendsInfoArray.append(Lilly)
            friendsInfoArray.append(Ben)
            friendsInfoArray.append(Colton)
            friendsInfoArray.append(Cory)
            friendsInfoArray.append(Eisley)
           */
            var theButton = SKSpriteNode()
            
            CanCollectCandy = true
            CanDropCandy = false
            
            
        NotificationCenter.default.addObserver(self, selector: #selector(LevelHome.PauseGame(_:)), name: NSNotification.Name(rawValue: "PauseGame"),  object: nil)
            
         updatePlayerImage()
            
            
        CreateCandy(counter: candyCountInt)
        CreateParents(counter: parentsCountInt)
        CreateBox(Character: charactername)
        //CreateFriends(Character: charactername, counter: friendsCountInt)
        CreateKids(Character: charactername, counter: friendsCountInt)
            
            
        } else {
        
        GameType = "kid"
        
        if let musicURL = Bundle.main.url(forResource: "HairUp", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            backgroundMusic.run(SKAction.changeVolume(to: 0.2, duration: 0))
            backgroundMusic.autoplayLooped = true
            addChild(backgroundMusic)
        }
            
        /*
        friendsInfoArray.append(Ember)
        friendsInfoArray.append(Lilly)
        friendsInfoArray.append(Ben)
        friendsInfoArray.append(Colton)
        friendsInfoArray.append(Cory)
        friendsInfoArray.append(Eisley)
        */
            
        var theButton = SKSpriteNode()
        
        CanCollectCandy = true
        CanDropCandy = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(LevelHome.PauseGame(_:)), name: NSNotification.Name(rawValue: "PauseGame"),  object: nil)
        
        print("DID MOVE TO VIEW")
        
        print("Candy Count: \(candyCountInt)")
        print("Friends Count: \(friendsCountInt)")
        print("Parents Count: \(parentsCountInt)")
        
        /*
        let randomIndex = Int(arc4random_uniform(UInt32(parentArray.count)))
        
        let ParentTexture = parentArray[randomIndex]
        
        if ParentTexture == "Dad" {
            ParentImageNormal = UIImage(named: "DadHeadTemp.png")!
            ParentImageNormalOther = UIImage(named: "MomHeadTemp.png")!
            momSpeed = momSpeed + (momSpeed * 0.2)
            
        } else {
            ParentImageNormal = UIImage(named: "MomHeadTemp.png")!
            ParentImageNormalOther = UIImage(named: "DadHeadTemp.png")!
        }
        */
        
        // Setup player
        //player = self.childNode(withName: "player") as? SKSpriteNode
        //player?.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
        
        
        //print("Player Contact Bit Mask: \(player?.physicsBody?.))
        
        updatePlayerImage()
        
       // self.listener = player
        
        
        //var parentCountTemp = 0
        
        CreateCandy(counter: candyCountInt)
            
        print("Did move, created Candy")
        CreateParents(counter: parentsCountInt)
        CreateBox(Character: charactername)
        CreateFriendsStart(Character: charactername, counter: friendsCountInt)
        CreateMap(Character: charactername)
        
        // Setup zombies
        for child in self.children {
            
            /*
            if child.name == "zombie" {
                if let child = child as? SKSpriteNode {
                    // Add SKAudioNode to zombie
                    let audioNode: SKAudioNode = SKAudioNode(fileNamed: "fear_moan.wav")
                   // child.addChild(audioNode)
                    print("Added Zombie")
                    zombies.append(child)
                }
            }
            */
            
            if child.name == "camera" {
                
                if let child = child as? SKCameraNode {
                print("IS CAMERA NODE")
                    
                if candyCountInt == 1 {
                    print("CAMERA IS 1 CANDY COUNT")
                    child.setScale(0.17)
                    //child.scaleas .scaleAsPoint = CGPoint(x: 0.25, y: 0.25)
                    /*
                    let amplitudeX:Float = 10;
                    let amplitudeY:Float = 6;
                    var actionsArray:[SKAction] = [];
                    
                    
                   // let moveX = Float(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2;
                   // let moveY = Float(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2;
                    
                    let moveX = amplitudeX / 2
                    let moveY = amplitudeY / 2
                    
                    let shakeAction = SKAction.moveBy(x: CGFloat(moveX), y: CGFloat(moveY), duration: 0.02);
                    shakeAction.timingMode = SKActionTimingMode.easeInEaseOut
                    actionsArray.append(shakeAction);
                    
                    
                    let actionSeq = SKAction.sequence(actionsArray);
                    //layer.runAction(actionSeq);
                    child.run(actionSeq)
                    
                    */
                    
                  }
                    
                    if candyCountInt == 2 {
                        print("CAMERA IS 1 CANDY COUNT")
                        child.setScale(0.15)
                        
                        
                    }
                    
                    if candyCountInt == 3 {
                        print("CAMERA IS 1 CANDY COUNT")
                        child.setScale(0.12)
                      
                        
                    }
                    
                    if candyCountInt == 4 {
                        print("CAMERA IS 1 CANDY COUNT")
                        child.setScale(0.10)
                        
                        
                    }
                    
                    if candyCountInt == 5 {
                        print("CAMERA IS 1 CANDY COUNT")
                        child.setScale(0.07)
                        
                        
                    }
                    
                }
                
            }
            
            
            if child.name == "toy" {
                if let child = child as? SKSpriteNode {
                    // Add SKAudioNode to zombie
                    let audioNode: SKAudioNode = SKAudioNode(fileNamed: "fear_moan.wav")
                    // child.addChild(audioNode)
                    //  child.physicsBody?.contactTestBitMask = child.physicsBody?.collisionBitMask
                   // print("Toy Contact Test Bit Mask: \(child.physicsBody?.contactTestBitMask)")
                   // print("Toy Contact Collision Bit Mask: \(child.physicsBody?.collisionBitMask)")
                    
                  //  print("Toy Category Bit Mask: \(child.physicsBody?.categoryBitMask)")
                    toys.append(child)
                }
            }
            
            
            /*
            
            if child.name == "candy" {
                if let child = child as? SKSpriteNode {
                    // Add SKAudioNode to zombie
                    let audioNode: SKAudioNode = SKAudioNode(fileNamed: "fear_moan.wav")
                    // child.addChild(audioNode)
                    //  child.physicsBody?.contactTestBitMask = child.physicsBody?.collisionBitMask
                   // print("Candy Contact Test Bit Mask: \(child.physicsBody?.contactTestBitMask)")
                  //  print("Candy Contact Collision Bit Mask: \(child.physicsBody?.collisionBitMask)")
                    
                  //  print("Candy Category Bit Mask: \(child.physicsBody?.categoryBitMask)")
                    
                    candies.append(child)
                }
            }
            
            
            
            if child.name == "parent" {
                
               // child.position = CGPoint(x: frame.size.width * random2(min: 0, max: 1), y: frame.size.height * random2(min: 0, max: 1))
                
                
                /*
                for (counter = 1; counter <= 50; counter++) {
                    //add objects to scene
                    func spawnEnemy() {
                        let enemy = SKSpriteNode(imageNamed: "gargar")
                        enemy.position = CGPoint(x: frame.size.width * random2(min: 0, max: 1), y: frame.size.height * random2(min: 0, max: 1))
                        addChild(enemy)
                    }
                }
                
                */
                
                
               // let randomIndex = Int(arc4random_uniform(UInt32(parentArray.count)))
                
               // let ParentTexture = parentArray[randomIndex]
                //messageToUserLBL.text = messageToUser
                
                
                /*
                if let child = child as? SKSpriteNode {
                    // Add SKAudioNode to zombie
                    let audioNode: SKAudioNode = SKAudioNode(fileNamed: "fear_moan.wav")
                    // child.addChild(audioNode)
                    //  child.physicsBody?.contactTestBitMask = child.physicsBody?.collisionBitMask
                    print("Parent Contact Test Bit Mask: \(child.physicsBody?.contactTestBitMask)")
                    print("Parent Contact Collision Bit Mask: \(child.physicsBody?.collisionBitMask)")
                    
                    /*
                    if parentCountTemp > 0 {
                    child.texture = SKTexture(image: ParentImageNormalOther)
                    } else {
                    child.texture = SKTexture(image: ParentImageNormal)
                    }
                    */
                    parents.append(child)
                   // parentCountTemp += 1
                }
                */
            }
            */
            
            
            
        }
        
        // Setup goal
        goal = self.childNode(withName: "goal") as? SKSpriteNode
            
        }
        
        // Setup initial camera position
     
        
       // print("SHOULD SEND NOTIFICATION")
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateCandyViews"), object: nil, userInfo: ["message":"NA","candyCount":"0","levelCandyCount":"\(candyCountInt)","levelHiddenCandyCount":"0","messageType":"Ok"])
        
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ToggleMusic"), object: nil, userInfo: ["update":"off"])
        
        NotificationCenter.default.addObserver(self, selector: #selector(LevelHome.GenerateCandy(_:)), name: NSNotification.Name(rawValue: "GenerateCandy"),  object: nil)
        
        
         NotificationCenter.default.addObserver(self, selector: #selector(LevelHome.TellOnPlayer(_:)), name: NSNotification.Name(rawValue: "TellOnPlayer"),  object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(LevelHome.ParentCanTouchPlayer(_:)), name: NSNotification.Name(rawValue: "ParentCanTouchPlayer"),  object: nil)
        
      //  parent.userData?.setValue(false, forKey: "parentCanTouchPlayer")
        
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateParentSpeed"), object: nil, userInfo: ["message":"NA","newSpeed":"\(momSpeed)","maxSpeed":"\(momSpeedMax)"])
        
        
        
        
        
      //  DispatchQueue.main.async(execute: {
        
           self.updateCamera()
            
       // })
        
    }
    
    func ParentCanTouchPlayer (_ notification:Notification) {
        
        for child in self.children {
            
            if child.name == "parent" {
                child.userData?.setValue(true, forKey: "parentCanTouchPlayer")
            }
        }
        
      //  parent.userData?.setValue(true, forKey: "parentCanTouchPlayer")
    }
    
    func TellOnPlayer (_ notification:Notification) {
        
        AvoidContact = false
        
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        // print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        
        let NotificationMessage = jsonAlert["message"].stringValue
        
        let action = jsonAlert["action"].stringValue
        
       // let amount = Int(amountTemp)!
        
        if action == "tell" {
            
        print("Player told on, increase parent speed")
        
            
            
              momSpeed = momSpeed + 20.0
            
            if momSpeed > momSpeedMax {
                momSpeed = momSpeedMax
            }
            
            print("MOM SPEED: \(momSpeed)")
            print("MAX SPEED: \(momSpeedMax)")
            
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateParentSpeed"), object: nil, userInfo: ["message":"NA","newSpeed":"\(momSpeed)","maxSpeed":"\(momSpeedMax)"])
            
        print("Parent speed is now: \(momSpeed)")
            
        }
   
        
    }
    
    func GenerateCandy (_ notification:Notification) {
        
        AvoidContact = false
        
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        // print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        
        let NotificationMessage = jsonAlert["message"].stringValue
        
        let amountTemp = jsonAlert["createAmount"].stringValue
        
        let amount = Int(amountTemp)!
        
        
        self.CandyPoints.removeLast()
        
      
        
        CreateCandy(counter: amount)
        
        
        // myData.remove(at: TempIndex)
        
        if HasMap {
        
        DispatchQueue.main.async(execute: {
            
            
            
        
        let PointsObects: [String: [CGPoint]] = [ "points": self.CandyPoints]
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "CreateRadarMap"), object: PointsObects, userInfo: ["message":"unhide"])
            
        })
            
        }
        
        
        print("New Candy Created")
        
    }
    
    func spawnCandy(counter: Int) {
        // let newCandy = SKSpriteNode(imageNamed: "MilkDuds.png", CGSizeMake(76, 56))
        
       
        
        let CandyTexture = SKTexture(image: UIImage(named: "MilkDuds.png")!)
        let CandySize = CGSize(width: 76, height: 56)
        
        
        let newCandy = SKSpriteNode(texture: CandyTexture, color: UIColor.clear, size: CandySize)
        
        let newX:CGFloat = 5851 //frame.size.width
        let newY:CGFloat = 7311 //frame.size.height
        
        
        
        //newCandy.position = CGPoint(x: newX * random2(min: 0, max: 1), y: newY * random2(min: 0, max: 1))
        
        
        if counter == 1 {
        newCandy.position = CGPoint(x: 2810, y: 4523)
        } else {
        newCandy.position = CGPoint(x: newX * random2(min: 0, max: 1), y: newY * random2(min: 0, max: 1))
        }
        
        self.CandyPoints.append(newCandy.position)
        
        // newCandy.size = CGSize( frame = CGRect(x: newCandy.position.x, y: newCandy.position.y, width: 76, height: 56)
        newCandy.name = "candy"
        newCandy.physicsBody = SKPhysicsBody(texture: CandyTexture, size: CandySize)
        
        //newParent.physicsBody = SKPhysicsBody(circleOfRadius: newParent.frame.size.width/2)
        newCandy.physicsBody?.isDynamic = true
        newCandy.physicsBody?.allowsRotation = false
        newCandy.physicsBody?.pinned = false
        newCandy.physicsBody?.affectedByGravity = false
        newCandy.physicsBody?.categoryBitMask = PhysicsCategory.candy.rawValue
        newCandy.physicsBody?.contactTestBitMask = 1
        newCandy.physicsBody?.collisionBitMask = 4294967295
        newCandy.physicsBody?.fieldBitMask = 4294967295
        
        print("Random Candy Position: \(newCandy.position)")
        
       // print("Candy Category Raw: \(PhysicsCategory.candy.rawValue)")
        
       // print("Candy Category: \(newCandy.physicsBody?.categoryBitMask)")
        
        addChild(newCandy)
        candies.append(newCandy)
    }
    func CreateBox(Character: String) {
        // let newCandy = SKSpriteNode(imageNamed: "MilkDuds.png", CGSizeMake(76, 56))
        
        let BTexture = SKTexture(image: UIImage(named: "ClosedChest.png")!)
        let BSize = CGSize(width: 76, height: 56)
        // 2770 4125
        
        let newCandy = SKSpriteNode(texture: BTexture, color: UIColor.clear, size: BSize)
        
        let newX:CGFloat = 3000 //frame.size.width
        let newY:CGFloat = 4132 //frame.size.height
        
        
        
        //newCandy.position = CGPoint(x: newX * random2(min: 0, max: 1), y: newY * random2(min: 0, max: 1))
        
        
        switch Character {
        case "tripp":
            newCandy.position = CGPoint(x: 3000, y: 4332)
        case "piper":
            newCandy.position = CGPoint(x: 2109, y: 4616)
        case "mom":
            newCandy.position = CGPoint(x: 2109, y: 4616)
        default:
            newCandy.position = CGPoint(x: 3000, y: 4332)
        }
        
        
        newCandy.name = "box"
        newCandy.physicsBody = SKPhysicsBody(texture: BTexture, size: BSize)
        
        //newParent.physicsBody = SKPhysicsBody(circleOfRadius: newParent.frame.size.width/2)
        newCandy.physicsBody?.isDynamic = true
        newCandy.physicsBody?.allowsRotation = false
        newCandy.physicsBody?.pinned = false
        newCandy.physicsBody?.affectedByGravity = false
        newCandy.physicsBody?.categoryBitMask = PhysicsCategory.box.rawValue
        newCandy.physicsBody?.contactTestBitMask = 1
        newCandy.physicsBody?.collisionBitMask = 4294967295
        newCandy.physicsBody?.fieldBitMask = 4294967295
        
        // print("Box Category Raw: \(PhysicsCategory.box.rawValue)")
        
        // print("Box Category: \(newCandy.physicsBody?.categoryBitMask)")
        
        // print("Random Candy Position: \(newCandy.position)")
        
        addChild(newCandy)
        // candies.append(newCandy)
    }
    
    func CreateMap(Character: String) {
       // let newCandy = SKSpriteNode(imageNamed: "MilkDuds.png", CGSizeMake(76, 56))
        
        
        print("Creating Map now")
        let BTexture = SKTexture(image: UIImage(named: "mapIcon.png")!)
        let BSize = CGSize(width: 76, height: 56)
       // 2770 4125
        
        let newCandy = SKSpriteNode(texture: BTexture, color: UIColor.clear, size: BSize)
        
        let newX:CGFloat = 3000 //frame.size.width
        let newY:CGFloat = 4132 //frame.size.height
        
        
        
        
        if candyCountInt == 1 {
           // newCandy.position = CGPoint(x: 3000, y: 4132)
            newCandy.position = CGPoint(x: 2900, y: 4332)
        } else {
            newCandy.position = CGPoint(x: newX * random2(min: 0, max: 1), y: newY * random2(min: 0, max: 1))
        }
        
        //UNCOMMNET TO CREATE RANDOM MAP POINT
        
        
       //newCandy.position = CGPoint(x: newX * random2(min: 0, max: 1), y: newY * random2(min: 0, max: 1))
        
        
       // newCandy.position = CGPoint(x: 2900, y: 4332)
        
        /*
        switch Character {
        case "tripp":
            newCandy.position = CGPoint(x: 3000, y: 4332)
        case "piper":
           newCandy.position = CGPoint(x: 2109, y: 4616)
        case "mom":
          newCandy.position = CGPoint(x: 2109, y: 4616)
        default:
          newCandy.position = CGPoint(x: 3000, y: 4332)
        }
        */
 

        newCandy.name = "map"
        newCandy.physicsBody = SKPhysicsBody(texture: BTexture, size: BSize)
            
            //newParent.physicsBody = SKPhysicsBody(circleOfRadius: newParent.frame.size.width/2)
        newCandy.physicsBody?.isDynamic = true
        newCandy.physicsBody?.allowsRotation = false
        newCandy.physicsBody?.pinned = false
        newCandy.physicsBody?.affectedByGravity = false
        newCandy.physicsBody?.categoryBitMask = PhysicsCategory.map.rawValue
        newCandy.physicsBody?.contactTestBitMask = 1
        newCandy.physicsBody?.collisionBitMask = 4294967295
        newCandy.physicsBody?.fieldBitMask = 4294967295
        
       // print("Box Category Raw: \(PhysicsCategory.box.rawValue)")
        
       // print("Box Category: \(newCandy.physicsBody?.categoryBitMask)")
        
       // print("Random Candy Position: \(newCandy.position)")
        
        addChild(newCandy)
       // candies.append(newCandy)
    }
    
    func tappedButton(button: SgButton) {
        print("tappedButton tappedButton tag=\(button.tag)")
        
        button.removeFromParent()
        
    }
    
    
    func CreateMessageBox(message: String) {
        // let newCandy = SKSpriteNode(imageNamed: "MilkDuds.png", CGSizeMake(76, 56))
     // print("Creating Message box")
        
        /*
        //var x: CGFloat = 100
        //var y: CGFloat = self.frame.height - 80
        
        
        var x = player?.position.x
        var y = player?.position.y
        
        var btn4 = SgButton(normalString: message, normalStringColor: UIColor.blue, size: CGSize(width: 400, height: 80), cornerRadius: 10.0, buttonFunc: tappedButton)
        
        btn4.position = CGPoint(x: x!, y: y!)
        btn4.tag = 0
        //self.addChild(btn4)
        */

        let NotificationMessage = "You don't have any candy to hide.  You need to go get some"
        
       // NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"You don't have any candy to hide.  You need to go get some","candyCount":"0","messageType":"Ok"])
        
    }
    
    func CreateToys (counter: Int) {
        
        //var counter
        for j in stride(from:1, through:counter, by: +1) {
            
            
            let CandyTexture = SKTexture(image: UIImage(named: "TrippToy1.png")!)
            let CandySize = CGSize(width: 76, height: 56)
            
            
            let newCandy = SKSpriteNode(texture: CandyTexture, color: UIColor.clear, size: CandySize)
            
            let newX:CGFloat = 5851 //frame.size.width
            let newY:CGFloat = 7311 //frame.size.height
            
            
            
            //newCandy.position = CGPoint(x: newX * random2(min: 0, max: 1), y: newY * random2(min: 0, max: 1))
            
            
            if counter == 1 {
                newCandy.position = CGPoint(x: 2810, y: 4523)
            } else {
                newCandy.position = CGPoint(x: newX * random2(min: 0, max: 1), y: newY * random2(min: 0, max: 1))
            }
            
            
            // newCandy.size = CGSize( frame = CGRect(x: newCandy.position.x, y: newCandy.position.y, width: 76, height: 56)
            newCandy.name = "candy"
            newCandy.physicsBody = SKPhysicsBody(texture: CandyTexture, size: CandySize)
            
            //newParent.physicsBody = SKPhysicsBody(circleOfRadius: newParent.frame.size.width/2)
            newCandy.physicsBody?.isDynamic = true
            newCandy.physicsBody?.allowsRotation = false
            newCandy.physicsBody?.pinned = false
            newCandy.physicsBody?.affectedByGravity = false
            newCandy.physicsBody?.categoryBitMask = PhysicsCategory.toys_pickup.rawValue
            newCandy.physicsBody?.contactTestBitMask = 1
            newCandy.physicsBody?.collisionBitMask = 4294967295
            newCandy.physicsBody?.fieldBitMask = 4294967295
            
            print("Random Candy Position: \(newCandy.position)")
            
            // print("Candy Category Raw: \(PhysicsCategory.candy.rawValue)")
            
            // print("Candy Category: \(newCandy.physicsBody?.categoryBitMask)")
            
            addChild(newCandy)
            ToysToPickUp.append(newCandy)
            
        }
        
    }
    
    
    func CreateCandy (counter: Int) {
        
       //var counter
        for j in stride(from:1, through:counter, by: +1) {
            
           // print("*****Candy J = \(j)*****")
            
            spawnCandy(counter: counter)
            //run SKAction to limit spawnEnemy placement to 1x
            //run(SKAction.sequence([SKAction.run(spawnEnemy)]
                
               // )
                
           // )
        }
        
        print("Created Candy at thsse points: \(CandyPoints)")

       // let PointsObects: [String: [CGPoint]] = [ "points": CandyPoints]
        
        
    //NotificationCenter.default.post(name: Notification.Name(rawValue: "CreateRadarMap"), object: nil, userInfo: ["points":"\(CandyPoints)"])
   // NotificationCenter.default.post(name: Notification.Name(rawValue: "CreateRadarMap"), object: PointsObects, userInfo: ["message":"unhide"])
      
    }
    
    func CreateParents (counter: Int) {
        
        var parentArray = ["Dad","Mom"]
        
        var ParentImageNormal = UIImage()
        var ParentImageNormalOther = UIImage()
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(parentArray.count)))
        
        
        let ParentTexture = parentArray[randomIndex]
        let ParentSize = CGSize(width: 100, height: 100)
        
        
        
        if ParentTexture == "Dad" {
            ParentImageNormal = UIImage(named: "HeadJared.png")!
            ParentImageNormalOther = UIImage(named: "MomHeadTemp.png")!
            // momSpeed = momSpeed + (momSpeed * 0.2)
            
        } else {
            ParentImageNormal = UIImage(named: "MomHeadTemp.png")!
            ParentImageNormalOther = UIImage(named: "HeadJared.png")!
        }
        
       // print("Parent Texture: \(ParentTexture)")
        
        
        
        var parentCountTemp = 0
        //var counter
        for j in stride(from:1, through:counter, by: +1) {
            
            parentCountTemp += 1
            
           // print("*****Parent J = \(j)*****")
            
            //let newParent = SKSpriteNode()
            
            var newParentTexture = SKTexture()
            
            if parentCountTemp == 1 {
                newParentTexture = SKTexture(image: ParentImageNormalOther)
            } else {
                newParentTexture = SKTexture(image: ParentImageNormal)
            }
            
            let newParent = SKSpriteNode(texture: newParentTexture, color: UIColor.clear, size: ParentSize)
            
            
            let newX:CGFloat = 5851 //frame.size.width
            let newY:CGFloat = 7311 //frame.size.height
            
            newParent.position = CGPoint(x: newX * random2(min: 0, max: 1), y: newY * random2(min: 0, max: 1))
            newParent.name = "parent"
            addChild(newParent)
            
            newParent.physicsBody = SKPhysicsBody(texture: newParentTexture, size: ParentSize)
            
            newParent.physicsBody?.isDynamic = true
            newParent.physicsBody?.allowsRotation = false
            newParent.physicsBody?.pinned = false
            newParent.physicsBody?.affectedByGravity = false
            newParent.physicsBody?.categoryBitMask = PhysicsCategory.parent.rawValue
            newParent.physicsBody?.contactTestBitMask = 1
            newParent.physicsBody?.collisionBitMask = 4294967295
            newParent.physicsBody?.fieldBitMask = 4294967295
            
            newParent.userData = NSMutableDictionary()
            
            newParent.userData?.setValue(true, forKey: "parentCanTouchPlayer")
            //newParent.run(SKAction.move(to: CGPoint(x: newParent.position.x, y: 0 - newParent.size.height), duration: 3))
            
           // print("Parent Position: \(newParent.position)")
            //addChild(newParent)
            
            
            parents.append(newParent)
            
            //run SKAction to limit spawnEnemy placement to 1x
            //run(SKAction.sequence([SKAction.run(spawnEnemy)]
            
            // )
            
            // )
        }
        
        print("Parents Created")
        
        // run(SKAction.sequence([SKAction.run(parents)]))
        
    }
    
    
    func CreateFriendsStart(Character: String, counter: Int) {
        
        
        
        var CreateFriendsInfoArray = [FriendInfo]()
        
        let PackInfo = GetExpansionPackInfo()
        
        
       // print("Pack info: \(PackInfo)")
        
        
        DispatchQueue.main.async(execute: {
        
        
        for Packs in PackInfo {
            
            
            let PackUnlocked = Packs.unlocked
            let PackEnabled = Packs.enabled
            
            print("PACK \(Packs.name) enabled = \(PackEnabled)")
            
            if PackEnabled {
                
                for member in Packs.PackMembers {
                    print("adding member: \(member.name)")
                    CreateFriendsInfoArray.append(member)
                    
                }
                
                
                
                
            }
            
            
        }
            
            print("CreateFriendInfoArray: \(CreateFriendsInfoArray)")
        
        self.friendsInfoArray = CreateFriendsInfoArray
        
        
        
        DispatchQueue.main.async(execute: {
            
            self.CreateFriends(Character: Character, counter: counter, Friends: CreateFriendsInfoArray)
            
        })
        
        })
        
        
    }
    
    func CreateFriends (Character: String, counter: Int, Friends: [FriendInfo]) {
        
        /*
        var CreateFriendsInfoArray = [FriendInfo]()
        
        
        
        let PackInfo = GetExpansionPackInfo()
        
        
        for Packs in PackInfo {
            
            
           let PackUnlocked = Packs.unlocked
           let PackEnabled = Packs.enabled
            
            if PackEnabled {
                
                
                
                for member in Packs.PackMembers {
                    
                   CreateFriendsInfoArray.append(member)
                    
                }
                
            
            
                
            }
            
            
        }
        
        self.friendsInfoArray = CreateFriendsInfoArray
        
        */
        
        var friendsArray = ["Dad","Mom"]
        
        print("****FRIENDS: \(friends)")
        
        var friendsInfoArrayTemp = self.friendsInfoArray
        
        //self.friendsInfoArray = Friends
        
        var friendsImageNormal = UIImage()
        var friendsImageNormalOther = UIImage()
        
        
        //let randomIndex = Int(arc4random_uniform(UInt32(friendsInfoArrayTemp.count)))
        //let FriendTexture = friendsInfoArrayTemp[randomIndex]
        
        let FriendSize = CGSize(width: 90, height: 90)
        
        
        
        /*
         if FriendTexture == "Dad" {
         friendsImageNormal = UIImage(named: "DadHeadTemp.png")!
         friendsImageNormalOther = UIImage(named: "MomHeadTemp.png")!
         // momSpeed = momSpeed + (momSpeed * 0.2)
         
         } else {
         friendsImageNormal = UIImage(named: "MomHeadTemp.png")!
         friendsImageNormalOther = UIImage(named: "DadHeadTemp.png")!
         }
         */
        
        // print("Parent Texture: \(FriendTexture)")
        
        
        
        var friendCountTemp = 0
        
        
        //var counter
        for j in stride(from:1, through:counter, by: +1) {
            
            let randomIndex = Int(arc4random_uniform(UInt32(friendsInfoArrayTemp.count)))
            let theFriend = friendsInfoArrayTemp[randomIndex]
            
            
            friendsInfoArrayTemp.remove(at: randomIndex)
            
            
            //friendCountTemp += 1
            
            // print("*****Parent J = \(j)*****")
            
            var newFriendTexture = SKTexture(image: theFriend.image)
            
            
            
            let newFriend = SKSpriteNode(texture: newFriendTexture, color: UIColor.clear, size: FriendSize)
            
            
            let newX:CGFloat = 5851 //frame.size.width
            let newY:CGFloat = 7311 //frame.size.height
            
            newFriend.position = CGPoint(x: newX * random2(min: 0, max: 1), y: newY * random2(min: 0, max: 1))
            newFriend.name = "friend"
            
            newFriend.userData = NSMutableDictionary()
            
            addChild(newFriend)
            
            newFriend.userData?.setValue(theFriend.name, forKey: "friendName")
            newFriend.userData?.setValue(theFriend.speed, forKey: "friendSpeed")
            newFriend.userData?.setValue(theFriend.canTouchPlayer, forKey: "friendCanTouchPlayer")
            //newFriend.setValue(theFriend.name, forKey: "friendName")
            //newFriend.setValue(theFriend.speed, forKey: "friendSpeed")
            
            newFriend.physicsBody = SKPhysicsBody(texture: newFriendTexture, size: FriendSize)
            
            newFriend.physicsBody?.isDynamic = true
            newFriend.physicsBody?.allowsRotation = false
            newFriend.physicsBody?.pinned = false
            newFriend.physicsBody?.affectedByGravity = false
            newFriend.physicsBody?.categoryBitMask = PhysicsCategory.friend.rawValue
            newFriend.physicsBody?.contactTestBitMask = 1
            newFriend.physicsBody?.collisionBitMask = 4294967295
            newFriend.physicsBody?.fieldBitMask = 4294967295
            //newParent.run(SKAction.move(to: CGPoint(x: newParent.position.x, y: 0 - newParent.size.height), duration: 3))
            
            //  print("Parent Position: \(newFriend.position)")
            //addChild(newParent)
            
            
            //  print("new Friend info: \(newFriend.userData)")
            
            friends.append(newFriend)
            
            //run SKAction to limit spawnEnemy placement to 1x
            //run(SKAction.sequence([SKAction.run(spawnEnemy)]
            
            // )
            
            // )
        }
        
        print("Parents Created")
        
        // run(SKAction.sequence([SKAction.run(parents)]))
        
    }
    
    
    func CreateKids (Character: String, counter: Int) {
        
        var friendsArray = ["Dad","Mom"]
        
        var friendsInfoArrayTemp = self.friendsInfoArray
        
        var friendsImageNormal = UIImage()
        var friendsImageNormalOther = UIImage()
        
        
        //let randomIndex = Int(arc4random_uniform(UInt32(friendsInfoArrayTemp.count)))
        //let FriendTexture = friendsInfoArrayTemp[randomIndex]
        
        let FriendSize = CGSize(width: 90, height: 90)
        
        
        
        /*
        if FriendTexture == "Dad" {
            friendsImageNormal = UIImage(named: "DadHeadTemp.png")!
            friendsImageNormalOther = UIImage(named: "MomHeadTemp.png")!
           // momSpeed = momSpeed + (momSpeed * 0.2)
            
        } else {
            friendsImageNormal = UIImage(named: "MomHeadTemp.png")!
            friendsImageNormalOther = UIImage(named: "DadHeadTemp.png")!
        }
        */
        
       // print("Parent Texture: \(FriendTexture)")
        
        
        
        var friendCountTemp = 0
        
        
        //var counter
        for j in stride(from:1, through:counter, by: +1) {
            
            let randomIndex = Int(arc4random_uniform(UInt32(friendsInfoArrayTemp.count)))
            let theFriend = friendsInfoArrayTemp[randomIndex]
            
            
            friendsInfoArrayTemp.remove(at: randomIndex)
            
            
            //friendCountTemp += 1
            
           // print("*****Parent J = \(j)*****")
            
            var newFriendTexture = SKTexture(image: theFriend.image)
            
    
            
            let newFriend = SKSpriteNode(texture: newFriendTexture, color: UIColor.clear, size: FriendSize)
            
            
            let newX:CGFloat = 5851 //frame.size.width
            let newY:CGFloat = 7311 //frame.size.height
            
            newFriend.position = CGPoint(x: newX * random2(min: 0, max: 1), y: newY * random2(min: 0, max: 1))
            newFriend.name = "friend"
            
            newFriend.userData = NSMutableDictionary()
            
            addChild(newFriend)
            
            newFriend.userData?.setValue(theFriend.name, forKey: "friendName")
            newFriend.userData?.setValue(theFriend.speed, forKey: "friendSpeed")
            newFriend.userData?.setValue(theFriend.canTouchPlayer, forKey: "friendCanTouchPlayer")
            //newFriend.setValue(theFriend.name, forKey: "friendName")
            //newFriend.setValue(theFriend.speed, forKey: "friendSpeed")
            
            newFriend.physicsBody = SKPhysicsBody(texture: newFriendTexture, size: FriendSize)
                
            newFriend.physicsBody?.isDynamic = true
            newFriend.physicsBody?.allowsRotation = false
            newFriend.physicsBody?.pinned = false
            newFriend.physicsBody?.affectedByGravity = false
            newFriend.physicsBody?.categoryBitMask = PhysicsCategory.friend.rawValue
            newFriend.physicsBody?.contactTestBitMask = 1
            newFriend.physicsBody?.collisionBitMask = 4294967295
            newFriend.physicsBody?.fieldBitMask = 4294967295
            //newParent.run(SKAction.move(to: CGPoint(x: newParent.position.x, y: 0 - newParent.size.height), duration: 3))

          //  print("Parent Position: \(newFriend.position)")
            //addChild(newParent)
            
            
          //  print("new Friend info: \(newFriend.userData)")
            
            friends.append(newFriend)
           
            //run SKAction to limit spawnEnemy placement to 1x
            //run(SKAction.sequence([SKAction.run(spawnEnemy)]
            
            // )
            
            // )
        }
        
        print("Parents Created")
        
        // run(SKAction.sequence([SKAction.run(parents)]))
        
    }
    
    func PauseGame (_ notification:Notification) {
        
        AvoidContact = false
        
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        // print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        
        let NotificationMessage = jsonAlert["message"].stringValue
        
        let action = jsonAlert["action"].stringValue
        
        
        switch action {
            
            case "pause":
            scene?.view?.isPaused = true
            //scene?.view?.isUserInteractionEnabled = false
            
            case "play":
            scene?.view?.isPaused = false
            //scene?.view?.isUserInteractionEnabled = true
            
        default:
            break
        }
        
        
        
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
            
            /*
            if theButton.containsPoint(touchLocation) {
                print("button tapped!")
            }
            */

        }
        
       
        
    }
    
    
    // MARK - Updates
    
    override func didSimulatePhysics() {
        
        
        
        if let _ = player {
            updatePlayer()
            
            
            
            if !ViewingMessage {
                
                if GameType == "kid" {
                
            //player type is kid
            updateZombies()
            updateToys()
            updateCandies()
            updateMom()
            updateFriends()
                    
                } else {
                    
            //player type is parent
            updateKids()
                    
                    
                }
                
            }
        }
    }
    
    // Determines if the player's position should be updated
    fileprivate func shouldMove(currentPosition: CGPoint, touchPosition: CGPoint) -> Bool {
        return abs(currentPosition.x - touchPosition.x) > player!.frame.width / 2 ||
            abs(currentPosition.y - touchPosition.y) > player!.frame.height/2
    }
    
    func pauseGameAction()
    {
        scene?.view?.isPaused = true
    }
    
    // Updates the player's position by moving towards the last touch made
    func updatePlayer() {
        
        if AvoidContact {
            
            /*
            if let touch = lastTouch {
            print("Updating Player, but player is avoiding contact, Oppposite Direction??")
            
           // player!.physicsBody!.isResting = true
            
            
            
            
            let currentPosition = player!.position
            if shouldMove(currentPosition: currentPosition, touchPosition: touch) {
                
                let angle = atan2(currentPosition.y + touch.y, currentPosition.x + touch.x) + CGFloat(M_PI)
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
            */
            
            
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
            
        } else {
        
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
    }
    
    func updateCamera() {
        if let camera = camera {
            // print("updating camera")
           // camera
            
            
            /*
            if candyCountInt == 1 {
            let amplitudeX:Float = 10;
            let amplitudeY:Float = 6;
             var actionsArray:[SKAction] = [];
            
            
            let moveX = Float(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2;
            let moveY = Float(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2;
            let shakeAction = SKAction.moveBy(x: CGFloat(moveX), y: CGFloat(moveY), duration: 0.02);
            shakeAction.timingMode = SKActionTimingMode.easeOut;
            actionsArray.append(shakeAction);
           
            
            let actionSeq = SKAction.sequence(actionsArray);
            //layer.runAction(actionSeq);
            camera.run(actionSeq)
            
            }
            
            */
            
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
    
    func updateCandies() {
        //print("Updating Toys")
        
        let targetPosition = player!.position
        
        for candy in candies {
            let currentPosition = candy.position
            
            
            
        }
        
        
    }
    
    // Updates the position of all zombies by moving towards the player
    
    
    func updateKids() {
        
        
        var targetPosition = player!.position
        
        let CurrentCandyCount = UserDefaults.standard.integer(forKey: "CurrentCandyCount")
        
        if CurrentCandyCount > 0 {
            
            for friend in friends {
                
                
                
                if friend.userData?.value(forKey: "resetTime") != nil {
                    
                    
                    let resetTimeTemp = friend.userData?.value(forKey: "resetTime") as! CFAbsoluteTime
                    
                    
                    let elapsed = CFAbsoluteTimeGetCurrent() - resetTimeTemp
                    
                    //  print("ELAPSED TIME = \(elapsed)")
                    
                    if elapsed < 50 {
                        
                        friend.userData?.setValue(false, forKey: "friendCanTouchPlayer")
                        
                        // print("\(friend.userData?.value(forKey: "friendName")) should be AWAY from the player")
                        
                        targetPosition = CGPoint(x: friend.position.x - 50, y: friend.position.y + 50)
                        
                        
                    } else {
                        
                        targetPosition = player!.position
                        //  print("\(friend.userData?.value(forKey: "friendName")) should be TO the player")
                        
                    }
                    
                } else {
                    
                    friend.userData?.setValue(true, forKey: "friendCanTouchPlayer")
                }
                
                
                
                
                let currentPosition = friend.position
                
                let angle = atan2(currentPosition.y - targetPosition.y, currentPosition.x - targetPosition.x) + CGFloat(M_PI)
                let rotateAction = SKAction.rotate(toAngle: angle + CGFloat(M_PI*0.5), duration: 0.0)
                friend.run(rotateAction)
                
                
                var friendSpeed = CGFloat()
                
                //if friend.userData?
                
                // print("Friend Info: \(friend.userData)")
                
                switch friend.userData?.value(forKey: "friendName") as! String {
                    
                case "Ember":
                    //print("it's ember")
                    friendSpeed = (friend.userData?.value(forKey: "friendSpeed") as! CGFloat)
                    
                case "Ben":
                    //print("it's ben")
                    //friendSpeed = (friend.value(forKey: "friendSpeed") as! CGFloat)
                    friendSpeed = (friend.userData?.value(forKey: "friendSpeed") as! CGFloat)
                    
                case "Lilly":
                    
                    //print("it's Lilly")
                    // friendSpeed = (friend.value(forKey: "friendSpeed") as! CGFloat)
                    friendSpeed = (friend.userData?.value(forKey: "friendSpeed") as! CGFloat)
                    
                default:
                    friendSpeed = (friend.userData?.value(forKey: "friendSpeed") as! CGFloat)
                }
                
                
                
                let velocityX = friendSpeed * cos(angle)
                let velocityY = friendSpeed * sin(angle)
                
                
                
                let newVelocity = CGVector(dx: velocityX, dy: velocityY)
                friend.physicsBody!.velocity = newVelocity;
            }
            
        }
    }
    
    
    func updateFriends() {
        
        var targetPosition = player!.position
        
        let CurrentCandyCount = UserDefaults.standard.integer(forKey: "CurrentCandyCount")
        
        if CurrentCandyCount > 0 {
        
        for friend in friends {
            
            
            
            if friend.userData?.value(forKey: "resetTime") != nil {
                
                
            let resetTimeTemp = friend.userData?.value(forKey: "resetTime") as! CFAbsoluteTime
            
            
            let elapsed = CFAbsoluteTimeGetCurrent() - resetTimeTemp
                
              //  print("ELAPSED TIME = \(elapsed)")
                
            if elapsed < 50 {
                
                friend.userData?.setValue(false, forKey: "friendCanTouchPlayer")
                
               // print("\(friend.userData?.value(forKey: "friendName")) should be AWAY from the player")
                    
                targetPosition = CGPoint(x: friend.position.x - 50, y: friend.position.y + 50)
                
                
            } else {
               
                targetPosition = player!.position
              //  print("\(friend.userData?.value(forKey: "friendName")) should be TO the player")
                
            }
            
            } else {
                
                friend.userData?.setValue(true, forKey: "friendCanTouchPlayer")
            }
            
            
                
            
            let currentPosition = friend.position
            
            let angle = atan2(currentPosition.y - targetPosition.y, currentPosition.x - targetPosition.x) + CGFloat(M_PI)
            let rotateAction = SKAction.rotate(toAngle: angle + CGFloat(M_PI*0.5), duration: 0.0)
            friend.run(rotateAction)
            
            
            var friendSpeed = CGFloat()
            
            //if friend.userData?
            
           // print("Friend Info: \(friend.userData)")
            
            switch friend.userData?.value(forKey: "friendName") as! String {
                
                case "Ember":
                //print("it's ember")
                friendSpeed = (friend.userData?.value(forKey: "friendSpeed") as! CGFloat)
                
                case "Ben":
                //print("it's ben")
                //friendSpeed = (friend.value(forKey: "friendSpeed") as! CGFloat)
                friendSpeed = (friend.userData?.value(forKey: "friendSpeed") as! CGFloat)
                
                case "Lilly":
                    
                //print("it's Lilly")
               // friendSpeed = (friend.value(forKey: "friendSpeed") as! CGFloat)
                friendSpeed = (friend.userData?.value(forKey: "friendSpeed") as! CGFloat)
                
            default:
                friendSpeed = (friend.userData?.value(forKey: "friendSpeed") as! CGFloat)
            }
            
            
            
            let velocityX = friendSpeed * cos(angle)
            let velocityY = friendSpeed * sin(angle)
            
           
            
            let newVelocity = CGVector(dx: velocityX, dy: velocityY)
            friend.physicsBody!.velocity = newVelocity;
        }
        
      }
    }
    
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
    
    func updateMom() {
        let targetPosition = player!.position
        
        
       // let randomPosition = player!.position
        
        
        
        let CurrentCandyCount = UserDefaults.standard.integer(forKey: "CurrentCandyCount")
        
         if CurrentCandyCount > 0 {
        
        for theMom in parents {
            let currentPosition = theMom.position
            
            let MomDistance = targetPosition.distance(point: currentPosition)
            
           // print("Mom is \(MomDistance) away!!!")
            
            if MomDistance < 500 {
                ParentsMoving = true
            }

            
            if ParentsMoving  {
            
            let angle = atan2(currentPosition.y - targetPosition.y, currentPosition.x - targetPosition.x) + CGFloat(M_PI)
            let rotateAction = SKAction.rotate(toAngle: angle + CGFloat(M_PI*0.5), duration: 0.0)
            theMom.run(rotateAction)
            
            let velocotyX = momSpeed * cos(angle)
            let velocityY = momSpeed * sin(angle)
            
            let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
            theMom.physicsBody!.velocity = newVelocity;
                
                
                
            } else {
                
                /*
                
                let currentPosition = theMom.position
                
                let rPosition = CGPoint(x: frame.size.width * random2(min: 0, max: 1), y: frame.size.height * random2(min: 0, max: 1))
                

                
                let angle = atan2(currentPosition.y - rPosition.y, currentPosition.x - rPosition.x) + CGFloat(M_PI)
                let rotateAction = SKAction.rotate(toAngle: angle + CGFloat(M_PI*0.5), duration: 0.0)
                theMom.run(rotateAction)
                
                let velocotyX = momSpeedSlow * cos(angle)
                let velocityY = momSpeedSlow * sin(angle)
                
                let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
                theMom.physicsBody!.velocity = newVelocity;
                
                */
                
                
            }
            
            
            
           }
            
         } else {
            
            /*
            
            for theMom in parents {
                let currentPosition = theMom.position
                
                let rPosition = CGPoint(x: frame.size.width * random2(min: 0, max: 1), y: frame.size.height * random2(min: 0, max: 1))
               // print("Current Position: \(currentPosition)")
               // print("Random Position: \(rPosition)")
                
                //child.position =
                
               // let MomDistance = targetPosition.distance(point: currentPosition)
                
                // print("Mom is \(MomDistance) away!!!")
                
                
              //  if MomDistance < 200 {
                    
                    let angle = atan2(currentPosition.y - rPosition.y, currentPosition.x - rPosition.x) + CGFloat(M_PI)
                    let rotateAction = SKAction.rotate(toAngle: angle + CGFloat(M_PI*0.5), duration: 0.0)
                    theMom.run(rotateAction)
                    
                    let velocotyX = momSpeedSlow * cos(angle)
                    let velocityY = momSpeedSlow * sin(angle)
                    
                    let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
                    //print("NewVelocity: \(newVelocity)")
                   // print("The Mom Name: \(theMom.name)")
                
                    theMom.physicsBody!.velocity = newVelocity;
                    
              //  }
                
            }
            
            
         */
        }
        
        
    }
    
    
    
    
    
    
    // MARK: - SKPhysicsContactDelegate
    
    func handleCandyContact(player: SKNode, candy: SKNode) {
        
        
        
        
        print("Handling player candy contact")
        
        
        //print("Candy Position: \(candy.position)")
        
        
        
        
        
        if CanCollectCandy {
            
          //  print("Handling player candy contact and CAN collect Candy")
            
            CanCollectCandy = false
            
            let currentPosition = player.position
            
            let candyDistance = candy.position.distance(point: currentPosition)
            
            
            if candyDistance < 70 {
                
              //  print("Candy Distance: \(candyDistance)")
                
                CandiesFound.append(candy as! SKSpriteNode)
                
                
                print("CandyPoints Count - BEFORE: \(CandyPoints.count)")
               // CandyPoints
                
                var i: Int = 0
                
                for cpoint in CandyPoints {
                    
                    if cpoint == candy.position {
                      print("Candy found in CandyPoints Array at index \(i)")
                        CandyPoints.remove(at: i)
                    }
                    i += 1
                }
                
                
                print("CandyPoints Count - AFTER: \(CandyPoints.count)")
                
                /*
                
                if CandyPoints.contains({$0.name == "foo"}) {
                    // it exists, do something
                } else {
                    // item not found
                }
                */
                
                
                candy.removeFromParent()
                
                
                let candyCountIntNow = UserDefaults.standard.integer(forKey: "CurrentCandyCount")
              //  print("From Game, Current Candy Count: \(candyCountIntNow)")
                
                //UserDefaults.standard.set(FinalCandy, forKey: "CurrentCandyCount")
                
                let soundToPlay = "PopSound.wav"
                self.run(SKAction.playSoundFileNamed(soundToPlay, waitForCompletion: false))
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"You picked up some candy!","candyCount":"1","messageType":"Not Ok"])
                
                //self.NotPickingUpCandy = false
                
                
                if HasMap {
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        
                        
                        let PointsObects: [String: [CGPoint]] = [ "points": self.CandyPoints]
                        
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "CreateRadarMap"), object: PointsObects, userInfo: ["message":"unhide"])
                        
                    })
                    
                }
                
                
            }
            
            DispatchQueue.main.async(execute: {
                
                self.CanCollectCandy = true
                
            })
            
        }
        
        
        
        ViewingMessage = false
        // print("Candy Distance: \(candyDistance)")
        
        // candy.removeFromParent()
        
    }
    
    func handleBoxContact(player: SKNode, box: SKNode) {
        
        let candyCountIntNow = UserDefaults.standard.integer(forKey: "CurrentCandyCount")
        
        if candyCountIntNow > 0 {
            
            CanDropCandy = true
            
        } else {
            
            CanDropCandy = false
            
        }
        
        
        
        
        print("Handling player BOX contact")
        
        
       // scene?.view?.isPaused = true
        
        AvoidContact = true
        
        //print("Candy Position: \(candy.position)")
        
        if CanDropCandy {
            
            print("Handling player candy contact and CAN collect Candy")
            
            CanDropCandy = false
            
            let currentPosition = player.position
            
            let boxDistance = box.position.distance(point: currentPosition)
            
            
            if boxDistance < 70 {
                
                
                if candyCountIntNow == candyCountInt {
                    
                    
                    gameOver(true, level: levelSelected, character: charactername)
                    
                    
                    
                } else {
                    
                    scene?.view?.isPaused = true
                    
                    // print("box Distance: \(boxDistance)")
                    
                    //CandiesFound.append(box as! SKSpriteNode)
                    
                    //box.removeFromParent()
                    
                    
                    
                    
                    
                    
                    // print("From Game, Current Candy Count: \(candyCountIntNow)")
                    
                    prefs.set(candyCountIntNow, forKey: "CurrentHiddenCount")
                    
                    prefs.set(0, forKey: "CurrentCandyCount")
                    
                    
                    //UserDefaults.standard.set(FinalCandy, forKey: "CurrentCandyCount")
                    
                    
                    
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "HideCandy"), object: nil, userInfo: ["message":"You have hidden your candy!","levelCandyCount":"\(candyCountIntNow)","levelHiddenCandyCount":"\(candyCountIntNow)","messageType":"Ok"])
                    
                   self.CanDropCandy = false
 
                    //self.NotPickingUpCandy = false
                    
                }
                
            }
            
            DispatchQueue.main.async(execute: {
                
               // self.CanDropCandy = true
                self.CanDropCandy = false
                //self.scene?.view?.isPaused = false
                
            })
            
        } else {
            
            
            
            /*
            let theAlert = SCLAlertView()
            
            theAlert.addButton("Ok") {
            }
            
            /*
             theAlert.addButton("No") {
             }
             */
            
            let NotificationMessage = "You don't have any candy to hide.  You need to go get some"
            
            // theAlert.showCustomOK(MessageImage, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "Message", subTitle: "\(NotificationMessage)", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            //showAlert(title: "Message", message: NotificationMessage)
            
            // SweetAlert().showAlert(NotificationMessage)
            
            print("Would display alert HERE")
            
            //NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"You don't have any candy to hide.  You need to go get some","candyCount":"0","messageType":"Ok"])
            
            CreateMessageBox(message: "Tap Me")
            
            */
            
            
        }
        
        
        ViewingMessage = false
        // print("Candy Distance: \(candyDistance)")
        
        // candy.removeFromParent()
        
    }
    
    func handleMapContact(player: SKNode, map: SKNode) {
        
     
        
        
        
        
        print("Handling player MAP contact")
        
        
       // scene?.view?.isPaused = true
        //AvoidContact = true
        
        if !HasMap {
            
            print("Handling player candy contact and CAN collect Candy")
            
            CanDropCandy = false
            
            let currentPosition = player.position
            
            let mapDistance = map.position.distance(point: currentPosition)
            
            
            if mapDistance < 70 {
                
                
                
              self.HasMap = true
                
                map.removeFromParent()
            
            }
            
            DispatchQueue.main.async(execute: {
                
                
                
                let PointsObects: [String: [CGPoint]] = [ "points": self.CandyPoints]
                
                
                //NotificationCenter.default.post(name: Notification.Name(rawValue: "CreateRadarMap"), object: nil, userInfo: ["points":"\(CandyPoints)"])
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "CreateRadarMap"), object: PointsObects, userInfo: ["message":"unhide"])
                
               // NotificationCenter.default.post(name: Notification.Name(rawValue: "CreateRadarMap"), object: PointsObects, userInfo: ["message":"NA"])
                
                //self.CanDropCandy = true
                //self.scene?.view?.isPaused = false
                
                //let soundToPlay = "ImTheMap.wav"
                //self.run(SKAction.playSoundFileNamed(soundToPlay, waitForCompletion: false))
                
            })
            
        } else {
            
    
            
        }
        
        
      // ViewingMessage = false
       
        
    }
    
    func handleFriendContact(player: SKNode, friend: SKNode) {
        
        
        //let elapsed = Date().timeIntervalSince(timeAtPress)
        
        let currentTime = CFAbsoluteTimeGetCurrent()
        
        print("CURRENT TIME = \(currentTime)")
        
        AvoidContact = true
        
         let candyCountIntNow = UserDefaults.standard.integer(forKey: "CurrentCandyCount")
        
        if candyCountIntNow > 0 {
            
            CanDropCandy = true
            
        } else {
            
            CanDropCandy = false
            
        }
        
        let theFriendName = friend.userData?.value(forKey: "friendName") as! String
        
        friend.userData?.setValue(currentTime, forKey: "resetTime")
        
        let CanTouchPlayer = friend.userData?.value(forKey: "friendCanTouchPlayer") as! Bool
        
        
        
        if CanTouchPlayer {
        
        //print("Handling player FRIEND contact")

       if CanDropCandy {
        
         //print("Handling player Friend contact and CAN collect Candy")
         
        CanDropCandy = false
        
        let currentPosition = player.position
        
        let friendDistance = friend.position.distance(point: currentPosition)
        
        
        if friendDistance < 70 {
            
            scene?.view?.isPaused = true
            
            print("friend Distance: \(friendDistance)")
            
            //CandiesFound.append(box as! SKSpriteNode)
            
            //box.removeFromParent()
            
            
           
           // print("From Game, Current Candy Count: \(candyCountIntNow)")
            
           // prefs.set(candyCountIntNow, forKey: "CurrentHiddenCount")
            
           // prefs.set(0, forKey: "CurrentCandyCount")
            
            let randomIndex = Int(arc4random_uniform(UInt32(myResponseArray.count)))
            
            let myResponse = myResponseArray[randomIndex]

            
            
            
            print("The Friend Name: \(theFriendName)")
            //UserDefaults.standard.set(FinalCandy, forKey: "CurrentCandyCount")
            
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "FriendContact"), object: nil, userInfo: ["message":"Can I have some candy please? -\(theFriendName)","levelCandyCount":"\(candyCountIntNow)","levelHiddenCandyCount":"\(candyCountIntNow)","messageType":"Ok","action":"share","response":"\(myResponse)"])
                    
                    //self.NotPickingUpCandy = false
                    
                }
        
        DispatchQueue.main.async(execute: {
            
           self.CanDropCandy = true
            
           // self.scene?.view?.isPaused = false
            
        })
        
       } else {
        
        
        
        let theAlert = SCLAlertView()
        
        theAlert.addButton("Ok") {
            
        }
        
        /*
         theAlert.addButton("No") {
         }
         */
        
      //  let friendlyMessage = "You don't have any candy to hide.  You need to go get some"
        
        let randomIndex = Int(arc4random_uniform(UInt32(friendlyMessageArray.count)))
        
        let friendlyMessage = friendlyMessageArray[randomIndex]
        
        let randomIndexResponse = Int(arc4random_uniform(UInt32(myResponseArray.count)))
        
        let myResponse = myResponseArray[randomIndexResponse]
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "FriendContact"), object: nil, userInfo: ["message":"\(friendlyMessage) -\(theFriendName)","levelCandyCount":"\(candyCountIntNow)","levelHiddenCandyCount":"\(candyCountIntNow)","messageType":"Ok","action":"na","response":"\(myResponse)"])
        
       // theAlert.showCustomOK(MessageImage, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "Message", subTitle: "\(NotificationMessage)", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        //showAlert(title: "Message", message: NotificationMessage)
        
       // SweetAlert().showAlert(NotificationMessage)
        
       // print("Would display alert HERE")
        
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"You don't have any candy to hide.  You need to go get some","candyCount":"0","messageType":"Ok"])
        
       // CreateMessageBox(message: "Tap Me")
        
        
        }
        
    }
    
        
        ViewingMessage = false
       // print("Candy Distance: \(candyDistance)")
        
       // candy.removeFromParent()
        
    }
    
    func handleParentContact(player: SKNode, parent: SKNode) {
        
        print("Handling player parent contact")
        
        
        
       // print("Candy Position: \(parent.position)")
        
        
        
        let currentPosition = player.position
        
        let parentDistance = parent.position.distance(point: currentPosition)
        
        
        
        let CurrentCandyCount = UserDefaults.standard.integer(forKey: "CurrentCandyCount")
        
        if CurrentCandyCount > 0 {
            
          //  NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"I didn't say you could have candy...go to your Room!","candyCount":"0","messageType":"Ok"])
            
            gameOver(false, level: levelSelected, character: charactername)
            
        } else {
            
            //scene?.view?.isPaused = true
            
           // var CanTouchPlayer = Bool()
            
            let CanTouchPlayer = parent.userData?.value(forKey: "parentCanTouchPlayer") as! Bool
            
            /*
            if (parent.userData?.value(forKey: "parentCanTouchPlayer") as! Bool) != nil {
                CanTouchPlayer = false
            } else {
                
            }
            */
            
            parent.userData?.setValue(false, forKey: "parentCanTouchPlayer")
            
            if CanTouchPlayer {
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"Oh hello there, good to see you","candyCount":"0","messageType":"Ok"])
                
                
                
            }
            
            
        }
        
        
        //print("Parent Distance: \(parentDistance)")
        
    ViewingMessage = false
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if GameType == "kid" {
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateParentSpeed"), object: nil, userInfo: ["message":"NA","newSpeed":"\(momSpeed)","maxSpeed":"\(momSpeedMax)"])
        
      //  NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateParentSpeed"), object: nil, userInfo: ["message":"NA","newSpeed":"80","maxSpeed":"155"])
        
        
        // Step 1. To find out what kind of contact we have,
        // construct a value representing the union of the bodies' categories
        // (same as the bitwise OR of the raw values)
        let contactCategory: PhysicsCategory = [contact.bodyA.category, contact.bodyB.category]
        
      //  print("CONTACT CATEGORY: \(contactCategory)")
        
        /*
        
        print("Contact Body A Category: \(contact.bodyA.categoryBitMask)")
        print("Contact Body B Category: \(contact.bodyB.categoryBitMask)")
        
        print("Contact Body A Test Category: \(contact.bodyA.category)")
        print("Contact Body B Test Category: \(contact.bodyB.category)")
        
        print("Contact Body A Contact Test: \(contact.bodyA.contactTestBitMask)")
        print("Contact Body B Contact Test: \(contact.bodyB.contactTestBitMask)")

        
        print("Contact Body A Field Bit: \(contact.bodyA.fieldBitMask)")
        print("Contact Body B Field Bit: \(contact.bodyB.fieldBitMask)")
        
        print("Contact Body A Name: \(contact.bodyA.node?.name)")
        print("Contact Body B Name: \(contact.bodyB.node?.name)")
        
        */
        
        if contactCategory.contains([.player, .candy]) {
            // Step 2: We know it's an enemy/bullet contact, so there are only
            // two possible arrangements for which body is which:
            
          //  print("Contains: \(.player) and \(.candy)" as Any)
            
            
            
            if contact.bodyA.category == .player {
                print("Contact Body A is the Player")
                print("Contact Body A Name: \(contact.bodyA.node?.name)")
                print("Contact Body B Name: \(contact.bodyB.node?.name)")
                
                if contact.bodyB.category == .candy {
                
                    ViewingMessage = true
                self.handleCandyContact(player: contact.bodyA.node!, candy: contact.bodyB.node!)
                
                } else if contact.bodyB.category == .box {
                    
                    ViewingMessage = true
                    self.handleBoxContact(player: contact.bodyA.node!, box: contact.bodyB.node!)
                    
                } else if contact.bodyB.category == .parent {
                    
                    ViewingMessage = true
                    self.handleParentContact(player: contact.bodyA.node!, parent: contact.bodyB.node!)
                    
                } else if contact.bodyB.category == .friend {
                    
                    ViewingMessage = true
                    self.handleFriendContact(player: contact.bodyA.node!, friend: contact.bodyB.node!)
                    
                } else if contact.bodyB.category == .map {
                    
                    ViewingMessage = true
                    
                    if contact.bodyB.node?.name != nil {
                        
                    self.handleMapContact(player: contact.bodyA.node!, map: contact.bodyB.node!)
                        
                    }
                    
                } else {
                    
                    
                    
                }
                
                
                
            } else if contact.bodyB.category == .player {
                print("Contact Body B is the Player")
                print("Contact Body A Name: \(contact.bodyA.node?.name)")
                print("Contact Body B Name: \(contact.bodyB.node?.name)")
                
                if contact.bodyA.category == .candy {
                    
                    ViewingMessage = true
                self.handleCandyContact(player: contact.bodyB.node!, candy: contact.bodyA.node!)
            
                }
                
                if contact.bodyA.category == .box {
                    
                    ViewingMessage = true
                    self.handleBoxContact(player: contact.bodyB.node!, box: contact.bodyA.node!)
  
                }
                
                if contact.bodyA.category == .parent {
                    
                    ViewingMessage = true
                    self.handleParentContact(player: contact.bodyB.node!, parent: contact.bodyA.node!)
                    
                }
                
                if contact.bodyA.category == .friend {
                    
                    ViewingMessage = true
                    self.handleFriendContact(player: contact.bodyB.node!, friend: contact.bodyA.node!)
                    
                }
                
                if contact.bodyA.category == .map {
                    
                    ViewingMessage = true
                    self.handleMapContact(player: contact.bodyB.node!, map: contact.bodyA.node!)
                    
                }
                
                
            } else {
                
            }
        } else if contactCategory.contains([.player, .parent]) {
            // Here we don't care which body is which, so no need to disambiguate.
            if contact.bodyA.category == .player {
                self.handleParentContact(player: contact.bodyA.node!, parent: contact.bodyB.node!)
            } else if contact.bodyB.category == .player {
                self.handleParentContact(player: contact.bodyB.node!, parent: contact.bodyA.node!)
            } else {
               // print("Player Not Involved in collision")
                //self.handleParentContact(player: contact.bodyB.node!, parent: contact.bodyA.node!)
            }
            
        } else if contactCategory.contains([.player, .box]) {
            // Here we don't care which body is which, so no need to disambiguate.
            if contact.bodyA.category == .player {
                self.handleBoxContact(player: contact.bodyA.node!, box: contact.bodyB.node!)
            } else if contact.bodyB.category == .player {
                self.handleBoxContact(player: contact.bodyB.node!, box: contact.bodyA.node!)
            } else {
               // print("Player Not Involved in collision")
                //self.handleParentContact(player: contact.bodyB.node!, parent: contact.bodyA.node!)
            }
            
        } else {
            // The compiler doesn't know about which possible
            // contactCategory values we consider valid, so
            // we need a default case to avoid compile error.
            // Use this as a debugging aid:
          //  preconditionFailure("Unexpected collision type: \(contactCategory)")
        }
            
        } else {
            
            
            
        }
    }
    
    
    /*
    
    func didBegin(_ contact: SKPhysicsContact) {
        // 1. Create local variables for two physics bodies
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        var playerBody: SKPhysicsBody
        
        
        
        var toy : SKNode? = nil
        var candy: SKNode? = nil
        
        print("Did Begin Contact A: \(contact.bodyA.categoryBitMask)")
        print("Did Begin Contact B: \(contact.bodyB.categoryBitMask)")
        
        print("Did Begin Contact A Name: \(contact.bodyA.node?.name)")
        print("Did Begin Contact B Name: \(contact.bodyB.node?.name)")
        
      //  print("Contact A Name = \(contact.bodyA.node?.name)")
      //  print("Contact B Name = \(contact.bodyB.node?.name)")
        // 2. Assign the two physics bodies so that the one with the lower category is always stored in firstBody
        /*
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        } else {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        */
        
        var UserTouching = Bool()
        var itemTouching = String()
        var NodeNum = Int()
        
       (UserTouching, itemTouching, NodeNum) = IsPlayerTouchingItem(contact: contact)
        
        
        if UserTouching {
            
            switch itemTouching {
                
                case "toy":
                print("is touching a toy")
                toy?.run(SKAction.playSoundFileNamed("EatingCandy.m4a",waitForCompletion:false));
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"You picked up a toy!","candyCount":"0"])
                
                if NodeNum == 1 {
                 toy = contact.bodyA.node
                } else {
                 toy = contact.bodyB.node
                }
                
                 toy?.removeFromParent()
                
                
                case "candy":
                    if NodeNum == 1 {
                        candy = contact.bodyA.node
                    } else {
                        candy = contact.bodyB.node
                    }
                    CandiesFound.append(candy as! SKSpriteNode)
                    
                    candy?.removeFromParent()
                  
                    
                    print("You picked up some candy!")
                    
                    CandyCount += 1
                    
                    //print("Candy Count: \(CandyCount)")
                    
                    DispatchQueue.main.async(execute: {
                        
                        //self.NotPickingUpCandy = true
                        
                        self.PickingUpCandy = self.prefs.bool(forKey: "NotPickingUpCandy")
                        
                        if !self.PickingUpCandy {
                            
                            print("OK TO PICK UP SOME CANDY!!!")
                            
                        self.prefs.set(true, forKey: "NotPickingUpCandy")
                        
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"You picked up some candy!","candyCount":"1","messageType":"Not Ok"])
                            
                          //self.NotPickingUpCandy = false
                            
                        } else {
                            
                            
                            print("CANT PICK UP CANDY!!!")
                        }
                       
                    })
                
                
                case "parent":
                    
                    
                    let CurrentCandyCount = UserDefaults.standard.integer(forKey: "CurrentCandyCount")
                    
                    if CurrentCandyCount > 0 {
                    
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"I didn't say you could have candy...go to your Room!","candyCount":"0","messageType":"Ok"])
                    
                    gameOver(false)
                        
                    } else {
                        
                     
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"Oh hello there, good to see you","candyCount":"0","messageType":"Ok"])
                        
                  }
                
                
            default:
                break
                
            }
            
            print("player is touching item: \(itemTouching)")
            
        }
        
        /*
        if contact.bodyA.categoryBitMask == 999 {
            playerBody = contact.bodyA
        }
        
        if contact.bodyB.categoryBitMask == 999 {
            playerBody = contact.bodyB
        }
        
        
        
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
 
        
        
        
        if firstBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == 4 {
            // Player & Goal
            
            
            
            print("Option 1: Youre touching a toy!")
            
            
        }
        
        if secondBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
            firstBody.categoryBitMask == 4 {
            // Player & Goal
            
            print("Option 2: Youre touching a toy!")
            
           
        }
        
        
        
        
        
        
        
        if firstBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == toys[0].physicsBody?.categoryBitMask {
            // Player & Zombie
            toy = secondBody.node
            print("You picked up a toy!")
            
            
            toy?.run(SKAction.playSoundFileNamed("EatingCandy.m4a",waitForCompletion:false));
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"You picked up a toy!"])
            
            // gameOver(false)
        } else if secondBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
            firstBody.categoryBitMask == toys[0].physicsBody?.categoryBitMask {
            // Player & Zombie
            toy = secondBody.node
            print("You picked up a toy!")
            
            
            toy?.run(SKAction.playSoundFileNamed("EatingCandy.m4a",waitForCompletion:false));
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"You picked up a toy!"])
            
            // gameOver(false)
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
            
            
            toy?.run(SKAction.playSoundFileNamed("EatingCandy.m4a",waitForCompletion:false));
            
             NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"You picked up a toy!"])
            
            // gameOver(false)
        } else if firstBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == candies[0].physicsBody?.categoryBitMask {
            // Player & Zombie
            candy = secondBody.node
            CandiesFound.append(candy as! SKSpriteNode)
            print("You picked up some candy!")
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"You picked up some candy!"])
            
            // gameOver(false)
        } else if firstBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == mom[0].physicsBody?.categoryBitMask {
            // Player & Zombie
            toy = secondBody.node
            print("You picked up some candy!")
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "GameMessage"), object: nil, userInfo: ["message":"Go to your Room!"])
            
             gameOver(false)
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
        
        */
        
        toy?.removeFromParent()
        candy?.removeFromParent()
        
    }
    
    */
    
    
    // MARK: Helper Functions
    
    fileprivate func gameOver(_ didWin: Bool, level: String, character: String) {
        print("- - - Game Ended - - -")
        
        
        var HighestLevelTemp = String()
        var soundToPlay: String?
        
        if didWin && level == "50" {
            prefs.set("all", forKey: "PlayingGroup")
        }
        
        switch character {
            case "tripp":
            print("tripp game over")
            
            if didWin {
                print("Level \(level) Complete")
                soundToPlay = "CrunchingSound.wav"
                //self.run(SKAction.playSoundFileNamed(soundToPlay!, waitForCompletion: false))
                
            } else {
                print("Level \(level) Failed")
                soundToPlay = "Dad_GoToYourRoom.wav"
                //self.run(SKAction.playSoundFileNamed(soundToPlay!, waitForCompletion: false))
            }
            
            
            print("Should be levelCompleteInfo: \(character)Level\(level)Complete")
            prefs.set(true, forKey: "\(character)Level\(level)Complete")
            
            
            
            if prefs.value(forKey: "\(character)HighestLevelComplete") == nil {
                HighestLevelTemp = "0"
            } else {
                HighestLevelTemp = prefs.value(forKey: "\(character)HighestLevelComplete") as! String
            }
            let HighestLevel = Int(HighestLevelTemp)!
            let levelInt = Int(level)!
            if levelInt > HighestLevel {
                prefs.set(level, forKey: "\(character)HighestLevelComplete")
            }
            
         
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "LevelClose"), object: nil, userInfo: ["message":"NA","level":"\(level)","character":"\(character)","didWin":"\(didWin)"])
            
         
            if didWin {
                soundToPlay = "CrunchingSound.wav"
                self.run(SKAction.playSoundFileNamed(soundToPlay!, waitForCompletion: false))
            } else {
                soundToPlay = "Dad_GoToYourRoom.wav"
                self.run(SKAction.playSoundFileNamed(soundToPlay!, waitForCompletion: false))
            }
            
            /*
            let menuScene = MenuScene(size: self.size)
            menuScene.soundToPlay = didWin ? "fear_win.mp3" : "Dad_GoToYourRoom.m4a"
            
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            menuScene.scaleMode = SKSceneScaleMode.aspectFill
            self.scene!.view?.presentScene(menuScene, transition: transition)
            */
            
            case "piper":
            print("piper game over")
            
            if didWin {
                print("Level \(level) Complete")
            } else {
                print("Level \(level) Failed")
            }
            
            
            print("Should be levelCompleteInfo: \(character)Level\(level)Complete")
            prefs.set(true, forKey: "\(character)Level\(level)Complete")
            
            
            
            if prefs.value(forKey: "\(character)HighestLevelComplete") == nil {
                HighestLevelTemp = "0"
            } else {
                HighestLevelTemp = prefs.value(forKey: "\(character)HighestLevelComplete") as! String
            }
            let HighestLevel = Int(HighestLevelTemp)!
            let levelInt = Int(level)!
            if levelInt > HighestLevel {
                prefs.set(level, forKey: "\(character)HighestLevelComplete")
            }
            
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "LevelClose"), object: nil, userInfo: ["message":"NA","level":"\(level)","character":"\(character)","didWin":"\(didWin)"])
            
            
            
            if didWin {
                soundToPlay = "CrunchingSound.wav"
                self.run(SKAction.playSoundFileNamed(soundToPlay!, waitForCompletion: false))
                
            } else {
                soundToPlay = "Dad_GoToYourRoom.wav"
                self.run(SKAction.playSoundFileNamed(soundToPlay!, waitForCompletion: false))
            }
            
            case "mom":
            
                print("mom game over")
                
                if didWin {
                    print("Level \(level) Complete")
                } else {
                    print("Level \(level) Failed")
                }
                
                
                print("Should be levelCompleteInfo: \(character)Level\(level)Complete")
                prefs.set(true, forKey: "\(character)Level\(level)Complete")
                
                
                
                if prefs.value(forKey: "\(character)HighestLevelComplete") == nil {
                    HighestLevelTemp = "0"
                } else {
                    HighestLevelTemp = prefs.value(forKey: "\(character)HighestLevelComplete") as! String
                }
                let HighestLevel = Int(HighestLevelTemp)!
                let levelInt = Int(level)!
                if levelInt > HighestLevel {
                    prefs.set(level, forKey: "\(character)HighestLevelComplete")
                }
                
                
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "LevelClose"), object: nil, userInfo: ["message":"NA","level":"\(level)","character":"\(character)","didWin":"\(didWin)"])
                
                
                
                if didWin {
                    soundToPlay = "CrunchingSound.wav"
                    self.run(SKAction.playSoundFileNamed(soundToPlay!, waitForCompletion: false))
                    
                } else {
                    soundToPlay = "Dad_GoToYourRoom.wav"
                    self.run(SKAction.playSoundFileNamed(soundToPlay!, waitForCompletion: false))
            }
            
            
            
            /*
            let menuScene = MenuScene(size: self.size)
            menuScene.soundToPlay = didWin ? "fear_win.mp3" : "Dad_GoToYourRoom.m4a"
            
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            menuScene.scaleMode = SKSceneScaleMode.aspectFill
            self.scene!.view?.presentScene(menuScene, transition: transition)
            */
            
            
        default:
        
            print("Other Player game over")
            
            if didWin {
                print("Level \(level) Complete")
                soundToPlay = "CrunchingSound.wav"
                //self.run(SKAction.playSoundFileNamed(soundToPlay!, waitForCompletion: false))
                
            } else {
                print("Level \(level) Failed")
                soundToPlay = "Dad_GoToYourRoom.wav"
                //self.run(SKAction.playSoundFileNamed(soundToPlay!, waitForCompletion: false))
            }
            
            
            print("Should be levelCompleteInfo: \(character)Level\(level)Complete")
            prefs.set(true, forKey: "\(character)Level\(level)Complete")
            
            
            
            if prefs.value(forKey: "\(character)HighestLevelComplete") == nil {
                HighestLevelTemp = "0"
            } else {
                HighestLevelTemp = prefs.value(forKey: "\(character)HighestLevelComplete") as! String
            }
            let HighestLevel = Int(HighestLevelTemp)!
            let levelInt = Int(level)!
            if levelInt > HighestLevel {
                prefs.set(level, forKey: "\(character)HighestLevelComplete")
            }
            
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "LevelClose"), object: nil, userInfo: ["message":"NA","level":"\(level)","character":"\(character)","didWin":"\(didWin)"])
            
            
            if didWin {
                soundToPlay = "CrunchingSound.wav"
                self.run(SKAction.playSoundFileNamed(soundToPlay!, waitForCompletion: false))
            } else {
                soundToPlay = "Dad_GoToYourRoom.wav"
                self.run(SKAction.playSoundFileNamed(soundToPlay!, waitForCompletion: false))
            }
        }
        
        
        
        
        
    }
    
    
    
    func IsPlayerTouchingItem(contact: SKPhysicsContact) -> (Bool, String, Int) {
        
        var IsTouchingItem = Bool()
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        var itemInvolved = String()
        var NodeNum: Int = 0
        
        var playerBody: SKPhysicsBody
        
        var PlayerBodyInvolved = Bool()
        
        
        if contact.bodyA.categoryBitMask == 999 {
            playerBody = contact.bodyA
            secondBody = contact.bodyB
            PlayerBodyInvolved = true
            NodeNum = 2
        } else if contact.bodyB.categoryBitMask == 999 {
            playerBody = contact.bodyB
            secondBody = contact.bodyA
            PlayerBodyInvolved = true
            NodeNum = 1
        } else {
           
           playerBody = contact.bodyB
           secondBody = contact.bodyA
            
           PlayerBodyInvolved = false
        }
        
        
        if PlayerBodyInvolved {
            
            
           IsTouchingItem = true
            
            
            switch secondBody.categoryBitMask {
                
            case ToyCategoryMask:
               itemInvolved = "toy"
            case CandyCategoryMask:
                itemInvolved = "candy"
            case MomCategoryMask:
                itemInvolved = "parent"
            case ZombieCategoryMask:
                itemInvolved = "zombie"
                
                /*
            case (candies[0].physicsBody?.categoryBitMask)!:
               itemInvolved = "candy"
            case (mom[0].physicsBody?.categoryBitMask)!:
               itemInvolved = "mom"
            case (zombies[0].physicsBody?.categoryBitMask)!:
               itemInvolved = "zombie"
                */
    
    
            default:
               itemInvolved = "none"
            }
            
  
        } else {
    
            itemInvolved = "none"
            IsTouchingItem = false
        }
        
    
        
        
        return (IsTouchingItem, itemInvolved, NodeNum)
        
    }
    
    
    
}



extension CGPoint {
    
    /**
     Calculates a distance to the given point.
     
     :param: point - the point to calculate a distance to
     
     :returns: distance between current and the given points
     */
    func distance(point: CGPoint) -> CGFloat {
        let dx = self.x - point.x
        let dy = self.y - point.y
        return sqrt(dx * dx + dy * dy);
    }
}

func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)

}
//manipulate that random f. to only return values btwn 0 and 1
func random2(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min

}

struct FriendInfo {
    
    var name = String()
    var image = UIImage()
    var speed = CGFloat()
    var ResetTime: CFAbsoluteTime?
    var canTouchPlayer = Bool()
    
    
}
//iterate loop 50x placing enemy position randomly

