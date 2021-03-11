//
//  FrameModifier.swift
//  backenddrivenswiftui
//
//  Created by Jaleel Akbashev on 10.03.21.
//

import SwiftUI

struct FrameModifier: ViewModifier {
    
    var frame: CodableView.Properties.Frame?
    var positionFrame:  CodableView.Properties.PositionFrame?

    @ViewBuilder func body(content: Content) -> some View {
        if let frame = self.frame {
            content.frame(width: frame.width.map { CGFloat($0) },
                           height: frame.height.map { CGFloat($0) },
                           alignment: frame.alignment?.convert() ?? .center)
        } else if let positionFrame = self.positionFrame {
            let maxWidth: CGFloat? = positionFrame.isWidthInfinite ? CGFloat.infinity : positionFrame.maxWidth.map { CGFloat($0) }
            let maxHeight: CGFloat? = positionFrame.isHeightInfinite ? CGFloat.infinity : positionFrame.maxHeight.map { CGFloat($0) }
            content.frame(minWidth: positionFrame.minWidth.map { CGFloat($0) },
                           idealWidth: positionFrame.idealWidth.map { CGFloat($0) },
                           maxWidth: maxWidth,
                           minHeight: positionFrame.minHeight.map { CGFloat($0) },
                           idealHeight: positionFrame.idealHeight.map { CGFloat($0) },
                           maxHeight: maxHeight,
                           alignment: positionFrame.alignment?.convert() ?? .center)
        } else {
            content
        }
    }
}

/// Applies Padding for all edges in case `padding` is not nil.
struct PaddingModifier: ViewModifier {
    var padding: EdgeInsets?
    
    @ViewBuilder func body(content: Content) -> some View {
        if let padding = padding {
            content.padding(padding)
        } else {
            content
        }
    }
}

struct BorderModifier: ViewModifier {
    var borderColor: Color?
    var borderWidth: CGFloat?

    @ViewBuilder func body(content: Content) -> some View {
        if let borderColor = borderColor {
            content.border(borderColor, width: borderWidth ?? 0)
        } else {
            content
        }
    }
}
