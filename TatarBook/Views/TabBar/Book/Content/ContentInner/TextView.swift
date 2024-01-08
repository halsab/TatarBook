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
                Text(.init(title))
                    .font(.system(.title3, design: .serif))
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
            }
            
            if let texts = textContent.texts {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(texts, id: \.self) { text in
                            Text(.init(text))
                                .font(.system(.body, design: .serif))
                        }
                    }
                    
                    if let footer = textContent.footer {
                        Divider()
                        Text(.init(footer))
                            .font(.system(.callout, design: .serif))
                            .foregroundColor(.gray)
                    }
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
