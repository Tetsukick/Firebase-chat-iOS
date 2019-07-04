//
//  CreateTalkRoomViewController.swift
//  firebase-chatting
//
//  Created by teppei.kikuchi on 7/4/19.
//  Copyright © 2019 teppei.kikuchi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class CreateTalkRoomViewController:  UIViewController {
    
    @IBOutlet weak var inputRoomView: UITextField!
    
     var databaseRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = Database.database().reference()
    }
    
    @IBAction func tappedCreateButton(_ sender: Any) {
        
        if let roomName = inputRoomView.text, !roomName.isEmpty {
            let instanceValue = ["name":"name", "message":"message"]
            databaseRef.child(roomName).childByAutoId().setValue(instanceValue)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
