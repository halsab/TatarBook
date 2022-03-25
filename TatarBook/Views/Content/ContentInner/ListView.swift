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
                        .font(.system(.headline, design: .rounded))
                }
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(textContent.texts, id: \.self) { text in
                        HStack {
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(.accentColor)
                            Text(text)
                                .font(.system(.body, design: .rounded))
                        }
                        if text != textContent.texts.last {
                            Divider()
                        }
                    }
                }
                .padding()
                .border(Color.accentColor)
                if let footer = textContent.footer {
                    Text(footer)
                        .font(.system(.footnote, design: .rounded))
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
