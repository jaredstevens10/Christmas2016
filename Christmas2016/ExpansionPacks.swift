//
//  ExpansionPacks.swift
//  Christmas2016
//
//  Created by Jared Stevens2 on 12/20/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit


func GetExpansionPackInfo() -> [ExpansionPack] {
    
    var PackTemp = [ExpansionPack]()
    let prefs:UserDefaults = UserDefaults.standard
    
    
    
    
    let Ember = FriendInfo(name: "Ember", image: UIImage(named: "FriendEmber")!, speed: 55.0, ResetTime: nil, canTouchPlayer: true)
    let Lilly = FriendInfo(name: "Lilly", image: UIImage(named: "FriendLilly")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
    
    let Ben = FriendInfo(name: "Ben", image: UIImage(named: "FriendBen")!, speed: 90.0, ResetTime: nil, canTouchPlayer: true)
    
    let Colton = FriendInfo(name: "Colton", image: UIImage(named: "FriendColton")!, speed: 105.0, ResetTime: nil, canTouchPlayer: true)
    
    let Lizzie = FriendInfo(name: "Lizzie", image: UIImage(named: "HeadLizzie")!, speed: 100.0, ResetTime: nil, canTouchPlayer: true)
    
    let Cory = FriendInfo(name: "Cory", image: UIImage(named: "FriendCory")!, speed: 100.0, ResetTime: nil, canTouchPlayer: true)
    let Eisley = FriendInfo(name: "Eisley", image: UIImage(named: "FriendEisley")!, speed: 85.0, ResetTime: nil, canTouchPlayer: true)
    
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
    
    let Mory = FriendInfo(name: "Mory", image: UIImage(named: "HeadMory")!, speed: 200.0, ResetTime: nil, canTouchPlayer: true)
    
    let Mandi = FriendInfo(name: "Mandi", image: UIImage(named: "HeadMandi")!, speed: 95.0, ResetTime: nil, canTouchPlayer: true)
    
    let Caden = FriendInfo(name: "Caden", image: UIImage(named: "HeadCaden")!, speed: 90.0, ResetTime: nil, canTouchPlayer: true)
    
    let Cali = FriendInfo(name: "Cali", image: UIImage(named: "HeadCali")!, speed: 170.0, ResetTime: nil, canTouchPlayer: true)
    
    let Ally = FriendInfo(name: "Ally", image: UIImage(named: "HeadAlly")!, speed: 80.0, ResetTime: nil, canTouchPlayer: true)
    
    let Tony = FriendInfo(name: "Tony", image: UIImage(named: "HeadTony")!, speed: 95.0, ResetTime: nil, canTouchPlayer: true)
    
    let Jessica = FriendInfo(name: "Jessica", image: UIImage(named: "HeadJessica")!, speed: 80.0, ResetTime: nil, canTouchPlayer: true)
    
    let Art = FriendInfo(name: "Art", image: UIImage(named: "HeadArt")!, speed: 85.0, ResetTime: nil, canTouchPlayer: true)
    
     let Joey = FriendInfo(name: "Joey", image: UIImage(named: "HeadJoey")!, speed: 60.0, ResetTime: nil, canTouchPlayer: true)
    
     let Elenor = FriendInfo(name: "Eleanor", image: UIImage(named: "HeadElenor")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
    
    
    let Abby = FriendInfo(name: "Abby", image: UIImage(named: "HeadAbby")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
    
    let Ben2 = FriendInfo(name: "Ben", image: UIImage(named: "HeadBen")!, speed: 85.0, ResetTime: nil, canTouchPlayer: true)
    
    let Emily = FriendInfo(name: "Emily", image: UIImage(named: "HeadEmily")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
    
    let Josh = FriendInfo(name: "Josh", image: UIImage(named: "HeadJosh")!, speed: 85.0, ResetTime: nil, canTouchPlayer: true)
    
    let Kendra = FriendInfo(name: "Kendra", image: UIImage(named: "HeadKendra")!, speed: 70.0, ResetTime: nil, canTouchPlayer: true)
    
    let Tim = FriendInfo(name: "Tim", image: UIImage(named: "HeadTim")!, speed: 85.0, ResetTime: nil, canTouchPlayer: true)
    
    let Bennett = FriendInfo(name: "Bennett", image: UIImage(named: "HeadBennett")!, speed: 80.0, ResetTime: nil, canTouchPlayer: true)

    
    let startUnlocked = true
    let startEnabled = true
    let Start = ExpansionPack(name: "Start", packImage: UIImage(named: "FriendBen.png")!, info: "The Millers...Colton, Lizze, Ben, and Lilly", unlocked: startUnlocked, packname: "start", PackMembers: [Lilly, Ember, Ben], enabled: startEnabled, visible: false)
    
    
    
    
    let MillersUnlocked = prefs.bool(forKey: "millerPackUnlocked")
    let MillersEnabled = prefs.bool(forKey: "millerPackEnabled")
    let Millers = ExpansionPack(name: "The Millers", packImage: UIImage(named: "Millers.png")!, info: "The Millers...Colton, Lizze, Ben, and Lilly", unlocked: MillersUnlocked, packname: "miller", PackMembers: [Colton, Lizzie, Ben, Lilly], enabled: MillersEnabled, visible: true)
    
    let CallahansUnlocked = prefs.bool(forKey: "callahanPackUnlocked")
    let CallahansEnabled = prefs.bool(forKey: "callahanPackEnabled")
    let Callahans = ExpansionPack(name: "The Callahans", packImage: UIImage(named: "Callahans.png")!, info: "The Callahans...Cory, Mandi, Eisley, and Ember", unlocked: CallahansUnlocked, packname: "callahan", PackMembers: [Cory, Mandi, Ember, Eisley], enabled: CallahansEnabled, visible: true)
    
    let MargadonnasUnlocked = prefs.bool(forKey: "margadonnaPackUnlocked")
    let MargadonnasEnabled = prefs.bool(forKey: "margadonnaPackEnabled")
    let Margadonnas = ExpansionPack(name: "The Margadonnas", packImage: UIImage(named: "Margadonnas.png")!, info: "The Margadonnas...Rich, Devon, Bennett, and Hudson", unlocked: MargadonnasUnlocked, packname: "margadonna", PackMembers: [Rich, Devon, Hudson, Bennett], enabled: MargadonnasEnabled, visible: true)
    
    let CousinsUnlocked = prefs.bool(forKey: "cousinPackUnlocked")
    let CousinsEnabled = prefs.bool(forKey: "cousinPackEnabled")
    let Cousins = ExpansionPack(name: "The Cousins", packImage: UIImage(named: "Cousins.png")!, info: "Elise, Asher, AJ, Joey, Elenor.", unlocked: CousinsUnlocked, packname: "cousins", PackMembers: [Elise, Asher, AJ, Joey, Elenor], enabled: CousinsEnabled, visible: true)
    
    let grandparentsUnlocked = prefs.bool(forKey: "grandparentPackUnlocked")
    let grandparentsEnabled = prefs.bool(forKey: "grandparentPackEnabled")
    let Grandparents = ExpansionPack(name: "The Grandparents", packImage: UIImage(named: "grandparents.png")!, info: "Papa (Michican), Mimi, Papa (Florida), Nana", unlocked: grandparentsUnlocked, packname: "grandparent", PackMembers: [Dan, Jane, Larry], enabled: grandparentsEnabled, visible: true)
    
    let auntsunclesUnlocked = prefs.bool(forKey: "auntsunclesPackUnlocked")
    let auntsunclesEnabled = prefs.bool(forKey: "auntsunclesPackEnabled")
    let AuntsUncles = ExpansionPack(name: "The Aunts & Uncles", packImage: UIImage(named: "AuntsUncles.png")!, info: "Uncle Sam, Uncle Bret, Aunt Shannon, Uncle Tony, Aunt Heidi, Uncle Art, Aunt Jessica...", unlocked: auntsunclesUnlocked, packname: "auntsuncles", PackMembers: [Bret, Shannon, Sam, Tony, Heidi, Art, Jessica, Abby, Tim, Ben2, Kendra, Josh, Emily], enabled: auntsunclesEnabled, visible: true)
    
    let specialUnlocked = prefs.bool(forKey: "specialPackUnlocked")
    let specialEnabled = prefs.bool(forKey: "specialPackEnabled")
    let Special = ExpansionPack(name: "Special Pack", packImage: UIImage(named: "SpecialPeople.png")!, info: "Unknown", unlocked: auntsunclesUnlocked, packname: "special", PackMembers: [Mory, Devin, Erin, Caden, Cali, Ally], enabled: specialEnabled, visible: true)
    
    
    PackTemp.append(Start)
    PackTemp.append(Grandparents)
    PackTemp.append(Cousins)
    PackTemp.append(AuntsUncles)
    PackTemp.append(Millers)
    PackTemp.append(Callahans)
    PackTemp.append(Margadonnas)
    PackTemp.append(Special)
    
    
    
    
    
    return PackTemp
}


import Foundation
import UIKit


func GetExpansionPackInfoNew() -> [ExpansionPack] {
    
    var PackTemp = [ExpansionPack]()
    let prefs:UserDefaults = UserDefaults.standard
    
    
    
   var PackTempNew = GetExpansionPackInfo()
    
    for Packs in PackTempNew {
        
        
        if Packs.visible {
            PackTemp.append(Packs)
        }
        
    }
    
    
    
    
    
    
    return PackTemp
}
