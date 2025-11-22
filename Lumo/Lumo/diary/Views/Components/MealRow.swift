//
//  Untitled.swift
//  Lumo
//
//  Created by Matvey Veselkov on 22.11.2025.
//
import SwiftUI

struct MealRow: View {
    let meal: MealData
    let onAddTap: () -> Void
    let isLast: Bool
    
    // Проверка: если калории > 0, значит элемент активен (зеленый)
    var isActive: Bool { meal.calories > 0 }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 12) {
                
                // 1. Круг
                ZStack {
                    Circle()
                        .fill(
                            isActive
                            // Цвет фона круга (Светло-белый на зеленом фоне)
                            ? Color.white.opacity(0.4)
                            // Серый для неактивных
                            : Color.black.opacity(0.05)
                        )
                        .frame(width: 52, height: 52)
                    
                    VStack(spacing: 0) {
                        Text("\(meal.calories)")
                            .font(.system(size: 15, weight: .bold))
                            // Цвет текста (Темно-зеленый)
                            .foregroundColor(isActive ? Color(red: 0.05, green: 0.2, blue: 0.05) : .secondary)
                        Text("ккал")
                            .font(.system(size: 10))
                            .foregroundColor(isActive ? Color(red: 0.05, green: 0.2, blue: 0.05).opacity(0.6) : .secondary)
                    }
                }
                
                // 2. Название
                Text(meal.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 0.05, green: 0.2, blue: 0.05)) // Темный текст
                    .frame(width: 80, alignment: .leading)
                
                Spacer()
                
                // 3. Цифры БЖУ
                Group {
                    Text("\(meal.protein)").frame(width: 28)
                    Text("\(meal.fat)").frame(width: 28)
                    Text("\(meal.carbs)").frame(width: 28)
                    Text("\(meal.percentage)%").frame(width: 38)
                }
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(red: 0.05, green: 0.2, blue: 0.05).opacity(0.7))
                
                // 4. Кнопка Плюс
                Button(action: onAddTap) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 26))
                        .foregroundColor(
                            isActive
                            ? Color(red: 0.1, green: 0.75, blue: 0.3) // Ярко-зеленый
                            : Color.black.opacity(0.2)
                        )
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16) // Важно: внутренний отступ
            
            // Разделитель
            if !isLast {
                Divider()
                    .background(Color.black.opacity(0.05))
                    .padding(.leading, 80)
            }
        }
    }
}





