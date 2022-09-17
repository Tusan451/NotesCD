//
//  ViewController.swift
//  Notes
//
//  Created by Olegio on 16.09.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
        appearence.backgroundColor = UIColor(red: 235/255, green: 64/255, blue: 52/255, alpha: 1)
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

