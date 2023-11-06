//
//  EditorViewController.swift
//  Neobis_iOS_ToDoApp
//
//  Created by Interlink on 6/11/23.
import UIKit

class EditorViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var task: Task?
    var indexPath: IndexPath?
    weak var delegate: TaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        if let task = task {
            // Редактирование существующей задачи
            nameTextField.text = task.name
            descriptionTextField.text = task.description
        } else {
            // Создание новой задачи
            nameTextField.text = ""
            descriptionTextField.text = ""
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, let description = descriptionTextField.text else {
            return
        }
        
        if let task = task, let indexPath = indexPath {
            // Редактирование существующей задачи
            delegate?.updateTask(at: indexPath, name: name, description: description)
        } else {
            // Создание новой задачи
            delegate?.createTask(name: name, description: description)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

