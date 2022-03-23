//
//  BookView.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI

struct BookView: View {
    
    @StateObject private var vm = BookViewModel()
    
    var body: some View {
        Form {
            ForEach(vm.book.contents) { content in
                ListContentView(textContent: content.list)
                TextContentView(textContent: content.text)
            }
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}
