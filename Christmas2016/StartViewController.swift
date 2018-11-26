//
//  StartViewController.swift
//  Christmas2016
//
//  Created by Jared Stevens2 on 11/21/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import AVFoundation

class StartViewController: UIViewController {
    
    @IBOutlet weak var newGameBTN: UIButton!
    
    @IBOutlet weak var newGameLBL: UILabel!
    
    
    var CandyResponseArray = ["You can't eat it yet", "Don't touch my candy!", "ha ha your fingers are all sticky now","gross","tricked ya, not real candy","no way kiddo"]
    
    var KidResponseArray = ["Ouch! don't poke me.", "Hey don't do that!", "that hurts!", "I'll poke you in the face", "stop","ugh"]
     let prefs:UserDefaults = UserDefaults.standard
    
    var url: URL!
    
    @IBOutlet weak var candyBTN: UIButton!
    
    
    @IBOutlet weak var CandyGrabLBL: UILabel!
    
    @IBOutlet weak var store_H: NSLayoutConstraint!
    
    @IBOutlet weak var storeBTN: UIButton!
    
    
    var musicPlayer: AVAudioPlayer!
    var MusicPlaying = Bool()
    
    var pulse = CABasicAnimation()
    var rotate = CABasicAnimation()
    var rotateP = CABasicAnimation()
    
    
    @IBOutlet weak var CandyIcon: UIImageView!
    
    @IBOutlet weak var musicPlayerBTN: UIButton!
    @IBOutlet weak var musicBTN_H: NSLayoutConstraint!
    
    @IBOutlet weak var musicBTN_W: NSLayoutConstraint!
    
    
    @IBOutlet weak var infoBTN: UIButton!
    
   // @IBOutlet weak var infoBTN_H: NSLayoutConstraint!
    
    @IBOutlet weak var infoBTN_W: NSLayoutConstraint!
    @IBOutlet weak var newGameView: UIView!
    @IBOutlet weak var newGameViewW: NSLayoutConstraint!
    @IBOutlet weak var newGameViewH: NSLayoutConstraint!
    @IBOutlet weak var newGameViewTOP: NSLayoutConstraint!
    
    
    @IBOutlet weak var candyH: NSLayoutConstraint!
    
    @IBOutlet weak var candyW: NSLayoutConstraint!
    
 
    
    @IBOutlet weak var headHolderH: NSLayoutConstraint!
    
    
    @IBOutlet weak var headHolderTOP: NSLayoutConstraint!
    
    @IBOutlet weak var piperX: NSLayoutConstraint!
    
    @IBOutlet weak var trippX: NSLayoutConstraint!
    //@IBOutlet weak var player1ViewLEAD: NSLayoutConstraint!
    
    @IBOutlet weak var trippHead: UIImageView!
    @IBOutlet weak var piperHead: UIImageView!
    
    @IBOutlet weak var piperHeadBTN: UIButton!
    @IBOutlet weak var trippHeadBTN: UIButton!
    
    @IBOutlet weak var trippHeadView: UIView!
    
    @IBOutlet weak var piperHeadView: UIView!
    
    @IBOutlet weak var headHolder: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
        
        prefs.set(DeviceH, forKey: "DeviceH")
        prefs.set(DeviceW, forKey: "DeviceW")
        
        print("DEVICE H: \(DeviceH)")
        print("DEVICE W: \(DeviceW)")
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;

        
        
        
        let path = Bundle.main.path(forResource: "CantStopTheFeelingInstrumental.mp3", ofType:nil)!
        
        url = URL(fileURLWithPath: path)
        
      //  self.newGameView.layer.cornerRadius = 70
        //6.25
        let FontSizeTemp = DeviceW / 7
        
        self.CandyGrabLBL.font.withSize(FontSizeTemp)
        
         self.CandyGrabLBL.font = UIFont(name: "Party LET", size: FontSizeTemp)
        
        let NewGameViewWidth = DeviceW / 3.5
        
        print("New Game Button View H/W: \(NewGameViewWidth)")
        
