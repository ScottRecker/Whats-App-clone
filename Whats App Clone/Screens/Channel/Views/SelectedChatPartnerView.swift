//
//  SelectedChatPartnerView.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/29/24.
//

import SwiftUI

struct SelectedChatPartnerView: View {
    let users: [UserItem]
    let onTapHandler: (_ user: UserItem) -> Void
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(users) { item in
                    chatPartnerView(item)
                }
            }
        }
    }

    private func chatPartnerView(_ user: UserItem) -> some View {
        VStack {
            Circle()
                .fill(.gray)
                .frame(width: 60, height: 60)
                .overlay(alignment: .topTrailing) {
                    cancelButton(user)
                }
            Text(user.username)
        }
    }

    private func cancelButton(_ user: UserItem) -> some View {
        Button {
            onTapHandler(user)
        } label: {
            Image(systemName: "xmark")
                .imageScale(.small)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(5)
                .background(Color(.systemGray2))
                .clipShape(Circle())
        }
    }
}

#Preview {
    SelectedChatPartnerView(users: UserItem.placeholders) { _ in
    }
}
