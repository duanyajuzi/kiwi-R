//  显示用户的订阅列表
//  SubscriptionsView.swift
//  kiwi R
//
//  Created by jarvis on 2023/5/21.
//

import Foundation
import SwiftUI
import FeedKit

struct SubscriptionsView: View{
    
    @State private var isAddingSubscription = false  // 是否正在添加订阅
    @State private var newSubscriptionURL = ""  // 用于输入新订阅的URL
    
    //订阅列表
    @State private var subscriptions: [Subscription] = []
    
    var body: some View{
        NavigationView{
            List(subscriptions.indices, id: \.self) { index in
                let subscription = subscriptions[index]
                NavigationLink(destination: ArticlesView(articles: $subscriptions[index].articles)) {
                    Text(subscription.title)
                }
            }
            
            .navigationBarTitle("Subscriptions")
            .navigationBarItems(trailing: addButton)
            
        }
    }
    
    private var addButton: some View {
        Button(action: {
            isAddingSubscription = true
        }) {
            Image(systemName: "plus")
        }
        .sheet(isPresented: $isAddingSubscription) {
            AddSubscriptionView(isPresented: $isAddingSubscription) { url in
                addSubscription(url: url)
            }
        }
    }
    
    
    private func addSubscription(url: URL) {
        let parser = FeedParser(URL: url)

        parser.parseAsync { result in
            switch result {
            case .success(let feed):
                if let title = feed.rssFeed?.title, !title.isEmpty {
                    var newArticles: [Article] = []
                    if let items = feed.rssFeed?.items {
                        for item in items {
                            let article = Article(title: item.title ?? "", summary: item.description ?? "")
                            newArticles.append(article)
                        }
                    }
                    
                    let newSubscription = Subscription(title: title, url: url, articles: newArticles)
                    DispatchQueue.main.async {
                        self.subscriptions.append(newSubscription)
                    }
                } else {
                    print("Failed to parse feed title.")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    
//    private func addSubscription(url: URL) {
//        let parser = FeedParser(URL: url)
//
//        parser.parseAsync { result in
//            switch result {
//            case .success(let feed):
//                if let title = feed.atomFeed?.title ?? feed.rssFeed?.title, !title.isEmpty {
//                    var newArticles: [Article] = []
//                    // 根据解析结果获取文章列表
//                    // 将获取到的文章添加到 newArticles 中
//                    if let atomFeed = feed.atomFeed, let entries = atomFeed.entries {
//                        // 遍历解析出的 AtomEntry 对象，将其转换为 Article 并添加到 newArticles 中
//                        for entry in entries {
//                            let article = Article(title: entry.title ?? "", summary: entry.summary ?? "")
//                            newArticles.append(article)
//                        }
//                    }
//                    let newSubscription = Subscription(title: title, url: url, articles: newArticles)
//                    DispatchQueue.main.async {
//                        self.subscriptions.append(newSubscription)
//                    }
//                } else {
//                    print("Failed to parse feed title.")
//                }
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        }
//    }

    
}

struct SubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionsView()
    }
}
