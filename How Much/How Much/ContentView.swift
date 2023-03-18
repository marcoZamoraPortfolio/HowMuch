//
//  ContentView.swift
//  How Much
//
//  Created by ma22756 on 2/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var tipPCt = 0
    @State private var numPeople = 1
    @State private var total = "0"
    @State private var calculate = false
    /// Checks to see if a decimal point can be added and that another doesn't already
    /// exist
    var canAddDecimal: Bool {
        return total.filter({$0 == "."}).count == 0 ? true : false
    }
    
    /// Checks that a digit can be added after the decimal point. Limiting the amount
    /// of digits to just 2 after decimal point
    var canAddDigit: Bool {
        guard let decIndex = total.firstIndex(of: ".") else { return true }
        let index = total.distance(from: total.startIndex, to: decIndex)
        return (total.count - index - 1) < 2
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text(total)
                    .font(.system(size: 70))
                    .frame(width: 260, alignment: .trailing)
                    .padding(.vertical, 1)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                HStack {
                    ForEach(7...9, id: \.self) { number in
                        numberButton("\(number)")
                    }
                }
                HStack {
                    ForEach(4...6, id: \.self) { number in
                        numberButton("\(number)")
                    }
                }
                HStack {
                    ForEach(1...3, id: \.self) { number in
                        numberButton("\(number)")
                    }
                }
                HStack {
                    numberButton("0")
                    numberButton(".")
                    Button {
                        if total.count == 1 {
                            total = "0"
                        } else {
                            total.removeLast()
                        }
                    } label: {
                        Image(systemName: "delete.backward.fill")
                            .frame(width: 80, height: 80)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 15)

                HStack {
                    Text("Tip")
                    Picker(selection: $tipPCt, label: Text("Tip")) {
                        ForEach(0...100, id: \.self) { tip in
                            Text("\(tip)%")
                        }
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.bottom, 15)

                HStack {
                    Text("Number of people")
                    Picker(selection: $numPeople, label: Text("Number of people")) {
                        ForEach(1...20, id: \.self) { tip in
                            Text("\(tip)")
                        }
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.bottom, 15)

                HStack {
                    Button("Calculate") {
                        calculate = true
                    }
                    .padding(.trailing, 15)
                    Button("Clear") {
                        total = "0"
                    }
                }
                .disabled(Double(total) == 0)
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
                Spacer()
            }
            .navigationTitle("Portion Calculator")
        }
    }

    func addDigit(_ number: String) {
        if canAddDigit {
            if number == "." && canAddDecimal {
                total += number
            } else {
                total = total == "0" ? number : total + number
            }
        }
    }

    func numberButton(_ number: String) -> some View {
        Button {
            addDigit(number)
        }
        label: {
            Text(number)
                .frame(width: 80, height: 80)
                .font(.largeTitle)
                .bold()
                .background(.purple)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
