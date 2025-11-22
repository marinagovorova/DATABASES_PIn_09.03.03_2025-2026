//
//  NutrientProgressBar.swift
//  Lumo
//
//  Created by Matvey Veselkov on 22.11.2025.
//
import SwiftUI

struct NutrientProgressBar: View {
    let nutrient: NutrientData
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(nutrient.name)
                .font(.system(size: 13, weight: .medium))
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 6)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(
                            width: geometry.size.width * nutrient.progress,
                            height: 6
                        )
                        .animation(.easeInOut(duration: 0.6), value: nutrient.progress)
                }
            }
            .frame(height: 6)
            
            Text(nutrient.displayText)
                .font(.system(size: 11))
                .foregroundColor(.secondary)
        }
    }
}

