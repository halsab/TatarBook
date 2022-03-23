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
            Section(header: Text(vm.book.title)) {
                ForEach(vm.book.contents) { content in
                    Text(content.text)
                }
            }
            ForEach(vm.book.contents) { content in
                TextListView(list: content.list)
            }
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}

struct TextListView: View {
    let list: TextList
    var body: some View {
        Section(header: Text(list.title)) {
            ForEach(list.rows, id: \.self) { row in
                Text(row)
            }
        }
    }
}
