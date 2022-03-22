//
//  StorageManager.swift
//  Instagram
//
//  Created by 王庆华 on 2022/3/21.
//

import Foundation
import FirebaseStorage

public class StorageManager{
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error{
        case failedToDownlaod
    }
    
    // MARK: Public
    
    public func uploadUserPost(model: UserPost,completion: ( Result<URL, Error>  ) -> Void){
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping  (Result<URL, IGStorageManagerError>) -> Void){
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else{
                completion(.failure(.failedToDownlaod))
                return
            }
            completion(.success(url))
        }
    }
    
    
}


public enum UserPostType{
    case photo, video
}

public struct UserPost{
    var postType: UserPostType
}
