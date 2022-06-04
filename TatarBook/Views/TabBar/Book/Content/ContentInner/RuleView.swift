//
//  RuleView.swift
//  TatarBook
//
//  Created by halsab on 04.06.2022.
//

import SwiftUI

struct RuleView: View {
    let rule: [String]
    var body: some View {
        VStack(spacing: 8) {
            Text(.init("Кагыйдә"))
                .font(.system(.headline, design: .serif))
            VStack(alignment: .leading) {
                ForEach(rule, id: \.self) { text in
                    Text(.init(text))
                        .font(.system(.body, design: .serif))
                        .fixedSize(horizontal: false, vertical: true)
                    if text != rule.last {
                        Divider()
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .border(Color.accentColor)
            .padding(5)
            .border(Color.accentColor, width: 2)
        }
    }
}

struct RuleView_Previews: PreviewProvider {
    static var previews: some View {
        RuleView(rule: [
            "Әйтелгәндә сузылмый торган хәрефләр тавыш хәрефләре (тартыклар) дип атала, ә әйткәндә теләгән хәтле сузыла ала торган хәрефләрне мәд хәрефләре (сузыклар) дип атыйлар."
        ])
    }
}
