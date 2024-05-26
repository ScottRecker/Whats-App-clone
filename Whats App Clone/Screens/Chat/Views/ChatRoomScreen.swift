//
//  ChatRoomScreen.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/25/24.
//

import SwiftUI

struct ChatRoomScreen: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<12) { _ in
                    Text("placeholder")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .background(Color.gray.opacity(0.1))
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            leadingNavItems()
            trailingNavItems()
        }
        .safeAreaInset(edge: .bottom) {
            TextInputAreaView()
        }
    }
}

// MARK: Toolbar Items
extension ChatRoomScreen {
    @ToolbarContentBuilder
    private func leadingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                Circle()
                    .frame(width: 35, height: 30)
                Text("QAUser12")
                    .bold()
            }
        }
    }

    @ToolbarContentBuilder
    private func trailingNavItems() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button {

            } label: {
                Image(systemName: "video")
            }
            Button {

            } label: {
                Image(systemName: "phone")

            }

        }
    }
}

#Preview {
    NavigationStack {
        ChatRoomScreen()
    }
}
