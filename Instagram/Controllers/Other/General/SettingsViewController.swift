//
//  SettingsViewController.swift
//  Instagram
//
//  Created by 王庆华 on 2022/3/20.
//

import UIKit
import SafariServices

struct SettingCellModel{
    let title : String
    let handler: ( () -> Void )
}

/// View Controller to show user settings
class SettingsViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier:  "cell")
        
        return table
    }()
    
    private var data = [ [SettingCellModel] ]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureModels()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func configureModels(){
        data.append( [
            SettingCellModel(title: "Edit Profile", handler: {[weak self] in
                self?.didTapEditProfile()
            }),
            SettingCellModel(title: "Invite Friends", handler: {[weak self] in
                self?.didTapInviteFriends()
            }),
            SettingCellModel(title: "Save Original Posts", handler: {[weak self] in
                self?.didTapSaveOriginalPosts()
            })
        ])
        data.append( [
            SettingCellModel(title: "Terms of Services", handler: {[weak self] in
                self?.openURL(type: .terms)
            })
        ])
        data.append( [
            SettingCellModel(title: "Privicy Policy", handler: {[weak self] in
                self?.openURL(type: .privicy)
            })
        ])
        
        data.append( [
            SettingCellModel(title: "Help / Feedback", handler: {[weak self] in
                self?.openURL(type: .help)
            })
        ])
        
        data.append( [
            SettingCellModel(title: "Log out", handler: {[weak self] in
                self?.didTapLogOut()
            })
        ])
    }
    
    private func didTapLogOut(){
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Log out", style: .destructive,handler: { _ in
            AuthManager.shared.logout { success in
                DispatchQueue.main.async {
                    if success{
                        // present log in
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: false) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }else{
                        // error occurred
                        fatalError("Could not log out user")
                    }
                }
            }
        }))
        
        // 适配Ipad的弹窗,否则会崩溃
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true)
    }
    
    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    
    private func didTapInviteFriends(){
        // Show share sheet to invite friends
        
    }
    
    
    private func didTapSaveOriginalPosts(){
        
    }
    
    enum SettingsURLType{
        case terms, privicy, help
    }
    private func openURL(type: SettingsURLType){
        let urlString : String
        switch type{
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        case .privicy:
            urlString = "https://www.instagram.com/terms/accept/"
        case .help:
            urlString = "https://help.instagram.com"
        }
        guard let url = URL(string: urlString) else{return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }

}



extension SettingsViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle cell selection
        data[indexPath.section][indexPath.row].handler()
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Settings"
//    }
}
