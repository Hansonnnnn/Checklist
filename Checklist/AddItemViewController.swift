//
//  AddItemViewController.swift
//  Checklist
//
//  Created by 谢振宇 on 2018/1/25.
//  Copyright © 2018年 谢振宇. All rights reserved.
//

import Foundation
import UIKit

class AddItemViewController: UITableViewController{
    @IBAction func done(){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancel(){
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
