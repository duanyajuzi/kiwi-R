//  显示文章的页面
//  ArticlesView.swift
//  kiwi R
//
//  Created by jarvis on 2023/5/21.
//

import SwiftUI

struct ArticlesView: View {
    @Binding var articles: [Article]

var body: some View {
    
        List(articles) { article in
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                Text(article.summary)
                    .font(.subheadline)
            }
        }
        .navigationBarTitle("Articles")
    }
}

