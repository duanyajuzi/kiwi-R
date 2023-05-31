//
//  Article.swift
//  kiwi R
//
//  Created by jarvis on 2023/5/21.
//

import Foundation

struct Article: Identifiable {
    let id = UUID()
    let title: String
    let summary: String
    var isFavorite: Bool = false
    var isArchived: Bool = false
}

