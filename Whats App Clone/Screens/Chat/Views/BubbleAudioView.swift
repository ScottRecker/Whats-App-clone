//
//  BubbleAudioView.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/26/24.
//

import SwiftUI

struct BubbleAudioView: View {
    let item: MessageItem
    @State private var sliderValue: Double = 0
    @State private var sliderRange: ClosedRange<Double> = 0...20

    var body: some View {
        VStack(alignment: item.horizontalAlignment, spacing: 3) {
            HStack {
                playButton()
                Slider(value: $sliderValue, in: sliderRange)
                    .tint(.gray)
                Text("04:00")
                    .foregroundStyle(.gray)
            }
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 11.0, style: .continuous))
            .padding(5)
            .background(item.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
            .applyTail(item.direction)

            timeStampTextView()
        }
        .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5, x: 0, y: 20)
        .frame(maxWidth: .infinity, alignment: item.alignment)
        .padding(.leading, item.direction == .received ? 5 : 100)
        .padding(.trailing, item.direction == .received ? 100 : 5)

    }

    private func playButton() -> some View {
        Button {
            print("Play button tapped")
        } label: {
            Image(systemName: "play.fill")
                .padding(10)
                .background(item.direction == .received ? .green : .white)
                .foregroundStyle(item.direction == .received ? .white : .black)
                .clipShape(Circle())
        }
    }

    private func timeStampTextView() -> some View {
        HStack {
            Text("3:05 PM")
                .font(.system(size: 13))
                .foregroundStyle(.gray)
            if item.direction == .sent {
                Image(.seen)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15, height: 15)
                    .foregroundStyle(Color(.systemBlue))
            }
        }
    }
}

#Preview {
    ScrollView {
        BubbleAudioView(item: .receivedPlaceholder)
        BubbleAudioView(item: .sentPlaceholder)
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal)
    .background(Color.gray.opacity(0.4))
    .onAppear {
        let thumbimage = UIImage(systemName: "circle.fill")
        UISlider.appearance()
            .setThumbImage(thumbimage, for: .normal)
    }
}
