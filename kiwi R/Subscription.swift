//
//  Subscription.swift
//  kiwi R
//
//  Created by jarvis on 2023/5/21.
//

import Foundation

struct Subscription: Identifiable,Equatable {
    static func == (lhs: Subscription, rhs: Subscription) -> Bool {
        return lhs.title == rhs.title && lhs.url == rhs.url
    }

    
    let id = UUID()
    //标题
    let title: String
    //url
    let url: URL
    
    var articles: [Article] = []
}

