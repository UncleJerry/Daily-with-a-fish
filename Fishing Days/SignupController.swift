//
//  SignupController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/3/30.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import Alamofire

class SignupController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var NextButton: ButtonView!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var FirstNLabel: UITextField!
    @IBOutlet weak var LastNLabel: UITextField!
    @IBOutlet weak var Tips: UILabel!
    @IBOutlet weak var MaleButton: RadioBox!
    @IBOutlet weak var FemaleButton: RadioBox!
    

    @IBAction func MaleTouch(_ sender: RadioBox) {
        MaleButton.doesSelected = true
        FemaleButton.doesSelected = false
    }
    @IBAction func FemaleTouch(_ sender: RadioBox) {
        FemaleButton.doesSelected = true
        MaleButton.doesSelected = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func NextStep(_ sender: ButtonView) {
        let parameter: Parameters = ["first": FirstNLabel.text!, "gender": FemaleButton.doesSelected ? "female" : "male", "last": FirstNLabel.text!]
        
        Alamofire.request("https://jerrypho.club:3223/signup/match_complete",method: .post, parameters: parameter).validate(statusCode: 200...202).responseData { response in
            switch response.result {
            case .success:
                self.performSegue(withIdentifier: "GoToMatch", sender: nil)
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToMatch"{
            let destination: MatchViewController = segue.destination as! MatchViewController
            if FemaleButton.doesSelected {
                destination.isFemale = true
            }else{
                destination.isFemale = false
            }
            
        }
    }
}
