//
//  CustomTabBar.swift
//  Lumo
//
//  Created by Matvey Veselkov on 22.11.2025.
//
import SwiftUI

// MARK: - Tab Bar Button
struct TabBarButton: View {
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(isSelected ? Color.green.opacity(0.85) : .gray)
                .scaleEffect(isSelected ? 1.1 : 1.0)
                .animation(.spring(response: 0.3), value: isSelected)
        }
    }
}

// MARK: - Custom Tab Bar
struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(
                icon: "person.crop.circle.fill",
                isSelected: selectedTab == 0,
                action: { selectedTab = 0 }
            )
            
            Spacer()
            
            TabBarButton(
                icon: "house.fill",
                isSelected: selectedTab == 1,
                action: { selectedTab = 1 }
            )
            
            Spacer()
            
            TabBarButton(
                icon: "chart.bar.fill",
                isSelected: selectedTab == 2,
                action: { selectedTab = 2 }
            )
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 16)
        .background(
            ZStack {
                // Основной фон
                Color.white
                
                // Блик сверху
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.8),
                        Color.clear
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 2)
                .offset(y: -30)
            }
        )
        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: -3)
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(1))
}


