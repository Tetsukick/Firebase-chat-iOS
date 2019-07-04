//
//  tolkRoomViewController.swift
//  firebase-chatting
//
//  Created by teppei.kikuchi on 7/3/19.
//  Copyright © 2019 teppei.kikuchi. All rights reserved.
//

import Foundation
import UIKit

class TalkRoomViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Room1"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showRoomView", sender: nil)
    }
}
