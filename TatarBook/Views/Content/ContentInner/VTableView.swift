//
//  VTableView.swift
//  TatarBook
//
//  Created by Ha Sab on 25.03.2022.
//

import SwiftUI

struct VTableView: View {
    let vTableContent: [TableSimpleCellContent]
    var body: some View {
        VStack {
            ForEach(vTableContent, id: \.self) { cell in
                VTableCellView(cell: cell)
            }
        }
        .padding()
        .border(Color.accentColor)
    }
}

struct VTableView_Previews: PreviewProvider {
    static var previews: some View {
        VTableView(vTableContent: [
        	TableSimpleCellContent(head: "Head 1", rows: ["Row 1", "Row 2", "Row 3"]),
            TableSimpleCellContent(head: "Head 2", rows: ["Row 1", "Row 2", "Row 3"]),
            TableSimpleCellContent(head: "Head 3", rows: ["Row 1", "Row 2", "Row 3"])
        ])
    }
}

struct VTableCellView: View {
    let cell: TableSimpleCellContent
    var body: some View {
        HStack {
            Text(.init(cell.head))
                .font(.system(.headline, design: .serif))
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.accentColor.opacity(0.3))
            
            if let rows = cell.rows {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(rows, id: \.self) { row in
                            Text(.init(row))
                                .font(.system(.body, design: .serif))
                            
                            if row != rows.last {
                                Divider()
                            }
                        }
                    }
                }
            }
        }
    }
}
