//
//  FirebaseConstants.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/28/24.
//

import Foundation
import Firebase
import FirebaseStorage


enum FirebaseConstants {

    private static let DatabaseRef = Database.database().reference()
    static let UserRef = DatabaseRef.child("users")

}
