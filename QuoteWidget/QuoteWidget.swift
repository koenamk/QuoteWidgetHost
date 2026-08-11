import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> QuoteEntry {
        QuoteEntry(date: Date(), configuration: QuoteConfigurationIntent())
    }

    func snapshot(for configuration: QuoteConfigurationIntent, in context: Context) async -> QuoteEntry {
        QuoteEntry(date: Date(), configuration: configuration)
    }

    func timeline(for configuration: QuoteConfigurationIntent, in context: Context) async -> Timeline<QuoteEntry> {
        // .never means it only redraws when you edit it — nothing runs in the background.
        Timeline(entries: [QuoteEntry(date: Date(), configuration: configuration)], policy: .never)
    }
}

struct QuoteEntry: TimelineEntry {
    let date: Date
    let configuration: QuoteConfigurationIntent
}

struct QuoteWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.configuration.quoteText)
            .font(fontFor(entry.configuration.fontChoice))
            .foregroundColor(entry.configuration.textColor.color)
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .containerBackground(for: .widget) {
                Color.black.opacity(entry.configuration.backgroundOpacity)
            }
    }

    func fontFor(_ option: FontOption) -> Font {
        if option == .handwriting {
            return .custom("Marker Felt", size: 20)
        }
        return .system(size: 20, weight: .medium, design: option.design)
    }
}

struct QuoteWidget: Widget {
    let kind: String = "QuoteWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: QuoteConfigurationIntent.self, provider: Provider()) { entry in
            QuoteWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Quote")
        .description("A customizable quote for your desktop.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

@main
struct QuoteWidgetBundle: WidgetBundle {
    var body: some Widget {
        QuoteWidget()
    }
}
