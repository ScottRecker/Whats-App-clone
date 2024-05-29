//
//  ChatPartnerRowView.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/28/24.
//

import SwiftUI

struct ChatPartnerRowView: View {
    let user: UserItem
    var body: some View {
        HStack {
            Circle()
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(user.username)
                    .bold()
                    .foregroundStyle(.whatsAppBlack)
                Text(user.bioUnwrapped)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    ChatPartnerRowView(user: .placeholder)
}
