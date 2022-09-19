//
//  NoteViewController.swift
//  Notes
//
//  Created by Olegio on 17.09.2022.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {
    
    var textView = UITextView()

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
        menuButton.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        
        let rightBarButtonItem = UIBarButtonItem(customView: menuButton)
        rightBarButtonItem.tintColor = .white
        rightBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        rightBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    // Setup Text View
    private func setupTextView() {
        textView = UITextView(frame: CGRect(x: 20, y: 0, width: UIScreen.main.bounds.size.width - 40, height: 400))
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        // Text View default settings
        textView.isEditable = true
        textView.text = "Enter your note here..."
        textView.textColor = .systemGray
        textView.font = UIFont.systemFont(ofSize: 15)
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


// MARK: - Keyboard hide methods

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
}
