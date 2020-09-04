//
//  SignInViewModel.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/3/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI

class SignInViewModel: ObservableObject {
    
    
     var email: String = ""
     var password: String = ""
     var errorString = ""

     @Published var showAlert: Bool = false
    
    func signin(email: String, password: String, completed: @escaping(_ user: User) -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        
        if !email.isEmpty && !password.isEmpty {
            AuthService.signInUser(email: email, password: password, onSuccess: completed, onError: onError)
             print("Fields are full")
            
        } else {
            showAlert = true
            errorString = "Please fill in all fields"
            onError(errorString)
        }
    }
}
