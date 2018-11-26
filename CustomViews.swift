//
//  CustomViews.swift
//  Christmas2016
//
//  Created by Jared Stevens2 on 12/14/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit


class HowToView: UIView {
    
    
    @IBOutlet weak var howtoLBL1_H: NSLayoutConstraint!
    @IBOutlet weak var howtoLBL2_H: NSLayoutConstraint!
    @IBOutlet weak var viewLBL_H: NSLayoutConstraint!
    
    @IBOutlet weak var howtoLBL1: UILabel!
    
    @IBOutlet weak var howtoLBL2: UILabel!
    
    @IBOutlet weak var candyGrabLBL: UILabel!
    
    
   // @IBOutlet weak var howtoLBL3: UILabel!
   
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    let prefs:UserDefaults = UserDefaults.standard
    
    var isOpen = Bool()
    var TimerCount = Int()
    
    @IBOutlet weak var HideBTN_H: NSLayoutConstraint!
    
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var holderView: UIView!
    
    @IBOutlet weak var imageHolder: UIImageView!
    
    @IBOutlet weak var smallHolderView: UIView!
    
    @IBOutlet weak var viewLBL: UILabel!
    
    //var PiperImage = UIImage(named: "PiperHighFive.png")
    
    var TimeAmount = String()
    
    var character = String()
    
    /*
     var traitTextTitle: String? {
     didSet {
     traitTitle.text = traitTextTitle
     }
     }
     */
    
    var viewDesc: String? {
        didSet {
            viewLBL.text = viewDesc
        }
    }
    
    /*
     var TheTraitImage: UIImage? {
     didSet {
     traitImage.image = TheTraitImage
     }
     }
     
     */
    
    var TraitImageURLTemp = String()
    
    //var imageURLname: String?
    var TraitImageURL: String? {
        didSet {
            TraitImageURLTemp = TraitImageURL!
        }
    }
    
    
    
    
    
    
    var buttonClicked = Bool()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let subView: UIView = loadViewFromNib()
        let bounds = UIScreen.main.bounds
        
        
        /*
         subView.smallHolderView.layer.cornerRadius = 10
         subView.smallHolderView.layer.masksToBounds = true
         subView.smallHolderView.clipsToBounds = true
         
         subView.hideBTN.layer.cornerRadius = 25
         subView.hideBTN.layer.masksToBounds = true
         subView.hideBTN.clipsToBounds = true
         subView.hideBTN.layer.borderColor = UIColor.white.cgColor
         subView.hideBTN.layer.borderWidth = 2
         
         */
        
        
        let DeviceH = bounds.size.height
        //let halfH = DeviceH / 2;
        let DeviceW = bounds.size.width
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;
        print("Start x = \(startX)")
        //subView.layer.masksToBounds = true
        // subView.clipsToBounds = true
        // subView.layer.cornerRadius = 10
        
