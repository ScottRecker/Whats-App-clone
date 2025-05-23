//
//  ChannelTabViewModel.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/30/24.
//

import Foundation
import Firebase
import OSLog

enum ChannelTabRoutes: Hashable {
    case chatRoom(_ channel: ChannelItem)
}

final class ChannelTabViewModel: ObservableObject {
    @Published var navRoutes = [ChannelTabRoutes]()
    @Published var navigateToChatRoom = false
    @Published var newChannel: ChannelItem?
    @Published var showChatPartnerPickerView = false
    @Published var channels = [ChannelItem]()
    typealias ChannelId = String
    @Published var channelDictionary: [ChannelId: ChannelItem] = [:]

    let logger = Logger(subsystem: "com.recker.Whats-App-Clone", category: "ChannelTabViewModel")
    private let currentUser: UserItem

    init(_ currentUser: UserItem) {
        self.currentUser = currentUser
        fetchCurrentUserChannels()
    }

    func onNewChannelCreation(_ channel: ChannelItem) {
        showChatPartnerPickerView = false
        newChannel = channel
        navigateToChatRoom = true
    }

    private func fetchCurrentUserChannels() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        FirebaseConstants.UserChannelsRef.child(currentUid).observe(.value) { [weak self] snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            dict.forEach { key, value in
                let channelId = key
                self?.getChannel(with: channelId)
            }
        } withCancel: { [weak self] error in
            self?.logger.error("Failed to get the current user's channelIds: \(error.localizedDescription)")
        }
    }

    private func getChannel(with channelId: String) {
        FirebaseConstants.ChannelsRef.child(channelId).observe(.value) { [weak self] snapshot in
            guard let dict = snapshot.value as? [String: Any], let self = self else { return }
            var channel = ChannelItem(dict)
            self.getChannelMembers(channel) { members in
                channel.members = members
                channel.members.append(self.currentUser)
                self.channelDictionary[channelId] = channel
                self.reloadData()
//                self.channels.append(channel)
                self.logger.debug("channel: \(channel.title)")
            }
        } withCancel: { [weak self] error in
            self?.logger.error("Failed to get the channel for id \(channelId): \(error.localizedDescription)")
        }
    }

    private func getChannelMembers(_ channel: ChannelItem, completion: @escaping (_ members: [UserItem]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let channelMemberUids = Array(channel.membersUids.filter { $0 != currentUid }.prefix(2))
        UserService.getUsers(with: channelMemberUids) { userNode in
            completion(userNode.users)
        }
    }

    private func reloadData() {
        self.channels = Array(channelDictionary.values)
        self.channels.sort { $0.lastMessageTimeStamp > $1.lastMessageTimeStamp }
    }

}
