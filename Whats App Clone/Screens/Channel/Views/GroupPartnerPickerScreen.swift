//
//  AddGroupChatPartnersScreen.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/29/24.
//

import SwiftUI

struct GroupPartnerPickerScreen: View {
    @ObservedObject var viewModel: ChatPartnerPickerViewModel
    @State private var searchText = ""

    var body: some View {
        List {
            if viewModel.showSelectedUsers {
                SelectedChatPartnerView(users: viewModel.selectedChatPartners) { user in
                    viewModel.handItemSelection(user)
                }
            }

            Section {
                ForEach(UserItem.placeholders) { item in
                    Button {
                        viewModel.handItemSelection(item)
                    } label: {
                        chatPartnerRowView(item)
                    }
                }
            }
        }
        .animation(.easeInOut, value: viewModel.showSelectedUsers)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search "
        )
        .toolbar {
            titleView()
            trailingNavItem()
        }
    }

    private func chatPartnerRowView(_ user: UserItem) -> some View {
        ChatPartnerRowView(user: user) {
            Spacer()
            let isSelected = viewModel.isUserSelected(user)
            let imageName = isSelected ? "checkmark.circle.fill" : "circle"
            let foregroundStyle = isSelected ? Color.blue : Color(.systemGray4)
            Image(systemName: imageName)
                .foregroundStyle(foregroundStyle)
                .imageScale(.large)
        }
    }
}

extension GroupPartnerPickerScreen {
    @ToolbarContentBuilder
    private func titleView() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            VStack {
                Text("Add Participants")
                    .bold()
                
                let count = viewModel.selectedChatPartners.count
                let maxCount = ChannelConstats.maxGroupParcitipants

                Text("\(count)/\(maxCount)")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
        }
    }

    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.navStack.append(.setupGroupChat)
            } label: {
                Text("Next")
                    .bold()
            }
            .disabled(viewModel.disableNextButton)
        }
    }
}

#Preview {
    NavigationStack {
        GroupPartnerPickerScreen(viewModel: ChatPartnerPickerViewModel())
    }
}
