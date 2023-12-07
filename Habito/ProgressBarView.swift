//
//  ProgressBarView.swift
//  MultiplicationLab
//
//  Created by Maks Winters on 13.11.2023.
//

import SwiftUI

struct ProgressBarView: View {
    
    var progress: Double
    var total: Double
    
    var body: some View {
        ProgressView(value: progress, total: total)
            .tint(.purple)
            .padding()
            .progressViewStyle(BarProgressStyle())
            .frame(height: 50)
    }
}

struct BarProgressStyle: ProgressViewStyle {
    
    @State var color: Color = .green
    var height: Double = 10.0
    var labelFontStyle: Font = .body
    
    @ViewBuilder func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                configuration.label
                    .font(labelFontStyle)
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(.white)
                    .opacity(0.5)
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                    }
                VStack {
                    Image(systemName: "arrowtriangle.up.fill")
                    let percentage = String(format: "%.0f%%", progress * 100)
                    Text(percentage)
                        .contentTransition(.numericText(value: Double(percentage) ?? 10))
                }
                .offset(CGSize(width: geometry.size.width * progress - 15, height: 10.0))
            }
        }
    }
}

#Preview {
    ProgressBarView(progress: 5, total: 7)
}
