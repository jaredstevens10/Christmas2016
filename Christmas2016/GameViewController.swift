//
//  GameViewController.swift
//  Christmas2016
//
//  Created by Jared Stevens2 on 11/18/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

extension SKNode {
    
    class func unarchiveFromFile(_ file : String, Character: String, level: String) -> SKNode? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks") {
            let sceneData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            
            
            var CandyCount = Int()
            var FriendsCount = Int()
            var ParentsCount = Int()
            
            switch level {
                
            case "1":
                
                print("unarchive, level 1 selected")
                CandyCount = 1
                FriendsCount = 3
                ParentsCount = 2
                
              //  FriendsCount = 0
              //  ParentsCount = 1
                
                
            case "2":
                CandyCount = 2
                FriendsCount = 1
                ParentsCount = 1
                
            case "3":
                CandyCount = 3
                FriendsCount = 1
                ParentsCount = 1
            case "4":
                CandyCount = 4
                FriendsCount = 1
                ParentsCount = 1
                
            case "5":
                CandyCount = 5
                FriendsCount = 1
                ParentsCount = 1
                
            case "6":
                CandyCount = 6
                FriendsCount = 10
                ParentsCount = 2
                
            case "7":
                CandyCount = 7
                FriendsCount = 10
                ParentsCount = 2
                
            case "8":
                CandyCount = 8
                FriendsCount = 10
                ParentsCount = 2
                
            case "9":
                CandyCount = 9
                FriendsCount = 10
                ParentsCount = 2
                
            case "10":
                CandyCount = 10
                FriendsCount = 10
                ParentsCount = 2
                
            case "11":
                CandyCount = 11
                FriendsCount = 10
                ParentsCount = 2
                
            case "12":
                CandyCount = 12
                FriendsCount = 10
                ParentsCount = 2
                
            case "13":
                CandyCount = 13
                FriendsCount = 10
                ParentsCount = 2
                
            case "14":
                CandyCount = 14
                FriendsCount = 10
                ParentsCount = 2
                
            case "15":
                CandyCount = 15
                FriendsCount = 10
                ParentsCount = 2
                
            case "16":
                CandyCount = 16
                FriendsCount = 10
                ParentsCount = 2
                
            case "17":
                CandyCount = 17
                FriendsCount = 10
                ParentsCount = 2
                
            case "18":
                CandyCount = 18
                FriendsCount = 10
                ParentsCount = 2
                
            case "19":
                CandyCount = 19
                FriendsCount = 10
                ParentsCount = 2
                
            case "20":
                CandyCount = 20
                FriendsCount = 10
                ParentsCount = 2
                
            case "21":
                CandyCount = 21
                FriendsCount = 10
                ParentsCount = 2
                
            case "22":
                CandyCount = 22
                FriendsCount = 10
                ParentsCount = 2
                
            case "23":
                CandyCount = 23
                FriendsCount = 10
                ParentsCount = 2
                
            case "24":
                CandyCount = 24
                FriendsCount = 10
                ParentsCount = 2
                
            case "25":
                CandyCount = 25
                FriendsCount = 10
                ParentsCount = 2
                
            case "26":
                CandyCount = 26
                FriendsCount = 10
                ParentsCount = 2
                
            case "27":
                CandyCount = 27
                FriendsCount = 10
                ParentsCount = 2
                
            case "28":
                CandyCount = 28
                FriendsCount = 10
                ParentsCount = 2
                
            case "29":
                CandyCount = 29
                FriendsCount = 10
                ParentsCount = 2
            case "30":
                CandyCount = 30
                FriendsCount = 10
                ParentsCount = 2
                
            case "31":
                CandyCount = 31
                FriendsCount = 5
                ParentsCount = 2
                
            case "32":
                CandyCount = 32
                FriendsCount = 5
                ParentsCount = 2
                
            case "33":
                CandyCount = 33
                FriendsCount = 5
                ParentsCount = 2
                
            case "34":
                CandyCount = 34
                FriendsCount = 5
                ParentsCount = 2
                
            case "35":
                CandyCount = 35
                FriendsCount = 6
                ParentsCount = 2
                
                
            case "36":
                CandyCount = 36
                FriendsCount = 6
                ParentsCount = 2
                
                
            case "37":
                CandyCount = 37
                FriendsCount = 6
                ParentsCount = 2
                
                
                
            default:
                CandyCount = 30
                FriendsCount = 7
                ParentsCount = 2
                
            }
            
            
            
