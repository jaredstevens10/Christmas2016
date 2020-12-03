//
//  LevelsViewController.swift
//  Christmas2016
//
//  Created by Jared Stevens2 on 12/12/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
//import AVFoundation

class LevelsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var topView_H: NSLayoutConstraint!
    
    let prefs:UserDefaults = UserDefaults.standard

    @IBOutlet weak var CharacterName: UILabel!
    
    var PlayerInfo = PlayersAvailable()
    
    // var musicPlayer: AVAudioPlayer!

    let reuseIdentifier = "LevelCell"
    
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    let itemsPerRow: CGFloat = 3
    
    var CharacterSelected = String()
    var LevelSelected = String()
    
    var StartGameImage = UIImage()
    
    
    var Levels = [LevelsAvailable]()
    
    var LevelsCountTemp = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50"]
    
    
     @IBOutlet weak var CollectionView: UICollectionView!
    
    
    func GetLevelInfo(Character: String) -> [LevelsAvailable]{
     var LevelsTemp = [LevelsAvailable]()
        
    
        var i = 0
        
        for item in LevelsCountTemp {
    
        let LevelCompleteInfo = prefs.bool(forKey: "\(CharacterSelected)Level\(item)Complete")
            
            
        var HighestLevelTemp = String()
            
            
            
            
            switch CharacterSelected {
                
                case "piper":
                
                    
                    if prefs.value(forKey: "piperHighestLevelComplete") == nil {
                        HighestLevelTemp = "0"
                        //HighestLevelTemp = "49"
                    } else {
                        HighestLevelTemp = prefs.value(forKey: "piperHighestLevelComplete") as! String
                }
 
                //HighestLevelTemp = "49"
                
                case "tripp":
                
                    if prefs.value(forKey: "trippHighestLevelComplete") == nil {
                        
                        print("HIGHEST LEVEL COMPLETE IS NIL")
                        HighestLevelTemp = "0"
                        //HighestLevelTemp = "49"
                    } else {
                        HighestLevelTemp = prefs.value(forKey: "trippHighestLevelComplete") as! String
                    }
 
                //HighestLevelTemp = "49"
                
                
                case "mom":
                
                    
                    if prefs.value(forKey: "trippHighestLevelComplete") == nil {
                        
                        print("HIGHEST LEVEL COMPLETE IS NIL")
                        HighestLevelTemp = "0"
                        //HighestLevelTemp = "49"
                    } else {
                        HighestLevelTemp = prefs.value(forKey: "trippHighestLevelComplete") as! String
                     }
 
                //HighestLevelTemp = "49"
                
            default:
                //break
                
                
                
                if prefs.value(forKey: "\(PlayerInfo.playerName)HighestLevelComplete") == nil {
                    
                    print("HIGHEST LEVEL COMPLETE IS NIL")
                    HighestLevelTemp = "0"
                } else {
                    HighestLevelTemp = prefs.value(forKey: "\(PlayerInfo.playerName)HighestLevelComplete") as! String
                    
                    print("UH OH ERROR")
                }
                
                
                
            }
            
            /*
        if CharacterSelected == "piper" {
            if prefs.value(forKey: "piperHighestLevelComplete") == nil {
                HighestLevelTemp = "0"
            } else {
                HighestLevelTemp = prefs.value(forKey: "piperHighestLevelComplete") as! String
            }
        }  else {
    
            if prefs.value(forKey: "trippHighestLevelComplete") == nil {
                
                print("HIGHEST LEVEL COMPLETE IS NIL")
                HighestLevelTemp = "0"
            } else {
                HighestLevelTemp = prefs.value(forKey: "trippHighestLevelComplete") as! String
            }
        }

            */
            
            print("*****Highest Level Completed: \(HighestLevelTemp)")
          
        let itemInt = Int(item)!
        
        let HighestLevel = Int(HighestLevelTemp)!
            
        var NextLevel = Bool()
            
            if (HighestLevel + 1) == itemInt {
                
             //   print("Highest level = \(itemInt)")
                
                NextLevel = true
                
            } else {
                
                NextLevel = false
                
            }
            
       print("Getting Level: \(CharacterSelected)Level\(item)Complete - is it Complete? \(LevelCompleteInfo), this is the next level to complete = \(NextLevel)")
            
            LevelsTemp.append(LevelsAvailable(Level: item,Completed: LevelCompleteInfo, NextLevel: NextLevel))
            
            
        }
    
    
        
        return LevelsTemp
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Levels Loaded - Character Selected: \(CharacterSelected)")
        
        
        Levels = GetLevelInfo(Character: CharacterSelected)
        
        
       
        switch CharacterSelected {
           
            
            case "piper":
            
                StartGameImage = UIImage(named: "PiperHead.png")!
                
                self.CharacterName.text = "Piper"
            
            case "tripp":
            
                StartGameImage = UIImage(named: "TrippHeadSmile.png")!
                
                self.CharacterName.text = "Tripp"
            
            /*
            case "mom":
            
                StartGameImage = UIImage(named: "TrippHeadSmile.png")!
                
                self.CharacterName.text = "Mom"
            
            */
            
        default:
            StartGameImage = PlayerInfo.playerImage
            self.CharacterName.text = PlayerInfo.LabelName
            
            
            
            
        }
        
        
        
        /*
        if CharacterSelected == "piper" {
            
            StartGameImage = UIImage(named: "PiperHead.png")!
            
            self.CharacterName.text = "Piper"
        } else {
            StartGameImage = UIImage(named: "TrippHeadSmile.png")!
            
            self.CharacterName.text = "Tripp"
            
        }
        
        */
        
         NotificationCenter.default.addObserver(self, selector: #selector(LevelsViewController.LevelCloseUpdate(_:)), name: NSNotification.Name(rawValue: "LevelCloseUpdate"),  object: nil)
        
        
        self.CollectionView.setContentOffset(CollectionView.contentOffset, animated:false)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2, left: 10, bottom: 0, right: 10)
        
        
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        let CellW = DeviceW / 4.68
        
        layout.itemSize = CGSize(width: CellW, height: CellW)
        layout.scrollDirection = .vertical
        
        CollectionView.collectionViewLayout = layout
        
       // self.CollectionView.delegate = self
       // self.CollectionView.dataSource = self
        
       // self.CollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        Levels = GetLevelInfo(Character: CharacterSelected)
        
        DispatchQueue.main.async(execute: {
          self.CollectionView.reloadData()
        })
    }
    
    @objc func LevelCloseUpdate(_ notification:Notification) {
        
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
        
        
        
        if didWin {
            
            
            var theImage = UIImage()
            
           
            
            
            let completeView:LevelCompleteView = UINib(nibName: "LevelCompleteView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LevelCompleteView
            
            completeView.character = character
            
            switch character {
                case "tripp":
                    
                    var theImages = [UIImage(named: "TrippYea.png")!]
                    let randomIndex = Int(arc4random_uniform(UInt32(theImages.count)))
                    theImage = theImages[randomIndex]
                    
                    completeView.imageHolder.image = theImage
                case "piper":
                    
                    var theImages = [UIImage(named: "PiperHighFive.png")!]
                    let randomIndex = Int(arc4random_uniform(UInt32(theImages.count)))
                    theImage = theImages[randomIndex]
                    
                    completeView.imageHolder.image = theImage
                
                case "mom":
                
                var theImages = [UIImage(named: "Meg Head.png")!]
                let randomIndex = Int(arc4random_uniform(UInt32(theImages.count)))
                theImage = theImages[randomIndex]
                
                completeView.imageHolder.image = theImage
                
            default:
                
                var theImages = [self.PlayerInfo.playerImage]
                let randomIndex = Int(arc4random_uniform(UInt32(theImages.count)))
                theImage = theImages[randomIndex]
                
                completeView.imageHolder.image = theImage
                
 
                
            }
            
            let DeviceH = self.view.frame.height
            //let halfH = DeviceH / 2;
            let DeviceW = self.view.frame.width
            //let WLess10 = DeviceW - 10;
            let startX = (DeviceW / 2) - 125;
            let startY = (DeviceH / 2) - 125;
            
            
            completeView.alpha = 0.0
            completeView.smallHolderView.layer.cornerRadius = 10
            completeView.smallHolderView.layer.masksToBounds = true
            completeView.smallHolderView.clipsToBounds = true
            completeView.frame = UIScreen.main.bounds
            
            self.view.addSubview(completeView)
            
            
            UIView.animate(withDuration: 0.25, animations: {
                completeView.alpha = 1.0
            })
            
            
            
            /*
 
         let completeView:LevelCompleteView = UINib(nibName: "LevelCompleteView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LevelCompleteView
         
         
        // completeView?.text = TraitNameFinal as String
        // completeView?.text = TheTrait.traitdescription as String
         // completeView.TheTraitImage? = image as UIImage
         //completeView.TraitImageURL = imageURLname
         
         
         
         let DeviceH = self.view.frame.height
         //let halfH = DeviceH / 2;
         let DeviceW = self.view.frame.width
         //let WLess10 = DeviceW - 10;
         let startX = (DeviceW / 2) - 125;
         let startY = (DeviceH / 2) - 125;
         
         
         completeView.alpha = 0.0
         //myTraitView.theView.layer.cornerRadius = 10
         //myTraitView.theView.layer.masksToBounds = true
         //myTraitView.theView.clipsToBounds = true
         completeView.frame = UIScreen.main.bounds
         
         self.view.addSubview(completeView)

         UIView.animate(withDuration: 0.25, animations: {
         completeView.alpha = 1.0
         })
            
            
            */
            
        } else {
            
            var theImage = UIImage()
            
            
            
            
            let completeView:LevelFailView = UINib(nibName: "LevelFailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LevelFailView
            
            completeView.character = character
            
            switch character {
            case "tripp":
                
                var theImages = [UIImage(named: "TrippCry.png")!,UIImage(named: "TrippTear.png")!,UIImage(named: "TrippBummer.png")!]
                let randomIndex = Int(arc4random_uniform(UInt32(theImages.count)))
                theImage = theImages[randomIndex]
                
                completeView.imageHolder.image = theImage
            case "piper":
                
                var theImages = [UIImage(named: "PiperCry.png")!,UIImage(named: "PiperTear.png")!,UIImage(named: "PiperBummer.png")!]
                let randomIndex = Int(arc4random_uniform(UInt32(theImages.count)))
                theImage = theImages[randomIndex]
                
                completeView.imageHolder.image = theImage
                
                
            case "mom":
                
                var theImages = [UIImage(named: "PiperCry.png")!,UIImage(named: "PiperTear.png")!,UIImage(named: "PiperBummer.png")!]
                let randomIndex = Int(arc4random_uniform(UInt32(theImages.count)))
                theImage = theImages[randomIndex]
                
                completeView.imageHolder.image = theImage
                
            default:
                
                var theImages = [UIImage(named: "TrippCry.png")!,UIImage(named: "TrippTear.png")!,UIImage(named: "TrippBummer.png")!]
                let randomIndex = Int(arc4random_uniform(UInt32(theImages.count)))
                theImage = theImages[randomIndex]
                
                completeView.imageHolder.image = theImage
                
                
                
            }
            
            let DeviceH = self.view.frame.height
            //let halfH = DeviceH / 2;
            let DeviceW = self.view.frame.width
            //let WLess10 = DeviceW - 10;
            let startX = (DeviceW / 2) - 125;
            let startY = (DeviceH / 2) - 125;
            
            
            completeView.alpha = 0.0
            completeView.smallHolderView.layer.cornerRadius = 10
            completeView.smallHolderView.layer.masksToBounds = true
            completeView.smallHolderView.clipsToBounds = true
            completeView.frame = UIScreen.main.bounds
            
            self.view.addSubview(completeView)
            
            
            UIView.animate(withDuration: 0.25, animations: {
                completeView.alpha = 1.0
            })
            
        }
        
        
        
        
        print("BACK ON LEVELS VIEW CONTROLLER: Did \(character) win: \(didWin)")
        
        
        //self.dismiss(animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return Levels.count
        return 1
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Levels.count
    }
    

    
    @objc func SelectLevelClicked(_ sender: UIButton!) {
        
        
        print("Select Level Clicked")
        //let TempSelectedTrait = TraitInventory()
        
       // var TheTrait = TotalTraitsInventoryArrayAdmin[sender.tag]
        
        let LevelInfo = Levels[sender.tag]
        
        LevelSelected = LevelInfo.Level
        
       // self.performSegue(withIdentifier: "StartGame", sender: self)
        
        
        
        
        let theAlert = SCLAlertView()
        theAlert.addButton("Yes") {
            
           // NotificationCenter.default.post(name: Notification.Name(rawValue: "ToggleMusic"), object: nil, userInfo: ["update":"yes"])
            
           
            self.performSegue(withIdentifier: "StartGame", sender: self)
            
        }
        
        theAlert.addButton("No") {
            
           
            
        }
        
        
        // theAlert.showCustomOK(UIImage(named: "PartyTraitsLogoCircle.png")!, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "View Trait Info?", subTitle: "Are you sure you want to view this player's assigned trait?")
        
        
        
        
        
        theAlert.showCustomOK(StartGameImage, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "Start?", subTitle: "Level: \(LevelSelected)", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
        
 
        
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LevelsCollectionViewCell
        
        
        let LevelInfo = Levels[indexPath.row]
        
        cell.LevelLBL.text = LevelInfo.Level as String
        
        let FontSizeTemp = DeviceW / 22.0588235

        cell.LevelLBL.font = UIFont(name: "Kailasa", size: CGFloat(FontSizeTemp))
        
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        
        
        cell.SelectLevelBTN.tag = (indexPath as NSIndexPath).row
        
       // if LevelInfo.Level != "1" {
        
        if LevelInfo.Completed {
        
        cell.SelectLevelBTN?.addTarget(self, action: #selector(LevelsViewController.SelectLevelClicked(_:)), for: .touchUpInside)
            
            
      //  cell.LevelLBL.textColor = UIColor.green
            cell.layer.backgroundColor = UIColor.green.cgColor
        
        } else {
            
            
     //   cell.LevelLBL.textColor = UIColor.red
            
            if LevelInfo.NextLevel {
                
            cell.SelectLevelBTN?.addTarget(self, action: #selector(LevelsViewController.SelectLevelClicked(_:)), for: .touchUpInside)
                
            cell.layer.backgroundColor = UIColor.yellow.cgColor
                
            } else {
                
            
            cell.layer.backgroundColor = UIColor(red: 0.9, green: 0.3, blue: 0.3, alpha: 1.0).cgColor
                
            }//UIColor.l UIColor.red.cgColor
            
        
            
        }
        
        /*else {
            
            
         cell.SelectLevelBTN?.addTarget(self, action: #selector(LevelsViewController.SelectLevelClicked(_:)), for: .touchUpInside)
            
        cell.layer.backgroundColor = UIColor.yellow.cgColor
         
        // cell.LevelLBL.textColor = UIColor.blue
            
            
        }
        */
        
        
        
        // Configure the cell
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let destination = segue.destination as? GameViewController {

            destination.CharacterSelected = CharacterSelected
            destination.LevelSelected = LevelSelected
            destination.PlayerInfo = PlayerInfo
            
        }
        
        
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        
        print("Item Selected")
        
       // LevelSelected = Levels[indexPath.row]
        
      //  self.performSegue(withIdentifier: "StartGame", sender: self)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
       // cell?.backgroundColor = UIColor.green
    }
    
    
    @IBAction func BackBTN(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
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
    
 
     private func updateCollectionViewLayout(with size: CGSize) {
     var margin : CGFloat = 0;
     margin = 10
        /*
     if isIPad {
     margin = 10
     }
     else{
     margin = 6
     /* if UIDevice.current.type == .iPhone6plus || UIDevice.current.type == .iPhone6Splus || UIDevice.current.type == .simulator{
     margin = 10
     
     }
 */
 
     }
        */
        
     if let layout = CollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
     layout.itemSize = CGSize(width:(self.view.frame.width/2)-margin, height:((self.view.frame.height-64)/4)-3)
     layout.invalidateLayout()
     }
        
     }
     
 

    
    //  UICollectionViewDelegateFlowLayout {
    //1
    
    /*
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    */


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func friendsBTN(_ sender: Any) {
        
       self.performSegue(withIdentifier: "enable", sender: self)
        
    }
    
    

}


struct LevelsAvailable {
    
 var Level = String()
 var Completed = Bool()
 var NextLevel = Bool()
  
}
