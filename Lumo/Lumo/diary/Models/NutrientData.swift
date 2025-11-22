//
//  NutrientData.swift
//  Lumo
//
//  Created by Matvey Veselkov on 22.11.2025.
//
import Foundation

struct NutrientData {
    let name: String
    let current: Int
    let goal: Int
    
    var progress: Double {
        guard goal > 0 else { return 0 }
        return min(Double(current) / Double(goal), 1.0)
    }
    
    var displayText: String {
        "\(current)/\(goal)"
    }
}

