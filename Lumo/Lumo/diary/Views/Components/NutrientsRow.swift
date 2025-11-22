//
//  NutrientsRow.swift
//  Lumo
//
//  Created by Matvey Veselkov on 22.11.2025.
//
import SwiftUI

struct NutrientsRow: View {
    let protein: NutrientData
    let fat: NutrientData
    let carbs: NutrientData
    
    var body: some View {
        HStack(spacing: 16) {
            NutrientProgressBar(nutrient: protein, color: .green)
            NutrientProgressBar(nutrient: fat, color: .green)
            NutrientProgressBar(nutrient: carbs, color: .green)
        }
        .padding(.horizontal, 4)
    }
}

