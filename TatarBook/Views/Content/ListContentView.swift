//
//  ListContentView.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI

struct ListContentView: View {
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
                HStack(alignment: .center) {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.accentColor)
                    Text(text)
                }
            }
        }
    }
}

struct ListContentView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            ListContentView(textContent: TextContent(
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
