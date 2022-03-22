//
//  ViewController.swift
//  Instagram
//
//  Created by 王庆华 on 2022/3/20.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleNotAuthenticated()
        
    }
    
    private func handleNotAuthenticated() {
        // check auth status
        if Auth.auth().currentUser == nil{
            // show login in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }else{
            
        }
    }
    
}

