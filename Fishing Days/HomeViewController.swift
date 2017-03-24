//
//  HomeViewController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/1/28.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "Background.png")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        InLoveLabel.fadeIn(duration: 3)
        let now = Day()
        
        CountLabel.text = now.printToLabel(model: CountModel.Full)
        CountLabel.fadeIn(duration: 4)
        if now.year > 0 || now.month > 0{
            TotalDays.text = now.printToLabel(model: CountModel.Days)
            TotalDays.fadeIn(duration: 4)
        }else{
            TotalDays.text = ""
        }
        
        StatusLabel.text = now.dayinfo.InternalStatus!.rawValue
        StatusLabel.fadeIn(duration: 5)
        guard let toast = now.dayinfo.SpeDay else {
            MiddleLabel.text = "Do you aware of that, " + now.dayinfo.NextSpeDate!.toString
            BottomLabel.text = "will be our " + now.dayinfo.NextSpeDay!.name + " Day."
            
            MiddleLabel.fadeIn(duration: 6)
            BottomLabel.fadeIn(duration: 7)
            
            Jerry.fadeIn(duration: 8)
            Zoe.fadeIn(duration: 8)
            About.fadeIn(duration: 8)
            
            return
        }
        
        MiddleLabel.text = toast.rawValue
        MiddleLabel.fadeIn(duration: 6)
        
        Jerry.fadeIn(duration: 8)
        Zoe.fadeIn(duration: 8)
        About.fadeIn(duration: 8)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    @IBOutlet var InLoveLabel: UILabel!
    @IBOutlet var CountLabel: UILabel!
    @IBOutlet var TotalDays: UILabel!
    @IBOutlet var StatusLabel: UILabel!
    @IBOutlet var MiddleLabel: UILabel!
    @IBOutlet var BottomLabel: UILabel!
    
    @IBOutlet var Jerry: UILabel!
    @IBOutlet var Zoe: UILabel!
    @IBOutlet var About: UILabel!

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
