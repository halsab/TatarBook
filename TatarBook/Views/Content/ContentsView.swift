//
//  ContentsView.swift
//  TatarBook
//
//  Created by Ha Sab on 24.03.2022.
//

import SwiftUI

struct ContentsView: View {
    let contents: [Content]
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(contents) { content in
                    if let title = content.title,
                       let contents = content.contents {
                        NavigationLinkView(title: title, contents: contents)
                    } else {
                        ContentView(content: content)
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentsView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
            .preferredColorScheme(.dark)
    }
}
