//
//  CircularProgressView.swift
//  Lumo
//
//  Created by Matvey Veselkov on 22.11.2025.
//
import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    let lineWidth: CGFloat
    let progressColor: Color
    let backgroundColor: Color
    
    init(
        progress: Double,
        lineWidth: CGFloat = 18,
        progressColor: Color = Color.green.opacity(0.85),
        backgroundColor: Color = Color.gray.opacity(0.15)
    ) {
        self.progress = min(max(progress, 0), 1)
        self.lineWidth = lineWidth
        self.progressColor = progressColor
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(backgroundColor, lineWidth: lineWidth)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    progressColor,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.8), value: progress)
        }
    }
}

#Preview {
    CircularProgressView(progress: 0.65)
        .frame(width: 140, height: 140)
        .padding()
}
