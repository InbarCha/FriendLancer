//
//  CommentsTableViewController.swift
//  FriendLancer
//
//  Created by Studio on 12/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit
import Firebase

class CommentsTableViewController: UITableViewController {

    //the comment's post
    var post:Post?
    var data = [Comment]()
    
    var observer1:Any?
    var observer2:Any?
    var observer3:Any?
    var selected:Comment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observer1 = ModelEvents.CommentDataNotification.observe{
            self.reloadData();
        }
        observer2 = ModelEvents.UserLoggedInDataNotification.observe {
            self.reloadData();
        }
        observer3 = ModelEvents.UserLoggedOutDataNotification.observe {
            self.reloadData();
        }
        
        reloadData();
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        observer1 = ModelEvents.CommentDataNotification.observe{
//            self.reloadData();
//        }
//        
//        reloadData();
//    }
    
    func reloadData(){
        if (Auth.auth().currentUser != nil) {
            Model.instance.getAllComments(callback: { (_data:[Comment]?) in
                if (_data != nil) {
                    self.data = _data!;
                    self.tableView.reloadData();
                }
            }, postId: post!.postId)
        }
        else {
            self.data = [Comment]()
            self.tableView.reloadData();
        }
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
        let cell:CommentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell

        // Configure the cell...
        let comment = data[indexPath.row]
        cell.nameLbl.text = comment.userName
        cell.ProfessionLbl.text = comment.userProfession
        cell.commentLbl.text = comment.comment
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = data[indexPath.row]
        performSegue(withIdentifier: "toEditCommentSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toNewCommentSegue"){
            let vc:NewCommentViewController = segue.destination as! NewCommentViewController
            vc.post = self.post
        }
        
        if (segue.identifier == "toEditCommentSegue"){
            let vc:EditCommentViewController = segue.destination as! EditCommentViewController
            vc.post = post
            vc.comment = selected
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
