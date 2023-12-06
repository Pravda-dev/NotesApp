//
//  NoteViewController.swift
//  NotesApp
//
//  Created by pravda on 28.11.2023.
//

import SnapKit
import UIKit

final class NoteViewController: UIViewController {
    //MARK: - GUI Variables
    private let attachmentView: UIImageView = {
        let view = UIImageView()
        
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private let textView: UITextView = {
        let view = UITextView()

        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.font = .systemFont(ofSize: 14)

      
        return view
    }()
    
    //MARK: - Properties
    var viewModel: NoteViewModelProtocol?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: - Methods
    private func configure() {
        textView.text = viewModel?.text
//        guard let imageData = note.image,
//              let image = UIImage(data: imageData) else { return }
//        attachmentView.image = image
    }
    
    //MARK: - Private Methods
    @objc
    private func saveAction() {
        viewModel?.save(with: textView.text)

        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func deleteAction() {
        viewModel?.delete()
        navigationController?.popViewController(animated: true)

    }
    
    private func setupUI() {
        view.addSubview(attachmentView)
        view.addSubview(textView)
        view.backgroundColor = .white
        let recognizer = UITapGestureRecognizer(target: self,
                                                action:
                                                    #selector(hideKeyboard))
        view.addGestureRecognizer(recognizer)
        textView.layer.borderWidth = textView.text.trimmingCharacters(in:
                .whitespacesAndNewlines).isEmpty ? 1 : 0
        
        setupConstraints()
        setImageHeight()
        setupBars()
    }
    
    private func setupConstraints() {
        attachmentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(attachmentView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).inset(-10)
        }
    }
    
    private func setImageHeight() {
        let height = attachmentView.image != nil ? 200 : 0
        
        attachmentView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    @objc
    private func hideKeyboard() {
        textView.resignFirstResponder()
    }
    
    @objc
    private func selectCategoryAction() {
        let alertController = UIAlertController(title: "Select Category",
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        let categories: [NoteCategory] = [.personal, .work, .study, .other]
        
        for category in categories {
            let action = UIAlertAction(title: "\(category)",
                                       style: .default) { [weak self] _ in
               
                print("Selected category: \(category)")
            }
            action.setValue(category.color, forKey: "titleTextColor")
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
    private func setupBars() {
        let categoryButton = UIBarButtonItem(title: "Category",
                                             style: .plain,
                                             target: self,
                                             action: #selector(selectCategoryAction))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash,
                                          target: self,
                                          action: #selector(deleteAction))
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save,
                                         target: self,
                                         action: #selector(saveAction))
        
        setToolbarItems([trashButton, flexibleSpace, categoryButton, flexibleSpace, saveButton], animated: true)
        
        navigationItem.rightBarButtonItem = saveButton
    }
}


