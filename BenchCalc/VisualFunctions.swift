//
//  VisualFunctions.swift
//  BenchCalc
//
//  Created by zma on 3/5/25.
//

import Foundation
import SwiftUI

struct ExpandViewer <Content: View>: View {
    
    @State private var isExpanded = false
    @ViewBuilder let expandableView : Content
    
    var body: some View {
        VStack {
            
            Button(action: {
                withAnimation(.easeIn(duration: 0.15)) {
                    self.isExpanded.toggle()
                }
                
            }){
                Text(self.isExpanded ? "Hide" : "View")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 40, alignment: .center)
                    .background(.blue)
                    .cornerRadius(5.0)
//                    .padding()
            }
            
            if self.isExpanded {
                 self.expandableView
            }
            
        }
       
    }
}

// ExpandableTextView.swift

import SwiftUI

public struct ExpandableText: View {
    var text : String
    
    var font: Font = .body
    var lineLimit: Int = 3
    var foregroundColor: Color = .primary
    
    var expandButton: TextSet = TextSet(text: "more", font: .callout, color: .blue)
    var collapseButton: TextSet? = TextSet(text: "collapse", font: .callout, color: .blue)
    
    var animation: Animation? = .none
    
    @State private var expand : Bool = false
    @State private var truncated : Bool = false
    @State private var fullSize: CGFloat = 0
    
    public init(text: String) {
        self.text = text
    }
    public var body: some View {
        ZStack(alignment: .bottomTrailing){
            Group {
                Text(text)
            }
                .font(font)
                .foregroundColor(foregroundColor)
                .lineLimit(expand == true ? nil : lineLimit)
                .animation(animation, value: expand)
                .mask(
                    VStack(spacing: 0){
                        Rectangle()
                            .foregroundColor(.black)
                        
                        HStack(spacing: 0){
                            Rectangle()
                                .foregroundColor(.black)
                            if truncated{
                                if !expand {
                                    HStack(alignment: .bottom,spacing: 0){
                                        LinearGradient(
                                            gradient: Gradient(stops: [
                                                Gradient.Stop(color: .black, location: 0),
                                                Gradient.Stop(color: .clear, location: 0.8)]),
                                            startPoint: .leading,
                                            endPoint: .trailing)
                                            .frame(width: 32, height: expandButton.text.height(usingFont: fontToUIFont(font: expandButton.font)))
                                        
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: expandButton.text.width(usingFont: fontToUIFont(font: expandButton.font)), alignment: .center)
                                    }
                                }
                                else if let collapseButton = collapseButton {
                                    HStack(alignment: .bottom,spacing: 0){
                                        LinearGradient(
                                            gradient: Gradient(stops: [
                                                Gradient.Stop(color: .black, location: 0),
                                                Gradient.Stop(color: .clear, location: 0.8)]),
                                            startPoint: .leading,
                                            endPoint: .trailing)
                                            .frame(width: 32, height: collapseButton.text.height(usingFont: fontToUIFont(font: collapseButton.font)))
                                        
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: collapseButton.text.width(usingFont: fontToUIFont(font: collapseButton.font)), alignment: .center)
                                    }
                                }
                            }
                        }
                        .frame(height: expandButton.text.height(usingFont: fontToUIFont(font: font)))
                    }
                )
            
            if truncated {
                if let collapseButton = collapseButton {
                    Button(action: {
                        self.expand.toggle()
                    }, label: {
                        Text(expand == false ? expandButton.text : collapseButton.text)
                            .font(expand == false ? expandButton.font : collapseButton.font)
                            .foregroundColor(expand == false ? expandButton.color : collapseButton.color)
                    })
                }
                else if !expand {
                    Button(action: {
                        self.expand = true
                    }, label: {
                        Text(expandButton.text)
                            .font(expandButton.font)
                            .foregroundColor(expandButton.color)
                    })
                }
            }
        }
        .background(
            ZStack{
                if !truncated {
                    if fullSize != 0 {
                        Text(text)
                            .font(font)
                            .lineLimit(lineLimit)
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            if fullSize > geo.size.height {
                                                self.truncated = true
                                                print(geo.size.height)
                                            }
                                        }
                                }
                            )
                    }
                    
                    Text(text)
                        .font(font)
                        .lineLimit(999)
                        .fixedSize(horizontal: false, vertical: true)
                        .background(GeometryReader { geo in
                            Color.clear
                                .onAppear() {
                                    self.fullSize = geo.size.height
                                }
                        })
                }
            }
                .hidden()
        )
    }
}

import SwiftUI
import Foundation

// MARK: - ExpandableText Extension

extension ExpandableText {
    // Modify font
    public func font(_ font: Font) -> Self {
        var result = self
        result.font = font
        return result
    }
    
    // Modify line limit
    public func lineLimit(_ lineLimit: Int) -> Self {
        var result = self
        result.lineLimit = lineLimit
        return result
    }
    
    // Modify foreground color
    public func foregroundColor(_ color: Color) -> Self {
        var result = self
        result.foregroundColor = color
        return result
    }
    
    // Modify expand button
    public func expandButton(_ expandButton: TextSet) -> Self {
        var result = self
        result.expandButton = expandButton
        return result
    }
    
    // Modify collapse button
    public func collapseButton(_ collapseButton: TextSet) -> Self {
        var result = self
        result.collapseButton = collapseButton
        return result
    }
    
    // Modify expand animation
    public func expandAnimation(_ animation: Animation?) -> Self {
        var result = self
        result.animation = animation
        return result
    }
}

// MARK: - String Extension

extension String {
    // Measure height of string
    func height(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes).height
    }
    
    // Measure width of string
    func width(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes).width
    }
}

// MARK: - TextSet Struct

public struct TextSet {
    var text: String
    var font: Font
    var color: Color

    public init(text: String, font: Font, color: Color) {
        self.text = text
        self.font = font
        self.color = color
    }
}

// MARK: - Font Conversion Function

func fontToUIFont(font: Font) -> UIFont {
    switch font {
    case .largeTitle: return .preferredFont(forTextStyle: .largeTitle)
    case .title: return .preferredFont(forTextStyle: .title1)
    case .title2, .title3: return .preferredFont(forTextStyle: .title2)
    case .headline: return .preferredFont(forTextStyle: .headline)
    case .subheadline: return .preferredFont(forTextStyle: .subheadline)
    case .callout: return .preferredFont(forTextStyle: .callout)
    case .caption: return .preferredFont(forTextStyle: .caption1)
    case .caption2, .footnote, .body: return .preferredFont(forTextStyle: .caption2)
    default: return .preferredFont(forTextStyle: .caption2)
    }
}

struct ContentView: View {
    var body: some View {
        ExpandableText(text: "Being a top 1% developer isn’t just about mastering Swift, SwiftUI, and Xcode. It’s also about having a solid grasp of various languages, allowing you to blend them together to streamline your iOS project development.")
            .font(.body)
            .foregroundColor(.primary)
            .lineLimit(3)
            .expandButton(TextSet(text: "more", font: .body, color: .blue))
            .collapseButton(TextSet(text: "collapse", font: .body, color: .blue))
            .expandAnimation(.easeOut)
            .padding(.horizontal, 24)
        /* All these modifiers are optional !!*/
        
        
        ExpandViewer {
            Text("Workout Notes")
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        }
    }
}
