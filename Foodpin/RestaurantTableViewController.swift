//
//  RestaurantTableViewController.swift
//  Foodpin
//
//  Created by viplab on 2018/7/29.
//  Copyright © 2018年 viplab. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurantNames = ["Cafe Deadend","Homei","Teakha","Cafe Loisl","Petite Oyster","For Kee Restaurant","Po's Atelier","Bourke Street Bakery","Haigh's Chocolate","Palomino Espresso","Upstate","Traif","Graham Avenue Meats And Deli","Waffle & Wolf","Five Leaves","Cafe Lore","Confessional","Barrafina","Donostia","Royal Oak","CASK Pub and Kitchen"]
    var restaurantimg = ["cafedeadend","homei","teakha","cafeloisl","petiteoyster","forkeerestaurant","posatelier","bourkestreetbakery","haighschocolate","palominoespresso","upstate","traif","grahamavenuemeats","wafflewolf","fiveleaves","cafelore","confessional","barrafina","donostia","royaloak","caskpubkitchen"]
    var restaurantLoction = ["Hong Kong","Hong Kong","Hong Kong","Hong Kong","Hong Kong","Hong Kong","Hong Kong","Sydney","Sydney","Sydney","New York","New York","New York","New York","New York","New York","New York","London","London","London","London"]
    var restaurantType = ["Coffee & Tea Shop","Cafe","Tea House","Austrian / Causual Drink","French","Bakery","Bakery","Chocolate","Cafe","American / Seafood","American","American","Breakfast & Brunch","Coffee & Tea","Coffee & Tea","Latin American","Spanish","Spanish","Spanish","British","Thai"]
    var restaurantbool = Array(repeating:false, count: 21)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)as!RestaurantTableViewCell
        
        
        //設定Cell
        cell.nameLabel?.text = restaurantNames[indexPath.row]
        cell.locationLabel.text = restaurantLoction[indexPath.row]
        cell.typeLabel?.text = restaurantType[indexPath.row]
        cell.thumbnailImageView?.image = UIImage(named:restaurantimg[indexPath.row])
        if restaurantbool[indexPath.row]{
            cell.heartIcon.isHidden = false
        }
        else
        {
            cell.heartIcon.isHidden = true
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //建立一個動作清單
        let optionMenu = UIAlertController(title:nil,message:"What do you want to do?",preferredStyle:.actionSheet)
        
        if let popoverController = optionMenu.popoverPresentationController{
            if let cell = tableView.cellForRow(at: indexPath){
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        
        //加入動作至選單中
        
        //取消
        let cancelAction = UIAlertAction(title:"Cancel",style:.cancel,handler:nil)
        optionMenu.addAction(cancelAction)
        
        //打電話
        let callActionHandler = {(action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title:"Service Unavailable",message:"Sorry the call feature is not available yet.Please retry later.",preferredStyle:.alert)
            alertMessage.addAction(UIAlertAction(title:"OK",style:.default,handler:nil))
            self.present(alertMessage,animated: true,completion: nil)
            
        }
        let callAction = UIAlertAction(title:"Call "+"123-000-\(indexPath.row)",style:.default,handler:callActionHandler)
        optionMenu.addAction(callAction)
        
        //打卡
        if restaurantbool[indexPath.row]{
            let checkInAction = UIAlertAction(title:"Undo Checkin",style:.default,handler:{(action:UIAlertAction!)->Void in
                let cell = tableView.cellForRow(at: indexPath)as!RestaurantTableViewCell
                cell.heartIcon.isHidden = true
                self.restaurantbool[indexPath.row] = false
            })
            optionMenu.addAction(checkInAction)
        }
        else{
            let checkInAction = UIAlertAction(title:"Check in",style:.default,handler:{(action:UIAlertAction!)->Void in
                let cell = tableView.cellForRow(at: indexPath)as!RestaurantTableViewCell
                cell.heartIcon.isHidden = false
                self.restaurantbool[indexPath.row]=true
            })
            optionMenu.addAction(checkInAction)
        }
        
        
        
        //呈現選單
        present(optionMenu,animated: true,completion: nil)
        
        //取消列的選取
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    
    
    
    
    
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
            restaurantNames.remove(at: indexPath.row)
            restaurantimg.remove(at: indexPath.row)
            restaurantType.remove(at: indexPath.row)
            restaurantLoction.remove(at: indexPath.row)
            restaurantbool.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }*/
    

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
