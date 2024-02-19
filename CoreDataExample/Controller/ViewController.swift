//
//  ViewController.swift
//  CoreDataExample
//
//  Created by apple on 19.02.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
        settupView()
    }
    
    //MARK: Элементы View
    private lazy var label: UILabel = {
        $0.text = "CoreData"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 20)
        return $0
    }(UILabel())
    
    private lazy var btnSeeAllNote: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "list.number"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .link
        return $0
    }(UIButton(primaryAction: btnSeeAllAction))
    
    private lazy var textField: UITextField = {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
        $0.backgroundColor = .lightGray
        $0.tag = 1
        $0.delegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        $0.placeholder = "Добавьте текст для заметки"
        $0.layer.cornerRadius = 14
        return $0
    }(UITextField())
    
    private lazy var btnCreateNote: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .lightGray
        $0.setTitle("Сохранить заметку", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 14
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return $0
    }(UIButton(primaryAction: btnCreateAction))
    
    
    //MARK: UIAction
    private lazy var btnCreateAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        guard let text = self.textField.text else { return }
        CoreDataManager.shared.createNote(title: text)
    }
    
    private lazy var btnSeeAllAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        let vc = NoteViewController()
        self.present(vc, animated: true)
    }
    
    //MARK: Функции
    private func settupView() {
        overrideUserInterfaceStyle = .light
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(btnCreateNote)
        view.addSubview(btnSeeAllNote)
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30),
            
            btnCreateNote.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            btnCreateNote.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            btnCreateNote.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            btnSeeAllNote.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            btnSeeAllNote.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            
        ])
    }
    

}


//MARK: Extension
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        CoreDataManager.shared.createNote(title: text)
        textField.endEditing(true)
        return true
    }
}
