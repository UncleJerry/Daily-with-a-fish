//
//  CellElement.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/29.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

protocol CellElement {
    var name: String? { get }
    var icon: UIImage? { get }
}

class Feature: CellElement {
    var icon: UIImage?
    var name: String?
    var navigation: String?
    var descrisption: String?
    
    init(name: String, descrisption: String, icon: UIImage, navigation: String) {
        self.name = name
        self.icon = icon
        self.navigation = navigation
        self.descrisption = descrisption
    }
    
    static func generate() -> [Feature] {
        
        return [Feature(name: "About Us", descrisption: "Review our love journal", icon: UIImage(named: "About us")!, navigation: "AboutUs"), Feature(name: "Notify", descrisption: "Set a notify for lover", icon: UIImage(named: "Notify")!, navigation: "Notify"), Feature(name: "Setting", descrisption: "Settings and Author", icon: UIImage(named: "Setting")!, navigation: "Settings")]
    }
}

