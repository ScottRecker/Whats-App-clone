//
//  MessageListController.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/26/24.
//

import Foundation
import UIKit
import SwiftUI
import Combine

final class MessageListController: UIViewController {
    
    init(_ viewModel: ChatRoomViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .clear
        view.backgroundColor = .clear
        setupViews()
        setupMessageListeners()
    }

    deinit {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }

    // MARK: Properties
    private let viewModel: ChatRoomViewModel
    private let cellIdentifier = "MessageListControllerCell"
    private var subscriptions = Set<AnyCancellable>()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(image: .chatbackground)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()

    // MARK: Methods
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    private func setupMessageListeners() {
        let delay = 200
        viewModel.$messages
            .debounce(for: .milliseconds(delay), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
            self?.tableView.reloadData()
            }.store(in: &subscriptions)
    }
}

// MARK: UITableViewDelegate & UITableViewDataSource
extension MessageListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        let message = viewModel.messages[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration {
            switch message.type {
            case .text:
                BubbleTextView(item: message)
            case .video, .photo:
                BubbleImageView(item: message)
            case .audio:
                BubbleAudioView(item: message)
            case .admin(let adminType):
                switch adminType {
                case .channelCreation:
                    ChannelCreationTextView()
                    if viewModel.channel.isGroupChat {
                        AdminMessageTextView(channel: viewModel.channel)
                    }
                default:
                    Text("Unknown")
                }
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

#Preview {
    MessageListView(ChatRoomViewModel(.placeholder))
        .ignoresSafeArea()
}