            UserDefaults.standard.set(CandyCount, forKey: "LevelTotalCandyCount")
             // NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateCandyViews"), object: nil, userInfo: ["message":"NA","candyCount":"0","levelCandyCount":"\(CandyCount)","levelHiddenCandyCount":"0","messageType":"Ok"])
            
            
            
            switch Character {
                
                case "tripp":
                
                    
                    print("Return Tripp Scene")
                   
                let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! LevelHome
                    archiver.finishDecoding()
                
                    scene.candyCountInt = CandyCount
                    scene.friendsCountInt = FriendsCount
                    scene.parentsCountInt = ParentsCount
                    scene.charactername = Character
                    scene.levelSelected = level
                
                    return scene
 
                
                
              case "piper":
                
                let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! LevelHome
                archiver.finishDecoding()
                
                
                scene.candyCountInt = CandyCount
                scene.friendsCountInt = FriendsCount
                scene.parentsCountInt = ParentsCount
                scene.charactername = Character
                scene.levelSelected = level
                
                return scene
                
            default:
                
                let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! LevelHome
                archiver.finishDecoding()
                
                scene.candyCountInt = CandyCount
                scene.friendsCountInt = FriendsCount
                scene.parentsCountInt = ParentsCount
                scene.charactername = Character
                scene.levelSelected = level
                
                return scene
                
               // return nil
               // break
                
            }
            
            
            
        } else {
            return nil
        }
    }
    
}

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var radarImage: UIImageView!
    
    
    @IBOutlet weak var parentSpeedTracker: UIProgressView!
    
    
    @IBOutlet weak var parentSpeedTitle: UILabel!
    
    @IBOutlet weak var parentSpeedLBL: UILabel!
    
    @IBOutlet weak var radarView: UIView!
    
    let MessageImage = UIImage(named: "DadHeadTemp.png")!
    
    let prefs:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var pauseBTN: UIButton!
    
    @IBOutlet weak var candyView: UIView!
    
    @IBOutlet weak var candyCountLBL: UILabel!
    
    @IBOutlet weak var totalCandyCountLBL: UILabel!
    
    
    @IBOutlet weak var treasureView: UIView!
    
    @IBOutlet weak var hiddenLBL: UILabel!
    
    @IBOutlet weak var totalCandyCountLBLh: UILabel!
    
    
    var candyCountIntNow = Int()
    
    var isPaused = Bool()
    
    var CharacterSelected = String()
    var LevelSelected = String()
    
    var PlayerInfo = PlayersAvailable()
    
    
    override func viewDidLoad() {
        
        print("GameView Loaded")
        super.viewDidLoad()
        
          NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.UpdateCandyViews(_:)), name: NSNotification.Name(rawValue: "UpdateCandyViews"),  object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.CreateRadarMap(_:)), name: NSNotification.Name(rawValue: "CreateRadarMap"),  object: nil)
        
        self.candyView.layer.cornerRadius = 40
        self.candyView.layer.masksToBounds = true
        self.candyView.clipsToBounds = true
        
       // self.radarView.layer.cornerRadius = 10
       // self.radarView.layer.masksToBounds = true
       // self.radarView.clipsToBounds = true
        self.radarView.isHidden = true
        
        self.treasureView.layer.cornerRadius = 40
        self.treasureView.layer.masksToBounds = true
        self.treasureView.clipsToBounds = true
        
        UserDefaults.standard.set(0, forKey: "CurrentCandyCount")
        
        UserDefaults.standard.set(0, forKey: "CurrentHiddenCount")
        
        print("Character Selected: \(CharacterSelected)")
        print("***Level Selected: \(LevelSelected)")
        
        switch CharacterSelected {
            
        case "tripp":
            
            print("Tripp Selected")
            
            /*
            if let scene = Level1.unarchiveFromFile("Level1", Character: CharacterSelected) as? Level1 {
                // Configure the view.
                let skView = self.view as! SKView
                skView.showsFPS = true
                skView.showsNodeCount = true
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = true
                
                /* Set the scale mode to scale to fit the window */
                scene.scaleMode = .aspectFill
                
                skView.presentScene(scene)
            }
            
            */
            
            
            if let scene = LevelHome.unarchiveFromFile("LevelHome", Character: CharacterSelected, level: LevelSelected) as? LevelHome {
                
                print("LevelHome Scene Selected")
                
                // Configure the view.
                let skView = self.view as! SKView
                skView.showsFPS = true
                skView.showsNodeCount = true
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = true
                
                /* Set the scale mode to scale to fit the window */
                scene.scaleMode = .aspectFill
                scene.PlayerImage = UIImage(named: "TrippHeadSmile.png")
                
                //SKTexture("TrippHeadSmile.png")
                
                //SKTexture.init(imageNamed: "TrippHeadSmile.png")
                
                
                DispatchQueue.main.async(execute: {
                    //self.CollectionView.reloadData()
                    print("dispatch que, present scene")
                    skView.presentScene(scene)
                })
                
                //skView.presentScene(scene)
                
            }
            
            /*
            
            if let scene = GameScene.unarchiveFromFile("GameScene", Character: CharacterSelected, level: LevelSelected) as? GameScene {
                // Configure the view.
                let skView = self.view as! SKView
                skView.showsFPS = true
                skView.showsNodeCount = true
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = true
                
                /* Set the scale mode to scale to fit the window */
                scene.scaleMode = .aspectFill
                //scene.PlayerImage = UIImage(named: "TrippHeadSmile.png")
                
                //SKTexture("TrippHeadSmile.png")
                
                //SKTexture.init(imageNamed: "TrippHeadSmile.png")
                
                skView.presentScene(scene)
            }
            */
            
            
        case "piper":
            
            if let scene = LevelHome.unarchiveFromFile("LevelHome", Character: CharacterSelected, level: LevelSelected) as? LevelHome {
                // Configure the view.
                let skView = self.view as! SKView
                skView.showsFPS = true
                skView.showsNodeCount = true
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = true
                
                /* Set the scale mode to scale to fit the window */
                scene.scaleMode = .aspectFill
               // scene.player?.texture = SKTexture.init(imageNamed: "PiperHead.png")
                scene.PlayerImage = UIImage(named: "PiperHead.png")
                
                skView.presentScene(scene)
            }
            
            
            
        default:
            
            
            if let scene = LevelHome.unarchiveFromFile("LevelHome", Character: CharacterSelected, level: LevelSelected) as? LevelHome {
                // Configure the view.
                let skView = self.view as! SKView
                skView.showsFPS = true
                skView.showsNodeCount = true
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = true
                
                /* Set the scale mode to scale to fit the window */
                scene.scaleMode = .aspectFill
                scene.PlayerImage = self.PlayerInfo.playerImage
                
                //SKTexture("TrippHeadSmile.png")
                
                //SKTexture.init(imageNamed: "TrippHeadSmile.png")
                
                skView.presentScene(scene)
            }
        }
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.GameMessage(_:)), name: NSNotification.Name(rawValue: "GameMessage"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.HideCandy(_:)), name: NSNotification.Name(rawValue: "HideCandy"),  object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.FriendContact(_:)), name: NSNotification.Name(rawValue: "FriendContact"),  object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.LevelClose(_:)), name: NSNotification.Name(rawValue: "LevelClose"),  object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.UpdateParentSpeed(_:)), name: NSNotification.Name(rawValue: "UpdateParentSpeed"),  object: nil)
        
        
        
        
        self.parentSpeedTracker.setProgress(0.0, animated: true)
      

    }
    
    func CreateRadarMap(_ notification:Notification) {
        
        print("Creating Game Radar")
        
      //  let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,AnyObject?>
        
      //  if let userInfo = notification.object as? [String:AnyObject] {
            
            if let pointsDict = notification.object as? [String:[CGPoint]] {
                
                print("Points Object Found")
       // var jsonAlert = JSON(userInfo)
          /*
                if let NotificationMessage = userInfo["message"] as? String {
                
            }
        */
        // let level = jsonAlert["level"].stringValue
            if let points = pointsDict["points"] as [CGPoint]! {
        
        print("Points Found")
       // let points = [CGPoint(x: 5505, y: 2099),CGPoint(x: 5389, y: 3774)]
        
        print("Points: \(points)")
        
        
        let theRadarImage = CreateRadar(Points: points)
        
        
        self.radarImage.image = theRadarImage
        self.radarImage.contentMode = .scaleAspectFit
        
         self.radarView.isHidden = false
        
            }
            
        }
 
        // let currentSpeedTemp = jsonAlert["currentSpeed"].stringValue
       
   
        
    }
    
    func UpdateParentSpeed(_ notification:Notification) {
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        let NotificationMessage = jsonAlert["message"].stringValue
        
       // let level = jsonAlert["level"].stringValue
        let newSpeedTemp = jsonAlert["newSpeed"].stringValue
       // let currentSpeedTemp = jsonAlert["currentSpeed"].stringValue
        let maxSpeedTemp = jsonAlert["maxSpeed"].stringValue
        //let didWinTemp = jsonAlert["didWin"].stringValue
        
        
        
      //  let newSpeedalmost = Int(newSpeedTemp)!
      //  let currentSpeedalmost = Int(currentSpeedTemp)!
      //  let maxSpeedalmost = Int(maxSpeedTemp)!
        
        let newSpeed = Float(newSpeedTemp)!
      //  let currentSpeed = Float(currentSpeedalmost)
        let maxSpeed = Float(maxSpeedTemp)!
        
     
        let ParentProgress: Float = newSpeed / maxSpeed
        
        print("Parent Speed: \(ParentProgress)")
        
        self.parentSpeedTracker.setProgress(ParentProgress, animated: true)
        
        let ParentProgressTextTemp = ParentProgress * 100
        let ParentProgressText = Int(round(ParentProgressTextTemp))
        
        self.parentSpeedTitle.text = "Parent's Speed:"
        self.parentSpeedLBL.text = "\(ParentProgressText)%"
        
        
     
        
    }
    
    func LevelClose(_ notification:Notification) {
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        let NotificationMessage = jsonAlert["message"].stringValue
        
        let level = jsonAlert["level"].stringValue
        let character = jsonAlert["character"].stringValue
        let didWinTemp = jsonAlert["didWin"].stringValue
        
        var didWin = Bool()
        
        if didWinTemp == "false" {
            didWin = false
        } else {
            didWin = true
        }
        
        
        
        
        
        self.dismiss(animated: true, completion: {
            
            
               NotificationCenter.default.post(name: Notification.Name(rawValue: "LevelCloseUpdate"), object: nil, userInfo: ["message":"NA","level":"\(level)","character":"\(character)","didWin":"\(didWin)"])
            
            
        })
        
    }
    
    
    func UpdateCandyViews(_ notification:Notification) {
        
        print("Should receive notification")
        
        var MyName = String()
        
        /*
         if self.prefs.value(forKey: "EXTUSERNAME") == nil {
         MyName = "Guest"
         } else {
         MyName = self.prefs.value(forKey: "EXTUSERNAME") as! String
         }
         */
        
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        // print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        
        let NotificationMessage = jsonAlert["message"].stringValue
        let candyCount = jsonAlert["candyCount"].stringValue
        let levelCandyCount = jsonAlert["levelCandyCount"].stringValue
        let levelHiddenCandyCount = jsonAlert["levelHiddenCandyCount"].stringValue
        
        let MessageType = jsonAlert["messageType"].stringValue
        
        let TempCandyCount = Int(candyCount)
        
        /*
         candyCountIntNow = UserDefaults.standard.integer(forKey: "CurrentCandyCount")
         print("Candy Count now: \(candyCountIntNow)")
         let FinalCandy = candyCountIntNow + TempCandyCount!
         print("New Candy Count: \(FinalCandy)")
         UserDefaults.standard.set(FinalCandy, forKey: "CurrentCandyCount")
         */
        
        print("LEVEL CANDY COUNT: \(levelCandyCount)")
        
        self.totalCandyCountLBL.text = "/ \(levelCandyCount)"
        
        
        
        
        self.totalCandyCountLBLh.text = "/ \(levelCandyCount)"
        self.candyCountLBL.text = candyCount
        // self.prefs.set(false, forKey: "NotPickingUpCandy")
        
        
        if MessageType == "Ok" {
            
            /*
             let alertController = UIAlertController(title: "Message", message: "\(NotificationMessage)", preferredStyle: .alert)
             
             let CancelAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
             print("Cancel button pressed")
             
             }
             
             
             //  alertController.addAction(yesAction);
             
             alertController.addAction(CancelAction);
             
             // alertController.view.tintColor = UIColor.blackColor();
             
             self.present(alertController, animated: true, completion: nil)
             */
            
        }
        
        
    }
    
    
    func HideCandy(_ notification:Notification) {
        
        print("Should receive hide candy notification")

        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        // print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        
        let NotificationMessage = jsonAlert["message"].stringValue
       // let candyCount = jsonAlert["candyCount"].stringValue
        let levelCandyCount = jsonAlert["levelCandyCount"].stringValue
        let levelHiddenCandyCount = jsonAlert["levelHiddenCandyCount"].stringValue
        
        let MessageType = jsonAlert["messageType"].stringValue
        
        let TempHiddenCandyCount = Int(levelHiddenCandyCount)
        
        UserDefaults.standard.set(TempHiddenCandyCount, forKey: "CurrentHiddenCount")
        
      
        
        print("LEVEL CANDY COUNT: \(levelHiddenCandyCount)")
        
        
        
        let LevelTotalHiddenCandyCount =  UserDefaults.standard.integer(forKey: "LevelTotalCandyCount")
            //.set(CandyCount, forKey: "LevelTotalCandyCount")
        let RemainingCandyCount = LevelTotalHiddenCandyCount - TempHiddenCandyCount!
        
        self.hiddenLBL.text = "\(levelHiddenCandyCount)"
        self.totalCandyCountLBLh.text = "/ \(LevelTotalHiddenCandyCount)"
        self.totalCandyCountLBL.text = "/ \(RemainingCandyCount)"
        
       // self.candyCountLBL.text = candyCount
       // self.prefs.set(false, forKey: "NotPickingUpCandy")
        
        
        if MessageType == "Ok" {
            
            
            let alertController = UIAlertController(title: "Success", message: "\(NotificationMessage)", preferredStyle: .alert)
            
            let CancelAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                print("Cancel button pressed")
                
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "PauseGame"), object: nil, userInfo: ["message":"Come up with a quote to describe this picture","action":"play"])
                
            }
            
            
            //  alertController.addAction(yesAction);
            
            alertController.addAction(CancelAction);
            
            // alertController.view.tintColor = UIColor.blackColor();
            
            self.present(alertController, animated: true, completion: nil)
            
            
        }
        
        
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    func GameMessage(_ notification:Notification) {
        
        var MyName = String()
        
        /*
         if self.prefs.value(forKey: "EXTUSERNAME") == nil {
         MyName = "Guest"
         } else {
         MyName = self.prefs.value(forKey: "EXTUSERNAME") as! String
         }
         */
        
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        // print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        
        let NotificationMessage = jsonAlert["message"].stringValue
        let candyCount = jsonAlert["candyCount"].stringValue
        let MessageType = jsonAlert["messageType"].stringValue
        
        
        let TempCandyCount = Int(candyCount)
        
        
        candyCountIntNow = UserDefaults.standard.integer(forKey: "CurrentCandyCount")
        
        print("Candy Count now: \(candyCountIntNow)")
        
        
        
        let FinalCandy = candyCountIntNow + TempCandyCount!
        
        print("New Candy Count: \(FinalCandy)")
        
        UserDefaults.standard.set(FinalCandy, forKey: "CurrentCandyCount")
        
        self.candyCountLBL.text = FinalCandy.description
        
        //was unhidden
       // self.prefs.set(false, forKey: "NotPickingUpCandy")
        
        
        if MessageType == "Ok" {
            
            
            
            let alertController = UIAlertController(title: "Message", message: "\(NotificationMessage)", preferredStyle: .alert)
            
            let CancelAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                print("Cancel button pressed")
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "PauseGame"), object: nil, userInfo: ["message":"Come up with a quote to describe this picture","action":"play"])
                
                print("WAITING 5 SECONDS NOW")
                self.delayWithSeconds(4){
                    
                    print("Waited 5 seconds, then update parent")
                      NotificationCenter.default.post(name: Notification.Name(rawValue: "ParentCanTouchPlayer"), object: nil, userInfo: ["message":"NA"])
                
                }
                
              
                
                
                
            }
            
            
            //  alertController.addAction(yesAction);
            
            alertController.addAction(CancelAction);
            
            // alertController.view.tintColor = UIColor.blackColor();
            
            self.present(alertController, animated: true, completion: nil)
            
            
            
            /*
             let theAlert = SCLAlertView()
             
             theAlert.addButton("Ok") {
             }
             
             /*
             theAlert.addButton("No") {
             }
             */
             
             
             theAlert.showCustomOK(MessageImage, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "Message", subTitle: "\(NotificationMessage)", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
             */
            
            // SweetAlert().showAlert(NotificationMessage)
            
            
        }
        
        
    }
    
    
    func FriendContact(_ notification:Notification) {
  
        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        // print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        
        let NotificationMessage = jsonAlert["message"].stringValue
        let candyCount = jsonAlert["candyCount"].stringValue
        let MessageType = jsonAlert["messageType"].stringValue
        let action = jsonAlert["action"].stringValue
        let response = jsonAlert["response"].stringValue
        let levelCandyCount = jsonAlert["levelCandyCount"].stringValue
        
        
        
        let TempCandyCount = Int(candyCount)
        
        
        candyCountIntNow = UserDefaults.standard.integer(forKey: "CurrentCandyCount")
        
        print("Candy Count now: \(candyCountIntNow)")
        
       
        
        //let FinalCandy = candyCountIntNow + TempCandyCount!
        
        //print("New Candy Count: \(FinalCandy)")
        
        //UserDefaults.standard.set(FinalCandy, forKey: "CurrentCandyCount")
        
       // self.candyCountLBL.text = FinalCandy.description
        
       // self.prefs.set(false, forKey: "NotPickingUpCandy")
        
        
        if action == "share" {
            
            
        
        let alertController = UIAlertController(title: "Share?", message: "\(NotificationMessage)", preferredStyle: .alert)
        
        let CancelAction = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in
            print("Cancel button pressed")
            
            
            let alertController2 = UIAlertController(title: "No Fair!", message: "I'm telling on you!", preferredStyle: .alert)
            
            let CancelAction = UIAlertAction(title: "Uh Oh", style: .default) { (action:UIAlertAction) in
                print("Cancel button pressed")
                
                
                 NotificationCenter.default.post(name: Notification.Name(rawValue: "TellOnPlayer"), object: nil, userInfo: ["message":"NA","action":"tell"])
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "PauseGame"), object: nil, userInfo: ["message":"NA","action":"play"])

            }
            
            
            alertController2.addAction(CancelAction);
            
            
             self.present(alertController2, animated: true, completion: nil)
            
            
        }
            
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
                print("Yes button pressed")
            
            
            let newCandyIntCount = self.candyCountIntNow - 1
            
            UserDefaults.standard.set(newCandyIntCount, forKey: "CurrentCandyCount")
            
            //self.totalCandyCountLBL.text = "/ \(newCandyIntCount)"
            self.candyCountLBL.text = "\(newCandyIntCount)"
            NotificationCenter.default.post(name: Notification.Name(rawValue: "PauseGame"), object: nil, userInfo: ["message":"NA","action":"play"])
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "GenerateCandy"), object: nil, userInfo: ["message":"NA","createAmount":"1"])
  
            
        }
        
        
        alertController.addAction(yesAction);
        
        alertController.addAction(CancelAction);
        
        // alertController.view.tintColor = UIColor.blackColor();
        
        self.present(alertController, animated: true, completion: nil)
            
            
        } else {
            
            
           
            
            let alertController = UIAlertController(title: "", message: "\(NotificationMessage)", preferredStyle: .alert)
            
            let CancelAction = UIAlertAction(title: "\(response)", style: .default) { (action:UIAlertAction) in
                print("Cancel button pressed")
          
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "PauseGame"), object: nil, userInfo: ["message":"NA","action":"play"])
                
            }

            
            alertController.addAction(CancelAction);
            
            // alertController.view.tintColor = UIColor.blackColor();
            
            self.present(alertController, animated: true, completion: nil)
            
            
            
        }

        
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.allButUpsideDown
        } else {
            return UIInterfaceOrientationMask.all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @IBAction func CloseBTN(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pauseGame(_ sender: Any) {
        
        if !isPaused {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "PauseGame"), object: nil, userInfo: ["message":"Come up with a quote to describe this picture","action":"pause"])
            
            isPaused = true
            
            pauseBTN.setTitle("Play", for: .normal)
            
        } else {
            
           NotificationCenter.default.post(name: Notification.Name(rawValue: "PauseGame"), object: nil, userInfo: ["message":"Come up with a quote to describe this picture","action":"play"])
            
            isPaused = false
            
            pauseBTN.setTitle("Pause", for: .normal)
            
        }
        
        
        
    }
    
    
    
    
}
