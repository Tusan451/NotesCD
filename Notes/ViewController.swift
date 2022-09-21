//
//  ViewController.swift
//  Notes
//
//  Created by Olegio on 16.09.2022.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    private let cellID = "cell"
    private var notes: [Note] = []
    
    private var addNoteSegue: UIStoryboardSegue!
    private var cellSegue: UIStoryboardSegue!
    
    private let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Table view cell registry
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 252/255, green: 246/255, blue: 232/255, alpha: 1)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "My Notes"
        
        // Set navigation bar basic settings
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearence.backgroundColor = UIColor(red: 252/255, green: 119/255, blue: 83/255, alpha: 1)
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.tintColor = .white
        
        // Set button to navigation bar
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
        rightBarButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func addNewNote() {
        addNoteSegue = UIStoryboardSegue(identifier: "addNote", source: ViewController(), destination: NoteViewController(noteName: nil), performHandler: {
            self.show(NoteViewController(noteName: nil), sender: nil)
        })
        addNoteSegue.perform()
    }
    
    // Fetch Data from Core Data
    private func fetchData() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            notes = try managedContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    // Delete Note frome Core Data Stack
    private func removeData(with noteName: String) {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "name = %@", noteName)
        
        if let notes = try? managedContext.fetch(fetchRequest), !notes.isEmpty {
            let note = notes.first!
            managedContext.delete(note)
            
            try? managedContext.save()
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.name
        cell.backgroundColor = UIColor(red: 252/255, green: 246/255, blue: 232/255, alpha: 1)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let note = notes[indexPath.row]
        guard let name = note.name else { return }
        
        let vc2 = NoteViewController(noteName: name)
        navigationController?.pushViewController(vc2, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Add Delete Action
        guard editingStyle == .delete else { return }
        
        // Delete Note from Core Data
        let note = notes[indexPath.row]
        notes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        guard let noteName = note.name else { return }
        removeData(with: noteName)
    }
}
