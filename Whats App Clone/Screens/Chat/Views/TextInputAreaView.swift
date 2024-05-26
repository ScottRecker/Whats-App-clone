//
//  TextInputAreaView.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/25/24.
//

import SwiftUI

struct TextInputAreaView: View {
    @State private var text = ""

    var body: some View {
//        HStack {
        HStack(alignment: .bottom, spacing: 5) {
            imagePickerButton()
                .padding(3)
            audioRecorderButton()
            messageTextField()
            sendMessageButton()
        }
        .padding(.bottom)
        .padding(.horizontal, 8)
        .padding(.top, 10)
        .background(.whatsAppWhite)
    }
    
    private func messageTextField() -> some View {
        TextField("", text: $text, axis: .vertical)
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.thinMaterial)
            )
            .overlay(textViewBorder())
    }

    private func textViewBorder() -> some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .stroke(Color(.systemGray5), lineWidth: 1.0)
    }

    private func imagePickerButton() -> some View {
        Button {

        }label: {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 22))
        }
    }

    private func audioRecorderButton() -> some View {
        Button {

        }label: {
            Image(systemName: "mic.fill")
                .fontWeight(.heavy)
                .imageScale(.small)
                .foregroundStyle(.white)
                .padding(6)
                .background(.blue)
                .clipShape(Circle())
                .padding(.horizontal, 3)
        }
    }

    private func sendMessageButton() -> some View {
        Button {

        }label: {
            Image(systemName: "arrow.up")
                .fontWeight(.heavy)
                .foregroundStyle(.white)
                .padding(6)
                .background(.blue)
                .clipShape(Circle())
        }
    }
}

#Preview {
    TextInputAreaView()
}
