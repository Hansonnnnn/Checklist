//
//  AddItemViewController.swift
//  Checklist
//
//  Created by 谢振宇 on 2018/1/25.
//  Copyright © 2018年 谢振宇. All rights reserved.
//

import Foundation
import UIKit
protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
}
class AddItemViewController: UITableViewController, UITextFieldDelegate{
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    weak var delegate: AddItemViewControllerDelegate?
    @IBAction func done(){
//        print("Contents of the text field: \(textField.text!)")
//        dismiss(animated: true, completion: nil)
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = true
        delegate?.addItemViewController(self, didFinishAdding: item)
    }
    @IBAction func cancel(){
//        dismiss(animated: true, completion: nil)
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //this is often called “giving the control focus”
        textField.becomeFirstResponder()
    }
    
    /**
     该方法实现当用户什么都没输入时，不让点击Done按钮；初始时，按钮的状态为Enable是在StoryBoard里面设置的
    */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
//        if newText.length > 0 {
//            doneBarButton.isEnabled = true
//        }else {
//            doneBarButton.isEnabled = false
//        }
        doneBarButton.isEnabled = (newText.length > 0)
//        print("range is: \(range)")
//        print("string is: \(string)")
//        print("oldText is: \(oldText)")
//        print("newText is: \(newText)")
        /*
         range is: {0, 0}
         string is: h
         oldText is:
         newText is: h
         */
 
        return true
    }
}
