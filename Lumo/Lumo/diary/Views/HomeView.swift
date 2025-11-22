//
//  HomeView.swift
//  Lumo
//
//  Created by Matvey Veselkov on 22.11.2025.
//
import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 1
    @State private var dailyStats = DailyStats(consumed: 500, burned: 250, goal: 1950)
    
    @State private var meals: [MealData] = [
        MealData(name: "Завтрак", calories: 500, protein: 25, fat: 20, carbs: 55),
        MealData(name: "Обед", calories: 0, protein: 0, fat: 0, carbs: 0),
        MealData(name: "Ужин", calories: 0, protein: 0, fat: 0, carbs: 0),
        MealData(name: "Перекус", calories: 0, protein: 0, fat: 0, carbs: 0)
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Приветствие
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Привет, Айлин!")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary)
                        Text("Вы молодец, продолжайте в том же духе!")
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // Карточки
                    CalorieRingView(dailyStats: dailyStats)
                        .padding(.horizontal)
                    
                    WaterIntakeCard(current: 1250, goal: 2200)
                        .padding(.horizontal)
                    
                    // СПИСОК ЕДЫ
                    VStack(spacing: 0) {
                        ForEach(Array(meals.enumerated()), id: \.element.id) { index, meal in
                            MealRow(
                                meal: meal,
                                onAddTap: {
                                    // Здесь мы используем meal.name, чтобы знать, куда нажали
                                    print("Добавить \(meal.name)")
                                    
                                    // Если нужно открыть экран добавления, здесь будет код навигации, например:
                                    // isShowingAddFoodSheet = true
                                    // selectedMealType = meal.name
                                },
                                isLast: index == meals.count - 1
                            )
                        }
                    }

                    // ВАЖНО: Внутренний отступ самого контейнера
                    .padding(.vertical, 4)
                    .background(
                        // ТОЧНАЯ КОПИЯ ЗЕЛЕНОГО ГРАДИЕНТА
                        ZStack {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.4, green: 0.85, blue: 0.6),  // Мятный
                                    Color(red: 0.25, green: 0.65, blue: 0.45) // Темнее
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.35),
                                    Color.white.opacity(0.05),
                                    Color.clear
                                ]),
                                center: .center,
                                startRadius: 10,
                                endRadius: 200
                            )
                            .blendMode(.overlay)
                        }
                    )
                    .cornerRadius(24)
                    .shadow(color: Color.green.opacity(0.2), radius: 12, x: 0, y: 6)
                    .padding(.horizontal)
                    .padding(.bottom, 100)
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}





