//
//  Status.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/6/7.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import Foundation
import RealmSwift

class Status: Object {
    dynamic var logged = false
    dynamic var signupView = ""
    dynamic var meetErrorWhenSignUp = false
    dynamic var deviceid = ""
    dynamic var registered = false
}

