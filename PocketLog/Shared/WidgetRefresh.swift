import Foundation

#if canImport(WidgetKit)
import WidgetKit
#endif

enum WidgetRefresh {
    static func reloadWidgets() {
        #if canImport(WidgetKit)
        WidgetCenter.shared.reloadAllTimelines()
        #endif
    }
}
