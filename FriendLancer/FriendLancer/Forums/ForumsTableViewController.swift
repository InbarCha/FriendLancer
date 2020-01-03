//
//  ForumsTableViewController.swift
//  FriendLancer
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit

class ForumsTableViewController: UITableViewController {
    var data = [Forum]()
    @IBOutlet weak var addNewForumBtn: UIBarButtonItem!
    
    var observer:Any?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observer = ModelEvents.ForumDataNotification.observe{
            self.reloadData();
        }
        
        reloadData();
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    func reloadData(){
        Model.instance.getAllForums { (_data:[Forum]?) in
            if (_data != nil) {
                self.data = _data!;
                self.tableView.reloadData();
            }
        };
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ForumTopicsCell = tableView.dequeueReusableCell(withIdentifier: "ForumTopicsCell", for: indexPath) as! ForumTopicsCell

        // Configure the cell...
        let forum = data[indexPath.row]
        cell.ForumTopicLbl.text = forum.forumTopic
        cell.ForumTopicImage.image = UIImage(named: "avatar")
        return cell
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
