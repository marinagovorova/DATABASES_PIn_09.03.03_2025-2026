//
//  MealData.swift
//  Lumo
//
//  Created by Matvey Veselkov on 22.11.2025.
//
import Foundation

struct MealData: Identifiable {
    let id = UUID()
    let name: String
    var calories: Int
    var protein: Int
    var fat: Int
    var carbs: Int
    
    var percentage: Int {
        guard calories > 0 else { return 0 }
        return Int((Double(calories) / 2000.0) * 100)
    }
    
    var isEmpty: Bool {
        calories == 0
    }
}

