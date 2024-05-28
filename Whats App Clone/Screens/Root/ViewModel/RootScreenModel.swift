//
//  RootScreenModel.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/28/24.
//

import Foundation
import Combine

final class RootScreenModel: ObservableObject {
    @Published private(set) var  authState = AuthState.pending
    private var cancellable: AnyCancellable?

    init() {
        cancellable = AuthManager.shared.authState.receive(on: DispatchQueue.main)
            .sink { [weak self] latestAuthState in
                self?.authState = latestAuthState
            }
    }
}

