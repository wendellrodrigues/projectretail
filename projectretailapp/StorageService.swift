//
//  StorageService.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/3/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import Firebase

class StorageService {
    
    static func storeUser(userId: String, email: String, metadata: StorageMetadata,onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        let firestoreUserId = Ref.FIRESTORE_USERID(userId: userId)
        
        let user = User.init(uid: userId, email: email)
        
        guard let dict = try? user.toDictionary() else { return }
        
        firestoreUserId.setData(dict) { (error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess(user)
        }
    }
    
    
    
    
    
    
}
