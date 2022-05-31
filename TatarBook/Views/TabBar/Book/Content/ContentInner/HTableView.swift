//
//  HTableView.swift
//  TatarBook
//
//  Created by Ha Sab on 25.03.2022.
//

import SwiftUI

struct HTableView: View {
    let hTableContent: [TableSimpleCellContent]
    @State private var scrollViewContentSize: CGSize = .zero
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(hTableContent, id: \.self) { cell in
                    HTableCellView(cell: cell)
                }
            }
            .padding()
            .border(Color.accentColor)
            .background(
                GeometryReader { geo -> Color in
                    DispatchQueue.main.async {
                        scrollViewContentSize = geo.size
                    }
                    return Color.clear
                }
            )
        }
        .frame(
            maxWidth: scrollViewContentSize.width
        )
    }
}

struct HTableView_Previews: PreviewProvider {
    static var previews: some View {
        HTableView(hTableContent: [
            TableSimpleCellContent(head: "Head 1", rows: ["Row 1", "Row 2", "Row 3"]),
            TableSimpleCellContent(head: "Head 2", rows: ["Row 1", "Row 2", "Row 3"]),
            TableSimpleCellContent(head: "Head 3", rows: ["Row 1", "Row 2", "Row 3"])
        ])
    }
}

struct HTableCellView: View {
    let cell: TableSimpleCellContent
    var body: some View {
        VStack {
            Text(.init(cell.head))
                .font(.system(.headline, design: .serif))
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor.opacity(0.3))
            
            if let rows = cell.rows {
                ForEach(rows, id: \.self) { row in
                    Text(.init(row))
                        .font(.system(.body, design: .serif))
                    
                    if row != rows.last {
                        Divider()
                    }
                }
            }
            Spacer()
        }
    }
}
