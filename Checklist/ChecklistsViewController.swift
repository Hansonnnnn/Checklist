//
//  ViewController.swift
//  Checklist
//
//  Created by 谢振宇 on 2018/1/22.
//  Copyright © 2018年 谢振宇. All rights reserved.
//

import UIKit

class ChecklistsViewController: UITableViewController, AddItemViewControllerDelegate {
    var items: [ChecklistItem]
//    var row0item: ChecklistItem
//    var row1item: ChecklistItem
//    var row2item: ChecklistItem
//    var row3item: ChecklistItem
//    var row4item: ChecklistItem
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        
        let row0item = ChecklistItem()
        row0item.text = "Walk the dog"
        row0item.checked = false
        items.append(row0item)
        
        let row1item = ChecklistItem()
        row1item.text = "Brush my teeth"
        row1item.checked = true
        items.append(row1item)
        
        let row2item = ChecklistItem()
        row2item.text = "Learn iOS development"
        row2item.checked = true
        items.append(row2item)
        
        let row3item = ChecklistItem()
        row3item.text = "Soccer practice"
        row3item.checked = false
        items.append(row3item)
        
        let row4item = ChecklistItem()
        row4item.text = "Eat ice cream"
        row4item.checked = true
        items.append(row4item)
        
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
//        if indexPath.row % 5 == 0{
//            label.text = row0item.text
//        }else if indexPath.row % 5 == 1{
//            label.text = row1item.text
//        }else if indexPath.row % 5 == 2{
//            label.text = row2item.text
//        }else if indexPath.row % 5 == 3{
//            label.text = row3item.text
//        }else if indexPath.row % 5 == 4{
//            label.text = row4item.text
//        }
//        let label = cell.viewWithTag(1000) as! UILabel
//        label.text = item.text
        //这两步被进一步抽象
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //make tableView(didSelectRowAt) toggle the checkmark
        if let cell = tableView.cellForRow(at: indexPath){
            let item = items[indexPath.row]
//            item.checked = !item.checked
            //进一步抽象为方法
            item.toggleChecked()
            
//            items[indexPath.row].checked = !items[indexPath.row].checked
//            if indexPath.row == 0{
//                row0item.checked = !row0item.checked
//            }else if indexPath.row == 1{
//                row1item.checked = !row1item.checked
//            }else if indexPath.row == 2{
//                row2item.checked = !row2item.checked
//            }else if indexPath.row == 3{
//                row3item.checked = !row3item.checked
//            }else if indexPath.row == 4{
//                row4item.checked = !row4item.checked
//            }
            //之前是这样的，直接根据cell.accessoryType来修改标记的，
            //现在应该是按照row来确定标记
//            if cell.accessoryType == .none{
//                cell.accessoryType = .checkmark
//            }else{
//                cell.accessoryType = .none
//            }
            //这里的isChecked不是完成时，而是现在还没做下面的判断的状态
            //如果被选择了，就要加上对勾？？？？？Right？
//            if isChecked {
//                cell.accessoryType = .checkmark
//            }else{
//                cell.accessoryType = .none
//            }
            //到目前为止这样的实现会导致点两下才能消失，原因：在一开始的时候accessoryType和变量状态不一致--一开始rowXchecked变量保存的false，而界面初始化就是true，即带checkmark的
            //解决方法Initially all the rows are unchecked
            configureCheckmark(for: cell, with: item)
        }
        //这一行的作用是可以让滑动点击时，变灰的行再变回原来的颜色
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath){
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem){
//        var isChecked = false
//        if indexPath.row == 0{
//            isChecked = row0item.checked
//        }else if indexPath.row == 1{
//            isChecked = row1item.checked
//        }else if indexPath.row == 2{
//            isChecked = row2item.checked
//        }else if indexPath.row == 3{
//            isChecked = row3item.checked
//        }else if indexPath.row == 4{
//            isChecked = row4item.checked
//        }
        if item.checked {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }

    @IBAction func addItem(){
        let newRowIndex = items.count
//        print(newRowIndex)
        let item = ChecklistItem()
        item.text = "I am a new row"
        item.checked = false
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        //分为两步，data model删除该元素；界面删除该元素所在行
        items.remove(at: indexPath.row)
        //注意一个地方：不管是增加还是删除，都是对数组进行操作
        let indexPaths = [indexPath]
        //.automatic是动画效果
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
}

