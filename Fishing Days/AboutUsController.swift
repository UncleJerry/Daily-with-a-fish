//
//  AboutUsController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/26.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class AboutUsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var CollectionView: UICollectionView!
    fileprivate var daycard: DayCard?
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UICollectionViewDataSource
extension AboutUsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        
        if indexPath.item < 3{
            switch indexPath.item {
            case 0:
                cell.Title.text = "Fall in love"
                cell.GiantText.text = daycard?.getTotalDays()
                cell.Image.isHidden = true
                cell.Description.isHidden = true
                
            case 1:
                cell.Title.text = "Today"
                cell.Image.isHidden = true

                
                guard let speDescrip = daycard?.getCurrentSpecial() else {
                    cell.Description.text = "Totay is normal but worth fighting for"
                    cell.GiantText.text = "Not in Special Day"
                    break
                }
                
                cell.GiantText.text = speDescrip
                cell.Description.text = ""
                
            case 2:
                cell.Title.text = "Next Special Day"
                cell.Image.isHidden = true
                let speDescrip = daycard?.getNextSpecial()
                cell.GiantText.text = speDescrip
                cell.Description.text = "Remain " + String(Date().calDays(thatDay: (daycard?.getNextSpeDate())!)) + " Days"
                
                
            default:
                break
            }
        }
        
        return cell
    }
}
