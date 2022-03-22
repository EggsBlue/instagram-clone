//
//  DatabaseManager.swift
//  Instagram
//
//  Created by 王庆华 on 2022/3/21.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // MARK: Public
    /// Check is username and email is available
    /// - Paramters
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void){
        completion(true)
    }
    
    /// Insert new user data to database
    /// - Paramters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - compleation: Async callback for result if database entry succeded
    public func insertNewUser(with email: String, username: String, complation: @escaping (Bool) -> Void){
        database.child(email.safeDatabaseKey()).setValue(["usernmae":username]) { error, reference in
            if error == nil{
                // successed
                complation(true)
            }else{
                // failed
                complation(false)
            }
        }
    }
    
  
}


