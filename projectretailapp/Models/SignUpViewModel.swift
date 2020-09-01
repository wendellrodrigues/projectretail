//
//  SignUpViewModel.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage

class SignUpViewModel: ObservableObject {
    
    var email: String = ""
    var password: String = ""
    var confirmedPassword: String = ""
    var errorString = ""
    
    @Published var showAlert: Bool = false
    
    func registerNewUser(email: String, password: String,
                completed: @escaping(_ user: User) -> Void,
                onError: @escaping(_ errorMessage: String) -> Void) {
        if(!email.isEmpty && !password.isEmpty && !confirmedPassword.isEmpty) {
             AuthService.registerUser(email: email, password: password, onSuccess: completed, onError: onError)
        } else {
            showAlert = true
            errorString = "Please fill in all the fields"
        }
    }
}

