//
//  DailyStats.swift
//  Lumo
//
//  Created by Matvey Veselkov on 22.11.2025.
//
import Foundation

struct DailyStats {
    var consumed: Int
    var burned: Int
    var goal: Int
    
    var remaining: Int {
        goal - consumed + burned
    }
    
    var progress: Double {
        guard goal > 0 else { return 0 }
        return min(Double(consumed) / Double(goal), 1.0)
    }
}

