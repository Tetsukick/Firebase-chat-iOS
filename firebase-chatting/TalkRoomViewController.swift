//
//  tolkRoomViewController.swift
//  firebase-chatting
//
//  Created by teppei.kikuchi on 7/3/19.
//  Copyright © 2019 teppei.kikuchi. All rights reserved.
//

import Foundation
import UIKit
import  FirebaseDatabase

class TalkRoomViewController: UITableViewController {
    
    var databaseRef: DatabaseReference!
    
    var roomData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = Database.database().reference()
        
        databaseRef.observe(.childAdded, with: { snapshot in
            self.roomData.append(snapshot.key)
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomData.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch  indexPath.row {
        case ..<roomData.count:
            cell.textLabel?.text = roomData[indexPath.row]
        default:
            cell.textLabel?.text = "+ Create New Room"
            cell.textLabel?.textColor = UIColor.blue
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case ..<roomData.count:
            let roomName = roomData[indexPath.row]
            self.performSegue(withIdentifier: "showRoomView", sender: roomName)
        default:
            self.performSegue(withIdentifier: "modalCreateRoomView", sender: nil)
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showRoomView", let targetVC = segue.destination as? ViewController else {
            return
        }
        
        if let roomName = sender as? String {
            targetVC.roomName = roomName
        }
    }
}
