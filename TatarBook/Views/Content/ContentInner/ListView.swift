//
//  ListView.swift
//  TatarBook
//
//  Created by Ha Sab on 24.03.2022.
//

import SwiftUI

struct ListView: View {
    let textContent: TextContent
    var body: some View {
            VStack(alignment: .leading) {
                if let title = textContent.title {
                    Text(title)
                        .font(.headline)
                }
                VStack(alignment: .leading, spacing: 8) {
                    if let texts = textContent.texts {
                        ForEach(texts, id: \.self) { text in
                            HStack {
                                Circle()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(.accentColor)
                                Text(text)
                                    .font(.body)
                            }
                            if text != texts.last {
                                Divider()
                            }
                        }
                    }
                }
                .padding()
                .border(Color.accentColor)
                if let footer = textContent.footer {
                    Text(footer)
                        .font(.footnote)
                }
            }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(textContent: TextContent(
            title: "List Title",
            texts: [
                "Lorem ipsum dolor sit amet",
                "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                "Duis aute irure dolor"
            ],
            footer: "Text Footer")
        )
        .preferredColorScheme(.dark)
    }
}
