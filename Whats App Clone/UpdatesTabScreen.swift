//
//  UpdatesTabScreen.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/24/24.
//

import SwiftUI

struct UpdatesTabScreen: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                StatusSectionHeader()
                    .listRowBackground(Color.clear)
                StatusSection()

                Section {
                    RecentUpdatesItemView()
                } header: {
                    Text("Recent Updates")
                }

                Section {
                    ChannelListView()
                } header: {
                    channelSectionHeader()
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Updates")
            .searchable(text: $searchText)
        }
    }

    private func channelSectionHeader() -> some View {
        HStack {
            Text("Channels")
                .font(.title3)
                .bold()
                .textCase(nil)
                .foregroundStyle(.whatsAppBlack)

            Spacer()

            Button {
               print("Plus button tapped")
            } label: {
                Image(systemName: "plus")
                    .padding(5)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }
        }
    }
}

extension UpdatesTabScreen {
    enum Constant {
        static let imageDimension: CGFloat = 55.0
    }
}
private struct StatusSectionHeader: View {
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "circle.dashed")
                .foregroundStyle(.blue)
                .imageScale(.large)
            (
                Text("Use Status to share photos, text and videos that disappear in 24 hours.")
                +
                Text(" ")
                +
                Text("Status Privacy")
                    .foregroundStyle(.blue).bold()
            )
            Image(systemName: "xmark")
        }
        .padding()
        .background(.whatsAppWhite)
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
    }
}

private struct StatusSection: View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: UpdatesTabScreen.Constant.imageDimension,
                       height: UpdatesTabScreen.Constant.imageDimension)

            VStack(alignment: .leading) {
                Text("My status")
                    .font(.callout)
                    .bold()
                Text("Add to my status")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))
            }

            Spacer()

            cameraButton()
            pencilButton()
        }
    }

    private func cameraButton() -> some View {
        Button {
            print("Camera button tapped")
        } label: {
            Image(systemName: "camera.fill")
                .padding(10)
                .background(Color(.systemGray6))
                .clipShape(Circle())
        }
    }

    private func pencilButton() -> some View {
        Button {
            print("Pencil button tapped")
        } label: {
            Image(systemName: "pencil")
                .padding(10)
                .background(Color(.systemGray6))
                .clipShape(Circle())
        }
    }
}

private struct RecentUpdatesItemView: View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: UpdatesTabScreen.Constant.imageDimension,
                       height: UpdatesTabScreen.Constant.imageDimension)
            VStack(alignment: .leading) {
                Text("Joseph Smith")
                    .font(.callout)
                    .bold()
                Text("1h ago")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))
            }
        }
    }
}

private struct ChannelListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Stay updated on topics that matter to you. Find channels to follow below.")
                .foregroundStyle(.gray)
                .font(.callout)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<5) { _ in
                        ChannelItemView()
                    }
                }
            }

            Button("Explore More") {
                print("Explore more button tapped")
            }
                .tint(.blue)
                .bold()
                .buttonStyle(.borderedProminent)
                .clipShape(Capsule())
                .padding(.vertical)
        }
    }
}

private struct ChannelItemView: View {
    var body: some View {
        VStack {
            Circle()
                .frame(width: 50, height: 50)
            Text("Real Madrid C.F")
            Button {

            } label: {
                Text("Follow")
                    .bold()
                    .padding(5)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.2))
                    .clipShape(Capsule())
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1))
    }
}

#Preview {
    UpdatesTabScreen()
}
