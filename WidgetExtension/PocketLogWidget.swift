import SwiftUI
import SwiftData
import WidgetKit

struct PocketLogEntry: TimelineEntry {
    let date: Date
    let todayTotal: Decimal
}

struct PocketLogProvider: TimelineProvider {
    func placeholder(in context: Context) -> PocketLogEntry {
        PocketLogEntry(date: .now, todayTotal: 42)
    }

    func getSnapshot(in context: Context, completion: @escaping (PocketLogEntry) -> Void) {
        completion(PocketLogEntry(date: .now, todayTotal: fetchTodayTotal()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PocketLogEntry>) -> Void) {
        let entry = PocketLogEntry(date: .now, todayTotal: fetchTodayTotal())
        let nextRefresh = Calendar.current.date(byAdding: .minute, value: 15, to: .now) ?? .now.addingTimeInterval(900)
        completion(Timeline(entries: [entry], policy: .after(nextRefresh)))
    }

    private func fetchTodayTotal() -> Decimal {
        let container = SharedModelContainer.make()
        let context = container.mainContext

        var descriptor = FetchDescriptor<ExpenseLog>(
            sortBy: [SortDescriptor(\ExpenseLog.createdAt, order: .reverse)]
        )

        let startOfDay = Calendar.current.startOfDay(for: .now)
        descriptor.predicate = #Predicate { log in
            log.createdAt >= startOfDay
        }

        do {
            let logs = try context.fetch(descriptor)
            return logs.reduce(Decimal.zero) { $0 + $1.amount }
        } catch {
            return .zero
        }
    }
}

struct PocketLogWidgetEntryView: View {
    var entry: PocketLogProvider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("TODAY")
                .font(.system(size: 16, weight: .heavy, design: .rounded))
                .foregroundStyle(PocketTheme.cyberOrange)

            Text("$\(entry.todayTotal.description)")
                .font(.system(size: 30, weight: .black, design: .rounded))
                .foregroundStyle(PocketTheme.cyberOrange)
                .minimumScaleFactor(0.6)

            Spacer(minLength: 0)

            Button(intent: QuickLogTenDollarsIntent()) {
                Text("Quick Log $10")
                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(PocketTheme.cyberOrange)
        }
        .padding()
        .containerBackground(for: .widget) {
            Color.white
        }
    }
}

struct PocketLogWidget: Widget {
    let kind: String = "PocketLogWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PocketLogProvider()) { entry in
            PocketLogWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("PocketLog Quick Entry")
        .description("Log $10 instantly without opening the app.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
