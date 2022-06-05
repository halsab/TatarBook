//
//  WordView.swift
//  TatarBook
//
//  Created by halsab on 02.06.2022.
//

import SwiftUI

struct WordView: View {
    let word: Word
    var body: some View {
        HStack {
            Text(.init(word.tatar))
                .font(.system(.body, design: .serif))
                .foregroundColor(.secondary)
            Spacer()
            Text(.init(word.oldTatar))
                .font(.system(.title, design: .serif))
                .foregroundColor(.accentColor)
        }
    }
}

struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        WordView(word: Word(tatar: "tatar", oldTatar: "old tatar"))
    }
}
