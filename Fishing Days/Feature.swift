//
//  Feature.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/25.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class Feature {
    var name: String?
    var icon: UIImage?
    var navigation: String?
    var descrisption: String?
    
    init(name: String, descrisption: String, icon: UIImage, navigation: String) {
        self.name = name
        self.icon = icon
        self.navigation = navigation
        self.descrisption = descrisption
    }
    
    static func generate() -> [Feature] {
        
        return [Feature(name: "About Us", descrisption: "Review your ", icon: UIImage(named: "Notify")!, navigation: "AboutUs"), Feature(name: "Notify", descrisption: "Set a notify for lover", icon: UIImage(named: "Notify")!, navigation: "Notify"), Feature(name: "Setting", descrisption: "Settings and Author", icon: UIImage(named: "Notify")!, navigation: "Setting")]
    }
}
