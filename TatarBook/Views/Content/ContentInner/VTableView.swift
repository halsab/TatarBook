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
                    Text(.init(cell.head))
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.accentColor.opacity(0.3))
                        .if(!cell.head.isArabic) {
                            $0.font(.system(.headline, design: .rounded))
                        }
                        .if(cell.head.isArabic) {
                            $0.font(.system(.title2, design: .serif))
                        }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(cell.rows, id: \.self) { row in
                                Text(.init(row))
                                    .if(!row.isArabic) {
                                        $0.font(.system(.body, design: .rounded))
                                    }
                                    .if(row.isArabic) {
                                        $0.font(.system(.title2, design: .serif))
                                    }
                                
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
