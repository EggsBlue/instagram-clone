//
//  AuthManager.swift
//  Instagram
//
//  Created by 王庆华 on 2022/3/21.
//

import Foundation
import FirebaseAuth


public class AuthManager{
    static let shared = AuthManager()
    
    // MARK: Public
    public func registerNewUser(username:String, email: String,password: String, completion:  @escaping  (Bool) -> Void ){
        /*
            - check if username is available
            - check if email is available
            - create an account
            - insert account to database
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate{
                /*
                - create an account
                - insert account to database
                */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard  error == nil, result != nil else{
                        // Firebase auth could not create account
                        completion(false)
                        return
                    }
                    // Insert account to database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted{
                            completion(true)
                        }else{
                            // Failed to insert database
                            completion(false)
                        }
                    }
                }
            }else{
                completion(false)
            }
        }
        
    }
    
    public func loginUser(username: String?,email:String?, password: String, completion: @escaping ((Bool) -> Void) ){
        if let email = email{
            // email login in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil , error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
            
        }else if let username = username {
            // username login in
            print(username)
        }
        
    }
    
    /// Attempt log out firebase user
    public func logout(compleation: (Bool) -> Void){
        do{
            try Auth.auth().signOut()
            compleation(true)
            print("退出成功")
            return
        }catch{
            compleation(false)
            print(error)
            return
        }
    }
}
