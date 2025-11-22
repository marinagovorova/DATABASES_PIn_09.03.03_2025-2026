//
//  WaterIntakeCard.swift
//  Lumo
//
//  Created by Matvey Veselkov on 22.11.2025.
//
import SwiftUI

// Исправленная 3D капля (с видимым объемом)
struct RealisticWaterDroplet: View {
    let size: CGFloat
    
    var body: some View {
        ZStack {
            // 1. Внешняя тень (для отрыва от фона)
            Circle()
                .fill(Color.black.opacity(0.25)) // Темная тень
                .frame(width: size, height: size)
                .offset(x: size * 0.1, y: size * 0.15) // Смещаем вниз-вправо
                .blur(radius: size * 0.1)
            
            // 2. Тело капли (Осветление фона под каплей)
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.25), // Светлый верх
                            Color.white.opacity(0.05)  // Прозрачный низ
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size, height: size)
                // Добавляем режим наложения для "стеклянности"
                .blendMode(.overlay)
            
            // 3. Внутренний контур (Глубина)
            Circle()
                .strokeBorder(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.1, green: 0.3, blue: 0.6).opacity(0.5), // Темный контур сверху
                            Color.clear,
                            Color.white.opacity(0.8) // Яркий контур снизу
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: size * 0.06
                )
                .frame(width: size, height: size)
            
            // 4. Нижний внутренний рефлекс (линза)
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.6),
                            Color.clear
                        ]),
                        center: .bottomTrailing,
                        startRadius: 0,
                        endRadius: size * 0.6
                    )
                )
                .frame(width: size * 0.9, height: size * 0.9)
                .offset(x: size * 0.05, y: size * 0.05)
                .mask(Circle().frame(width: size, height: size)) // Обрезаем только блик
            
            // 5. Верхний зеркальный блик
            Ellipse()
                .fill(Color.white.opacity(0.9))
                .frame(width: size * 0.35, height: size * 0.25)
                .rotationEffect(.degrees(-45))
                .offset(x: -size * 0.2, y: -size * 0.25)
                .blur(radius: size * 0.05) // Мягкое размытие
            
            // 6. Точечный блик (резкий)
            Circle()
                .fill(Color.white)
                .frame(width: size * 0.08, height: size * 0.08)
                .offset(x: size * 0.1, y: -size * 0.35)
        }
    }
}

struct WaterIntakeCard: View {
    @State private var currentWater: Double
    let goalWater: Double
    
    init(current: Double, goal: Double) {
        self._currentWater = State(initialValue: current)
        self.goalWater = goal
    }
    
    var progress: Double {
        guard goalWater > 0 else { return 0 }
        return min(currentWater / goalWater, 1.0)
    }
    
    var body: some View {
        ZStack {
            // === ФОН КАРТОЧКИ ===
            ZStack {
                // 1. Горизонтальный градиент
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.4, green: 0.75, blue: 0.95), // Светло-голубой (Sky Blue)
                        Color(red: 0.2, green: 0.6, blue: 0.85)   // Насыщенный синий
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                
                // 2. Центральный просвет (Glow)
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.35), // Яркий центр
                        Color.white.opacity(0.05),
                        Color.clear
                    ]),
                    center: .center,
                    startRadius: 10,
                    endRadius: 200
                )
                .blendMode(.overlay)
            }
            .cornerRadius(20)
            .shadow(color: Color.blue.opacity(0.3), radius: 15, x: 0, y: 8)
            
            // === КАПЛИ ===
            // Используем ZStack и обрезаем его целиком, а не каждую каплю отдельно
            ZStack {
                // Левая верхняя (большая)
                RealisticWaterDroplet(size: 60)
                    .offset(x: -160, y: -52)
                
                // Правая верхняя (средняя)
                RealisticWaterDroplet(size: 55)
                    .offset(x: 105, y: -70)
                
                // Правая крайняя (средняя)
                RealisticWaterDroplet(size: 50)
                    .offset(x: 165, y: -15)
                
                // Левая нижняя (средняя)
                RealisticWaterDroplet(size: 50)
                    .offset(x: -80, y: 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // На всю карточку
            .clipShape(RoundedRectangle(cornerRadius: 20)) // Обрезаем капли по границе карточки
            
            // === КОНТЕНТ ===
            VStack(spacing: 0) {
                Text("Не забудь\nвыпить воды!")
                    .font(.system(size: 28, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.05, green: 0.15, blue: 0.3)) // Темно-синий текст для контраста
                    .padding(.top, 25)
                    .shadow(color: Color.white.opacity(0.3), radius: 1, x: 0, y: 1)
                
                Spacer()
                
                HStack(alignment: .bottom, spacing: 15) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("\(Int(currentWater)) мл")
                                .font(.system(size: 19, weight: .semibold))
                                .foregroundColor(.black)
                            Spacer()
                            Text("\(Int(goalWater).formattedWithSeparator()) мл")
                                .font(.system(size: 19, weight: .semibold))
                                .foregroundColor(.black)
                        }
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white.opacity(0.4))
                                    .frame(height: 16)
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(red: 0.0, green: 0.45, blue: 0.8)) // Яркий синий
                                    .frame(width: geometry.size.width * progress, height: 16)
                                    .animation(.spring(response: 0.6), value: progress)
                            }
                        }
                        .frame(height: 16)
                    }
                    .padding(.bottom, 25)
                    
                    Button(action: {
                        withAnimation {
                            currentWater = min(currentWater + 250, goalWater)
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.white.opacity(0.9))
                                .frame(width: 55, height: 55)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(Color(red: 0.0, green: 0.45, blue: 0.8))
                        }
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 20)
            }
        }
        .frame(height: 200) // Чуть выше карточка
    }
}

extension Int {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(for: self) ?? ""
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.1).ignoresSafeArea()
        WaterIntakeCard(current: 500, goal: 2200)
            .padding()
    }
}









