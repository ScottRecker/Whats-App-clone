//
//  CircularProfileImageView.swift
//  Whats App Clone
//
//  Created by Scott Recker on 6/19/24.
//

import SwiftUI
import Kingfisher

struct CircularProfileImageView: View {
    let profileImageUrl: String?
    let size: Size
    let fallbackImage: FallbackImage

    init(_ profileImageUrl: String? = nil, size: Size) {
        self.profileImageUrl = profileImageUrl
        self.size = size
        self.fallbackImage = .directChatIcon
    }

    var body: some View {
        if let profileImageUrl {
            KFImage(URL(string: profileImageUrl))
                .resizable()
                .placeholder { ProgressView() }
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())

        } else {
            placeholderImageView()
        }
    }

    private func placeholderImageView() -> some View {
        Image(systemName: fallbackImage.rawValue)
            .resizable()
            .scaledToFit()
            .imageScale(.large)
            .foregroundColor(Color.placeholder)
            .frame(width: size.dimension, height: size.dimension)
            .background(.white)
            .clipShape(Circle())
    }
}

extension CircularProfileImageView {
    enum Size {
        case mini, xSmall, small, medium, large, xLarge
        case custom(CGFloat)

        var dimension: CGFloat {
            switch self {

            case .mini:
                return 30
            case .xSmall:
                return 40
            case .small:
                return 50
            case .medium:
                return 60
            case .large:
                return 80
            case .xLarge:
                return 120
            case .custom(let dimension):
                return dimension
            }
        }
    }

    enum FallbackImage: String {
        case directChatIcon = "person.circle.fill"
        case groupChatIcon = "person.2.circle.fill"

        init(for memberCount: Int) {
            switch memberCount {
            case 2:
                self = .directChatIcon
            default:
                self = .groupChatIcon
            }
        }
    }
}

extension CircularProfileImageView {
    init(_ channel: ChannelItem, size: Size) {
        self.profileImageUrl = channel.coverImageUrl
        self.size = size
        self.fallbackImage = FallbackImage(for: channel.membersCount)
    }
}

#Preview {
    CircularProfileImageView(size: .large)
}
