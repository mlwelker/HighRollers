
import SwiftData
import SwiftUI

@main
struct HighRollersApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: RollResult.self)
    }
}
