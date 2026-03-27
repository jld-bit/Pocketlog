import Foundation
import SwiftData

enum SharedModelContainer {
    static func make(inMemory: Bool = false) -> ModelContainer {
        do {
            let schema = Schema([ExpenseLog.self])
            let configuration = ModelConfiguration(
                schema: schema,
                url: inMemory ? nil : AppGroup.storeURL(),
                allowsSave: true,
                isStoredInMemoryOnly: inMemory
            )
            return try ModelContainer(for: schema, configurations: configuration)
        } catch {
            fatalError("Failed to initialize shared model container: \(error)")
        }
    }
}
