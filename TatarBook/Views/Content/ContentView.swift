//
//  ContentView.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI

struct ContentView: View {
    let content: Content
    var body: some View {
        VStack {
            if let textContent = content.text {
                TextView(textContent: textContent)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
            .preferredColorScheme(.dark)
    }
}
