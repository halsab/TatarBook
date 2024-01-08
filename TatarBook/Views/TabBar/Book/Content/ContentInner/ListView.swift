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
                Text(.init(title))
                    .font(.system(.headline, design: .serif))
            }
            
            if let texts = textContent.texts {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(texts, id: \.self) { text in
                        HStack {
                            VStack {
                                Circle()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(.accentColor)
                                    .padding(.top)
                                Spacer()
                            }
                            Text(.init(text))
                                .font(.system(.body, design: .serif))
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                        if text != texts.last {
                            Divider()
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .border(Color.accentColor)
            }
            
            if let footer = textContent.footer {
                Text(.init(footer))
                    .font(.system(.callout, design: .serif))
                    .foregroundColor(.gray)
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
