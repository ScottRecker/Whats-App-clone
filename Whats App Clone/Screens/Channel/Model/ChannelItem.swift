//
//  ChannelItem.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/30/24.
//

import Foundation

struct ChannelItem: Identifiable {

    var id: String
    var name: String?
    var lastMessage: String
    var creationDate: Date
    var lastMessageTimeStamp: Date
    var membersCount: UInt
    var adminUids: [String]
    var memberUids: [String]
    var members: [UserItem]
    var thumbnailURL: String?

    var isGroupChat: Bool {
        members.count > 2
    }
    
    static let placeholder = ChannelItem(id: "1", lastMessage: "Hello world", creationDate: Date(), lastMessageTimeStamp: Date(), membersCount: 2, adminUids: [], memberUids: [], members: [])
}
