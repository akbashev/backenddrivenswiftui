//
//  JSONView.swift
//  backenddrivenswiftui (iOS)
//
//  Created by Jaleel Akbashev on 10.03.21.
//

import SwiftUI
import Kingfisher

public struct CodableView: Codable, View, Identifiable {
    
    public struct Properties: Codable {
        
        public struct Border: Codable {
            let color: String?
            let width: Float?
        }
        
        public struct Padding: Codable {
            let top: Float?
            let bottom: Float?
            let left: Float?
            let right: Float?
            
            public func convert() -> EdgeInsets {
                return EdgeInsets(top: top.map { CGFloat($0) } ?? 0.0,
                                  leading: left.map { CGFloat($0) } ?? 0.0,
                                  bottom: bottom.map { CGFloat($0) } ?? 0.0,
                                  trailing: right.map { CGFloat($0) } ?? 0.0)
            }
        }
        
        public struct Frame: Codable {
            let width: Float?
            let height: Float?
            let alignment: Alignment?
        }
        
        public struct PositionFrame: Codable {
            
            private static let infinity: String = "infinity"

            let minWidth: Float?
            let idealWidth: Float?
            let maxWidth: Float?
            let minHeight: Float?
            let idealHeight: Float?
            let maxHeight: Float?
            let alignment: Alignment?
            
            var isWidthInfinite: Bool = false
            var isHeightInfinite: Bool = false
            
            enum CodingKeys: String, CodingKey {
                case maxWidth
                case maxHeight

                case minWidth
                case minHeight

                case idealWidth
                case idealHeight
                
                case alignment
            }
            
            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                do {
                    let width = try container.decode(String.self, forKey: .maxWidth)
                    switch width {
                    case PositionFrame.infinity:
                        self.isWidthInfinite = true
                    default:
                        break
                    }
                    self.maxWidth = nil
                } catch {
                    self.maxWidth = try container.decodeIfPresent(Float.self, forKey: .maxWidth)
                }
                
                do {
                    let width = try container.decode(String.self, forKey: .maxHeight)
                    switch width {
                    case PositionFrame.infinity:
                        self.isHeightInfinite = true
                    default:
                        break
                    }
                    self.maxHeight = nil
                } catch {
                    self.maxHeight = try container.decodeIfPresent(Float.self, forKey: .maxHeight)
                }
                
                self.minWidth = try container.decodeIfPresent(Float.self, forKey: .minWidth)
                self.minHeight = try container.decodeIfPresent(Float.self, forKey: .minHeight)
                self.idealWidth = try container.decodeIfPresent(Float.self, forKey: .idealWidth)
                self.idealHeight = try container.decodeIfPresent(Float.self, forKey: .idealHeight)
                self.alignment = try container.decodeIfPresent(Alignment.self, forKey: .alignment)
            }
            
            public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                if self.isWidthInfinite {
                    try container.encode(PositionFrame.infinity, forKey: .maxWidth)
                } else {
                    try container.encodeIfPresent(self.maxWidth, forKey: .maxWidth)
                }
                if self.isHeightInfinite {
                    try container.encode(PositionFrame.infinity, forKey: .maxHeight)
                } else {
                    try container.encodeIfPresent(self.maxHeight, forKey: .maxHeight)
                }
                
                try container.encodeIfPresent(self.minWidth, forKey: .minWidth)
                try container.encodeIfPresent(self.minHeight, forKey: .minHeight)
                try container.encodeIfPresent(self.idealWidth, forKey: .idealWidth)
                try container.encodeIfPresent(self.idealHeight, forKey: .idealHeight)
                try container.encodeIfPresent(self.alignment, forKey: .alignment)
            }
        }
        
        public enum HorizontalAlignment: String, Codable {
            case left
            case center
            case right
            
            public func convert() -> SwiftUI.HorizontalAlignment {
                switch self {
                case .left:
                    return .leading
                case .center:
                    return .center
                case .right:
                    return .trailing
                }
            }
        }
        
        public enum VerticalAlignment: String, Codable {
            case top
            case bottom
            case center
            case firstTextBaseline
            case lastTextBaseline
            
            public func convert() -> SwiftUI.VerticalAlignment {
                switch self {
                case .top:
                    return .top
                case .bottom:
                    return .bottom
                case .center:
                    return .center
                case .firstTextBaseline:
                    return .firstTextBaseline
                case .lastTextBaseline:
                    return .lastTextBaseline
                }
            }
        }
        
        public enum Alignment: String, Codable {
            case bottom
            case bottomLeft
            case bottomRight
            case center
            case left
            case top
            case topLeft
            case topRight
            case right
            
            public func convert() -> SwiftUI.Alignment {
                switch self {
                case .bottom:
                    return .bottom
                case .bottomLeft:
                    return .bottomLeading
                case .bottomRight:
                    return .bottomTrailing
                case .center:
                    return .center
                case .left:
                    return .leading
                case .top:
                    return .top
                case .topLeft:
                    return .topLeading
                case .topRight:
                    return .topTrailing
                case .right:
                    return .trailing
                }
            }
        }
        
        public enum Axis: String, Codable {
            case vertical
            case horizontal
            
            public func convert() -> SwiftUI.Axis.Set {
                switch self {
                case .horizontal:
                    return .horizontal
                case .vertical:
                    return .vertical
                }
            }
        }
        
        public enum Font: String, Codable {
            case largeTitle
            case title
            case headline
            case subheadline
            case body
            case callout
            case footnote
            case caption
            
            public func convert() -> SwiftUI.Font {
                switch self {
                case .largeTitle:
                    return .largeTitle
                case .title:
                    return .title
                case .headline:
                    return .headline
                case .subheadline:
                    return .subheadline
                case .body:
                    return .body
                case .callout:
                    return .callout
                case .footnote:
                    return .footnote
                case .caption:
                    return .caption
                }
            }
        }
        
        public enum FontWeight: String, Codable {
            case ultraLight
            case thin
            case light
            case regular
            case medium
            case semibold
            case bold
            case heavy
            case black
            
            public func convert() -> SwiftUI.Font.Weight {
                switch self {
                case .ultraLight:
                    return .ultraLight
                case .thin:
                    return .thin
                case .light:
                    return .light
                case .regular:
                    return .regular
                case .medium:
                    return .medium
                case .semibold:
                    return .semibold
                case .bold:
                    return .bold
                case .heavy:
                    return .heavy
                case .black:
                    return .black
                }
            }
        }
        
        
        let border: Border?
        let padding: Padding?
        let frame: Frame?
        let positionFrame: PositionFrame?
        
        let horizontalAlignment: HorizontalAlignment?
        let verticalAlignment: VerticalAlignment?
        let alignment: Alignment?
        
        let axis: Axis?
        let font: Font?
        let fontWeight: FontWeight?
        
        let foregroundColor: String?
        let backgroundColor: String?
        
        let spacing: Int?
        let minLength: Float?
        
        let showsIndicators: Bool?
    }
    
    
    struct Value: Codable {
        enum ImageType: String, Codable {
            case url
            case local
            case system
        }
        
        var text: String?
        var imageUrl: String?
        var imageType: ImageType?
    }
    
    
    enum ViewType: String, Codable {
        case Image
        case Text
        case HStack
        case VStack
        case ZStack
        case Rectangle
        case Circle
        case Spacer
        case Divider
        case List
        case ScrollView
    }
    
    public var id = UUID()
    
    var type: ViewType?
    var value: Value?
    var properties: Properties?
    var subviews: [CodableView]?
    
    enum CodingKeys: String, CodingKey {
        case type
        case value
        case properties
        case subviews
    }
    
    public var body: some View {
        self.render()
            .foregroundColor(properties?.foregroundColor.map { Color(hex: $0) })
            .background(properties?.backgroundColor.map { Color(hex: $0) })
            .modifier(FrameModifier(frame: properties?.frame, positionFrame: properties?.positionFrame))
            .modifier(BorderModifier(borderColor: properties?.border?.color.map { Color(hex: $0) }, borderWidth: properties?.border?.width.map { CGFloat($0) }))
            .modifier(PaddingModifier(padding: properties?.padding?.convert()))
    }
    
}

