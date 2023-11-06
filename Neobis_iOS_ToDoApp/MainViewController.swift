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

protocol TaskDelegate: AnyObject {
    func createTask(name: String, description: String)
    func updateTask(at indexPath: IndexPath, name: String, description: String)
}

class MainViewController: UIViewController {

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
         //  '+' button
         let editorVC = storyboard?.instantiateViewController(withIdentifier: "EditorViewController") as! EditorViewController
         editorVC.delegate = self
         present(editorVC, animated: true, completion: nil)
         // анимация
         tableView.beginUpdates()
             let indexPathToAdd = [IndexPath(row: 1, section: 0), IndexPath(row: 5, section: 0)]
             let indexPathToRemove = [IndexPath(row: 1, section: 0), IndexPath(row: 5, section: 0)]

             tableView.insertRows(at: indexPathToAdd, with: .fade)
             tableView.deleteRows(at: indexPathToRemove, with: .fade)

             tableView.endUpdates()
     }
     
     @IBAction func editorButtonTapped(_ sender: UIButton) {
         //  'Editor' button
         let editorVC = storyboard?.instantiateViewController(withIdentifier: "EditorViewController") as! EditorViewController
         editorVC.delegate = self
         present(editorVC, animated: true, completion: nil)
     }
 }

 extension MainViewController: TaskDelegate {
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       //повторное испотзование ячеек
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].name
        cell.accessoryType = .detailButton
        cell.tintColor = .blue
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
    // automaticDimension высоту будет расчитывать сама для статистического
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60}
        else {
            return UITableView.automaticDimension }}
    //для предварительного расчета размера ячеек для статистического
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 60 }
        else {
            return 120 }}
    // стандартнвй стиль ячеек Uitableview
    private func tableView(_tableView:UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        let selectedRow = indexPath.row
        let selectedSection = indexPath.section }
   
}
