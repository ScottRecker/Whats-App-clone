//
//  GroupSetupScreen.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/29/24.
//

import SwiftUI

struct NewGroupSetupScreen: View {
    @State private var channelName = ""
    @ObservedObject var viewModel: ChatPartnerPickerViewModel
    var onCreate: (_ newChannel: ChannelItem) -> Void

    var body: some View {
        List {
            Section {
                channelSetupUpHeaderView()
            }

            Section {
               Text("Disappearing Meassages")
                Text("Group Permissaon")
            }

            Section {
                SelectedChatPartnerView(users: viewModel.selectedChatPartners) { item in
                    viewModel.handItemSelection(item)
                }
            } header: {
                let count = viewModel.selectedChatPartners.count
                let maxCount = ChannelConstats.maxGroupParcitipants

                Text("Participants: \(count) of \(maxCount)")
                    .bold()
            }
            .listRowBackground(Color.clear)
        }
        .navigationTitle("New Group")
        .toolbar {
            trailNavItem()
        }
    }

    private func channelSetupUpHeaderView() -> some View {
        HStack {
            profileImageView()
            TextField(
                "",
                text: $channelName,
                prompt: Text("Group name (optional)"),
                axis: .vertical
            )

        }
    }

    private func profileImageView() -> some View {
        Button {

        } label: {
            ZStack {
                Image(systemName: "camera.fill")
                    .imageScale(.large)
            }
            .frame(width: 60, height: 60)
            .background(Color(.systemGray6))
            .clipShape(Circle())
        }
    }

    @ToolbarContentBuilder
    private func trailNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Create") {
                viewModel.createGroupChannel(channelName, completion: onCreate)
            }
            .bold()
            .disabled(viewModel.disableNextButton)
        }
    }
}

#Preview {
    NavigationStack {
        NewGroupSetupScreen(viewModel: ChatPartnerPickerViewModel()) { _ in
        }
    }
}
