//
//  ChannelTabScreen.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/25/24.
//

import SwiftUI

struct ChannelTabScreen: View {
    @State private var searchText = ""
    @State private var showChatPartnerPickerView = false

    var body: some View {
        NavigationStack {
            List {
                archivedButton()
                ForEach(0..<3) { _ in
                    NavigationLink {
                        ChatRoomScreen()
                    } label: {
                        ChannelItemView()
                    }
                }
                inboxFooterView()
                    .listRowSeparator(.hidden)
            }
            .navigationTitle("Chats")
            .searchable(text: $searchText)
            .listStyle(.plain)
            .toolbar {
                leadingNavItem()
                trailingNavItem()
            }
            .sheet(isPresented: $showChatPartnerPickerView) {
                ChatPartnerPickerScreen()
            }
        }
    }
}

extension ChannelTabScreen {
    @ToolbarContentBuilder
    private func leadingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                Button {
                    print("menu button tapped")
                } label: {
                    Label("Select Chats", systemImage: "checkmark.circle")
                }

            } label: {
                Image(systemName: "ellipsis.circle")
            }
        }
    }

    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            aiButton()
            cameraButton()
            newChatButton()
        }
    }

    private func aiButton() -> some View {
        Button {

        } label: {
            Image(.circle)
        }
    }

    private func newChatButton() -> some View {
        Button {
            showChatPartnerPickerView = true
        } label: {
            Image(.plus)
        }
    }

    private func cameraButton() -> some View {
        Button {

        } label: {
            Image(systemName: "camera")
        }
    }

    private func archivedButton() -> some View {
        Button {

        } label: {
            Label("Archived", systemImage: "archivebox.fill")
                .bold()
                .padding()
                .foregroundStyle(.gray)
        }
    }

    private func inboxFooterView() -> some View {
        HStack {
            Image(systemName: "lock.fill")
            (
                Text("Your personal messages are ")
                +
                Text("end-to-end encrypted")
                    .foregroundColor(.blue)
            )
        }
        .foregroundColor(.gray)
        .font(.caption)
        .padding(.horizontal)
    }
}

#Preview {
    ChannelTabScreen()
}
