//
//  RootAlerts.swift
//  Christmas2016
//
//  Created by Jared Stevens2 on 12/13/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation

import SpriteKit

protocol Alerts { }
extension Alerts where Self: SKScene {
    
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alertController.addAction(okAction)
        
        self.view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithSettings(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alertController.addAction(okAction)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            
            if let url = NSURL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(url as URL)
            }
        }
        alertController.addAction(settingsAction)
        
        self.view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
