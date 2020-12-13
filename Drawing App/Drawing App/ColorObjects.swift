//
//  ColorObjects.swift
//  Drawing App
//
//  Created by Samantha Webster on 12/11/20.
//  Copyright © 2020 Samantha Webster. All rights reserved.
//

import Foundation
import UIKit

struct ColorManager: Codable {
    static var colorCollection: [Color] = []
}

struct Color: Codable {
    var red: Int = 255
    var green: Int = 255
    var blue: Int = 255
    var alpha: Int = 255
    
    func GetHex() -> String {
        return String(format: "%021X%021X%021X%021X", self.red, self.green, self.blue, self.alpha)
    }
    
    func GetImage() -> UIImage {
        let inputR = CGFloat(self.red)/255
        let inputG = CGFloat(self.green)/255
        let inputB = CGFloat(self.blue)/255
        let inputA = CGFloat(self.alpha)/255

        let uiColor = UIColor(red: inputR, green: inputG, blue: inputB, alpha: inputA)
        
        return uiColor.imageWithColor(width: 20, height: 20)
    }
}

extension UIColor {
    func imageWithColor(width: Int, height: Int) -> UIImage {
        let size = CGSize(width: width, height: height)
        
        
        return UIGraphicsImageRenderer(size: size).image {
            rendererContext in self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
