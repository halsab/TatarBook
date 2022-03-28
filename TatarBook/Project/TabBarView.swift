//
//  TabBarView.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            BookView()
                .tabItem {
                    Label("Китап", systemImage: "books.vertical")
                }
            TestView()
                .tabItem {
                    Label("Тест", systemImage: "list.number")
                }
            DictionaryView()
                .tabItem {
                    Label("Сүзлек", systemImage: "textformat")
                }
            Text("Көйләнеш")
                .tabItem {
                    Label("Көйләнеш", systemImage: "gear")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
