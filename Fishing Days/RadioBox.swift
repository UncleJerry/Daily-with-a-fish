//
//  RadioBox.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/4/1.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class RadioBox: UIButton {
    
    var selectedButton: UIImage?
    var selectedBG: UIImage = UIImage(named: "ButtonBG")!
    var unSelecteButton: UIImage?
    var image: String?
    
    var doesSelected: Bool = false {
        willSet{
            
            // load the image name info if haven't loaded
            guard image != nil else {
                if self.currentImage?.size.width == CGFloat(22) {
                    image = "Female"
                }else{
                    image = "Male"
                }
                return
            }
        }
        didSet{
            
            if doesSelected {
                self.setImage(selectedButton ?? UIImage(named: image! + "S"), for: .normal)
                self.setBackgroundImage(selectedBG, for: .normal)
                
                // load the image if haven't loaded
                guard selectedButton != nil else {
                    selectedButton = UIImage(named: image! + "S")
                    return
                }
            }else{
                self.setImage(unSelecteButton ?? UIImage(named: image!), for: .normal)
                self.setBackgroundImage(nil, for: .normal)
                
                // load the image if haven't loaded
                guard unSelecteButton != nil else {
                    unSelecteButton = UIImage(named: image!)
                    return
                }
            }
        }
    }
    

}
