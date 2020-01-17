//
//  ForumsForTopicTableViewController.swift
//  FriendLancer
//
//  Created by Studio on 06/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit
import Firebase

class ForumsForTopicTableViewController: UITableViewController {

    var forum:Forum?
    var data = [Post]()
    
    var observer1:Any?;
    var observer2:Any?
    var observer3:Any?
    var selected:Post?
    @IBOutlet weak var plusBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observer1 = ModelEvents.PostDataNotification.observe{
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
                    self.plusBtn.isEnabled = true
                }
            }, email: email!)
        }
        else {
            self.plusBtn.isEnabled = false
        }
    }
    
    func reloadData(){
        Model.instance.getAllPosts(callback: { (_data:[Post]?) in
            if (_data != nil) {
                self.data = _data!;
                self.tableView.reloadData();
            }
        }, forumName: forum!.forumTopic)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ForumPostCell = tableView.dequeueReusableCell(withIdentifier: "ForumPostCell", for: indexPath) as! ForumPostCell

        // Configure the cell...
        let post = data[indexPath.row]
        cell.titleLbl.text = post.postTitle
        cell.meetingPlaceLbl.text = post.meetingPlace
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = data[indexPath.row]
        performSegue(withIdentifier: "ToPostSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToPostSegue"){
            let vc:ForumPostViewController = segue.destination as! ForumPostViewController
            vc.post = selected
        }
        if (segue.identifier == "toNewForumPostSegue") {
            let vc:NewPostViewController = segue.destination as! NewPostViewController
            vc.forumTopic = self.forum!.forumTopic
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
