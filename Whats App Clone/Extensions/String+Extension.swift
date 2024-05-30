//
//  String+Extension.swift
//  Whats App Clone
//
//  Created by Scott Recker on 5/30/24.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
