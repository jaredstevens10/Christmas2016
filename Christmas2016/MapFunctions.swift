//
//  MapFunctions.swift
//  Christmas2016
//
//  Created by Jared Stevens2 on 12/21/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit
//
//  MapEditFunctions.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/6/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//


func CreateRadar(Points: [CGPoint]) -> UIImage {
    
    //var Edit
    
    
    var ItemName = "Candy"
    
    var newRed = UInt8()
    var newGreen = UInt8()
    var newBlue = UInt8()
    
    (newRed, newGreen, newBlue) = ReturnItemsColorCode(ItemName)
    
    
    let EditedImage = processPixelsInImage(in: UIImage(named: "MapRadarTemp.png")!, points: Points)
    
    //   let EditedImage = processPixelsInImage(UIImage(named: "MapRadar2.png")!, xLoc: 3, yLoc: 11, newRed: newRed, newGreen: newGreen, newBlue: newBlue, Points: Points)
    
   // mapImageView.image = EditedImage
    
    return EditedImage!
    /*
    DispatchQueue.main.async(execute: {
        print("generating Map now")
        self.GenerateMap(EditedImage)
    })
    */
}



func processPixelsInImageOld(_ inputImage: UIImage, xLoc: CGFloat, yLoc: CGFloat, newRed: UInt8, newGreen: UInt8, newBlue: UInt8, Points: [CGPoint]) -> UIImage {
    
  //  var tiles: [Tile]!
  //  var entities = [Entity]()
    
    
    
    
    let inputCGImage     = inputImage.cgImage
    let colorSpace       = CGColorSpaceCreateDeviceRGB()
    let width            = inputCGImage?.width
    let height           = inputCGImage?.height
    let bytesPerPixel    = 4
    let bitsPerComponent = 8
    let bytesPerRow      = bytesPerPixel * width!
    let bitmapInfo       = CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
    
    let context = CGContext(data: nil, width: width!, height: height!, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)!
    context.draw(inputCGImage!, in: CGRect(x: 0, y: 0, width: CGFloat(width!), height: CGFloat(height!)))
    
    //  let pixelBuffer = UnsafeMutablePointer<UInt32>(context.data)
    
    // let uncastedData = context.data
    
    //let data = context.assumin
    // let pixelBuffer = uncastedData?.assumingMemoryBound(to: Int.self)
    
    // let pixelBuffer: UnsafePointer<UInt8> = CFDataGetBytePtr(uncastedData as! CFData!)
    
    // let pixelData = (inputImage as! CGImage).dataProvider!.data
    
    
    let pixelBuffer = context.data?.assumingMemoryBound(to: UInt8.self)
    
    
    //let pixelBuffer = UnsafeMutablePointer<RGBA32>(CGBitmapContextGetData(context))
    
    // let pixelBuffer: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
    
    // let pixelBuffer = uncastedData?.assumingMemoryBound(to: UInt8.self)
    
    var currentPixel = pixelBuffer
    
    for Point in Points {
        
        let newX = round((Point.x / 100)) / 2
        let newY = round((Point.y / 100)) / 2//Point.y
    
    
    for i in 0 ..< Int(height!) {
        for j in 0 ..< Int(width!) {
            
            
            //    let offset = j * bytesPerPixel
            //    let red = pixelBuffer?[offset + 1]
            //    let green = pixelBuffer?[offset + 2]
            //    let blue = pixelBuffer?[offset + 3]
            
            
            /*
             
             print("Tiles: \(tiles)")
             
             //convert color to tile type
             let tile = tiles[j]
             
             print("Item i for x:\(tiles![j].x) and y:\(tiles![j].y): red =\(red) green=\(green) blue=\(blue)")
             
             
             
             if (tiles![j].x == Int(xLoc)) && (tiles![j].y == Int(yLoc)) {
             
             currentPixel?.pointee = Int(rgba(red: newRed, green: newGreen, blue: newBlue, alpha: 255))
             
             }
             
             if red(UInt32(pixel)) == 0 && green(UInt32(pixel)) == 0 && blue(UInt32(pixel)) == 0 {
             //  currentPixel.memory = rgba(red: 255, green: 0, blue: 0, alpha: 255)
             //  currentPixel.memory = rgba(red: 255, green: 0, blue: 0, alpha: 255)
             
             }
             
             
             // print("UPDATED Item i for x:\(tiles![j].x) and y:\(tiles![j].y): newRed =\(newRed) newGreen=\(newGreen) newBlue=\(newBlue)")
             
             // let one = 1 as! UnsafeMutablePoint<Int>
             
             currentPixel = currentPixel! + 1
             
             */
            
            
            var pixel = (currentPixel?.pointee)
            
            print("x? = \(j.description)")
            print("y? =\(i.description)")
            
            if (j == Int(newX)) && (i == Int(newY)) {
                print("this is the desired x y coordinate: x=\(j) y=\(i)")
                //SWIFT 3 ERROR
                
               // currentPixel?.
                pixel = UInt8(rgba(red: newRed, green: newGreen, blue: newBlue, alpha: 255))
                
               // currentPixel?.memory = pixel!
               // currentPixel?.pointee = UInt8(rgba(red: newRed, green: newGreen, blue: newBlue, alpha: 255))
                
            }
            
            /*
            // let x = i
            if red(UInt32(pixel!)) == 0 && green(UInt32(pixel!)) == 0 && blue(UInt32(pixel!)) == 0 {
                //  currentPixel.memory = rgba(red: 255, green: 0, blue: 0, alpha: 255)
                currentPixel?.pointee = UInt8(rgba(red: 255, green: 0, blue: 0, alpha: 255))
                
            }
            
            */
            
            currentPixel = currentPixel! + 1
            
            
        }
    }
    
    
  }

    
    /*
     for j in 0 ..< width * height {
     
     //get color components
     let offset = j * bytesPerPixel
     let red = pixelBuffer[offset + 1]
     let green = pixelBuffer[offset + 2]
     let blue = pixelBuffer[offset + 3]
     
     
     
     
     //convert color to tile type
     let tile = tiles[j]
     
     print("Item i for x:\(tiles![j].x) and y:\(tiles![j].y): red =\(red) green=\(green) blue=\(blue)")
     
     
     
     if (tiles![j].x == Int(xLoc)) && (tiles![j].y == Int(yLoc)) {
     
     currentPixel.memory = rgba(red: newRed, green: newGreen, blue: newBlue, alpha: 255)
     
     }
     
     print("UPDATED Item i for x:\(tiles![j].x) and y:\(tiles![j].y): newRed =\(newRed) newGreen=\(newGreen) newBlue=\(newBlue)")
     
     currentPixel++
     }
     
     
     */
    
    let outputCGImage = context.makeImage()
    let outputImage = UIImage(cgImage: outputCGImage!, scale: inputImage.scale, orientation: inputImage.imageOrientation)
    
    return outputImage
}


