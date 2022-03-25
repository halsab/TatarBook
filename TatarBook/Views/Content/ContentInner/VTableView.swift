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
                HStack {
                    Text(cell.head)
                        .font(.system(.headline, design: .rounded))
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.accentColor.opacity(0.3))
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(cell.rows, id: \.self) { row in
                                Text(row)
                                    .font(.system(.body, design: .rounded))
                                if row != cell.rows.last {
                                    Divider()
                                }
                            }
                        }
                    }
                    
                }
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
