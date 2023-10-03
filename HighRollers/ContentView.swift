// TODO
// DONE 1. users roll dice
// DONE 2. then store the results
// DONE 3. viewable results history

// BONUS TODO
// DONE 1. Let the user customize the dice that are rolled:
// DONE  (a) how many dice
// DONE  (b) what type: 4-sided, 6-sided, 8-sided, 10-sided, 12-sided, 20-sided, 100-sided.
// DONE 2. Show the total rolled on the dice.
// DONE 3. Store the results using JSON or Core Data – anywhere they are persistent.
// 4. Add haptic feedback when dice are rolled.
// 5X. For a real challenge, make the value rolled by the dice flick through various possible values before settling on the final figure.
// 6. add accessibility with VoiceOver

// NOTES:
// don’t need to create fancy 3D effects – just show the numbers that were “rolled”
// For 5X: making the results flick through various values before settling on the final figure -- The easiest way to tackle this is through a Timer that gets cancelled after a certain number of calls.


import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var results: [RollResult]
    
    @State private var die1 = Die.roll(.d6)
    @State private var die2 = Die.roll(.d6)
    @State private var dieType = 1
    @State private var numberOfDice = 0
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: die1.image)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color(red: 0.3, green: 0.3, blue: 0.3))
                        .frame(width: 100, height: 100)
                    
                    if numberOfDice >= 1 {
                        Image(systemName: die2.image)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color(red: 0.3, green: 0.3, blue: 0.3))
                            .frame(width: 100, height: 100)
                    }
                    
                }
                
                HStack {
                    Picker("Die Type", selection: $dieType) {
                        ForEach(0..<6) { num in
                            switch num {
                            case 0:
                                Text("d4")
                            case 1:
                                Text("d6")
                            case 2:
                                Text("d8")
                            case 3:
                                Text("d12")
                            case 4:
                                Text("d20")
                            case 5:
                                Text("d100")
                            default:
                                Text("d6")
                            }
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Number of Dice", selection: $numberOfDice) {
                        ForEach(0..<2) { num in
                            Text("x\(num + 1)")
                        }
                    }
                }
                
                Button("Roll") {
                    switch dieType {
                    case 0:
                        die1 = Die.roll(.d4)
                        die2 = Die.roll(.d4)
                    case 1:
                        die1 = Die.roll(.d6)
                        die2 = Die.roll(.d6)
                    case 2:
                        die1 = Die.roll(.d8)
                        die2 = Die.roll(.d8)
                    case 3:
                        die1 = Die.roll(.d12)
                        die2 = Die.roll(.d12)
                    case 4:
                        die1 = Die.roll(.d20)
                        die2 = Die.roll(.d20)
                    case 5:
                        die1 = Die.roll(.d100)
                        die2 = Die.roll(.d100)
                    default:
                        die1 = Die.roll(.d6)
                        die2 = Die.roll(.d6)
                    }
                    modelContext.insert(RollResult(die1Result: die1.value, die2Result: numberOfDice == 1 ? die2.value : nil, dieType: dieType))
                }
                .buttonStyle(.borderedProminent)
            }
            .toolbar {
                NavigationLink {
                    List {
                        ForEach(results) { result in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("\(result.die1Result)")
                                    
                                    if let d2 = result.die2Result {
                                        Text("+ \(d2)")
                                    }
                                }
                                
                                Text(result.date.formatted(date: .long, time: .shortened))
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "clock")
                        Text("History")
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
