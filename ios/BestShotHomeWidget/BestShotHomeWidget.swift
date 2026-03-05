import SwiftUI
import WidgetKit
import UIKit

private enum WidgetConfig {
  static let kind = "BestShotHomeWidget"
  static let appGroupId = "group.com.douggy.bestshot"
}

private enum WidgetKeys {
  static let imagePath = "bestshot_widget_image_path"
  static let caption = "bestshot_widget_caption"
  static let layout = "bestshot_widget_layout"
  static let preset = "bestshot_widget_preset"
  static let updatedAt = "bestshot_widget_updated_at"
}

struct BestShotWidgetEntry: TimelineEntry {
  let date: Date
  let imagePath: String?
  let caption: String
  let layout: String
  let preset: String
  let updatedAtLabel: String
}

struct BestShotTimelineProvider: TimelineProvider {
  func placeholder(in context: Context) -> BestShotWidgetEntry {
    BestShotWidgetEntry(
      date: Date(),
      imagePath: nil,
      caption: "Your latest BestShot export appears here",
      layout: "vertical_1x4",
      preset: "ratio_4x5",
      updatedAtLabel: "Just now"
    )
  }

  func getSnapshot(
    in context: Context,
    completion: @escaping (BestShotWidgetEntry) -> Void
  ) {
    completion(loadEntry())
  }

  func getTimeline(
    in context: Context,
    completion: @escaping (Timeline<BestShotWidgetEntry>) -> Void
  ) {
    let entry = loadEntry()
    let nextRefresh = Date().addingTimeInterval(15 * 60)
    completion(Timeline(entries: [entry], policy: .after(nextRefresh)))
  }

  private func loadEntry() -> BestShotWidgetEntry {
    let defaults = UserDefaults(suiteName: WidgetConfig.appGroupId)
    let imagePath = defaults?.string(forKey: WidgetKeys.imagePath)
    let caption = defaults?.string(forKey: WidgetKeys.caption) ?? "Export from BestShot"
    let layout = defaults?.string(forKey: WidgetKeys.layout) ?? "vertical_1x4"
    let preset = defaults?.string(forKey: WidgetKeys.preset) ?? "ratio_4x5"
    let updatedAtRaw = defaults?.string(forKey: WidgetKeys.updatedAt)

    let updatedAtLabel: String
    if
      let updatedAtRaw,
      let updatedAtMillis = Double(updatedAtRaw)
    {
      let updatedDate = Date(timeIntervalSince1970: updatedAtMillis / 1000.0)
      let formatter = DateFormatter()
      formatter.dateStyle = .none
      formatter.timeStyle = .short
      formatter.locale = .autoupdatingCurrent
      formatter.timeZone = .autoupdatingCurrent
      updatedAtLabel = formatter.string(from: updatedDate)
    } else {
      updatedAtLabel = "--:--"
    }

    return BestShotWidgetEntry(
      date: Date(),
      imagePath: imagePath,
      caption: caption,
      layout: layout,
      preset: preset,
      updatedAtLabel: updatedAtLabel
    )
  }
}

struct BestShotHomeWidgetEntryView: View {
  @Environment(\.widgetFamily) private var family
  let entry: BestShotWidgetEntry

  var body: some View {
    ZStack {
      Color.white

      switch family {
      case .systemSmall:
        smallView
      default:
        mediumView
      }
    }
  }

  private var smallView: some View {
    VStack(alignment: .leading, spacing: 8) {
      imagePreview(height: 86)
      Text(entry.caption)
        .font(.system(size: 12, weight: .semibold))
        .lineLimit(1)
      Text("Updated \(entry.updatedAtLabel)")
        .font(.system(size: 10))
        .foregroundColor(.secondary)
    }
    .padding(12)
  }

  private var mediumView: some View {
    HStack(spacing: 12) {
      imagePreview(height: 110)
        .frame(width: 110)

      VStack(alignment: .leading, spacing: 6) {
        Text("BestShot")
          .font(.system(size: 16, weight: .bold))
        Text(entry.caption)
          .font(.system(size: 13, weight: .semibold))
          .lineLimit(2)
        Text("Layout: \(entry.layout)")
          .font(.system(size: 11))
          .foregroundColor(.secondary)
        Text("Preset: \(entry.preset)")
          .font(.system(size: 11))
          .foregroundColor(.secondary)
        Spacer()
        Text("Updated \(entry.updatedAtLabel)")
          .font(.system(size: 10))
          .foregroundColor(.secondary)
      }
      Spacer()
    }
    .padding(12)
  }

  @ViewBuilder
  private func imagePreview(height: CGFloat) -> some View {
    if
      let imagePath = entry.imagePath,
      let image = UIImage(contentsOfFile: imagePath)
    {
      Image(uiImage: image)
        .resizable()
        .scaledToFill()
        .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    } else {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.gray.opacity(0.2))
        Image(systemName: "photo")
          .font(.system(size: 18, weight: .medium))
          .foregroundColor(.gray)
      }
      .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
    }
  }
}

struct BestShotHomeWidget: Widget {
  let kind: String = WidgetConfig.kind

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: BestShotTimelineProvider()) { entry in
      BestShotHomeWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("BestShot")
    .description("Shows your latest BestShot export.")
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}
