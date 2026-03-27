import Foundation
import UserNotifications

enum BudgetReminderManager {
    private static let reminderIdentifier = "daily-budget-reminder"

    static func requestAuthorizationIfNeeded() async {
        do {
            let center = UNUserNotificationCenter.current()
            let settings = await center.notificationSettings()

            guard settings.authorizationStatus == .notDetermined else { return }

            _ = try await center.requestAuthorization(options: [.alert, .badge, .sound])
        } catch {
            print("Notification permission request failed: \(error)")
        }
    }

    static func scheduleDailyReminder(hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = "PocketLog"
        content.body = "Quick check-in: log today's spending to stay on budget."
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: reminderIdentifier, content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [reminderIdentifier])
        center.add(request)
    }
}
