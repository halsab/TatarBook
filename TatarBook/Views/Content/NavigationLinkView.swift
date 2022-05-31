//
//  NavigationLinkView.swift
//  TatarBook
//
//  Created by Ha Sab on 24.03.2022.
//

import SwiftUI

struct NavigationLinkView: View {
    let title: String
    let contents: [ContentModel]
    var body: some View {
        NavigationLink(
            destination:
                ContentsView(contentTitle: title, contents: contents)
//                .navigationBarTitleDisplayMode(.inline)
//                .navigationTitle(Text(title))
        ) {
            Text(.init(title))
                .font(.system(.title3, design: .serif))
                .bold()
                .frame(maxWidth: .infinity)
                .padding(8)
        }
        .buttonStyle(BorderedButtonStyle())
    }
}

struct NavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
            .preferredColorScheme(.dark)
    }
}
