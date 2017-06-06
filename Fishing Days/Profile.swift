//
//  Profile.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/6/5.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import Foundation
import RealmSwift

class Profile: Object {
    dynamic var Firstname = ""
    dynamic var Lastname = ""
    dynamic var isFemale = false
    dynamic var matchedFName = ""
    dynamic var matchedLName = ""
    dynamic var dateString = ""
}
