//
//  Constants.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/30/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
//import FirebaseStorage


//Sign Up
let TXTFIELD_BACKGROUND = Color.gray.opacity(0.2) //Background color of signup text fields
let TXT_PWD_ALLOWANCES = "At least 6 characters required"
let EMAIL_ICON = "envelope.fill"
let PWD_ICON = "lock.fill"
let TXT_CNFRM_PASS = "CONFIRM PASSWORD"
let TXT_REGISTER_BUTTON = "Register"
let TXT_ALREADY_HAVE_ACCOUNT = "Already have an account?"


//Sign In
let TXT_SIGN_IN = "SIGN IN"
let TXT_EMAIL = "EMAIL"
let TXT_PWD = "PASSWORD"
let TXT_CREATE_ACCOUNT = "Don't have an account yet?"
let TXT_SIGN_IN_BUTTON = "Sign In"
let TXT_SIGN_UP_BUTTON = "REGISTER"

//Firebase
class Ref {
    static var FIRESTORE_ROOT = Firestore.firestore()
    static var FIRESTORE_COLLECTION_USERS = FIRESTORE_ROOT.collection("users")
    static func FIRESTORE_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_USERS.document(userId)
    }
}







