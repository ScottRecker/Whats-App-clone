//
//  ChatPartnerPickerScreen.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/28/24.
//

import SwiftUI

struct ChatPartnerPickerScreen: View {
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ChatPartnerPickerViewModel()

    var onCreate: (_ newChannel: ChannelItem) -> Void

    var body: some View {
        NavigationStack(path: $viewModel.navStack) {
            List {
                ForEach(ChatPartnerPickerOptions.allCases) { item in
                    HeaderItemView(item: item) {
                        guard item == ChatPartnerPickerOptions.newGroup else { return }
                        viewModel.navStack.append(.groupPartnerPicker)
                    }
                }

                Section {
                    ForEach(viewModel.users) { user in
                        ChatPartnerRowView(user: user)
                            .onTapGesture {
                                viewModel.createDirectChannel(user, completion: onCreate)
                            }
                    }
                } header: {
                    Text("Contacts on WhatsApp")
                        .textCase(nil)
                        .bold()
                }
                if viewModel.isPaginatable {
                    loadMoreUsers()
                }
            }
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search name or number"
            )
            .navigationTitle("New Chat")
            .navigationDestination(for: ChannelCreationRoute.self) { route in
                destinationView(for: route)
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $viewModel.errorState.showError) {
                Alert(
                    title: Text("Uh Oh 😕"),
                    message: Text(viewModel.errorState.errorMessage),
                    dismissButton: .default(Text("Ok"))
                )
            }
            .toolbar {
                trailingNavItem()
            }
            .onAppear {
                viewModel.deselectAllChatPartners()
            }
        }
    }

    private func loadMoreUsers() -> some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
            .task {
                await viewModel.fetchUsers()
            }
    }
}

extension ChatPartnerPickerScreen {
    @ViewBuilder
    private func destinationView(for route: ChannelCreationRoute) -> some View {
        switch route {
        case .groupPartnerPicker:
            GroupPartnerPickerScreen(viewModel: viewModel)
        case .setupGroupChat:
            NewGroupSetupScreen(viewModel: viewModel, onCreate: onCreate)
        }

    }
}

extension ChatPartnerPickerScreen {
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(.gray)
                    .padding(8)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }
        }
    }
}

extension ChatPartnerPickerScreen {
    private struct HeaderItemView: View {
        let item: ChatPartnerPickerOptions
        let onTapHandler: () -> Void

        var body: some View {
            Button {
                onTapHandler()
            } label: {
                buttonBody()
            }
        }

        private func buttonBody() -> some View {
            HStack {
                Image(systemName: item.imageName)
                    .font(.footnote)
                    .frame(width: 40, height: 40)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())

                Text(item.title)
            }
        }
    }
}

enum ChatPartnerPickerOptions: String, CaseIterable, Identifiable {
    case newGroup = "New Group"
    case newContact = "New Contact"
    case newCommunity = "New Community"

    var id: String {
        return rawValue
    }

    var title: String {
        return rawValue
    }

    var imageName: String {
        switch self {

        case .newGroup:
            return "person.2.fill"
        case .newContact:
            return "person.fill.badge.plus"
        case .newCommunity:
            return "person.3.fill"
        }
    }
}

#Preview {
    ChatPartnerPickerScreen { channel in

    }
}
