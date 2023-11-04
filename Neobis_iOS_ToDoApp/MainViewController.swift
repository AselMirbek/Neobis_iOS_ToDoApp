//
//  ViewController.swift
//  Neobis_iOS_ToDoApp
//
//  Created by Interlink on 4/11/23.
//

import UIKit
class Task {
    var name: String
    var description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}

protocol TaskDelegate: class {
    func createTask(name: String, description: String)
    func updateTask(at indexPath: IndexPath, name: String, description: String)
}
class ViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var addButton: UIButton!
     @IBOutlet weak var editorButton: UIButton!
     
     var tasks: [Task] = []
     
     weak var delegate: TaskDelegate?

     override func viewDidLoad() {
         super.viewDidLoad()
         
         tableView.delegate = self
         tableView.dataSource = self
     }

     @IBAction func addButtonTapped(_ sender: UIButton) {
         // Handle '+' button tap
         let editorVC = storyboard?.instantiateViewController(withIdentifier: "EditorViewController") as! EditorViewController
         editorVC.delegate = self
         present(editorVC, animated: true, completion: nil)
     }
     
     @IBAction func editorButtonTapped(_ sender: UIButton) {
         // Handle 'Editor' button tap
         let editorVC = storyboard?.instantiateViewController(withIdentifier: "EditorViewController") as! EditorViewController
         editorVC.delegate = self
         present(editorVC, animated: true, completion: nil)
     }
 }

 extension ViewController: TaskDelegate {
     func createTask(name: String, description: String) {
         tasks.append(Task(name: name, description: description))
         tableView.reloadData()
     }
     
     func updateTask(at indexPath: IndexPath, name: String, description: String) {
         tasks[indexPath.row].name = name
         tasks[indexPath.row].description = description
         tableView.reloadRows(at: [indexPath], with: .automatic)
     }
 }

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        let editorVC = storyboard?.instantiateViewController(withIdentifier: "EditorViewController") as! EditorViewController
        editorVC.task = task
        editorVC.delegate = self
        editorVC.indexPath = indexPath
        present(editorVC, animated: true, completion: nil)
    }
}
