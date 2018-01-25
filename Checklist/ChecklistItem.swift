//
//  ChecklistItem.swift
//  Checklist
//
//  Created by 谢振宇 on 2018/1/25.
//  Copyright © 2018年 谢振宇. All rights reserved.
//

import Foundation

class ChecklistItem{
    var text = ""
    var checked = false
    
    func toggleChecked(){
        checked = !checked
    }
}
