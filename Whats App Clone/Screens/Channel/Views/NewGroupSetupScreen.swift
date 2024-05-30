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
                Text("Participants: 12/12")
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
            Circle()
                .frame(width: 60, height: 60)
            TextField(
                "",
                text: $channelName,
                prompt: Text("Group name (optional)"),
                axis: .vertical
            )

        }
    }

    @ToolbarContentBuilder
    private func trailNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Create") {

            }
            .bold()
            .disabled(viewModel.disableNextButton)
        }
    }
}

#Preview {
    NavigationStack {
        NewGroupSetupScreen(viewModel: ChatPartnerPickerViewModel())
    }
}
