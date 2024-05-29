//
//  RootScreen.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/28/24.
//

import SwiftUI

struct RootScreen: View {
    @StateObject private var viewModel = RootScreenModel()

    var body: some View {
        switch viewModel.authState {
        case .pending:
            ProgressView()
                .controlSize(.large)
        case .loggedIn(let loggedInUser):
            MainTabView(loggedInUser)
        case .loggedOut:
            LoginScreen()

        }
    }
}

#Preview {
    RootScreen()
}
