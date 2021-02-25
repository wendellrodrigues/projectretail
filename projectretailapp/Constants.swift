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
import FirebaseFirestoreSwift
//import FirebaseStorage

//Sign In
let TXT_SIGN_IN = "Sign In"
let TXT_EMAIL = "Email"
let TXT_PWD = "Password"
let TXT_CREATE_ACCOUNT = "Don't have an account yet?"
let TXT_SIGN_IN_BUTTON = "Sign In"
let TXT_SIGN_UP_BUTTON = "Register"

//Sign Up

let TXT_PWD_ALLOWANCES = "At least 6 characters required"
let USER_ICON = "person.fill" 
let EMAIL_ICON = "envelope.fill"
let PWD_ICON = "lock.fill"
let PWD_CONFIRM_ICON = "lock.slash.fill"
let TXT_CNFRM_PASS = "Confirm Password"
let TXT_FIRST_NAME = "First Name"
let TXT_REGISTER_BUTTON = "Register"
let TXT_ALREADY_HAVE_ACCOUNT = "Already have an account?"
let PWD_HELP = "Passwords must be between 6 and 20 characters"

//Sizing

let TXT_PRODUCT_HELP = "Which types of products are you most interested in?"
let TXT_SEX_HELP = "You can select either, or both"
let SHIRT_SIZES: [String] = ["XS", "S", "M", "L", "XL", "XXL"]
let MENS_WAIST_SIZES: [Int] = [26, 28, 29, 30, 31, 32, 33, 34, 35, 36, 38, 40]
let MENS_LENGTH_SIZES: [Int] = [26, 28, 29, 30, 31, 32, 33, 34, 35, 36, 38, 40]
let WOMENS_PANTS_SIZES: [String] = ["0", "2", "4", "6", "8", "10", "12", "12W",
                                    "14", "14W", "16", "16W", "18", "18W", "20",
                                    "20W", "22", "22W", "24W", "26W", "28W"]

let DEFAULT_MENS_WAIST = 26
let DEFAULT_MENS_LENGTH = 26
let DEFAULT_MENS_SHIRT = "M"
let DEFAULT_WOMENS_PANTS = "XS"
let DEFAULT_WOMENS_SHIRT = "M"

let TEXT_CONTINUE = "Continue"
let TEXT_BACK = "Back"
let BACK_BUTTON = "chevron.left"




//Firebase
class Ref {
    
    //Firestore Users
    static var FIRESTORE_ROOT = Firestore.firestore()
    static var FIRESTORE_COLLECTION_USERS = FIRESTORE_ROOT.collection("users")
    static func FIRESTORE_DOCUMENT_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_USERS.document(userId)
    }
    
    //Firestore stores
    static var FIRESTORE_COLLECTION_STORES = FIRESTORE_ROOT.collection("stores")
    static var FIRESTORE_COLLECTION_GROUP_STORES = FIRESTORE_ROOT.collectionGroup("stores")
    static func FIRESTORE_DOCUMENT_STOREID(storeId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_STORES.document(storeId)
    }
    
    //Firestore beacons
    static var FIRESTORE_COLLECTION_BEACONS = FIRESTORE_ROOT.collection("beacons")
}

//AWS 
//let REQUEST_URL = "ec2-3-131-169-109.us-east-2.compute.amazonaws.com"
let REQUEST_URL = "192.168.1.66"