        // myRemindView.alpha = 0.0
        // myRemindView.frame = CGRectMake(startX, startY, 250, 250)
        //subView.frame = CGRectMake(startX, startY, 250, 250)
        subView.frame = self.bounds
        //label1.text = "123" //would cause error
        addSubview(subView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func loadViewFromNib() -> UIView {
        let view: UIView = UINib(nibName: "HowToView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        
        
        
        
        return view
    }
    
    
    
    
    override func awakeFromNib() {
        
        /*
         view = instanceFromNib()
         view.frame = bounds
         view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         view.translatesAutoresizingMaskIntoConstraints = true
         
         addSubview(view)
         */
        
       // self.smallHolderView.layer.cornerRadius = 10
      //  self.smallHolderView.layer.masksToBounds = true
      //  self.smallHolderView.clipsToBounds = true
        
        let DeviceH = prefs.value(forKey: "DeviceH") as! Double
        //let halfH = DeviceH / 2;
        let DeviceW = prefs.value(forKey: "DeviceW") as! Double
        
        let HideBTN_Height = DeviceW / 6.25
        self.HideBTN_H.constant = CGFloat(HideBTN_Height)
        
        self.viewLBL_H.constant = CGFloat(DeviceW) / 3.75
        
        self.howtoLBL1_H.constant = CGFloat(DeviceW) / 3.75
        
        self.howtoLBL2_H.constant = CGFloat(DeviceW) / 3.75
        
        
        let FontSizeTemp = DeviceW / 22.0588235
        
        let FontSizeTempTitle = DeviceW / 10
        
        let FontSizeTempBTN = DeviceW / 20
        
        //howtoLBL1(FontSizeTemp)
        
       // self.CandyGrabLBL.font = UIFont(name: "Noteworthy Light", size: FontSizeTemp)
        
        
        self.howtoLBL1.font = UIFont(name: "Noteworthy", size: CGFloat(FontSizeTemp))
        
        self.howtoLBL2.font = UIFont(name: "Noteworthy", size: CGFloat(FontSizeTemp))
        
        self.viewLBL.font = UIFont(name: "Noteworthy", size: CGFloat(FontSizeTemp))
        
        
        self.candyGrabLBL.font = UIFont(name: "Party LET", size: CGFloat(FontSizeTempTitle))
        
       // self.musicBTN_W.constant = musicBTN_Height
       // self.musicPlayerBTN.layer.cornerRadius = (musicBTN_Height / 2)
        
        
        
        self.hideBTN.layer.cornerRadius = (CGFloat(HideBTN_Height) / 2)
        self.hideBTN.layer.masksToBounds = true
        self.hideBTN.clipsToBounds = true
        self.hideBTN.layer.borderColor = UIColor.white.cgColor
        self.hideBTN.layer.borderWidth = 4
        
        self.hideBTN.titleLabel?.font = UIFont(name: "Noteworthy", size: CGFloat(FontSizeTempBTN))
        
        
        //self.imageHolder.image = UIImage(named: "PiperHighGive.png")
        //PiperImage
        /*
         
         // TraitImageURLTemp = prefs.value(forKey: "GroupViewingPlayerTraitImageURL") as! String
         
         // print("Trait View Image URL: \(TraitImageURLTemp)")
         
         let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(TraitImageURLTemp).png")
         print("Trait View url for image = \(url)")
         let theImageData = try? Data(contentsOf: url)
         
         //TestImage = UIImage(data:theImageData!)!
         
         let image  = UIImage(data: theImageData!)!
         
         
         self.traitImage.image = image
         self.traitImage.contentMode = .scaleAspectFit
         
         */
        
        /*
         let randomIndex = Int(arc4random_uniform(UInt32(NumColors.count)))
         
         
         self.lblView.layer.cornerRadius = 10
         self.pickerView.layer.cornerRadius = 10
         
         self.lblView.layer.borderWidth = 2
         self.pickerView.layer.borderWidth = 2
         self.lblView.layer.borderColor = NumColors[randomIndex].cgColor
         self.pickerView.layer.borderColor = NumColors[randomIndex].cgColor
         */
        // self.pickerView.dataSource = self;
        // self.pickerView.delegate = self;
        
        //Do something here when it wakes
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    @IBAction func reportContent(_ sender: Any) {
        
        
        
    }
    
    @IBAction func hideBTN(_ sender: AnyObject) {
        
        prefs.set(true, forKey: "NotFirstView")
        
        UIView.animate(withDuration: 0.75, animations: {
            self.alpha = 0.0
        })
        
        
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "LevelCompleteView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
        }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
}

class LevelCompleteView: UIView {
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    let prefs:UserDefaults = UserDefaults.standard
    
    var isOpen = Bool()
    var TimerCount = Int()
    
   
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var holderView: UIView!
    
    @IBOutlet weak var imageHolder: UIImageView!
    
    @IBOutlet weak var smallHolderView: UIView!
    
    @IBOutlet weak var viewLBL: UILabel!
    
    //var PiperImage = UIImage(named: "PiperHighFive.png")
    
    var TimeAmount = String()
    
    var character = String()
    
    /*
    var traitTextTitle: String? {
        didSet {
            traitTitle.text = traitTextTitle
        }
    }
    */
    
    var viewDesc: String? {
        didSet {
            viewLBL.text = viewDesc
        }
    }
    
    /*
     var TheTraitImage: UIImage? {
     didSet {
     traitImage.image = TheTraitImage
     }
     }
     
     */
    
    var TraitImageURLTemp = String()
    
    //var imageURLname: String?
    var TraitImageURL: String? {
        didSet {
            TraitImageURLTemp = TraitImageURL!
        }
    }
    
   
    
    
    
    
    var buttonClicked = Bool()
    
   
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let subView: UIView = loadViewFromNib()
        let bounds = UIScreen.main.bounds
        
       
        /*
        subView.smallHolderView.layer.cornerRadius = 10
        subView.smallHolderView.layer.masksToBounds = true
        subView.smallHolderView.clipsToBounds = true
        
        subView.hideBTN.layer.cornerRadius = 25
        subView.hideBTN.layer.masksToBounds = true
        subView.hideBTN.clipsToBounds = true
        subView.hideBTN.layer.borderColor = UIColor.white.cgColor
        subView.hideBTN.layer.borderWidth = 2
        
        */
        
        
        let DeviceH = bounds.size.height
        //let halfH = DeviceH / 2;
        let DeviceW = bounds.size.width
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;
        print("Start x = \(startX)")
        //subView.layer.masksToBounds = true
        // subView.clipsToBounds = true
        // subView.layer.cornerRadius = 10
        
        // myRemindView.alpha = 0.0
        // myRemindView.frame = CGRectMake(startX, startY, 250, 250)
        //subView.frame = CGRectMake(startX, startY, 250, 250)
        subView.frame = self.bounds
        //label1.text = "123" //would cause error
        addSubview(subView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func loadViewFromNib() -> UIView {
        let view: UIView = UINib(nibName: "LevelCompleteView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        
        
        return view
    }
    
    
    
    
    override func awakeFromNib() {
        
        /*
        view = instanceFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
        */
        
        self.smallHolderView.layer.cornerRadius = 10
        self.smallHolderView.layer.masksToBounds = true
        self.smallHolderView.clipsToBounds = true
        
        self.hideBTN.layer.cornerRadius = 25
        self.hideBTN.layer.masksToBounds = true
        self.hideBTN.clipsToBounds = true
        self.hideBTN.layer.borderColor = UIColor.white.cgColor
        self.hideBTN.layer.borderWidth = 2
        
        
        //self.imageHolder.image = UIImage(named: "PiperHighGive.png")
        //PiperImage
        /*
        
       // TraitImageURLTemp = prefs.value(forKey: "GroupViewingPlayerTraitImageURL") as! String
        
       // print("Trait View Image URL: \(TraitImageURLTemp)")
        
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(TraitImageURLTemp).png")
        print("Trait View url for image = \(url)")
        let theImageData = try? Data(contentsOf: url)
        
        //TestImage = UIImage(data:theImageData!)!
        
        let image  = UIImage(data: theImageData!)!
        
        
        self.traitImage.image = image
        self.traitImage.contentMode = .scaleAspectFit
        
        */
        
        /*
         let randomIndex = Int(arc4random_uniform(UInt32(NumColors.count)))
         
         
         self.lblView.layer.cornerRadius = 10
         self.pickerView.layer.cornerRadius = 10
         
         self.lblView.layer.borderWidth = 2
         self.pickerView.layer.borderWidth = 2
         self.lblView.layer.borderColor = NumColors[randomIndex].cgColor
         self.pickerView.layer.borderColor = NumColors[randomIndex].cgColor
         */
        // self.pickerView.dataSource = self;
        // self.pickerView.delegate = self;
        
        //Do something here when it wakes
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    @IBAction func reportContent(_ sender: Any) {
        
      
        
    }

    @IBAction func hideBTN(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 0.75, animations: {
            self.alpha = 0.0
        })
        

        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "LevelCompleteView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds

        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
        }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
}


class LevelFailView: UIView {
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    let prefs:UserDefaults = UserDefaults.standard
    
    var isOpen = Bool()
    var TimerCount = Int()
    
    
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var holderView: UIView!
    
    @IBOutlet weak var imageHolder: UIImageView!
    
    
    @IBOutlet weak var smallHolderView: UIView!
    
    @IBOutlet weak var viewLBL: UILabel!
    
    var character = String()
    
    var TimeAmount = String()
    
    /*
     var traitTextTitle: String? {
     didSet {
     traitTitle.text = traitTextTitle
     }
     }
     */
    
    var viewDesc: String? {
        didSet {
            viewLBL.text = viewDesc
        }
    }
    

    
    var TraitImageURLTemp = String()
    
    //var imageURLname: String?
    var TraitImageURL: String? {
        didSet {
            TraitImageURLTemp = TraitImageURL!
        }
    }
    
    
    
    var buttonClicked = Bool()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let subView: UIView = loadViewFromNib()
        let bounds = UIScreen.main.bounds
        
        
        /*
         subView.smallHolderView.layer.cornerRadius = 10
         subView.smallHolderView.layer.masksToBounds = true
         subView.smallHolderView.clipsToBounds = true
         
         subView.hideBTN.layer.cornerRadius = 25
         subView.hideBTN.layer.masksToBounds = true
         subView.hideBTN.clipsToBounds = true
         subView.hideBTN.layer.borderColor = UIColor.white.cgColor
         subView.hideBTN.layer.borderWidth = 2
         
         */
        
        
        let DeviceH = bounds.size.height
        //let halfH = DeviceH / 2;
        let DeviceW = bounds.size.width
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;
        print("Start x = \(startX)")
        //subView.layer.masksToBounds = true
        // subView.clipsToBounds = true
        // subView.layer.cornerRadius = 10
        
        // myRemindView.alpha = 0.0
        // myRemindView.frame = CGRectMake(startX, startY, 250, 250)
        //subView.frame = CGRectMake(startX, startY, 250, 250)
        subView.frame = self.bounds
        //label1.text = "123" //would cause error
        addSubview(subView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func loadViewFromNib() -> UIView {
        let view: UIView = UINib(nibName: "LevelCompleteView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        
        
        return view
    }
    
    

    
    override func awakeFromNib() {
        
        self.smallHolderView.layer.cornerRadius = 10
        self.smallHolderView.layer.masksToBounds = true
        self.smallHolderView.clipsToBounds = true
        self.hideBTN.layer.cornerRadius = 25
        self.hideBTN.layer.masksToBounds = true
        self.hideBTN.clipsToBounds = true
        self.hideBTN.layer.borderColor = UIColor.white.cgColor
        self.hideBTN.layer.borderWidth = 2
        
       
        /*
         
         // TraitImageURLTemp = prefs.value(forKey: "GroupViewingPlayerTraitImageURL") as! String
         
         // print("Trait View Image URL: \(TraitImageURLTemp)")
         
         let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(TraitImageURLTemp).png")
         print("Trait View url for image = \(url)")
         let theImageData = try? Data(contentsOf: url)
         
         //TestImage = UIImage(data:theImageData!)!
         
         let image  = UIImage(data: theImageData!)!
         
         
         self.traitImage.image = image
         self.traitImage.contentMode = .scaleAspectFit
         
         */
        
        /*
         let randomIndex = Int(arc4random_uniform(UInt32(NumColors.count)))
         
         
         self.lblView.layer.cornerRadius = 10
         self.pickerView.layer.cornerRadius = 10
         
         self.lblView.layer.borderWidth = 2
         self.pickerView.layer.borderWidth = 2
         self.lblView.layer.borderColor = NumColors[randomIndex].cgColor
         self.pickerView.layer.borderColor = NumColors[randomIndex].cgColor
         */
        // self.pickerView.dataSource = self;
        // self.pickerView.delegate = self;
        
        //Do something here when it wakes
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    @IBAction func reportContent(_ sender: Any) {
        
        
        
    }
    
    @IBAction func hideBTN(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 0.75, animations: {
            self.alpha = 0.0
        })
        
        //let TimeAmount = "1m"
        
        // prefs.setValue(self.TimeAmount, forKey: "TimerGameTimeLBL")
        
        //  NotificationCenter.default.post(name: Notification.Name(rawValue: "updateTimerLBL"), object: self)
        
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "LevelFailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        
        
        
        //let ImageURL = Nib.options
        
        //let data = (Nib. as NSNotification).userInfo
        //let googleImageData2 = data!["data"] as! Data
        
        
        
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
        }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
}
