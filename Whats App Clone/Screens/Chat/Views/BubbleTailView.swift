//
//  SwiftUIView.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/26/24.
//

import SwiftUI

struct BubbleTailView: View {
    var direction: MessageDirection

    private var backgroundColor: Color {
        return direction == .received ? .bubbleWhite : .bubbleGreen
//        .bubbleGreen
    }

    var body: some View {
        Image(direction == .sent ? .outgoingTail : .incomingTail)
            .renderingMode(.template)
            .resizable()
            .frame(width: 10, height: 10)
            .offset(y: 3.0)
            .foregroundStyle(backgroundColor)
    }
}

#Preview {
    ScrollView {
        BubbleTailView(direction: .received)
        BubbleTailView(direction: .sent)
    }
    .frame(maxWidth: .infinity)
    .background(Color.gray)
}
