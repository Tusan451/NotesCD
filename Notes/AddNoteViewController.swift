//
//  NoteViewController.swift
//  Notes
//
//  Created by Olegio on 17.09.2022.
//

import UIKit

class AddNoteViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let textField = UITextField(frame: CGRect(x: 20, y: 170, width: 350, height: 150))
        textField.placeholder = "Enter your note here..."
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.clearButtonMode = .never
        textField.contentVerticalAlignment = .top
        textField.delegate = self
        self.view.addSubview(textField)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 252/255, green: 246/255, blue: 232/255, alpha: 1)
        setupNavigationBar()
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
        menuButton.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        
        let rightBarButtonItem = UIBarButtonItem(customView: menuButton)
        rightBarButtonItem.tintColor = .white
        let width = rightBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        width?.isActive = true
        let height = rightBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        height?.isActive = true
        
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
