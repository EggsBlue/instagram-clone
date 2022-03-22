//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by 王庆华 on 2022/3/20.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItem =
        UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    @objc private func didTapSave(){
        
    }
    
    @objc private func didTapCancel(){
        dismiss(animated: true)
    }
    
    @objc private func didTapChangeProfilePicture(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change Profile picture", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default,handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose From Library", style: .default,handler: { _ in
            
        }))
        
        // Adapt iPad
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default))
        present(actionSheet, animated: true)
    }
}
