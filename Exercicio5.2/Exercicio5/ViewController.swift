//
//  ViewController.swift
//  Exercicio5
//
//  Created by user151694 on 4/2/19.
//  Copyright © 2019 PUC. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    
    var items: [Todo] = []
    
    private let todoRepository = TodoRepository(
        network: NetworkService(baseUrl: "https://puc-dam-todolist.herokuapp.com/"),
        token: "qAw3FhMdMNacuwEyM0YNIS8XCTLUZ1ARxLJhu0O4Z0Q=")
    //User LA211
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodoItemCell.self,
                                forCellReuseIdentifier: "todoItem")
        atualizaLista()
        
    }
    
    @IBAction func AddIem(_ sender: Any) {
        let alert = UIAlertController(title: "Nova Tarefa", message: "Digite a nova tarefa", preferredStyle: .alert)
        alert.addTextField{(textField) in textField.placeholder = "Tarefa"}
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(_) in
            guard let task = alert.textFields?.first?.text else {return}
            
            self.todoRepository.create(taskTitle: task, callback: { (result) in
                switch result{
                case .success(let todoData):
                    self.atualizaLista()
                    print(todoData)
                case .error(let erro):
                    print(erro)
                }})
            self.tableView.reloadData()
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    func atualizaLista(){
        todoRepository.all { (result) in
            switch result{
            case .success(let todoData):
                self.items = todoData
                self.tableView.reloadData()
                print(todoData)
            case .error(let erro):
                print(erro)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let tarefaRealizada = self.items[indexPath.row].isCompleted
        let todo = self.items[indexPath.row]
        var msg = "Realizada"
        
        if (tarefaRealizada){msg = "Desmarcar"}
        
        let RealizarTarefaAction = UIContextualAction(
            style: .normal, title: msg, handler: {
                (action, view, completionHandler) in
                if (tarefaRealizada){self.items[indexPath.row].isCompleted = false}
                else{self.items[indexPath.row].isCompleted.toggle()}
                
                self.todoRepository.toggleComplete(id: todo.id!, callback: { (result) in
                    switch result{
                    case .success(let todoData):
                        print(todoData)
                    case .error(let erro):
                        print(erro)
                    }})
                self.tableView.reloadData()
                completionHandler(true)})
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [RealizarTarefaAction])
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Remover", handler: {(action, view, completionHandler) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoItem") as? TodoItemCell else{ fatalError()}
            let todo = self.items[indexPath.row]
            self.todoRepository.delete(id: todo.id! , callback: { (result) in
                
                switch result{
                case .success(let todoData):
                    self.atualizaLista()
                    self.tableView.reloadData()
                    print(todoData)
                case .error(let erro):
                    print(erro)}})
            
            self.tableView.reloadData()
            completionHandler(true)})
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [removeAction])
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoItem") as? TodoItemCell else{ fatalError()}
        let todo = items[indexPath.row]
        cell.textLabel?.text = todo.task
        cell.isCompleted = todo.isCompleted
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].isCompleted.toggle()
        // tableView.reloadData()
        // animacao
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.middle)
    }
    
    func tableView(_ tableView: UITableView,
                   willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        return indexPath
    }
    
    
       
}

