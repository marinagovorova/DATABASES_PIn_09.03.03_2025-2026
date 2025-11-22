//
//  CalorieRingView.swift
//  Lumo
//
//  Created by Matvey Veselkov on 22.11.2025.
//
import SwiftUI

struct CalorieRingView: View {
    let dailyStats: DailyStats
    
    var body: some View {
        ZStack {
            // === ФОН (Светлый мятно-зеленый градиент) ===
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.42, green: 0.82, blue: 0.62), // Мятный
                        Color(red: 0.28, green: 0.68, blue: 0.48)  // Изумрудный
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Блик в центре
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.4),
                        Color.white.opacity(0.1),
                        Color.clear
                    ]),
                    center: .center,
                    startRadius: 10,
                    endRadius: 220
                )
                .blendMode(.overlay)
            }
            .cornerRadius(24)
            .shadow(color: Color.green.opacity(0.25), radius: 12, x: 0, y: 6)
            
            // === КОНТЕНТ ===
            VStack(spacing: 25) {
                // ВЕРХНЯЯ ЧАСТЬ (Цифры и Круг)
                HStack(alignment: .center, spacing: 10) {
                    
                    // СЪЕДЕНО
                    VStack(spacing: 2) {
                        Text("\(dailyStats.consumed)")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.05, green: 0.2, blue: 0.05)) // Темно-зеленый
                        Text("Съедено")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.05, green: 0.2, blue: 0.05).opacity(0.6))
                    }
                    .frame(width: 80)
                    
                    // КРУГ
                    ZStack {
                        // Подложка круга
                        Circle()
                            .stroke(Color.white.opacity(0.35), lineWidth: 18)
                            .frame(width: 140, height: 140)
                        
                        // Индикатор прогресса
                        Circle()
                            .trim(from: 0.0, to: dailyStats.progress)
                            .stroke(
                                Color(red: 0.1, green: 0.75, blue: 0.3), // Яркий зеленый
                                style: StrokeStyle(lineWidth: 18, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                            .frame(width: 140, height: 140)
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                        
                        // Текст внутри
                        VStack(spacing: 0) {
                            Text("\(dailyStats.remaining)")
                                .font(.system(size: 34, weight: .bold, design: .rounded))
                                .foregroundColor(.black.opacity(0.9))
                            Text("осталось")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.black.opacity(0.6))
                        }
                    }
                    
                    // СОЖЖЕНО
                    VStack(spacing: 2) {
                        Text("\(dailyStats.burned)")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.05, green: 0.2, blue: 0.05))
                        Text("Сожжено")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.05, green: 0.2, blue: 0.05).opacity(0.6))
                    }
                    .frame(width: 80)
                }
                .padding(.top, 20)
                
                // НИЖНЯЯ ЧАСТЬ (БЖУ - Белки, Жиры, Углеводы)
                HStack(spacing: 12) {
                    NutrientBarView(
                        name: "Белки",
                        current: 25,
                        max: 110,
                        color: Color(red: 0.1, green: 0.75, blue: 0.3)
                    )
                    NutrientBarView(
                        name: "Жиры",
                        current: 20,
                        max: 55,
                        color: Color(red: 0.1, green: 0.75, blue: 0.3)
                    )
                    NutrientBarView(
                        name: "Углеводы",
                        current: 55,
                        max: 230,
                        color: Color(red: 0.1, green: 0.75, blue: 0.3)
                    )
                }
                .padding(.bottom, 25)
                .padding(.horizontal, 20)
            }
        }
    }
}

// Внутренний компонент для полосок БЖУ
struct NutrientBarView: View {
    let name: String
    let current: Int
    let max: Int
    let color: Color
    
    var progress: Double { Double(current) / Double(max) }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(name)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(red: 0.05, green: 0.15, blue: 0.05)) // Темный текст
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Фон полоски
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.black.opacity(0.08))
                        .frame(height: 7)
                    
                    // Заполнение
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(width: geometry.size.width * progress, height: 7)
                }
            }
            .frame(height: 7)
            
            Text("\(current)/\(max)")
                .font(.system(size: 12))
                .foregroundColor(Color.black.opacity(0.5))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CalorieRingView(dailyStats: DailyStats(consumed: 500, burned: 250, goal: 1950))
        .padding()
}




