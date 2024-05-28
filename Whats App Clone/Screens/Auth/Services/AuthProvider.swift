//
//  AuthProvider.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/27/24.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

enum AuthState {
    case pending, loggedIn, loggedOut
}

protocol AuthProvider {
    static var shared: AuthProvider { get }
    var authState: CurrentValueSubject<AuthState, Never> { get }
    func autoLogin() async
    func login(with email: String, and password: String) async throws
    func createAccount(for username: String, with email: String, and password: String) async throws
    func logOut() async throws
}

final class AuthManager: AuthProvider {

    static let shared: AuthProvider = AuthManager()

    private init() { }

    var authState = CurrentValueSubject<AuthState, Never>(.pending)

    func autoLogin() async {

    }
    
    func login(with email: String, and password: String) async throws {

    }
    
    func createAccount(for username: String, with email: String, and password: String) async throws {
        // invoke firebase create account method: store the user iin our firebase auth

        // store the new user info in our database
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let uid = authResult.user.uid
        let newUser = UserItem(uid: uid, username: username, email: email)
        try await saveUserInfoDatabase(user: newUser)
    }
    
    func logOut() async throws {

    }
    

}

extension AuthManager {
    private func saveUserInfoDatabase(user: UserItem) async throws {
        let userDictionary = ["uid": user.uid, "username": user.username, "email": user.email]
        try await Database.database().reference().child("users").child(user.uid).setValue(userDictionary)
    }

}

struct UserItem: Identifiable, Hashable, Decodable {
    let uid: String
    let username: String
    let email: String
    var bio: String? = nil
    var profileImageUrl: String? = nil

    var id: String {
        return uid
    }

    var bioUnwrapped: String {
        return bio ?? "Hey there! I am using WhatsApp"
    }
}
