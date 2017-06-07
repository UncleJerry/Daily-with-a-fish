//
//  SettingCell.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/29.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class SettingCell: GeneralCollectionCell {
    
    @IBOutlet weak var FirstLabel: UILabel!
    @IBOutlet weak var SecondLabel: UILabel!
    
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var FirstTextfield: UITextField!
    @IBOutlet weak var SecondTextfield: UITextField!
    
    @IBOutlet weak var FirstSwitch: UISwitch!
    @IBOutlet weak var SecondSwitch: UISwitch!
    
    @IBOutlet weak var FirstButton: FunctionButton!
    @IBOutlet weak var SecondButton: FunctionButton!
    
    
    var profile: Profile?{
        didSet{
            FirstButton.isHidden = true
            SecondButton.isHidden = true
            
            Title.text = setting.name
            FirstLabel.text = "Name: "
            FirstTextfield.text = profile!.Firstname + " " + profile!.Lastname
            SecondLabel.text = "Fall in love with " + profile!.matchedFName + " " + profile!.matchedLName
            SecondTextfield.isHidden = true
            
            FirstSwitch.isHidden = true
            SecondSwitch.isHidden = true
        }
    }
    
    var setting: Setting! {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        
        if setting.type == .Basic {
            FirstButton.isHidden = true
            SecondButton.isHidden = true
            
            Title.text = "Days"
            FirstLabel.text = setting.name
            FirstTextfield.isHidden = true
            SecondLabel.text = "Show total days or year, month"
            SecondTextfield.isHidden = true
            SecondSwitch.isHidden = true
            
            let defaults: UserDefaults = UserDefaults.standard
            FirstSwitch.isOn = defaults.bool(forKey: "DisplayTotalDays")
            
        }else if setting.type == .About {
            FirstButton.isHidden = true
            SecondButton.isHidden = true
            
            Title.text = "About"
            FirstLabel.text = "Designed by Jerry Chou"
            FirstTextfield.isHidden = true
            SecondTextfield.isHidden = true
            SecondLabel.text = "Illustrated by Zoe Liu"
            
            FirstSwitch.isHidden = true
            SecondSwitch.isHidden = true
        }else if setting.type == .Logout {
            Title.text = "More"
            FirstButton.setTitle("Click here to give us advices.", for: UIControlState.normal)
            FirstButton.command = "email"
            SecondButton.setTitle("Want to log out? ", for: UIControlState.normal)
            SecondButton.command = "Logout"
            
            FirstLabel.isHidden = true
            SecondLabel.isHidden = true
            FirstTextfield.isHidden = true
            SecondTextfield.isHidden = true
            
            FirstSwitch.isHidden = true
            SecondSwitch.isHidden = true
        }
    }
}
