//
//  BookContentView.swift
//  TatarBook
//
//  Created by halsab on 02.06.2022.
//

import SwiftUI

struct BookContentView: View {
    @Binding var contents: [ContentModel]
    var body: some View {
        ContentsView(contentTitle: "Иске имля", contents: contents)
            .navigationTitle(Text("Китап"))
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct BookContentView_Previews: PreviewProvider {
    @State private static var contents: [ContentModel] = []
    static var previews: some View {
        BookContentView(contents: $contents)
    }
}
