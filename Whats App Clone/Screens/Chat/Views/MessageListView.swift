//
//  MessageList View.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/26/24.
//

import SwiftUI

struct MessageListView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MessageListController

    func makeUIViewController(context: Context) -> MessageListController {
        let messageListController = MessageListController()
        return messageListController
    }

    func updateUIViewController(_ uiViewController: MessageListController, context: Context) {

    }
}

#Preview {
    MessageListView()
}
