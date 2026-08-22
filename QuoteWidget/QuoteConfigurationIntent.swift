import WidgetKit
import AppIntents
import SwiftUI

struct QuoteConfigurationIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Quote Settings"
    static var description = IntentDescription("Customize the text, font, color, and background of your quote widget.")

    @Parameter(title: "Quote Text", default: "Stay hungry, stay foolish.")
    var quoteText: String

    @Parameter(title: "Font", default: .system)
    var fontChoice: FontOption

    @Parameter(title: "Text Color", default: .black)
    var textColor: ColorOption

    @Parameter(title: "Background Opacity (0 = fully see-through)", default: 0.0)
    var backgroundOpacity: Double
}

enum FontOption: String, AppEnum {
    case system, serif, rounded, monospaced, handwriting

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Font")
    static var caseDisplayRepresentations: [FontOption: DisplayRepresentation] = [
        .system: "System",
        .serif: "Serif",
        .rounded: "Rounded",
        .monospaced: "Monospaced",
        .handwriting: "Handwriting"
    ]

    var design: Font.Design {
        switch self {
        case .system: return .default
        case .serif: return .serif
        case .rounded: return .rounded
        case .monospaced: return .monospaced
        case .handwriting: return .default
        }
    }
}

enum ColorOption: String, AppEnum {
    case white, black, red, orange, yellow, green, blue, purple, gray

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Color")
    static var caseDisplayRepresentations: [ColorOption: DisplayRepresentation] = [
        .white: "White",
        .black: "Black",
        .red: "Red",
        .orange: "Orange",
        .yellow: "Yellow",
        .green: "Green",
        .blue: "Blue",
        .purple: "Purple",
        .gray: "Gray"
    ]

    var color: Color {
        switch self {
        case .white: return .white
        case .black: return .black
        case .red: return .red
        case .orange: return .orange
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        case .purple: return .purple
        case .gray: return .gray
        }
    }
}
