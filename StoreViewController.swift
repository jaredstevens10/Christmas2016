//
//  StoreViewController.swift
//  Christmas2016
//
//  Created by Jared Stevens2 on 12/20/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
   
    @IBOutlet weak var titleLBL: UILabel!
    let prefs:UserDefaults = UserDefaults.standard
    
    var NiceThings = [" Tripp and Piper must hug for 15 seconds, then you will receive the passcode", " Give your mother a hug, then you will receive the passcode", "Tell a funny joke (someone must laugh), then you will receive the passcode"]
    
    let reuseIdentifier = "LevelCell"
    var Packs = [ExpansionPack]()
    var PackSelected = ExpansionPack()
    
         @IBOutlet weak var CollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        
        self.CollectionView.setContentOffset(CollectionView.contentOffset, animated:false)
        
        self.CollectionView.backgroundColor = UIColor.clear
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2, left: 10, bottom: 0, right: 10)
        
        
        // let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        // let DeviceW = self.view.frame.width
        let CellW = DeviceW / 1.1
        let CellH = (CellW) / 2
        layout.itemSize = CGSize(width: CellW, height: CellH)
        layout.scrollDirection = .vertical
        
        CollectionView.collectionViewLayout = layout

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
       
        
        
        Packs = GetExpansionPackInfoNew()
        
        DispatchQueue.main.async(execute: {
            self.CollectionView.reloadData()
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backBTN(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Packs.count
    }
    
    func SelectPackClicked(_ sender: UIButton!) {
        
        
        let packSelected = Packs[sender.tag]
        
        
        // var PackSelected = ExpansionPack()
        
       // self.CharacterSelected = playerInfo.playerName
        
        //self.SelectedPlayerInfo = playerInfo
        
        
       // print("CHARACTER SELECTED: \(CharacterSelected)")
        
       // self.performSegue(withIdentifier: "StartGame", sender: self)
        
        //let TempSelectedTrait = TraitInventory()
        
        // var TheTrait = TotalTraitsInventoryArrayAdmin[sender.tag]
        
        let packName = packSelected.name
        
        let packID = packSelected.packname
         
        // let LevelInfo = Levels[sender.tag]
         
        // LevelSelected = LevelInfo.Level
        
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(NiceThings.count)))
        let NiceThingItem = NiceThings[randomIndex]
        
        
        
        let theAlert = SCLAlertView()
        
        let firstTextField = theAlert.addTextField("Passcode")
        firstTextField.textAlignment = .center
        
        
        theAlert.addButton("Submit", action: {
            
            print("Saved Clicked")
            
            //let firstTextField = theAlert.te
            
            
            if firstTextField.text == "\(packID)code" {
                //if firstTextField.text != "" {
                
                
                
                self.prefs.set(true, forKey: "\(packID)PackUnlocked")
                self.prefs.set(true, forKey: "\(packID)PackEnabled")
                
                DispatchQueue.main.async(execute: {
                    
                    self.Packs = GetExpansionPackInfoNew()
                    
                    DispatchQueue.main.async(execute: {
                        self.CollectionView.reloadData()
                    })
                    
                })
                
                /*
                
                let TempPlayerTraitInfo = self.GameTotalTraitInfo[self.PlayerRowSelected]
                
                let temptraitname = TempPlayerTraitInfo.traitname
                let temptraitimageURL = TempPlayerTraitInfo.imageURL
                let temptraitlevel = TempPlayerTraitInfo.traitlevel
                let temptraitid = TempPlayerTraitInfo.traitid
                let tempimagedata = TempPlayerTraitInfo.traitimagedata
                let tempdescription = TempPlayerTraitInfo.traitdescription
                let templocalTrait = TempPlayerTraitInfo.localTrait
                let tempPlayer = TempPlayerTraitInfo.Player
                let tempPlayerName = firstTextField.text
                
                
                let TempPlayerTraitInfoUpdated = TraitInventoryPlayer(traitname: temptraitname as NSString, imageURL: temptraitimageURL, traitlevel: temptraitlevel, traitid: temptraitid, traitimagedata: tempimagedata, traitdescription: tempdescription as NSString, localTrait: templocalTrait, Player: tempPlayer, PlayerName: tempPlayerName!)
                
                
                self.GameTotalTraitInfo.remove(at: self.PlayerRowSelected);
                self.GameTotalTraitInfo.insert(TempPlayerTraitInfoUpdated, at: self.PlayerRowSelected)
                self.PlayerNamesArray.remove(at: self.PlayerRowSelected);
                self.PlayerNamesArray.insert(tempPlayerName!, at: self.PlayerRowSelected)
                // self.PlayerIDs.remove(at: self.PlayerRowSelected);
                // self.PlayerIDs.insert("NONE", at: self.PlayerRowSelected)
                
                
                
                
                DispatchQueue.main.async(execute: {
                    
                    //self.GameTotalTraitInfo = GameTotalTraitInfoTemp
                    
                    
                    
                    print("Should have completed loading the next round")
                    print("****Next round traits: \(self.GameTotalTraitInfo)")
                    // self.CurrentGroupGameInfo = GroupGameInfoUpdate(Round)
                    
                    /*
                     self.CurrentGroupGameInfo = GroupGameInfoUpdate(dictionary: ["Round":"\(self.currentRound)" as AnyObject,"NumPlayersArray":"\(self.currentRound)" as AnyObject,"NumPlayers":"\(self.NumberPlayersArray.count)" as AnyObject,"TraitsAvailable":"\(self.TotalTraits)" as AnyObject,"TraitsUsed":"\(self.TraitsUsed)" as AnyObject,"CurrentRoundTraits":"\(self.GroupGameTraits)" as AnyObject,"maxRounds":"\(self.GroupGameMaxRoundsInt)" as AnyObject])
                     
                     */
                    
                    //self.CurrentGroupGameInfo = GroupGameInfoUpdate(Round: self.currentRound)
                    self.CurrentGroupGameInfo = GroupGameInfoUpdate(Round: self.currentRound, NumPlayersArray: self.NumberPlayersArray, NumPlayers: self.NumberPlayersArray.count, TraitsAvailable: self.TotalTraits, TraitsUsed: self.TraitsUsed, CurrentRoundTraits: self.GroupGameTraits, maxRounds: self.GroupGameMaxRoundsInt, PlayerNames: self.PlayerNamesArray)
                    
                    //  self.CurrentGroupGameInfo = GroupGameInfoUpdate(
                    
                    //self.prefs.set(self.CurrentGroupGameInfo, forKey: "CurrentGroupGameInfo")
                    
                    
                    
                    //  let CurrentGroupGameInfoArray = [self.CurrentGroupGameInfo]
                    
                    
                    let EncodedCurrentGroupGameInfo = self.CurrentGroupGameInfo?.encode()
                    
                    print("Encoded Group Game Info: \(EncodedCurrentGroupGameInfo)")
                    
                    // self.prefs.set(self.CurrentGroupGameInfo, forKey: "CurrentGroupGameInfo")
                    self.prefs.set(EncodedCurrentGroupGameInfo, forKey: "CurrentGroupGameInfo")
                    
                    
                    self.TableView.reloadData()
                    
                    
                    
                })
                
                
                // self.TableView.reloadData()
                
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
         

        
        
        theAlert.showCustomOKText(UIImage(named: "lockIcon.png")!, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "\(packName) Pack", subTitle: "Unlock \(packName) Expansion Pack?  \(NiceThingItem)", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1, textTitle: "Code Word")
        
         
         
      //  theAlert.showCustomOKText(UIImage(named: "lockIcon.png")!, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "Expansion Pack", subTitle: "Unlock \(packName) Expansion Pack?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LevelsCollectionViewCell
        
        
        let packInfo = Packs[indexPath.row]
        
        cell.LevelLBL.text = packInfo.name as String
        
        let FontSizeTemp = DeviceW / 22.0588235
        
        cell.LevelLBL.font = UIFont(name: "Kailasa", size: CGFloat(FontSizeTemp))
        
        cell.playerImage.image = packInfo.packImage
        cell.playerImage.contentMode = .scaleAspectFit
        cell.packInfoLBL.text = packInfo.info
        
        if packInfo.unlocked {
            cell.lockedView.isHidden = true
        } else {
            cell.lockedView.isHidden = false
        }
        
        //  cell.layer.borderColor = UIColor.black.cgColor
        //  cell.layer.borderWidth = 1
        //  cell.layer.cornerRadius = 8
        
        
        cell.SelectLevelBTN.tag = (indexPath as NSIndexPath).row
        
        // if LevelInfo.Level != "1" {
        
        cell.SelectLevelBTN?.addTarget(self, action: #selector(StoreViewController.SelectPackClicked(_:)), for: .touchUpInside)
        
        
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

}

struct ExpansionPack {
    
    var name = String()
    var packImage = UIImage()
    var info = String()
    var unlocked = Bool()
    var packname = String()
    var PackMembers = [FriendInfo]()
    var enabled = Bool()
    var visible = Bool()
    // var NextLevel = Bool()
    
}