private extension CodableView {
    
    @ViewBuilder func scrollView() -> some View {
        let axis = self.properties?.axis?.convert() ?? .vertical
        let showsIndicators = self.properties?.showsIndicators ?? true
        let spacing = self.properties?.spacing.map { CGFloat($0) }
        let horizontalAlignment = self.properties?.horizontalAlignment?.convert() ?? .center
        let verticalAlignment = self.properties?.verticalAlignment?.convert() ?? .center
        
        ScrollView(axis, showsIndicators: showsIndicators) {
            switch axis {
            case .horizontal:
                HStack(alignment: verticalAlignment, spacing: spacing) {
                    ForEach(subviews ?? []) { $0 }
                }
            default:
                VStack(alignment: horizontalAlignment, spacing: spacing) {
                    ForEach(subviews ?? []) { $0 }
                }
            }
            
        }
    }
    
    @ViewBuilder func list() -> some View {
        List(subviews ?? []) { $0 }
    }
    
    @ViewBuilder func vstack() -> some View {
        let spacing = self.properties?.spacing.map { CGFloat($0) }
        let horizontalAlignment = self.properties?.horizontalAlignment?.convert() ?? .center
        VStack(alignment: horizontalAlignment, spacing: spacing) {
            ForEach(subviews ?? []) { $0 }
        }
    }
    
    @ViewBuilder func hstack() -> some View {
        let spacing = self.properties?.spacing.map { CGFloat($0) }
        let verticalAlignment = self.properties?.verticalAlignment?.convert() ?? .center
        HStack(alignment: verticalAlignment, spacing: spacing) {
            ForEach(subviews ?? []) { $0 }
        }
    }
    
    @ViewBuilder func zstack() -> some View {
        let overlayAlignment = self.properties?.alignment?.convert() ?? .center
        ZStack(alignment: overlayAlignment) {
            ForEach(subviews ?? []) { $0 }
        }
    }
    
    @ViewBuilder func text() -> some View {
        let font = self.properties?.font?.convert()
        let fontWeight = self.properties?.fontWeight?.convert()
        Text(self.value?.text ?? "")
            .font(font)
            .fontWeight(fontWeight)
    }
    
    @ViewBuilder func image() -> some View {
        let url = self.value?.imageUrl ?? ""
        switch self.value?.imageType {
        case .system:
            Image(systemName: url)
                .resizable()
                .scaledToFit()
        case .local:
            Image(url)
                .resizable()
                .scaledToFit()
        case .url:
            KFImage(URL(string: url))
                .resizable()
                .scaledToFit()
        case .none:
            Text.parsingErrorText
        }
        
    }
    
    @ViewBuilder func spacer() -> some View {
        let minLength = self.properties?.minLength.map { CGFloat($0) }
        Spacer(minLength: minLength)
    }
    
    @ViewBuilder func render() -> some View {
        switch self.type {
        case .ScrollView: scrollView()
        case .List: list()
        case .VStack: vstack()
        case .HStack: hstack()
        case .ZStack: zstack()
        case .Text: text()
        case .Image: image()
        case .Spacer: spacer()
        case .Rectangle: Rectangle()
        case .Divider: Divider()
        case .Circle: Circle()
        default: EmptyView()
        }
    }

}

private extension Text {
    static var parsingErrorText = Text("Parsing error.")
}
