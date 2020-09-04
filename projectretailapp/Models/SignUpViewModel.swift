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
    
    @Published var errorString = "Passwords must be in between 6 and 20 characters"
    @Published var showError: Bool = true
    
    //Register User with firebase
    //Pass on errors to register function if exist
    func registerNewUser(email: String, password: String,
                completed: @escaping(_ user: User) -> Void,
                onError: @escaping(_ errorMessage: String) -> Void) {
        if(email.isEmpty && password.isEmpty && confirmedPassword.isEmpty) {
            errorString = "Please fill in all the fields"
            onError(errorString)
        }
        else if(password != confirmedPassword) {
            errorString = "Passwords do not match"
            onError(errorString)
        }
        else {
           AuthService.registerUser(email: email, password: password, onSuccess: completed, onError: onError)
        }
    }
}




