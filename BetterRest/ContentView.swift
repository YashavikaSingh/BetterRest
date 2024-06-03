//
//  ContentView.swift
//  BetterRest
//
//  Created by Yashavika Singh on 03.06.24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount =  8.0
    @State private var wakeUp = Date.now
    @State private var coffeeAmount = 1
    
    var body: some View {
        
        NavigationStack{
            VStack{
                Text("When do you want to wake up?")
                    .font(.headline)
                
                
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .padding(40)
                    .font(.title2)
                    .labelsHidden()
                
                Text("Desired amount   of sleep ")
                    .font(.headline)
                
                Stepper("Sleep Amount: \(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    .padding(40)
                    
                
                Text("Daily coffee intake?")
                    .font(.headline)
                Stepper("  \(coffeeAmount) Cups of coffee: ", value: $coffeeAmount, in: 0...10, step: 1)
                    .padding(40)
                    .navigationTitle("BettterRest")
                        .toolbar{
                            Button("Calculate", action: calculateBedtime)
                        }
                
            }
        }
        
     
        
        
    }
    
    
    func calculateBedtime(){
         
    }
}

#Preview {
    ContentView()
}
