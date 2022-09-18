//
//  NoteViewController.swift
//  Notes
//
//  Created by Olegio on 17.09.2022.
//

import UIKit

class AddNoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 252/255, green: 246/255, blue: 232/255, alpha: 1)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Add Note"
        let iconForButton = UIImage(named: "done-50")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 15, height: 15))
        let iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(iconForButton, for: .normal)
        iconButton.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: iconButton)
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func saveNote() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
