//
//  ContentsView.swift
//  TatarBook
//
//  Created by Ha Sab on 24.03.2022.
//

import SwiftUI

struct ContentsView: View {
    let contentTitle: String
    let contents: [ContentModel]
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(.init(contentTitle))
                    .font(.system(.title, design: .serif))
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.accentColor, lineWidth: 1)
                    )
                ForEach(contents) { content in
                    if let title = content.title,
                       let contents = content.contents {
                        NavigationLinkView(title: title, contents: contents)
                    } else {
                        ContentView(title: contentTitle, content: content)
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
