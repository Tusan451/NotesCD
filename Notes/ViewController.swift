//
//  ViewController.swift
//  Notes
//
//  Created by Olegio on 16.09.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    private let cellID = "cell"
    private var notes: [String] = []
    
    let addNoteSegue = UIStoryboardSegue(identifier: "addNote", source: ViewController(), destination: NoteViewController())
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Table view cell registry
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
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
        
        // Set button to navigation bar
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        rightBarButtonItem.tintColor = .white
    }
    
    @objc private func addNewTask() {
        
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
        cell.textLabel?.text = note
        
        return cell
    }
}