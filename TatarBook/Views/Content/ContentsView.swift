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
                        NavigationLink(
                            destination:
                                ContentsView(contents: contents)
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationTitle(Text(title))
                        ) {
                            Text(title)
                                .frame(maxWidth: .infinity)
                                .padding(8)
                        }
                        .buttonStyle(BorderedButtonStyle())
                        .padding(.horizontal)
                    } else {
                        ContentView(content: content)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom)
        }
    }
}

struct ContentsView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
            .preferredColorScheme(.dark)
    }
}
