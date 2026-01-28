//
//  MugshotDashboardView.swift
//  PhoneAddictionMugshot
//
//  Created by Shmuel Dukes on 1/23/26.
//


import SwiftUI

struct MugshotDashboardView: View {
    // Mock data for the grid
    let timestamps = ["10:15 AM", "12:30 PM", "3:45 PM", "5:20 PM", "7:10 PM", "9:05 PM"]
    
    var body: some View {
        ZStack {
            // Background with subtle depth
            Color.black.ignoresSafeArea()
            BackgroundGlow()

            VStack(spacing: 30) {
                // Header Section
                VStack(spacing: 8) {
                    Text("Today's Screen Time")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("6h 42m")
                        .font(.system(size: 96, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color(red: 0.95, green: 0.3, blue: 0.2), .orange],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text("Average Daily Usage")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.top, 60)

                // Mugshot Count Banner
                HStack {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                    
                    Text("Mugshots Captured: 6")
                        .font(.system(size: 34, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(LinearGradient(colors: [.blue.opacity(0.5), .purple.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
                        )
                )
                .padding(.horizontal, 40)

                // Mugshot Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(timestamps, id: \.self) { time in
                        MugshotCard(time: time)
                    }
                }
                .padding(.horizontal, 40)

                Spacer()

                // Action Button
                Button(action: {}) {
                    HStack {
                        Text("📸 Take Mugshot Now")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(
                        LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(20)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            }
            
            // Custom Tab Bar (Simplified)
            VStack {
                Spacer()
                TabBarPlaceholder()
            }
        }
    }
}

// MARK: - Subviews

struct MugshotCard: View {
    let time: String
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Placeholder for the photo
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.3))
                .aspectRatio(1.0, contentMode: .fit)
            
            Text(time)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
                .padding(8)
                .background(Color.black.opacity(0.4))
                .cornerRadius(8)
                .padding(10)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}

struct BackgroundGlow: View {
    var body: some View {
        Canvas { context, size in
            context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(.black))
            // Add custom gradients or "waves" here to match the screenshot background
        }
        .opacity(0.5)
    }
}

struct TabBarPlaceholder: View {
    var body: some View {
        HStack {
            Spacer()
            TabItem(icon: "square.grid.2x2.fill", label: "Dashboard", active: true)
            Spacer()
            TabItem(icon: "calendar", label: "History")
            Spacer()
            TabItem(icon: "gearshape", label: "Settings")
            Spacer()
            TabItem(icon: "person.circle", label: "Profile")
            Spacer()
        }
        .frame(height: 90)
        .background(Color.black)
    }
}

struct TabItem: View {
    let icon: String
    let label: String
    var active: Bool = false
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 24))
            Text(label)
                .font(.system(size: 12))
        }
        .foregroundColor(active ? .blue : .gray)
    }
}