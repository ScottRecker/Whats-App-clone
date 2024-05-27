//
//  AuthHeaderView.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/27/24.
//

import SwiftUI

struct AuthHeaderView: View {
    var body: some View {
        HStack {
            Image(.whatsapp)
                .resizable()
                .frame(width: 40, height: 40)
            Text("WhatsApp")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    ZStack {
        Color(.lightGray)
        AuthHeaderView()
    }
}
