//
//  EnabledFriendsViewController.swift
//  Christmas2016
//
//  Created by Jared Stevens2 on 12/20/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class EnabledFriendsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    var NiceThings = [" Tripp and Piper must hug for 15 seconds, then you will receive the passcode", " Give your mother a hug, then you will receive the passcode", "Tell a funny joke (someone must laugh), then you will receive the passcode"]
    
    @IBOutlet weak var titleLBL: UILabel!
    let prefs:UserDefaults = UserDefaults.standard
    
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
        let CellH = CellW / 4
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
    
    @objc func SelectFriendSwitchClicked(_ sender: UISwitch!) {
        
        
        print("Switch tapped")
        let packSelected = Packs[sender.tag]
        
        let randomIndex = Int(arc4random_uniform(UInt32(NiceThings.count)))
        let NiceThingItem = NiceThings[randomIndex]
        
        let packName = packSelected.name
        
        let packID = packSelected.packname
        
        // let LevelInfo = Levels[sender.tag]
        
        // LevelSelected = LevelInfo.Level
        
        
        let PackEnabled = packSelected.enabled
        let PackUnlocked = packSelected.unlocked
        
        if PackEnabled {
            
            
            print("Pack was enabled, now it's not")
            prefs.set(false, forKey: "\(packID)PackEnabled")
            
            
            
        } else {
            
            if PackUnlocked {
                
                print("Pack wasn't enabled, now it is")
            
             prefs.set(true, forKey: "\(packID)PackEnabled")
                
            } else {
                
                
                
              
                
                let theAlert = SCLAlertView()
                
                let firstTextField = theAlert.addTextField("Passcode")
                firstTextField.textAlignment = .center
                
                
                theAlert.addButton("Submit", action: {
                    
                    print("Saved Clicked")
                    
                    //let firstTextField = theAlert.te
                    
                    
                    //if firstTextField.text == "\(packID)code" {
               // if firstTextField.text != "" {
                    if (1 == 1) {
                        
                        
                        self.prefs.set(true, forKey: "\(packID)PackUnlocked")
                        self.prefs.set(true, forKey: "\(packID)PackEnabled")
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.Packs = GetExpansionPackInfoNew()
                            
                            DispatchQueue.main.async(execute: {
                                self.CollectionView.reloadData()
                            })
                            
                        })
                        
                        
                        
                    } else {
                        let alertController2 = UIAlertController(title: "Incorrect", message: "Incorrect Passcode", preferredStyle: .alert)
                        
                        let cancelAction2 = UIAlertAction(title: "Ok", style: .default, handler: {
                            (action : UIAlertAction!) -> Void in
                            
                            sender.setOn(false, animated: true)
                            
                        })
                        
                        alertController2.addAction(cancelAction2)
                        
                        self.present(alertController2, animated: true, completion: nil)
                    }
                    
                    
                    
                })
          
                
                theAlert.addButton("Cancel") {
                    
                }
                
                
                
                
                theAlert.showCustomOKText(UIImage(named: "lockIcon.png")!, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "\(packName) Pack", subTitle: "Unlock \(packName) Expansion Pack?  \(NiceThingItem)", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1, textTitle: "Code Word")

                
                
                
                
                
            }
            
            
            
        }
        
        
        
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
        
        theAlert.addButton("Cancel") {
            
        }
        
        
        // theAlert.showCustomOK(UIImage(named: "PartyTraitsLogoCircle.png")!, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "View Trait Info?", subTitle: "Are you sure you want to view this player's assigned trait?")
        
        
        
        
        
        theAlert.showCustomOK(UIImage(named: "lockIcon.png")!, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "Expansion Pack", subTitle: "Unlock \(packName) Expansion Pack?", duration: nil, completeText: "", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        */
        
        
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
       // cell.packInfoLBL.text = packInfo.info
        
        
        cell.holderView.layer.cornerRadius = 10
        //  cell.layer.borderColor = UIColor.black.cgColor
        //  cell.layer.borderWidth = 1
        //  cell.layer.cornerRadius = 8
        
        
       // cell.SelectLevelBTN.tag = (indexPath as NSIndexPath).row
        
        // if LevelInfo.Level != "1" {
        
       // cell.SelectLevelBTN?.addTarget(self, action: #selector(StoreViewController.SelectPackClicked(_:)), for: .touchUpInside)
        
        cell.packSwitch.tag = (indexPath as NSIndexPath).row
        
        cell.packSwitch.addTarget(self, action: #selector(EnabledFriendsViewController.SelectFriendSwitchClicked(_:)), for: .touchUpInside)
        
        if packInfo.enabled {
            
            cell.packSwitch.setOn(true, animated: false)
        } else {
            cell.packSwitch.setOn(false, animated: false)
        }
        
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
