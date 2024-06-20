//
//  MainTabView.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/24/24.
//

import SwiftUI

struct MainTabView: View {
    private let currentUser: UserItem

    init(_ currentUser: UserItem) {
        self.currentUser = currentUser
        makeTabBarOpaque()
        let thumbimage = UIImage(systemName: "circle.fill")
        UISlider.appearance()
            .setThumbImage(thumbimage, for: .normal)
    }

    var body: some View {
        TabView {
            UpdatesTabScreen()
                .tabItem {
                    Image(systemName: Tab.updates.icon)
                    Text(Tab.updates.title)
                }
            CallsTabScreen()
                .tabItem {
                    Image(systemName: Tab.calls.icon)
                    Text(Tab.calls.title)
                }
            CommunityTabScreen()
                .tabItem {
                    Image(systemName: Tab.communities.icon)
                    Text(Tab.communities.title)
                }
            ChannelTabScreen(currentUser)
                .tabItem {
                    Image(systemName: Tab.chats.icon)
                    Text(Tab.chats.title)
                }
            SettingsTabScreen()
                .tabItem {
                    Image(systemName: Tab.settings.icon)
                    Text(Tab.settings.title)
                }

        }
    }

    private func makeTabBarOpaque() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

private func placeholderItemView(_ title: String) -> some View {
    ScrollView {
        ForEach(0..<120) { _ in
            Text(title)
                .bold()
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .background(Color.green.opacity(0.5))
        }
//        .frame(maxWidth: .infinity)
    }
}

extension MainTabView {
    private enum Tab: String {
        case updates, calls, communities, chats, settings
        
        fileprivate var title: String {
            return rawValue.capitalized
        }

        fileprivate var icon: String {
            switch self {
            case .updates:
                return "circle.dashed.inset.filled"
            case .calls:
                return "phone"
            case .communities:
                return "person.3"
            case .chats:
                return "message"
            case .settings:
                return "gear"
            }
        }
    }
}

#Preview {
    MainTabView(.placeholder)
}
