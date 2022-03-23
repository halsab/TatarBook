//
//  TextContentView.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI

struct TextContentView: View {
    let textContent: TextContent
    var isTitleExist: Bool {
        textContent.title != nil
    }
    var isFooterExist: Bool {
        textContent.footer != nil
    }
    var body: some View {
        Section(
            header: isTitleExist ? Text(textContent.title ?? "") : nil,
            footer: isFooterExist ? Text(textContent.footer ?? "") : nil
        ) {
            ForEach(textContent.texts, id: \.self) { text in
                Text(text)
            }
        }
        .listRowSeparator(.hidden)
    }
}

struct TextContentView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            TextContentView(textContent: TextContent(
                title: "Title",
                texts: [
                    "Text 1",
                    "Text 2",
                    "Text 3"
                ],
                footer: "Footer")
            )
        }
    }
}
