//
//  ContentView.swift
//  WeSplit
//
//  Created by Corwin Rainier on 6/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var people = 2
    @State private var tip = 20
    @FocusState private var focused : Bool
    
    let percentages = [10, 15, 20, 25, 0]
    
    var total: Double {
        let peopleInput = Double(people + 2)
        let tipInput = Double(tip)
        let tipCalc = amount / 100 * tipInput
        let amountCalc = amount + tipCalc
        let total = amountCalc / peopleInput
        return total
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($focused)
                    Picker("Number of people", selection: $people) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tip) {
                        ForEach(percentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("choose the tip percentage")
                }
                Section {
                    Text(total, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
                .navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            focused = false
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
