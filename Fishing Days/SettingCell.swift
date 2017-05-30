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
    
    var setting: Setting! {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        
        if setting.type == .Profile {
            Title.text = setting.name
            FirstLabel.text = "Name"
            FirstTextfield.text = "Jerry"
            SecondLabel.text = "Fall in love with "
            SecondTextfield.isHidden = true
            
            FirstSwitch.isHidden = true
            SecondSwitch.isHidden = true
        }else if setting.type == .Basic {
            Title.text = "Days"
            FirstLabel.text = setting.name
            FirstTextfield.isHidden = true
            SecondLabel.text = "Show total days or year, month"
            SecondTextfield.isHidden = true
            SecondSwitch.isHidden = true
            
        }else if setting.type == .About {
            Title.text = "About"
            FirstLabel.text = "Designed by Jerry Chou"
            FirstTextfield.isHidden = true
            SecondTextfield.isHidden = true
            SecondLabel.text = "Illustrated by Zoe Liu"
            
            FirstSwitch.isHidden = true
            SecondSwitch.isHidden = true
        }
    }
}
