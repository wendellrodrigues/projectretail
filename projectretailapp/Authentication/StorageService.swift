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
    
    //Initial storage of user with primary fields
    static func storeUser(userId: String,
                          firstName: String,
                          email: String,
                          metadata: StorageMetadata,
                          onSuccess: @escaping(_ user: User) -> Void,
                          onError: @escaping(_ errorMessage: String) -> Void) {
        
        let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: userId)
        
        let user = User.init(
            uid: userId,
            firstName: firstName,
            email: email,
            hasEnteredSizingPreferences: false,
            maleShirtSize: DEFAULT_MENS_SHIRT,
            maleWaistSize: DEFAULT_MENS_WAIST,
            maleLengthSize: DEFAULT_MENS_LENGTH,
            femaleShirtSize: DEFAULT_WOMENS_SHIRT,
            femalePantsSize: DEFAULT_WOMENS_PANTS
        )
        
        guard let dict = try? user.toDictionary() else { return }
        
        firestoreUserId.setData(dict) { (error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess(user)
        }
    }
    
    //Creating (or updating) of size preferences
    static func updateSizingPreferences(userId: String,
                                        maleShirtSize: String,
                                        maleWaistSize: Int,
                                        maleLengthSize: Int,
                                        femalePantsSize: String,
                                        femaleShirtSize: String) {
        
        let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: userId)
        
        firestoreUserId.updateData([
            "maleShirtSize" : maleShirtSize,
            "maleWaistSize" : maleWaistSize,
            "maleLengthSize" : maleLengthSize,
            "femalePantsSize" : femalePantsSize,
            "femaleShirtSize" : femaleShirtSize,
            "hasEnteredSizingPreferences" : true
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        return
    }
    
    
    //Function to be called ONLY when user selects male in registration or is updating male preferences only
    static func updateMaleOnlySizingPreferences(userId: String,
                                        maleShirtSize: String,
                                        maleWaistSize: Int,
                                        maleLengthSize: Int) {
        
        let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: userId)
        
        firestoreUserId.updateData([
            "maleShirtSize" : maleShirtSize,
            "maleWaistSize" : maleWaistSize,
            "maleLengthSize" : maleLengthSize,
            "hasEnteredSizingPreferences" : true
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        return
    }
    
    //Function to be called ONLY when user selects female in registration or is updating male preferences only
    static func updateFemaaleOnlySizingPreferences(userId: String,
                                                 femalePantsSize: Int,
                                                 femaleShirtSize: Int) {
        
        let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: userId)
        
        firestoreUserId.updateData([
            "femalePantsSize" : femalePantsSize,
            "femaleShirtSize" : femaleShirtSize,
            "hasEnteredSizingPreferences" : true
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        return
    }
}
