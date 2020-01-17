//
//  MeetPlacesTypesTableViewController.swift
//  FriendLancer
//
//  Created by Studio on 12/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit

class MeetPlacesTypesTableViewController: UITableViewController {
    
    @IBOutlet weak var plusBarBtn: UIBarButtonItem!
    var data = [MeetPlaceType]()
    
    var observer:Any?
    var selected:MeetPlaceType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observer = ModelEvents.MeetPlacesTypeDataNotification.observe{
            self.reloadData();
        }
        
        reloadData();
    }

    // MARK: - Table view data source
    
    func reloadData(){
        Model.instance.getAllMeetingPlaceTypes(callback: { (_data:[MeetPlaceType]?) in
            if (_data != nil) {
                self.data = _data!;
                self.tableView.reloadData();
            }
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MeetPlaceTypeCell = tableView.dequeueReusableCell(withIdentifier: "MeetPlaceTypeCell", for: indexPath) as! MeetPlaceTypeCell

        // Configure the cell...
        let meetPlaceType = data[indexPath.row]
        cell.meetPlaceTypeLbl.text = meetPlaceType.type
        
 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = data[indexPath.row]
        performSegue(withIdentifier: "toMeetPlacesSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toMeetPlacesSegue"){
            let vc:MeetPlaceTableViewController = segue.destination as! MeetPlaceTableViewController
            vc.meetPlaceType = selected
        }
    }
    
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
