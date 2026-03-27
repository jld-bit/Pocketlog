import Foundation

enum AppGroup {
    static let identifier = "group.com.example.pocketlog"
    static let storeFileName = "PocketLog.sqlite"

    static func storeURL() -> URL {
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: identifier) else {
            fatalError("App Group container not found. Set up group: \(identifier)")
        }

        return containerURL.appending(path: storeFileName)
    }
}
