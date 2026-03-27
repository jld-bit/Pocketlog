import Foundation
import SwiftData

@Model
final class ExpenseLog {
    var id: UUID
    var amount: Decimal
    var note: String
    var createdAt: Date

    init(id: UUID = UUID(), amount: Decimal, note: String = "Quick Log", createdAt: Date = .now) {
        self.id = id
        self.amount = amount
        self.note = note
        self.createdAt = createdAt
    }
}
