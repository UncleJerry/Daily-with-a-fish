//
//  ViewController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/1/24.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        CountLabel.text = getStr()
        CountLabel.fadeIn()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBOutlet var CountLabel: UILabel!
    
    func getStr() -> String {
        let now = Day()
        
        return now.printToLabel(model: CountModel.Full)
    }

}

