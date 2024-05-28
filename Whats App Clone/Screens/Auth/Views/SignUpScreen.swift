//
//  SignUpScreen.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/27/24.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var authScreenModel: AuthScreenModel

    var body: some View {
        VStack {
            Spacer()
            AuthHeaderView()
            
            AuthTextField(type: .email, text: $authScreenModel.email)
            AuthTextField(type: .custom("Username", "at"), text: $authScreenModel.username)
            AuthTextField(type: .password, text: $authScreenModel.password)

            AuthButton(title: "Create an Account") {
                Task {
                    await authScreenModel.handleSignup()
                }
            }
            .disabled(authScreenModel.disableLoginButton)

            Spacer()
            backButton()
                .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LinearGradient(
                colors: [.green, .green.opacity(0.8), .teal],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }

    private func backButton() -> some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "sparkles")

                (
                    Text("Already created an account ? ")
                    +
                    Text("Log in").bold()
                )

                Image(systemName: "sparkles")
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    SignUpScreen(authScreenModel: AuthScreenModel())
}
