//
//  ViewController.swift
//  Exercicio5
//
//  Created by user151694 on 4/2/19.
//  Copyright © 2019 PUC. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    struct Todo{
        var Task:String
        var isCompleted: Bool = false
        
        init (Task : String){
            self.Task = Task
            self.isCompleted = false
        }
        
    }
    
    var items: [Todo] = [
        Todo(Task: "Terminar exercícios de IOS"),
        Todo(Task: "Trocar Android por um Iphone"),
        Todo(Task: "Comprar um MackBook"),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
            tableView.register(TodoItemCell.self,forCellReuseIdentifier: "todoItem")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoItem" , for: indexPath) as? TodoItemCell else { fatalError() }
        
        
        let todo = items[indexPath.row]
        cell.textLabel?.text = todo.Task
        cell.isCompleted = todo.isCompleted
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].isCompleted.toggle()
      //  tableView.reloadData()
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    
       
}

