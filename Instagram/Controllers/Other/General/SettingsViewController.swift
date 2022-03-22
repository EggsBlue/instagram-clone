//
//  SettingsViewController.swift
//  Instagram
//
//  Created by 王庆华 on 2022/3/20.
//

import UIKit

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
        let section = [
            SettingCellModel(title: "Log out", handler: {[weak self] in
                self?.didTapLogOut()
            })
        ]
        data.append(section)
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
