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
    @State private var wakeUp = Date.now
    @State private var coffeeAmount = 1
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
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
                    .alert(alertTitle, isPresented: $showingAlert){
                    Button("OK"){}
                      } message: {
                Text(alertMessage)
                }
            }
        } 
        
     
        
        
    }
    
    
    func calculateBedtime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config )
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0)*60*60
            let minute = (components.minute ?? 0)*60
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal  bedtime is ..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }
        catch{
          alertTitle = "Error"
        alertMessage = "Sorry, there was a problem with the model"
        }
        
        showingAlert = true
    }
    
   
}

#Preview {
    ContentView()
}
