//
//  MeetPlaceTableViewController.swift
//  FriendLancer
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit
import Firebase

class MeetPlaceTableViewController: UITableViewController {

    var meetPlaceType:MeetPlaceType?
    var data = [MeetPlace]()
    var observer1:Any?
    var observer2:Any?
    var observer3:Any?
    var selected:MeetPlace?
    @IBOutlet weak var plusBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (meetPlaceType != nil) {
            self.title = meetPlaceType?.type
        }
        
        observer1 = ModelEvents.MeetPlacesDataNotification.observe{
            self.reloadData();
        }
        observer2 = ModelEvents.UserLoggedInDataNotification.observe {
            self.ifUserLoggedIn()
        }
        observer3 = ModelEvents.UserLoggedOutDataNotification.observe {
            self.ifUserLoggedIn()
        }
        
        reloadData();
        ifUserLoggedIn()
    }
    
    func ifUserLoggedIn() {
        if (Auth.auth().currentUser != nil) {
            //user is logged in. check if it's admin
            let email = Auth.auth().currentUser?.email
            Model.instance.getUserByEmail(callback: { (myUser:User?) in
                if(myUser != nil) {
                    if (myUser?.isAdmin == "true") {
                        self.plusBtn.isEnabled = true
                    }
                    else {
                        self.plusBtn.isEnabled = false
                    }
                }
            }, email: email!)
        }
        else {
            self.plusBtn.isEnabled = false
        }
    }
    
    
    func reloadData(){
        Model.instance.getAllMeetingPlaces(callback: { (_data:[MeetPlace]?) in
            if (_data != nil) {
                self.data = _data!;
                self.tableView.reloadData();
            }
        }, meetPlaceTypeId: meetPlaceType!.typeId)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MeetPlaceCell = tableView.dequeueReusableCell(withIdentifier: "MeetPlaceCell", for: indexPath) as! MeetPlaceCell

        // Configure the cell...
        let meetPlace = data[indexPath.row]
        cell.name.text = meetPlace.name
        cell.address.text = meetPlace.address
        cell.city.text = meetPlace.city
        
        if (meetPlace.image != "") {
            cell.myImage.kf.setImage(with: URL(string: meetPlace.image))
        }
        else {
            cell.myImage.image = UIImage(named: "avatar")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = data[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toNewMeetPlaceSegue"){
            let vc:NewMeetPlaceViewController = segue.destination as! NewMeetPlaceViewController
            vc.meetPlaceType = self.meetPlaceType!
        }
    }
    
    

    /*s
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