        self.newGameViewH.constant = NewGameViewWidth
        self.newGameViewW.constant = NewGameViewWidth
        self.newGameView.layer.cornerRadius = NewGameViewWidth / 2
        
        self.newGameViewTOP.constant = DeviceH / 2.39928058
        
        let FontSizeTempNewGame = DeviceW / 15
        
            //self.newGameBTN.set
        
        self.newGameLBL.font.withSize(FontSizeTempNewGame)
        
        print("New Game LBL font size: \(FontSizeTempNewGame)")
        
        self.newGameLBL.font = UIFont(name: "Party LET", size: FontSizeTempNewGame)
        
        self.candyH.constant = DeviceW / 4.75
        
        self.candyW.constant = DeviceW / 4.75
        
        let HeadHolderHeight = DeviceH / 7.11466667
        self.headHolderH.constant = HeadHolderHeight
        self.piperX.constant = (DeviceW / 6.25) * -1
        self.trippX.constant = DeviceW / 6.25
        
        //self.infoBTN_H.constant = DeviceW / 9
        //self.infoBTN_W.constant = DeviceW / 9
        
        let musicBTN_Height = DeviceW / 6.25
        
        self.musicBTN_H.constant = musicBTN_Height
        self.musicBTN_W.constant = musicBTN_Height
        self.musicPlayerBTN.layer.cornerRadius = (musicBTN_Height / 2)
        
        self.store_H.constant = musicBTN_Height
        self.infoBTN_W.constant = musicBTN_Height
        
        
        
        
        self.newGameView.clipsToBounds = true
        self.newGameView.layer.masksToBounds = true
        self.newGameView.layer.borderWidth = 2
        self.newGameView.layer.borderColor = UIColor.white.cgColor
        
       // self.musicPlayerBTN.layer.cornerRadius = 30
        
        self.musicPlayerBTN.layer.borderWidth = 3
        self.musicPlayerBTN.layer.borderColor = UIColor(red: 0.98039, green: 0.0, blue: 0.29019, alpha: 1.0).cgColor
        self.musicPlayerBTN.setImage(UIImage(named: "PauseIcon.png"), for: .normal)
        
        pulse = CABasicAnimation(keyPath: "opacity")
        pulse.duration = 2
        pulse.fromValue = 0.5
        pulse.toValue = 0.6
        pulse.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulse.autoreverses = true
        pulse.repeatCount = FLT_MAX
        
        /*
        rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = 0.0
        rotate.toValue = CGFloat(M_PI * 2.0)
        rotate.duration = 1
        */
        
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
        
        trippHeadView.layer.add(rotate, forKey: "trippRotate")
       // trippHead.layer.add(pulse, forKey: "trippPulse")
       // trippHeadBTN.setImage(UIImage(named: "TrippHeadSmile.png")!, for: .normal)
        trippHead.image = UIImage(named: "TrippHeadSmile.png")!
        
        piperHeadView.layer.add(rotateP, forKey: "piperRotate")
       // piperHead.layer.add(pulse, forKey: "piperPulse")
        piperHead.image = UIImage(named: "PiperHead.png")!
       //  piperHeadBTN.setImage(UIImage(named: "PiperHead.png")!, for: .normal)
      
        
        //UIColor(red: 0.14117, green: 0.60784, blue: 0.23137, alpha: 1.0).cgColor
        
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            musicPlayer = sound
            sound.play()
            sound.volume = 0.2
            self.MusicPlaying = true
            
