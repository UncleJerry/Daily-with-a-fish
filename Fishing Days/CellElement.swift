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
    var description: String? { get }
    var icon: UIImage? { get }
    var navigation: String? { get }

}

class Feature: CellElement {

    var icon: UIImage?
    var name: String?
    var navigation: String?
    var description: String?
    
    init(name: String, descrisption: String, icon: UIImage, navigation: String) {
        self.name = name
        self.icon = icon
        self.navigation = navigation
        self.description = descrisption
    }
    
    static func generate() -> [Feature] {
        
        return [Feature(name: "About Us", descrisption: "Review our love journal", icon: UIImage(named: "About us")!, navigation: "AboutUs"), Feature(name: "Notify", descrisption: "Set a notify for lover", icon: UIImage(named: "Notify")!, navigation: "Notify"), Feature(name: "Setting", descrisption: "Settings and Author", icon: UIImage(named: "Setting")!, navigation: "Settings")]
    }
}

class Setting: CellElement {
    var description: String?
    var icon: UIImage?
    var name: String?
    var type: SettingType = .Basic
    var navigation: String?
    
    init(name: String, description: String?, icon: UIImage?, type: SettingType, navigation: String?) {
        self.name = name
        self.description = description ?? nil
        self.icon = icon ?? nil
        self.type = type
        self.navigation = navigation ?? nil
    }
    
    static func generate() -> [Setting]{
        return [Setting(name: "Profile", description: nil, icon: nil, type: .Profile, navigation: nil), Setting(name: "Display Total days", description: nil, icon: nil, type: .Basic, navigation: nil), Setting(name: "Log out", description: nil, icon: nil, type: .Logout, navigation: "Logout"), Setting(name: "About Author", description: nil, icon: nil, type: .About, navigation: nil)]
    }
    
}

enum SettingType {
    case Basic // Switch
    case Display
    case Profile
    case About
    case Logout
}
