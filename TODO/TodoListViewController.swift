//
//  ViewController.swift
//  TODO
//
//  Created by Euclid on 2019/4/16.
//  Copyright © 2019 liuxiang. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["购买水杯","吃饭","修改密码"] //临时呈现的事务列表项
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- Add New Items
    @IBAction func addButtonPresent(_sender: UIBarButtonItem) {
        
        //声明一个新的变量，生存期在方法的内部
        var textField = UITextField()
        
        //创建了一个UIAlertController类型对象，并设置警告对话框的标题为”添加一个新的Todo项目“，风格为.alert类型。
        let alert = UIAlertController(title: "添加一个新的Todo项目", message: "", preferredStyle: .alert)
        //创建了一个UIAlertAction类型的对象
        let action = UIAlertAction(title: "添加项目", style: .default) { (action) in
            //用户单击”添加项目“后执行的代码
            self.itemArray.append(textField.text!)
            self.tableView.reloadData() //前面数据更新了，因此也要重载数据，更新视图
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "创建一个新项目..."
            //让textField指向alertTextField，因为出了闭包，alertTextField就不存在了
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil) //通过present方法将警告框显示在屏幕上
    }
    
    //MARK:- Table View DataSource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //初始化cell，ID为ToDoItemCell，在故事板中可以找到。也就是告诉Controller，我们复用哪个单元格对象（cell）。
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        //每行的cell显示的文本为行数对应的在itemArray中的数据。textLabel是每个单元格对象都会有的内置Label。
        cell.textLabel?.text = itemArray[indexPath.row]
        //返回这个cell给函数
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count //设置表格每类（Section）对应的行数为数组的元素个数。注意：Section默认为1.
    }
    
    //MARK:- Table View Delegate methods
    //该方法用于告诉控制器用户单击了表格视图中的哪个单元格，我们通过indexPath参数得到该信息。
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)  //打印的是row值，就是行数。从0开始，和数组索引是一样的。
        print(itemArray[indexPath.row]) //打印的是点击的row对应的数据内的元素值。
        
        //如果是勾选状态，点击后取消勾选，否则，点击后勾选。
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark //点击后右侧出现勾选。
        }
        //取消选中状态，并启用动画过渡。解决点击某个后，一直保持灰色选中状态，这样可以变成点击状态。视觉效果：点击完后，灰色逐渐消失。
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

