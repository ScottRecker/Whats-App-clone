//
//  ChatPartnerPickerViewModel.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/28/24.
//

import Foundation

enum ChannelCreationRoute {
    case addGroupChatMembers
    case setupGroupChat
}

final class ChatPartnerPickerViewModel: ObservableObject {
    @Published var navStack = [ChannelCreationRoute]()
    @Published var selectedChatPartners = [UserItem]()

    var showSelectedUsers: Bool {
        return !selectedChatPartners.isEmpty
    }


    // MARK: - Public Methods

    func handItemSelection(_ item: UserItem) {
        if isUserSelected(item) {
            // deselect
            guard let index = selectedChatPartners.firstIndex(where: { $0.uid == item.uid }) else { return }
            selectedChatPartners.remove(at: index)
        } else {
            // select
            selectedChatPartners.append(item)
        }
    }

    func isUserSelected(_ user: UserItem) -> Bool {
        let isSelected = selectedChatPartners.contains { $0.uid == user.uid }
        return isSelected
    }
}
