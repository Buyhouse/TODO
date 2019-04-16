//
//  ViewController.swift
//  TODO
//
//  Created by Euclid on 2019/4/16.
//  Copyright © 2019 liuxiang. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    //UserDefaults适合存储轻量级的本地客户端数据，适合存储一些简单的，如字符串和数字之类的东西。用来保存一个系统的用户名、密码实现记住密码功能，UserDefaults是首选。
    //    let defaults = UserDefaults.standard //因为 UserDefaults 是单例模式，所以需要通过类方法 standard 获取该类的实例
    
    var itemArray = [Item]() //声明一个存储Item对象的数组变量
    
    //创建一个常量存储应用的 Document 的路径
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)
        
        /*
        //创建一些默认数据
        let newItem = Item() //创建一个 Item 对象
        newItem.title = "购买水杯" //设置 Item 的 title 属性
        itemArray.append(newItem) //该 Item 对象添加到 itemArray 数组中
        
        let newItem2 = Item() //创建一个 Item 对象
        newItem2.title = "吃饭🍚" //设置 Item 的 title 属性
        itemArray.append(newItem2) //该 Item 对象添加到 itemArray 数组中
        
        let newItem3 = Item() //创建一个 Item 对象
        newItem3.title = "拯救地球🌍" //设置 Item 的 title 属性
        itemArray.append(newItem3) //该 Item 对象添加到 itemArray 数组中
        */
        
        loadItems()
        
        //再向 itemArray 数组中添加 117 个 newItem
//        for index in 4...120 {
//            let newItem = Item()
//            newItem.title = "第\(index)件事务"
//            itemArray.append(newItem)
//        }
        
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
            let newItem = Item() //创建一个 Item 对象
            newItem.title = textField.text! //设置 title 属性的值为用户输入的内容
            
            self.itemArray.append(newItem) //将 newItem 添加到 itemArray 数组之中
            
            self.saveItems() //存储Items
            
            //通过set()方法，将 itemArray 数组存储到 UserDefaults 中，与其对应的键名为TodoListArray
            //            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
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
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        //如果 itemArray 中的 Item 对象中的 done 属性为 false，则不勾选，否则勾选。
        let item = itemArray[indexPath.row]
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        //        if itemArray[indexPath.row].done == false {
        //            cell.accessoryType = .none
        //        } else {
        //            cell.accessoryType = .checkmark
        //        }
        
        
        print("更新第：\(indexPath.row)行")
        
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
        print(itemArray[indexPath.row].title) //打印的是点击的row对应的数据内的元素的title属性值。
        
        //通过 indexPath 参数，获取用户点击的单元格，判断单元格 done 属性值，如果值为 false，则修改为 true；反之，修改为false。
        //这里仅仅是根据用户点选修改数据，而数据知道的视图样式设置在 cellForRowAt 方法中
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //取反操作，常用于点选改变状态,同于下面代码
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        saveItems() //储存Items
        
        //更新视图
        tableView.beginUpdates()  //告诉表格视图我们想要马上更新某些单元格对象的界面了。
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)  //告诉表格视图我们想要马上更新某些单元格对象的界面了。
        tableView.endUpdates()  //告诉表格视图更新单元格的操作结束。
        
        //取消选中状态，并启用动画过渡。解决点击某个后，一直保持灰色选中状态，这样可以变成点击状态。视觉效果：点击完后，灰色逐渐消失。
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //存储Items
    func saveItems() {
        //借助 PropertyListEncoder 类对 itemArray 数组进行编码
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("编码错误：\(error)")
        }
    }
    
    //加载Items
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("解码 item 错误!")
            }
        }
    }
    
}

