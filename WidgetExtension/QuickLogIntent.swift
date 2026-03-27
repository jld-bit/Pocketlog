import AppIntents
import SwiftData

struct QuickLogTenDollarsIntent: AppIntent {
    static let title: LocalizedStringResource = "Quick Log $10"
    static let description = IntentDescription("Adds a $10 entry instantly to PocketLog.")
    static var openAppWhenRun = false

    @MainActor
    func perform() async throws -> some IntentResult {
        let container = SharedModelContainer.make()
        let context = container.mainContext
        context.insert(ExpenseLog(amount: 10, note: "Widget Quick Log"))
        try context.save()
        WidgetRefresh.reloadWidgets()
        return .result()
    }
}