           // self.musicPlayerBTN.setTitle("Stop", for: .normal)
            self.musicPlayerBTN.setImage(UIImage(named: "PauseIcon.png"), for: .normal)
            prefs.set(true, forKey: "MainMusicPlaying")
        } catch {
            self.MusicPlaying = false
           // self.musicPlayerBTN.setTitle("Play", for: .normal)
            
            self.musicPlayerBTN.setImage(UIImage(named: "PlayIcon.png"), for: .normal)
            prefs.set(false, forKey: "MainMusicPlaying")
            // couldn't load file :(
        }
        
       // self.piperHead.
        
        NotificationCenter.default.addObserver(self, selector: #selector(StartViewController.ToggleMusic(_:)), name: NSNotification.Name(rawValue: "ToggleMusic"),  object: nil)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func HowToButton(_ sender: Any) {
        
        
        var theImage = UIImage()
        
        
        
        
        let completeView:HowToView = UINib(nibName: "HowToView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! HowToView
        
       
        
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        let NotFirstView = prefs.bool(forKey: "NotFirstView")
        
        if !NotFirstView {
        
        var theImage = UIImage()
        
        
        
        
        let completeView:HowToView = UINib(nibName: "HowToView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! HowToView
        
        
        /*
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
            
        default:
            break
        }
        
        */
        
            
        let DeviceH = self.view.frame.height
        //let halfH = DeviceH / 2;
        let DeviceW = self.view.frame.width
            
       
        //let WLess10 = DeviceW - 10;
        let startX = (DeviceW / 2) - 125;
        let startY = (DeviceH / 2) - 125;
            
            
            
            /*
            
            UIView.animate(withDuration: 3.0, animations: { () -> Void in
                
                
                
                //head size is 1/5 of width
                //headHolderH = 7.11466667 of Height
                
                // NewGameView = 2.55 of Width
                
                // CandyGrabText = 7.41111111 of Height
                
                let NewGameViewWidth = DeviceW / 2.55
                
                self.newGameViewH.constant = NewGameViewWidth
                self.newGameViewW.constant = NewGameViewWidth
                self.newGameView.layer.cornerRadius = NewGameViewWidth / 2
                
                let HeadHolderHeight = DeviceH / 7.11466667
                self.headHolderH.constant = HeadHolderHeight
        
                
                self.infoBTN_H.constant = DeviceW / 9
                self.infoBTN_W.constant = DeviceW / 9
                
                let musicBTN_Height = DeviceW / 6.25
                self.musicBTN_H.constant = musicBTN_Height
                self.musicBTN_W.constant = musicBTN_Height
                self.musicPlayerBTN.layer.cornerRadius = musicBTN_Height
                
                
                
                
                /*
                self.PQLogo.center.y = self.PQLogo.center.y + 50
                
                self.imageTOP.constant = DeviceW / 20
                
                self.PQLogo.transform = CGAffineTransform(scaleX: 1.5, y: 1.5);
                
                
                self.PQLogoW.constant = DeviceW / 8
                let PQWidth = DeviceW / 8
                self.PQLogoH.constant = PQWidth * 0.8
                
                */
            
                
                
                
            })
            
            
            */
        
        
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
        
        
        if MusicPlaying {
        
            
            trippHeadView.layer.add(rotate, forKey: "trippRotate")
            // trippHead.layer.add(pulse, forKey: "trippPulse")
            
            piperHeadView.layer.add(rotateP, forKey: "piperRotate")
            // piperHead.layer.add(pulse, forKey: "piperPulse")
            
           piperHead.image = UIImage(named: "PiperHead.png")!
            
//             trippHead.setImage(UIImage(named: "TrippHeadSmile.png")!, for: .normal)
            
          //   piperHead.setImage(UIImage(named: "PiperHead.png")!, for: .normal)
            trippHead.image = UIImage(named: "TrippHeadSmile.png")!
            

        } else {
            
            
            trippHeadView.layer.removeAllAnimations()
            piperHeadView.layer.removeAllAnimations()
            
            piperHead.image = UIImage(named: "PiperHeadSad.png")!
            trippHead.image = UIImage(named: "TrippHeadSad.png")!
            
           // trippHead.setImage(UIImage(named: "TrippHeadSad.png")!, for: .normal)
            
           // piperHeadBTN.setImage(UIImage(named: "PiperHeadSad.png")!, for: .normal)
 
        
        }
        
    }
    
    
    func ToggleMusic(_ notification:Notification) {
        

        
        let userInfo:Dictionary<String,String?> = (notification as NSNotification).userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        // print("JSON ALERT \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        
        let UpdateMusic = jsonAlert["update"].stringValue

        
        if UpdateMusic == "yes" {
        
        if MusicPlaying {
            
            
            if musicPlayer != nil {
                musicPlayer.stop()
                musicPlayer = nil
                
                self.MusicPlaying = false
                
               // self.musicPlayerBTN.setTitle("Play", for: .normal)
                self.musicPlayerBTN.setImage(UIImage(named: "PlayIcon.png"), for: .normal)
                prefs.set(false, forKey: "MainMusicPlaying")
                
                trippHeadView.layer.removeAllAnimations()
                piperHeadView.layer.removeAllAnimations()
                
                piperHead.image = UIImage(named: "PiperHeadSad.png")!
                trippHead.image = UIImage(named: "TrippHeadSad.png")!
                
               // trippHeadBTN.setImage(UIImage(named: "TrippHeadSad.png")!, for: .normal)
                
                //piperHeadBTN.setImage(UIImage(named: "PiperHeadSad.png")!, for: .normal)
                
                
            } else {
                
                
                
               
                
                
                
                print("no music is playing")
            }
            
            
            
        } else {
            
            do {
                let sound = try AVAudioPlayer(contentsOf: url)
                musicPlayer = sound
                sound.play()
                self.MusicPlaying = true
               // self.musicPlayerBTN.setTitle("Stop", for: .normal)
                self.musicPlayerBTN.setImage(UIImage(named: "PauseIcon.png"), for: .normal)
                
                prefs.set(true, forKey: "MainMusicPlaying")
                
                trippHeadView.layer.add(rotate, forKey: "trippRotate")
               // trippHead.layer.add(pulse, forKey: "trippPulse")
                
                piperHeadView.layer.add(rotateP, forKey: "piperRotate")
               // piperHead.layer.add(pulse, forKey: "piperPulse")
                
                piperHead.image = UIImage(named: "PiperHead.png")!
                trippHead.image = UIImage(named: "TrippHeadSmile.png")!
                
              //  trippHeadBTN.setImage(UIImage(named: "TrippHeadSmile.png")!, for: .normal)
                
             //   piperHeadBTN.setImage(UIImage(named: "PiperHead.png")!, for: .normal)
                
                
            } catch {
                self.MusicPlaying = false
                // couldn't load file :(
            }
            
        }
            
        }
        
        if UpdateMusic == "off" {
            
            if MusicPlaying {
                
                
                if musicPlayer != nil {
                    musicPlayer.stop()
                    musicPlayer = nil
                    
                    self.MusicPlaying = false
                    
                   // self.musicPlayerBTN.setTitle("Play", for: .normal)
                    self.musicPlayerBTN.setImage(UIImage(named: "PlayIcon.png"), for: .normal)
                    
                    prefs.set(false, forKey: "MainMusicPlaying")
                    
                    trippHeadView.layer.removeAllAnimations()
                    piperHeadView.layer.removeAllAnimations()
                    
                    piperHead.image = UIImage(named: "PiperHeadSad.png")!
                    trippHead.image = UIImage(named: "TrippHeadSad.png")!
                    
                  //  trippHeadBTN.setImage(UIImage(named: "TrippHeadSad.png")!, for: .normal)
                    
                 //   piperHeadBTN.setImage(UIImage(named: "PiperHeadSad.png")!, for: .normal)
                    
                    
                } else {
                    
                    print("no music is playing")
                }
                
                
                
            }
            
        }
        
        
    }
    
    
    @IBAction func newGameBTN(_ sender: Any) {
        
        self.performSegue(withIdentifier: "NewGame", sender: self)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func MusicToggle(_ sender: Any) {
        
        if MusicPlaying {
            
            
            if musicPlayer != nil {
                musicPlayer.stop()
                musicPlayer = nil
                
                self.MusicPlaying = false
                
             //   self.musicPlayerBTN.setTitle("Play", for: .normal)
                self.musicPlayerBTN.setImage(UIImage(named: "PlayIcon.png"), for: .normal)
                
                prefs.set(false, forKey: "MainMusicPlaying")
                
                //trippHead.layer.removeAnimation(forKey: "trippPulse")
                //trippHead.layer.removeAnimation(forKey: "trippRotate")
                 trippHeadView.layer.removeAllAnimations()
               // piperHead.layer.removeAnimation(forKey: "piperPulse")
               // piperHead.layer.removeAnimation(forKey: "piperRotate")
                piperHeadView.layer.removeAllAnimations()
                
                piperHead.image = UIImage(named: "PiperHeadSad.png")!
                trippHead.image = UIImage(named: "TrippHeadSad.png")!
                
               // trippHeadBTN.setImage(UIImage(named: "TrippHeadSmile.png")!, for: .normal)
                
              //  piperHeadBTN.setImage(UIImage(named: "PiperHead.png")!, for: .normal)
                
            } else {
                
                print("no music is playing")
            }
            
            
            
        } else {
            
            do {
                let sound = try AVAudioPlayer(contentsOf: url)
                musicPlayer = sound
                sound.play()
                self.MusicPlaying = true
               // self.musicPlayerBTN.setTitle("Stop", for: .normal)
                self.musicPlayerBTN.setImage(UIImage(named: "PauseIcon.png"), for: .normal)
                
                prefs.set(true, forKey: "MainMusicPlaying")
                
                trippHeadView.layer.add(rotate, forKey: "trippRotate")
               // trippHead.layer.add(pulse, forKey: "trippPulse")
                
                piperHeadView.layer.add(rotateP, forKey: "piperRotate")
               // piperHead.layer.add(pulse, forKey: "piperPulse")
                
          //  trippHeadBTN.setImage(UIImage(named: "TrippHeadSmile.png")!, for: .normal)
                
          //  piperHeadBTN.setImage(UIImage(named: "PiperHead.png")!, for: .normal)
                
                piperHead.image = UIImage(named: "PiperHead.png")!
                trippHead.image = UIImage(named: "TrippHeadSmile.png")!
                
                
            } catch {
                self.MusicPlaying = false
                // couldn't load file :(
            }
            
        }
        
        
    }
    
    
    @IBAction func TrippBTN(_ sender: Any) {
        
        let theAlert = SCLAlertView()
        
        
        
        // theAlert.showCustomOK(UIImage(named: "PartyTraitsLogoCircle.png")!, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "View Trait Info?", subTitle: "Are you sure you want to view this player's assigned trait?")
        
        
       let StartGameImage = UIImage(named: "TrippHeadSad.png")!
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(KidResponseArray.count)))
        let KidResponse = KidResponseArray[randomIndex]
        
        theAlert.showCustomOK(StartGameImage, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "Hey", subTitle: "\(KidResponse)", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        
    }
    
    
    @IBAction func PiperBTN(_ sender: Any) {
        let theAlert = SCLAlertView()
        
        
        
        // theAlert.showCustomOK(UIImage(named: "PartyTraitsLogoCircle.png")!, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "View Trait Info?", subTitle: "Are you sure you want to view this player's assigned trait?")
        
        
        let StartGameImage = UIImage(named: "PiperHeadSad.png")!
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(KidResponseArray.count)))
        let KidResponse = KidResponseArray[randomIndex]
        
        theAlert.showCustomOK(StartGameImage, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "Hey", subTitle: "\(KidResponse)", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        
    }
    
    
    @IBAction func candyAction(_ sender: Any) {
        
        let StartGameImage = UIImage(named: "CandyIcon2.png")!
        
        let randomIndex = Int(arc4random_uniform(UInt32(CandyResponseArray.count)))
        let CandyResponse = CandyResponseArray[randomIndex]
        
         let theAlert = SCLAlertView()
        
        
        theAlert.showCustomOK(StartGameImage, color: UIColor(red: 0.14901961, green: 0.6, blue: 1.0, alpha: 1.0), title: "Candy", subTitle: "\(CandyResponse)", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
        
        
    }
    
  
    
    
    
    @IBAction func StoreBTN(_ sender: Any) {
        
        self.performSegue(withIdentifier: "store", sender: self)
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
