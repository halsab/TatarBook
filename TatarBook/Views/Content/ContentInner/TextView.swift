//
//  TextView.swift
//  TatarBook
//
//  Created by Ha Sab on 24.03.2022.
//

import SwiftUI

struct TextView: View {
    let textContent: TextContent
    var body: some View {
        VStack {
            if let title = textContent.title {
                Text(title)
                    .font(.title)
                    .padding()
            }
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 10) {
                    if let texts = textContent.texts {
                        ForEach(texts, id: \.self) { text in
                            Text(text)
                                .font(.body)
                        }
                    }
                }
                if let footer = textContent.footer {
                    Divider()
                    Text(footer)
                        .font(.footnote)
                }
            }
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(textContent: TextContent(
            title: "Text Title",
            texts: [
            	"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
            ],
            footer: "Text Footer")
        )
        .preferredColorScheme(.dark)
    }
}
