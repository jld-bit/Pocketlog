import SwiftData
import SwiftUI

@main
struct PocketLogApp: App {
    @State private var modelContainer = SharedModelContainer.make()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
                .task {
                    await BudgetReminderManager.requestAuthorizationIfNeeded()
                    BudgetReminderManager.scheduleDailyReminder(hour: 20, minute: 0)
                }
        }
        .onChange(of: scenePhase) { _, newPhase in
            guard newPhase == .background else { return }
            WidgetRefresh.reloadWidgets()
        }
    }
}
