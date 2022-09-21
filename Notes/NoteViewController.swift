//
//  NoteViewController.swift
//  Notes
//
//  Created by Olegio on 17.09.2022.
//

import UIKit
import CoreData

class NoteViewController: UIViewController, UITextViewDelegate {
    
    var textView = UITextView()
    private let placeholder = "Enter your note here..."
    private let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let noteName: String?
    private var updatedName: String?
    
    init(noteName: String?) {
        self.noteName = noteName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addDoneButtonOnKeyboard()
        }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 252/255, green: 246/255, blue: 232/255, alpha: 1)
        setupNavigationBar()
        setupTextView()
    }
    
    private func setupNavigationBar() {
        title = "Add Note"
        addRightBarButtonItem()
    }
    
    // Set button to navigation bar
    private func addRightBarButtonItem() {
        let menuButton = UIButton(type: .custom)
        menuButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuButton.setImage(UIImage(named: "DoneButton"), for: .normal)
        menuButton.addTarget(self, action: #selector(saveNoteButtonAction), for: .touchUpInside)
        
        let rightBarButtonItem = UIBarButtonItem(customView: menuButton)
        rightBarButtonItem.tintColor = .white
        rightBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        rightBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func saveNoteButtonAction() {
        
        if noteName == nil {
            guard let updatedName = updatedName else { return }
            saveData(with: updatedName)
            self.navigationController?.popViewController(animated: true)
        } else {
            guard let noteName = noteName else { return }
            guard let updatedName = updatedName else { return }
            updateData(with: noteName, for: updatedName)
            self.navigationController?.popViewController(animated: true)
        }
    }

    private func saveData(with noteName: String) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Note", in: managedContext) else { return }
        let note = NSManagedObject(entity: entityDescription, insertInto: managedContext) as! Note
        note.name = noteName
        
        do {
            try managedContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func updateData(with noteName: String, for newName: String) {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "name = %@", noteName)
        
        if let notes = try? managedContext.fetch(fetchRequest), !notes.isEmpty {
            let note = notes.first!
            note.name = newName
            
            try? managedContext.save()
        }
    }
    
    // Setup Text View
    private func setupTextView() {
        textView = UITextView(frame: CGRect(x: 20, y: 0, width: UIScreen.main.bounds.size.width - 20, height: 400))
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        // Text View default settings
        textView.isEditable = true
        if noteName != nil {
            textView.text = noteName
            textView.textColor = .black
        } else {
            textView.text = placeholder
            textView.textColor = .systemGray
        }
//        textView.textColor = .systemGray
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = nil
        textView.autocorrectionType = .no
        textView.keyboardType = .default
        textView.returnKeyType = .default
        textView.delegate = self
        self.view.addSubview(textView)
        
        // Text View constraints
        textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
    }
}


// MARK: - UITextViewDelegate

extension NoteViewController {
    
    // Hide keyboard on touck on the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // Add Done Button on keyboard
    func addDoneButtonOnKeyboard() {
        let doneToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolBar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))

        let items = [flexSpace, doneButton]
        doneToolBar.items = items
        doneToolBar.sizeToFit()

        textView.inputAccessoryView = doneToolBar
    }
    
    @objc private func doneButtonAction() {
        textView.resignFirstResponder()
    }
    
    // Clear placeholder text when begin editing
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "" || textView.text == placeholder {
            textView.text = nil
            textView.textColor = .black
        }
        return true
    }
    
    // Set placeholder text if text is ""
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholder
            textView.textColor = .systemGray
        } else {
            updatedName = textView.text
        }
    }
}
