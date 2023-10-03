
import Foundation

enum DieType {
    case d4, d6, d8, d12, d20, d100
}

struct Die {
    let value: Int
    let image: String
    let sides: Int
}

extension Die {
    static func roll(_ type: DieType) -> Die {
        switch type {
        case .d4:
            let result = Int.random(in: 1...4)
            return Die(value: result, image: "\(result).circle", sides: 4)
        case .d6:
            let result = Int.random(in: 1...6)
            return Die(value: result, image: "die.face.\(result)", sides: 6)
        case .d8:
            let result = Int.random(in: 1...8)
            return Die(value: result, image: "\(result).circle", sides: 8)
        case .d12:
            let result = Int.random(in: 1...12)
            return Die(value: result, image: "\(result).circle", sides: 12)
        case .d20:
            let result = Int.random(in: 1...20)
            return Die(value: result, image: "\(result).circle", sides: 20)
        case .d100:
            let result = Int.random(in: 1...100)
            return Die(value: result, image: "number.square", sides: 100)
        }
    }
}
