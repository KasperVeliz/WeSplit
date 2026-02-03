//
//  ContentView.swift
//  WeSplit
//
//  Created by Kasper Veliz on 2/2/26.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount: Double = 0
    @State private var numberSelection: Int = 0
    @State private var tipSelection: Int = 0
    
    let tipPercentages = [0, 15, 20, 25]
    
    var totalPerPerson: Double{
        //Calculate the total/person
        let numOfPeople = Double(numberSelection + 2)
        let tip = Double(tipSelection)
        
        let grandTotal = checkAmount * (1 + (tip/100))
        return grandTotal/numOfPeople
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Bill amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Split by", selection: $numberSelection){
                        ForEach(2..<25){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section{
                    Picker("Tip", selection: $tipSelection){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section{
                    Text("Total per person: \(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocused{
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
