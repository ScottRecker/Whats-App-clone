//
//  CallTabScreen.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/24/24.
//

import SwiftUI

struct CallsTabScreen: View {
    @State private var searchText = ""
    @State private var callHistory = CallHistory.all

    var body: some View {
        NavigationStack {
            List {
                Section {
                    CreateCallLinkSection()
                }
                Section {
                    RecentCallItemView()
                }
            }
            .navigationTitle("Calls")
            .searchable(text: $searchText)
            .toolbar {
                leadingNavItem()
                trailingNavItem()
                principleNavItem()
            }
        }
    }
}

extension CallsTabScreen {
    @ToolbarContentBuilder
    private func leadingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Edit") {
                print("Edit button pressed")
            }
        }
    }

    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                print("Edit button pressed")
            } label: {
                Image(systemName: "phone.arrow.up.right")
            }
        }
    }

    @ToolbarContentBuilder
    private func principleNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Picker("", selection: $callHistory) {
                ForEach(CallHistory.allCases) { item in
                    Text(item.rawValue.capitalized)
                        .tag(item.id)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 150)
        }
    }

    private enum CallHistory: String, CaseIterable, Identifiable {
        case all, missed
        var id: String {
            return rawValue
        }
    }
}

private struct CreateCallLinkSection: View {
    var body: some View {
        HStack {
            Image(systemName: "link")
                .padding(8)
                .background(Color(.systemGray6))
                .clipShape(Circle())
                .foregroundStyle(.blue)

            VStack(alignment: .leading) {
                Text("Create call link")
                    .foregroundStyle(.blue)
                Text("Share a link for your WhatsApp call")
                    .foregroundStyle(.gray)
                    .font(.caption)
            }
        }
    }
}

private struct RecentCallItemView: View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: 45, height: 45)
            recentCallsTextView()
            Spacer()
            Text("Yesterday")
            .foregroundStyle(.gray)
            .font(.system(size:16))
        }
    }

    private func recentCallsTextView() -> some View {
        VStack(alignment: .leading) {
            Text("John Smith")
            HStack {
                Image(systemName: "phone.arrow.up.right.fill")
                Text("Outgoing")
            }
            .font(.system(size: 14))
            .foregroundStyle(.gray)
        }
    }
}

#Preview {
    CallsTabScreen()
}
