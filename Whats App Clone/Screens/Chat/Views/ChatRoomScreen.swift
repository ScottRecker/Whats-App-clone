//
//  ChatRoomScreen.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/25/24.
//

import SwiftUI

struct ChatRoomScreen: View {
    let channel: ChannelItem
    @StateObject private var viewModel: ChatRoomViewModel

    init(channel: ChannelItem) {
        self.channel = channel
        _viewModel = StateObject(wrappedValue: ChatRoomViewModel(channel))
    }

    var body: some View {
        MessageListView(viewModel)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                leadingNavItems()
                trailingNavItems()
            }
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .bottom) {
                TextInputAreaView(textMessage: $viewModel.textMessage) {
                    viewModel.sendMessage()
                }
            }
    }
}

// MARK: Toolbar Items
extension ChatRoomScreen {
    // TODO: Change this to be more dynamic
    private var channelTitle: String {
        let maxCount = 20
        let trailingChars = channel.title.count > maxCount ? "..." : ""
        let title = String(channel.title.prefix(maxCount) + trailingChars)
        return title
    }

    @ToolbarContentBuilder
    private func leadingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                CircularProfileImageView(channel, size: .mini)

                Text(channelTitle)
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
        ChatRoomScreen(channel: .placeholder)
    }
}
