//
//  ContentView.swift
//  BetterRest
//
//  Created by Yashavika Singh on 03.06.24.
//
import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount =  8.0
    @State private var wakeUp = defaultWakeUpTime
    @State private var coffeeAmount = 1
    @State private var finalMessage = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components ) ?? .now
    }
    
 
    
    
    var body: some View {
        
        NavigationStack{
            Form{
                
                Section("When do you want to wake up?"){
                  
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .font(.title2)
                        .labelsHidden()
                }
             
                
                Section("Desired amount   of sleep "){
                     
                    
                Stepper("Sleep Amount: \(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
              
                    
                
                Section("Daily coffee intake?") {
                
       
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)

                }
                Section{
                    Text( "Your ideal  bedtime is \(calculateBedtime()) ").font(.title3)
                }
              
                
                 
                
            }
            .navigationTitle("BettterRest")
        }
 
        
    }
    
    
     func calculateBedtime() -> String{
        var result = ""
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config )
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0)*60*60
            let minute = (components.minute ?? 0)*60
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
        
             result = sleepTime.formatted(date: .omitted, time: .shortened)
        }
        catch{
            result = "Something went wrong with the model"
        }
        
        return result
    }
    
   
}

#Preview {
    ContentView()
}
