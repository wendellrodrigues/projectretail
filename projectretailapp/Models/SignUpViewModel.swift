//
//  SignUpViewModel.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    var email: String = ""
    var password: String = ""
    var confirmedPassword: String = ""
    var typing: Bool = false
    var errorString = ""
    
    @Published var showAlert: Bool = false
    
//    func signup(username: String, email: String, password: String, imageData: Data,
//                completed: @escaping(_ user: User) -> Void,
//                onError: @escaping(_ errorMessage: String) -> Void) {
//        if(!username.isEmpty && !email.isEmpty && !password.isEmpty && !confirmedPassword.isEmpty) {
//             AuthService.registerUser(username: username, email: email, password: password, onSuccess: completed, onError: onError)
//        } else {
//            showAlert = true
//            errorString = "Please fill in all the fields"
//        }
//    }
}
