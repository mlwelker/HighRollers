
import Foundation
import SwiftData

@Model
class RollResult {
    var die1Result: Int
    var die2Result: Int?
    var date: Date
    var dieType: Int
    
    init(die1Result: Int, die2Result: Int? = nil, date: Date = .now, dieType: Int) {
        self.die1Result = die1Result
        self.die2Result = die2Result
        self.date = date
        self.dieType = dieType
    }
}
