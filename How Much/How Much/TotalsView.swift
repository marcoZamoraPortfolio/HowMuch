//
//  TotalsView.swift
//  How Much
//
//  Created by ma22756 on 3/17/23.
//

import SwiftUI

struct TotalsView: View {
    let total: Double
    let tipPct: Int
    let numPeople: Int
    var tipAmout: Double {
        total * Double(tipPct)/100
    }

    var totalAmount: Double {
        total + tipAmout
    }

    var portion: Double {
        totalAmount / Double(numPeople)
    }

    let identifier = Locale.current.currency?.identifier ?? ""

    var body: some View {
        Grid {
            GridRow {
                Text("Original Bill")
                    .gridColumnAlignment(.leading)
                Text("\(total, format: .currency(code: identifier))")
                    .gridColumnAlignment(.trailing)
            }

            GridRow {
                Text("Tip")
                Text("\(tipAmout)")
            }

            GridRow {
                Text("Total")
                Text("\(totalAmount)")
            }

            GridRow {
                Text("Portion")
                Text("\(portion)")
            }
        }
    }
}

struct TotalsView_Previews: PreviewProvider {
    static var previews: some View {
        TotalsView(total: 135.40, tipPct: 16, numPeople: 2)
    }
}
