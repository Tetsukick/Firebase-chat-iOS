//
//  KeyBoardToolBar.swift
//  smartESQ
//
//  Created by asiaquest on 2017/10/04.
//  Copyright © 2017年 asiaquest. All rights reserved.
//

import Foundation
import UIKit

class KeyboardToolBar : UIToolbar {
    
    init(target: Any, action: Selector?) {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40)
        super.init(frame: frame)
        settingBarItem(frame: frame, target: target, action: action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func settingBarItem(frame: CGRect, target: Any, action: Selector?) {
        barStyle = UIBarStyle.default
        sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: target, action: nil)
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: target, action: action)
        items = [spacer, commitButton]
    }
}
