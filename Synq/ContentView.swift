//
//  ContentView.swift
//  Synq
//
//  Created by Martin Flischman on 2025/05/18.
//

import SwiftUI

struct ContentView: View {
    // MARK: - State
    @State private var inputNumber: String = ""
    @State private var inputUnit: Int = 0
    @State private var outputUnit: Int = 0
    @FocusState private var isInputFocused: Bool

    // MARK: - Units
    let units = ["Seconds", "Minutes", "Hours", "Days"]

    // MARK: - Computed Conversion Result
    var result: Double {
        guard let value = Double(inputNumber.trimmingCharacters(in: .whitespaces)) else {
            return 0
        }

        var seconds = 0.0

        // Convert input to seconds
        if inputUnit == 0 { seconds = value }
        else if inputUnit == 1 { seconds = value * 60 }
        else if inputUnit == 2 { seconds = value * 3600 }
        else if inputUnit == 3 { seconds = value * 86400 }

        // Convert seconds to output
        if outputUnit == 0 { return seconds }
        else if outputUnit == 1 { return seconds / 60 }
        else if outputUnit == 2 { return seconds / 3600 }
        else if outputUnit == 3 { return seconds / 86400 }

        return 0
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.1)
                    .ignoresSafeArea()
                
                Form {
                    // MARK: - Input
                    Section(header: Text("Value to Convert")) {
                        TextField("Enter a number", text: $inputNumber)
                            .keyboardType(.decimalPad)
                            .focused($isInputFocused)
                    }
                    
                    // MARK: - Unit Selection
                    Section(header: Text("Select Units")) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Convert From:")
                                .font(.subheadline)
                                .bold()
                            Picker("From", selection: $inputUnit) {
                                ForEach(units.indices, id: \.self) {
                                    Text(units[$0])
                                }
                            }
                            .pickerStyle(.segmented)
                            
                            Text("Convert To:")
                                .font(.subheadline)
                                .bold()
                            Picker("To", selection: $outputUnit) {
                                ForEach(units.indices, id: \.self) {
                                    Text(units[$0])
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    
                    // MARK: - Result
                    Section {
                        VStack(spacing: 8) {
                            Text("Result")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                            
                            Text(
                                result.truncatingRemainder(dividingBy: 1) == 0
                                ? "\(Int(result))"
                                : String(format: "%.2f", result)
                            )
                            .font(.system(size: 42, weight: .bold))
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                            
                            Text(units[outputUnit])
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .navigationTitle("Synq")
                .toolbar {
                    // MARK: - Keyboard Done Button
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isInputFocused = false
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
