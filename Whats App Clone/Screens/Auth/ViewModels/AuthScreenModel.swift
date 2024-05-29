//
//  AuthScreenModel.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/27/24.
//

import Foundation

@MainActor
final class AuthScreenModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var isLoading = false
    @Published var errorState: (showError: Bool, errorMessage: String) = (false, "Uh oh")

    // MARK: Computed Properties
    var disableLoginButton: Bool {
        return email.isEmpty || password.isEmpty || isLoading
    }

    var disableSignUpButton: Bool {
        return email.isEmpty || password.isEmpty || username.isEmpty || isLoading
    }

    func handleSignup() async {
        isLoading = true
        
        // FIXME: Use defer to guarentee `isLoading` is set to false?
//        defer {
//            isLoading = false
//        }

        do {
            try await AuthManager.shared.createAccount(for: username, with: email, and: password)
        } catch {
            errorState.errorMessage = "Failed to create an account \(error.localizedDescription)"
            errorState.showError = true
            isLoading = false
        }
    }

    func handleLogin() async {
        isLoading = true
        do {
            try await AuthManager.shared.login(with: email, and: password)
            print("🛠️ HEYO: How is isLoading being updated? :\(isLoading)")
        } catch {
            errorState.errorMessage = "Failed to login\n\(error.localizedDescription)"
            errorState.showError = true
            isLoading = false
        }
    }
}
