//
//  ViewController.swift
//  firebase-chatting
//
//  Created by teppei.kikuchi on 2019/06/26.
//  Copyright © 2019 teppei.kikuchi. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameInputView: UITextField!
    @IBOutlet weak var messageInputView: UITextField!
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    
    var databaseRef: DatabaseReference!
    
    let userDefaults = UserDefaults.standard
    fileprivate let nameKey = "name"
    fileprivate let messageKey = "message"
    
    var roomName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        readData()
        
        addKeyboardShowHideObserver()
        
        nameInputView.delegate = self
        nameInputView.text = readNameData()
        
    }
    
    private func readData() {
        databaseRef = Database.database().reference().child(roomName!)
        
        databaseRef.observe(.childAdded, with: { snapshot in
            dump(snapshot)
            if let obj = snapshot.value as? [String : AnyObject], let name = obj[self.nameKey] as? String, let message = obj[self.messageKey] {
                let currentText = self.textView.text
                self.textView.text = (currentText ?? "") + "\n\(name) : \(message)"
            }
        })
    }
    
    private func addKeyboardShowHideObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @IBAction func tappedSendButton(_ sender: Any) {
        view.endEditing(true)
        
        if let name = nameInputView.text, let message = messageInputView.text {
            save(name: name)
            
            let messageData = [nameKey: name, messageKey: message]
            databaseRef.childByAutoId().setValue(messageData)
            
            messageInputView.text = ""
        }
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification){
        if let userInfo = notification.userInfo, let keyboardFrameInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            inputViewBottomMargin.constant = keyboardFrameInfo.cgRectValue.height
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification){
        inputViewBottomMargin.constant = 0
    }
    
    fileprivate func readNameData() -> String {
        return userDefaults.object(forKey: nameKey) as? String ?? ""
    }
    
    fileprivate func save(name: String) {
        userDefaults.set(name, forKey: nameKey)
        userDefaults.synchronize()
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let inputText = textField.text else {
            return true
        }
        save(name: inputText)
        
        return true
    }
}
