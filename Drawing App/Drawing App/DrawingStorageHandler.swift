//
//  DrawingStorageHandler.swift
//  Drawing App
//
//  Created by Samantha Webster on 12/11/20.
//  Copyright © 2020 Samantha Webster. All rights reserved.
//

import Foundation
import UIKit

struct DrawingStorageHandler {
    static var drawingDefaults: UserDefaults = UserDefaults.standard
    
    static func isSet(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    static func set(key: String, value: Any) {
        drawingDefaults.set(value, forKey: key)
    }
    
    
}