func processPixelsInImage(in image: UIImage, points: [CGPoint]) -> UIImage? {
    guard let inputCGImage = image.cgImage else {
        print("unable to get cgImage")
        return nil
    }
    let colorSpace       = CGColorSpaceCreateDeviceRGB()
    let width            = inputCGImage.width
    let height           = inputCGImage.height
    let bytesPerPixel    = 4
    let bitsPerComponent = 8
    let bytesPerRow      = bytesPerPixel * width
    let bitmapInfo       = RGBA32.bitmapInfo
    
    guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo) else {
        print("unable to create context")
        return nil
    }
    context.draw(inputCGImage, in: CGRect(x: 0, y: 0, width: width, height: height))
    
    guard let buffer = context.data else {
        print("unable to get context data")
        return nil
    }
    
    let pixelBuffer = buffer.bindMemory(to: RGBA32.self, capacity: width * height)
    
    let black = RGBA32(red: 0, green: 0, blue: 0, alpha: 255)
    let red = RGBA32(red: 0, green: 0, blue: 0, alpha: 255)
    
    for Point in points {
        
        let newX = round((Point.x / 100)) / 2
        let newY = round((Point.y / 100)) / 2//Point.y

    
    for row in 0 ..< Int(height) {
        for column in 0 ..< Int(width) {
            let offset = row * width + column
            
            /*
            if pixelBuffer[offset] == black {
                pixelBuffer[offset] = red
            }
            */
            
            if (row == Int(newX)) && (column == Int(newY)) {
                
                pixelBuffer[offset] = red
                print("this is the desired x y coordinate: x=\(row) y=\(column)")
                //SWIFT 3 ERROR
                
                // currentPixel?.
                //pixel = UInt8(rgba(red: newRed, green: newGreen, blue: newBlue, alpha: 255))
                
                // currentPixel?.memory = pixel!
                // currentPixel?.pointee = UInt8(rgba(red: newRed, green: newGreen, blue: newBlue, alpha: 255))
                
            }
            
        }
    }
    
}
    let outputCGImage = context.makeImage()!
    let outputImage = UIImage(cgImage: outputCGImage, scale: image.scale, orientation: image.imageOrientation)
    
    return outputImage
}


func alpha(_ color: UInt32) -> UInt8 {
    return UInt8((color >> 24) & 255)
}

func red(_ color: UInt32) -> UInt8 {
    return UInt8((color >> 16) & 255)
}

func green(_ color: UInt32) -> UInt8 {
    return UInt8((color >> 8) & 255)
}

func blue(_ color: UInt32) -> UInt8 {
    return UInt8((color >> 0) & 255)
}

func rgba(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) -> UInt32 {
    return (UInt32(alpha) << 24) | (UInt32(red) << 16) | (UInt32(green) << 8) | (UInt32(blue) << 0)
}



func ReturnItemsColorCode(_ itemName: String) -> (UInt8, UInt8, UInt8) {
    
    var newRed = UInt8()
    var newGreen = UInt8()
    var newBlue = UInt8()
    
    
    switch itemName {
        
    case "Box":
        newRed = 200
        newGreen = 200
        newBlue = 0
    case "Bomb":
        newRed = 190
        newGreen = 190
        newBlue = 0
        
    case "Candy":
        newRed = 255
        newGreen = 0
        newBlue = 0
        
    default:
        break
    }
    
    return (newRed, newGreen, newBlue)
    
}


struct RGBA32: Equatable {
    var color: UInt32
    
    var red: UInt8 {
        return UInt8((color >> 24) & 255)
    }
    
    var green: UInt8 {
        return UInt8((color >> 16) & 255)
    }
    
    var blue: UInt8 {
        return UInt8((color >> 8) & 255)
    }
    
    var alpha: UInt8 {
        return UInt8((color >> 0) & 255)
    }
    
    init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        color = (UInt32(red) << 24) | (UInt32(green) << 16) | (UInt32(blue) << 8) | (UInt32(alpha) << 0)
    }
    
    static let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
    
    static func ==(lhs: RGBA32, rhs: RGBA32) -> Bool {
        return lhs.color == rhs.color
    }
}

