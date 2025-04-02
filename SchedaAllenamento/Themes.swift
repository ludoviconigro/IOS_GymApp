import SwiftUI


enum AppTheme: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }

    var label: String {
        switch self {
        case .system: return "Sistema"
        case .light: return "Chiaro"
        case .dark: return "Scuro"
        }
    }
}

enum AppColorTheme: String, CaseIterable, Identifiable {
    case blue, green, red, orange, purple

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .blue: return .blue
        case .green: return .green
        case .red: return .red
        case .orange: return .orange
        case .purple: return .purple
        }
    }

    var label: String {
        switch self {
        case .blue: return "Blu"
        case .green: return "Verde"
        case .red: return "Rosso"
        case .orange: return "Arancione"
        case .purple: return "Viola"
        }
    }
}
