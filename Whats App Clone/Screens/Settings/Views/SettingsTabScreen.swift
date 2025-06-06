//
//  SettingsTabScreen.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/25/24.
//

import SwiftUI

struct SettingsTabScreen: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                SettingsHeaderView()
                Section {
                    SettingsItemView(item: .broadCastLists)
                    SettingsItemView(item: .starredMessages)
                    SettingsItemView(item: .linkedDevices)
                }
                Section {
                    SettingsItemView(item: .account)
                    SettingsItemView(item: .privacy)
                    SettingsItemView(item: .chats)
                }
                Section {
                    SettingsItemView(item: .help)
                    SettingsItemView(item: .tellFriend)
                }
            }
            .navigationTitle("Settings")
            .searchable(text: $searchText)
            .toolbar {
                leadingNavItem()
            }
        }
    }
}

extension SettingsTabScreen {
    @ToolbarContentBuilder
    private func leadingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Sign Out") {
                Task { try? await AuthManager.shared.logOut() }
            }
            .foregroundStyle(.red)
        }
    }
}

private struct SettingsHeaderView: View {
    var body: some View {
        Section {
            HStack {
                Circle()
                    .frame(width: 55, height: 55)
                userInfoTextView()
            }
            SettingsItemView(item: .avatar)
        }
    }

    private func userInfoTextView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Qa User 13")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(.qrcode)
                    .renderingMode(.template)
                    .foregroundStyle(.blue)
                    .padding(5)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }

            Text("Hey there! I am using WhatsApp")
                .foregroundStyle(.gray)
                .font(.callout)
        }
        .lineLimit(1)
    }
}

#Preview {
    SettingsTabScreen()
}
