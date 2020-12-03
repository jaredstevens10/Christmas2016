//
//  NewGameViewController.swift
//  Christmas2016
//
//  Created by Jared Stevens2 on 11/21/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    @IBOutlet weak var difPlayersBTN: UIButton!
    
    
    let reuseIdentifier = "LevelCell"
    var Players = [PlayersAvailable]()
    var SelectedPlayerInfo = PlayersAvailable()
    
     @IBOutlet weak var CollectionView: UICollectionView!
    
    @IBOutlet weak var newGameLBL: UILabel!
    
    @IBOutlet weak var selectCharacterLBL: UILabel!
    
   // @IBOutlet weak var playerMOM: UIView!
    
   // @IBOutlet weak var playerMOM_W: NSLayoutConstraint!
    
    let prefs:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var player1View: UIView!
    
    @IBOutlet weak var player1ViewW: NSLayoutConstraint!
    @IBOutlet weak var player1ViewH: NSLayoutConstraint!
    @IBOutlet weak var player1ViewTOP: NSLayoutConstraint!
    @IBOutlet weak var player1ViewLEAD: NSLayoutConstraint!
    
    var rotate = CABasicAnimation()
    var rotateP = CABasicAnimation()
     @IBOutlet weak var musicPlayerBTN: UIButton!
    
    @IBOutlet weak var musicBTN_W: NSLayoutConstraint!
    
    @IBOutlet weak var musicBTN_H: NSLayoutConstraint!
    
    @IBOutlet weak var player2View: UIView!
    
    @IBOutlet weak var player2ViewW: NSLayoutConstraint!
    @IBOutlet weak var player2ViewH: NSLayoutConstraint!
    @IBOutlet weak var player2ViewTOP: NSLayoutConstraint!
    @IBOutlet weak var player2ViewTRAIL: NSLayoutConstraint!
    
    
    @IBOutlet weak var headHolderH: NSLayoutConstraint!
    
    
    //@IBOutlet weak var headHolderTOP: NSLayoutConstraint!
    
    @IBOutlet weak var headHolderY: NSLayoutConstraint!
    
    @IBOutlet weak var piperX: NSLayoutConstraint!
    
    @IBOutlet weak var trippX: NSLayoutConstraint!
    //@IBOutlet weak var player1ViewLEAD: NSLayoutConstraint!

    
    @IBOutlet weak var headHolder: UIView!
    
    
    var CharacterSelected = String()
    
    var momVisible = Bool()
    
    var PlayingGroup = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if prefs.value(forKey: "PlayingGroup") == nil {
            
            prefs.set("stevens", forKey: "PlayingGroup")
            
            PlayingGroup = "stevens"
            
        } else {
            
            PlayingGroup = prefs.value(forKey: "PlayingGroup") as! String
        }
        
       // print("New game view loaded")
       // momVisible = true
        /*
        if momVisible {
        self.playerMOM.isHidden = false
        } else {
         self.playerMOM.isHidden = true
        }
        */
        
        
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        
        
        let FontSizeTempSelect = DeviceW / 15
        
        self.selectCharacterLBL.font.withSize(FontSizeTempSelect)
        
        self.selectCharacterLBL.font = UIFont(name: "Party LET", size: FontSizeTempSelect)
   
        //6.25
        let FontSizeTempNewGame = DeviceW / 7
        
        //self.newGameBTN.set
        
        self.newGameLBL.font.withSize(FontSizeTempNewGame)
        
         self.newGameLBL.font = UIFont(name: "Party LET", size: FontSizeTempNewGame)
        //self.candyH.constant = DeviceW / 3.75
        
        //self.candyW.constant = DeviceW / 3.75
        
        /*
        let HeadHolderHeight = DeviceH / 7.11466667
        self.headHolderH.constant = HeadHolderHeight
        self.piperX.constant = (DeviceW / 6.25) * -1
        self.trippX.constant = DeviceW / 6.25
        
        */
       // self.playerMOM_W.constant = HeadHolderHeight
        
        
        let musicBTN_Height = DeviceW / 6.25
        self.musicBTN_H.constant = musicBTN_Height
        self.musicBTN_W.constant = musicBTN_Height
        self.musicPlayerBTN.layer.cornerRadius = (musicBTN_Height / 2)
        
        
        rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = -0.4
        rotate.toValue = CGFloat(M_PI * 0.2)
        rotate.duration = 0.5
        rotate.autoreverses = true
        rotate.repeatCount = FLT_MAX
        
        rotateP = CABasicAnimation(keyPath: "transform.rotation")
        rotateP.fromValue = -0.4
        rotateP.toValue = CGFloat(M_PI * 0.2)
        rotateP.duration = 0.5
        rotateP.autoreverses = true
        rotateP.repeatCount = FLT_MAX
        
        
        /*
        if prefs.bool(forKey: "MainMusicPlaying") {
            
        player1View.layer.add(rotate, forKey: "trippRotate")
        player2View.layer.add(rotateP, forKey: "piperRotate")
            
        } else {
            player1View.layer.removeAllAnimations()
            player2View.layer.removeAllAnimations()
        }
        */
        
        /*
        self.player1View.layer.cornerRadius = HeadHolderHeight / 2
        self.player1View.layer.masksToBounds = true
        self.player1View.clipsToBounds = true
        
        self.player2View.layer.cornerRadius = HeadHolderHeight / 2
        self.player2View.layer.masksToBounds = true
        self.player2View.clipsToBounds = true
        
        */
        
      //  self.playerMOM.layer.cornerRadius = HeadHolderHeight / 2
      //  self.playerMOM.layer.masksToBounds = true
      //  self.playerMOM.clipsToBounds = true
        
       // self.musicPlayerBTN.layer.cornerRadius = 30
        self.musicPlayerBTN.layer.borderWidth = 3
        self.musicPlayerBTN.layer.borderColor = UIColor(red: 0.98039, green: 0.0, blue: 0.29019, alpha: 1.0).cgColor
        
        
        
        self.CollectionView.setContentOffset(CollectionView.contentOffset, animated:false)
        self.CollectionView.backgroundColor = UIColor.clear
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2, left: 10, bottom: 0, right: 10)
        
        
       // let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
       // let DeviceW = self.view.frame.width
        let CellW = DeviceW / 2.5
        
        layout.itemSize = CGSize(width: CellW, height: CellW)
        layout.scrollDirection = .vertical
        
        CollectionView.collectionViewLayout = layout


        // Do any additional setup after loading the view.
    }
    
    func GetPlayersInfo(group: String) -> [PlayersAvailable] {
        var PlayersTemp = [PlayersAvailable]()
        
        
        print("Getting players info")
        
        switch group {
        
        
            
        case "stevens":
            
        let PlayerTripp = PlayersAvailable(playerName: "tripp", playerImage: UIImage(named: "Tripp Head 2.png")!, LabelName: "Tripp")
        let PlayerPiper = PlayersAvailable(playerName: "piper", playerImage: UIImage(named: "PiperHeadReal.png")!, LabelName: "Piper")
        
        
        let PlayerMegan = PlayersAvailable(playerName: "mom", playerImage: UIImage(named: "Meg Head.png")!, LabelName: "Megan")
        let PlayerJared = PlayersAvailable(playerName: "dad", playerImage: UIImage(named: "HeadJared.png")!, LabelName: "Jared")
        
        PlayersTemp.append(PlayerTripp)
        PlayersTemp.append(PlayerPiper)
        //PlayersTemp.append(PlayerJared)
            
        case "parents":
            
                let PlayerMegan = PlayersAvailable(playerName: "mom", playerImage: UIImage(named: "Meg Head.png")!, LabelName: "Megan")
                let PlayerJared = PlayersAvailable(playerName: "dad", playerImage: UIImage(named: "HeadJared.png")!, LabelName: "Jared")
                
                PlayersTemp.append(PlayerMegan)
                PlayersTemp.append(PlayerJared)
            
            
            
        case "cronk":
         
            
        
                
                let player1 = PlayersAvailable(playerName: "Elise", playerImage: UIImage(named: "HeadElise")!, LabelName: "Elise")
                
                let player2 = PlayersAvailable(playerName: "Asher", playerImage: UIImage(named: "HeadAsher")!, LabelName: "Asher")
                
        
                
                PlayersTemp.append(player1)
                PlayersTemp.append(player2)
            
            
        case "all":
            
            
            let PlayerTripp = PlayersAvailable(playerName: "tripp", playerImage: UIImage(named: "Tripp Head 2.png")!, LabelName: "Tripp")
            let PlayerPiper = PlayersAvailable(playerName: "piper", playerImage: UIImage(named: "PiperHeadReal.png")!, LabelName: "Piper")
            
            let PlayerMegan = PlayersAvailable(playerName: "mom", playerImage: UIImage(named: "Meg Head.png")!, LabelName: "Megan")
            let PlayerJared = PlayersAvailable(playerName: "dad", playerImage: UIImage(named: "HeadJared.png")!, LabelName: "Jared")
            
            let PlayerMory = PlayersAvailable(playerName: "Mory", playerImage: UIImage(named: "HeadMory.png")!, LabelName: "Mory")
            
            let player1 = PlayersAvailable(playerName: "Elise", playerImage: UIImage(named: "HeadElise")!, LabelName: "Elise")
            
            let player2 = PlayersAvailable(playerName: "Asher", playerImage: UIImage(named: "HeadAsher")!, LabelName: "Asher")
            
            
            let player3 = PlayersAvailable(playerName: "Ember", playerImage: UIImage(named: "FriendEmber")!, LabelName: "Ember")
            
            let player4 = PlayersAvailable(playerName: "Lilly", playerImage: UIImage(named: "FriendLilly")!, LabelName: "Lilly")
            
            let player5 = PlayersAvailable(playerName: "Ben", playerImage: UIImage(named: "FriendBen")!, LabelName: "Ben")
            
            let player6 = PlayersAvailable(playerName: "Eisley", playerImage: UIImage(named: "FriendEisley")!, LabelName: "Eisley")
            
            let player7 = PlayersAvailable(playerName: "AJ", playerImage: UIImage(named: "HeadAJ")!, LabelName: "AJ")
            
            let player8 = PlayersAvailable(playerName: "Hudson", playerImage: UIImage(named: "HeadHudson")!, LabelName: "Hudson")
            
            let player9 = PlayersAvailable(playerName: "Bennett", playerImage: UIImage(named: "HeadBennett")!, LabelName: "Bennett")
            
           // let Hudson = FriendInfo(name: "Hudson", image: UIImage(named: "HeadHudson")!, speed: 60.0, ResetTime: nil, canTouchPlayer: true)
            
            
            PlayersTemp.append(PlayerTripp)
            PlayersTemp.append(PlayerPiper)
            PlayersTemp.append(PlayerMegan)
            PlayersTemp.append(PlayerJared)
            PlayersTemp.append(PlayerMory)
            PlayersTemp.append(player1)
            PlayersTemp.append(player2)
            PlayersTemp.append(player3)
            PlayersTemp.append(player4)
            PlayersTemp.append(player5)
            PlayersTemp.append(player6)
            PlayersTemp.append(player7)
            PlayersTemp.append(player8)
            PlayersTemp.append(player9)
            
            /*
            
            let Colton = FriendInfo(name: "Colton", image: UIImage(named: "FriendColton")!, speed: 105.0, ResetTime: nil, canTouchPlayer: true)
            
            let Lizzie = FriendInfo(name: "Lizzie", image: UIImage(named: "HeadLizzie")!, speed: 100.0, ResetTime: nil, canTouchPlayer: true)
            
            let Cory = FriendInfo(name: "Cory", image: UIImage(named: "FriendCory")!, speed: 100.0, ResetTime: nil, canTouchPlayer: true)
            
            
            let Bret = FriendInfo(name: "Bret", image: UIImage(named: "HeadBret")!, speed: 102.0, ResetTime: nil, canTouchPlayer: true)
            
            let Rich = FriendInfo(name: "Rich", image: UIImage(named: "HeadRich")!, speed: 95.0, ResetTime: nil, canTouchPlayer: true)
            
            let Devon = FriendInfo(name: "Devon", image: UIImage(named: "HeadDevon")!, speed: 85.0, ResetTime: nil, canTouchPlayer: true)
            
            let Hudson = FriendInfo(name: "Hudson", image: UIImage(named: "HeadHudson")!, speed: 60.0, ResetTime: nil, canTouchPlayer: true)
            
            //BENNETT??
            
            let Devin = FriendInfo(name: "Devin", image: UIImage(named: "HeadDevin")!, speed: 85.0, ResetTime: nil, canTouchPlayer: true)
            
            let Erin = FriendInfo(name: "Erin", image: UIImage(named: "HeadErin")!, speed: 80.0, ResetTime: nil, canTouchPlayer: true)
            
            let AJ = FriendInfo(name: "AJ", image: UIImage(named: "HeadAJ")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
            
            let Heidi = FriendInfo(name: "Heidi", image: UIImage(named: "HeadHeidi")!, speed: 90.0, ResetTime: nil, canTouchPlayer: true)
            
            let Jane = FriendInfo(name: "Jane", image: UIImage(named: "HeadJane")!, speed: 90.0, ResetTime: nil, canTouchPlayer: true)
            
            let Dan = FriendInfo(name: "Dan", image: UIImage(named: "HeadDan")!, speed: 95.0, ResetTime: nil, canTouchPlayer: true)
            
            let Larry = FriendInfo(name: "Larry", image: UIImage(named: "HeadLarry")!, speed: 92.0, ResetTime: nil, canTouchPlayer: true)
            
            let Elise = FriendInfo(name: "Elise", image: UIImage(named: "HeadElise")!, speed: 85.0, ResetTime: nil, canTouchPlayer: true)
            
            let Shannon = FriendInfo(name: "Shannon", image: UIImage(named: "HeadShannon")!, speed: 90.0, ResetTime: nil, canTouchPlayer: true)
            
            let Asher = FriendInfo(name: "Asher", image: UIImage(named: "HeadAsher")!, speed: 90.0, ResetTime: nil, canTouchPlayer: true)
            
            let Sam = FriendInfo(name: "Sam", image: UIImage(named: "HeadSam")!, speed: 100.0, ResetTime: nil, canTouchPlayer: true)
            
            let Mory = FriendInfo(name: "Mory", image: UIImage(named: "HeadMory")!, speed: 125.0, ResetTime: nil, canTouchPlayer: true)
            
            let Mandi = FriendInfo(name: "Mandi", image: UIImage(named: "HeadMandi")!, speed: 95.0, ResetTime: nil, canTouchPlayer: true)
            
            let Caden = FriendInfo(name: "Caden", image: UIImage(named: "HeadCaden")!, speed: 90.0, ResetTime: nil, canTouchPlayer: true)
            
            let Cali = FriendInfo(name: "Cali", image: UIImage(named: "HeadCali")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
            
            let Ally = FriendInfo(name: "Ally", image: UIImage(named: "HeadAlly")!, speed: 80.0, ResetTime: nil, canTouchPlayer: true)
            
            let Tony = FriendInfo(name: "Tony", image: UIImage(named: "HeadTony")!, speed: 95.0, ResetTime: nil, canTouchPlayer: true)
            
            let Jessica = FriendInfo(name: "Jessica", image: UIImage(named: "HeadJessica")!, speed: 80.0, ResetTime: nil, canTouchPlayer: true)
            
            let Art = FriendInfo(name: "Art", image: UIImage(named: "HeadArt")!, speed: 85.0, ResetTime: nil, canTouchPlayer: true)
            
            let Joey = FriendInfo(name: "Joey", image: UIImage(named: "HeadJoey")!, speed: 60.0, ResetTime: nil, canTouchPlayer: true)
            
            let Elenor = FriendInfo(name: "Eleanor", image: UIImage(named: "HeadElenor")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
            
            
            let Abby = FriendInfo(name: "Abby", image: UIImage(named: "HeadAbby")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
            
            let Ben2 = FriendInfo(name: "Ben", image: UIImage(named: "HeadBen")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
            
            let Emily = FriendInfo(name: "Emily", image: UIImage(named: "HeadEmily")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
            
            let Josh = FriendInfo(name: "Josh", image: UIImage(named: "HeadJosh")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
            
            let Kendra = FriendInfo(name: "Kendra", image: UIImage(named: "HeadKendra")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
            
            let Tim = FriendInfo(name: "Tim", image: UIImage(named: "HeadTim")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
            
            */
            
          //  PlayersTemp.append(
            
        
        default:
            
            let PlayerTripp = PlayersAvailable(playerName: "Elise", playerImage: UIImage(named: "HeadElise.png")!, LabelName: "Tripp")
            let PlayerPiper = PlayersAvailable(playerName: "piper", playerImage: UIImage(named: "PiperHeadReal.png")!, LabelName: "Piper")

            
            PlayersTemp.append(PlayerTripp)
            PlayersTemp.append(PlayerPiper)
            
            
        }
        
        
        return PlayersTemp
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
      //  print("new game view appeared")
        
        if prefs.bool(forKey: "MainMusicPlaying") {
            
            player1View.layer.add(rotate, forKey: "trippRotate")
            player2View.layer.add(rotateP, forKey: "piperRotate")
            
        } else {
            player1View.layer.removeAllAnimations()
            player2View.layer.removeAllAnimations()
        }
        
        
        Players = GetPlayersInfo(group: PlayingGroup)
        
        DispatchQueue.main.async(execute: {
         //   print("reload collection view, players count = \(Players.count)")
            self.CollectionView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func momBTN(_ sender: Any) {
        
        self.CharacterSelected = "mom"
        
        self.performSegue(withIdentifier: "StartGame", sender: self)
        
    }
    @IBAction func Player1BTN(_ sender: Any) {
        
        self.CharacterSelected = "tripp"
        
        self.performSegue(withIdentifier: "StartGame", sender: self)
        
    }
    
    
    @IBAction func Player2BTN(_ sender: Any) {
        
        self.CharacterSelected = "piper"
        
        self.performSegue(withIdentifier: "StartGame", sender: self)
    
    }
   
    
    @IBAction func closeBTN(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let destination = segue.destination as? LevelsViewController {
            // destination.GameName = GameNameInfo[GameIndex]
            destination.CharacterSelected = CharacterSelected
            destination.PlayerInfo = SelectedPlayerInfo
           // destination.newGame = SegueNewGame
           // destination.MediaType = SegueMediaType
           // destination.TempTurnNumber = SegueTurnNumber
            
        }
        
        
        
        
    }
    
    @IBAction func MusicToggle(_ sender: Any) {
        
        if prefs.bool(forKey: "MainMusicPlaying") {
            
            self.musicPlayerBTN.setImage(UIImage(named: "PlayIcon.png"), for: .normal)
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ToggleMusic"), object: nil, userInfo: ["update":"off"])
            
            
            player1View.layer.removeAllAnimations()
            
            player2View.layer.removeAllAnimations()
            
        } else {
            
            
            self.musicPlayerBTN.setImage(UIImage(named: "PauseIcon.png"), for: .normal)
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ToggleMusic"), object: nil, userInfo: ["update":"yes"])
            
            player1View.layer.add(rotate, forKey: "trippRotate")
            
            player2View.layer.add(rotateP, forKey: "piperRotate")
            
        }
    }
    
  
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Players.count
    }

    
    @objc func SelectPlayerClicked(_ sender: UIButton!) {
        
        
        let playerInfo = Players[sender.tag]
        
        self.CharacterSelected = playerInfo.playerName
        
        self.SelectedPlayerInfo = playerInfo
        
        
        print("CHARACTER SELECTED: \(CharacterSelected)")
        
        self.performSegue(withIdentifier: "StartGame", sender: self)
        
        //let TempSelectedTrait = TraitInventory()
        
        // var TheTrait = TotalTraitsInventoryArrayAdmin[sender.tag]
        
        /*
        
        let LevelInfo = Levels[sender.tag]
        
        LevelSelected = LevelInfo.Level
        
        let theAlert = SCLAlertView()
        theAlert.addButton("Yes") {
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ToggleMusic"), object: nil, userInfo: ["update":"yes"])
            
            
            self.performSegue(withIdentifier: "StartGame", sender: self)
            
        }
        
        theAlert.addButton("No") {
            
            
            
        }
        
        
        // theAlert.showCustomOK(UIImage(named: "PartyTraitsLogoCircle.png")!, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "View Trait Info?", subTitle: "Are you sure you want to view this player's assigned trait?")
        
        
        
        
        
        theAlert.showCustomOK(StartGameImage, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "Start?", subTitle: "Level: \(LevelSelected)", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
        */
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LevelsCollectionViewCell
        
        
        let PlayerInfo = Players[indexPath.row]
        
        cell.LevelLBL.text = PlayerInfo.LabelName as String
        
        let FontSizeTemp = DeviceW / 28.0588235
        
        cell.LevelLBL.font = UIFont(name: "Kailasa", size: CGFloat(FontSizeTemp))
        cell.playerImage.image = PlayerInfo.playerImage
        cell.playerImage.contentMode = .scaleAspectFit
        
      //  cell.layer.borderColor = UIColor.black.cgColor
      //  cell.layer.borderWidth = 1
      //  cell.layer.cornerRadius = 8
        
        
        cell.SelectLevelBTN.tag = (indexPath as NSIndexPath).row
        
        // if LevelInfo.Level != "1" {
        
        cell.SelectLevelBTN?.addTarget(self, action: #selector(NewGameViewController.SelectPlayerClicked(_:)), for: .touchUpInside)
            
            
        //cell.LevelLBL.textColor = UIColor.green
        //cell.layer.backgroundColor = UIColor.green.cgColor
            
        
        
        
        // Configure the cell
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        
        
        
        
        let CellW = DeviceW / 4.68
        
        print("Cell Size: \(CellW)")
        // let CellH = 64
        return CGSize(width: CellW, height: CellW)
        //return CGSizeMake(64, 64)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func difPlayers(_ sender: Any) {
        
        let GameBeaten = prefs.bool(forKey: "GameBeaten")
       
        /*
       
        if GameBeaten {
        
            
            let theAlert = SCLAlertView()
            
            
            theAlert.addButton("Yes") {
                
              
                
            }

            theAlert.addButton("Cancel") {
                
                
                
            }
            
            let StartGameImage2 = UIImage(named: "CandyIcon2.png")!
            
            // let randomIndex = Int(arc4random_uniform(UInt32(CandyResponseArray.count)))
            let CandyResponse = "Select the player group you'd like to play with"
            
            
            
            theAlert.showCustomOK(StartGameImage2, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "Other Players?", subTitle: "\(CandyResponse)", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
        
      
        
        
        } else {
            
            
            let StartGameImage = UIImage(named: "CandyIcon2.png")!
            
           // let randomIndex = Int(arc4random_uniform(UInt32(CandyResponseArray.count)))
            let CandyResponse = "You must complete each level with one Tripp or Piper before you can unlock other Players"
            
            let theAlert = SCLAlertView()
            
            
            theAlert.showCustomOK(StartGameImage, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "Other Players?", subTitle: "\(CandyResponse)", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
            
            
            */
             
             let theAlert = SCLAlertView()
             
             let firstTextField = theAlert.addTextField("Passcode")
             firstTextField.textAlignment = .center
             
             
             theAlert.addButton("Submit", action: {
             
             print("Saved Clicked")
             
             //let firstTextField = theAlert.te
             
             
            // if firstTextField.text == "dadisawesome" {
                if (1 == 1) {
                 //self.prefs.set("all", forKey: "PlayingGroup")
                
                self.PlayingGroup = "all"
                
                self.Players = self.GetPlayersInfo(group: self.PlayingGroup)
                
                DispatchQueue.main.async(execute: {
                    //   print("reload collection view, players count = \(Players.count)")
                    self.CollectionView.reloadData()
                })
                
             //if firstTextField.text != "" {
             
             
             /*
             self.prefs.set(true, forKey: "\(packID)PackUnlocked")
             self.prefs.set(true, forKey: "\(packID)PackEnabled")
             
             DispatchQueue.main.async(execute: {
             
             self.Packs = GetExpansionPackInfoNew()
             
             DispatchQueue.main.async(execute: {
             self.CollectionView.reloadData()
             })
             
             })
             */
             
             
             
             } else {
             let alertController2 = UIAlertController(title: "Incorrect", message: "Incorrect Passcode", preferredStyle: .alert)
             
             let cancelAction2 = UIAlertAction(title: "Ok", style: .default, handler: {
             (action : UIAlertAction!) -> Void in
             
             })
             
             alertController2.addAction(cancelAction2)
             
             self.present(alertController2, animated: true, completion: nil)
             }
             
             
             
             })
             
             
             
             /*
             let theAlert = SCLAlertView()
             
             theAlert.addButton("Submit") {
             
             self.prefs.set(true, forKey: "\(packID)PackUnlocked")
             
             
             DispatchQueue.main.async(execute: {
             
             self.Packs = GetExpansionPackInfo()
             
             DispatchQueue.main.async(execute: {
             self.CollectionView.reloadData()
             })
             
             })
             
             //  prefs.bool(forKey: "grandparentPackUnlocked")
             
             }
             */
             
             theAlert.addButton("Cancel") {
             
             }
             
             
             
             
             theAlert.showCustomOKText(UIImage(named: "lockIcon.png")!, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "Secret Players", subTitle: "You need to enter the correct code or beat level 50 with any player to unlock the secret players", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1, textTitle: "Code Word")
            
        
            
            
        }
        
   // }

}


struct PlayersAvailable {
    
    var playerName = String()
    var playerImage = UIImage()
    var LabelName = String()
   // var NextLevel = Bool()
    
}
