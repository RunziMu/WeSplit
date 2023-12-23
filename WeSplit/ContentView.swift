//
//  ContentView.swift
//  WeSplit
//
//  Created by Runzi Mu on 2023-12-22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 0
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [8, 10 , 15, 20, 0]
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople + 1)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Total Amount") {
                    TextField("Amount",
                              value: $checkAmount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    Picker("Number of people" , selection: $numberOfPeople){
                        ForEach(1..<100){
                            Text("\($0) people")
                        }
                    }
                    //                    .pickerStyle(.navigationLink)
                }
                Section("Summary") {
                    Text(totalPerPerson,
                         format: .currency(code: Locale.current.currency? .identifier ?? "USD"))
                }
                Section("Tip") {
                    Picker("Tip percentages" , selection: $tipPercentage) {
                        ForEach(tipPercentages , id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
