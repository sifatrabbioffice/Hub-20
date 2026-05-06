import SwiftUI

@main
struct GameHubApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var currentPage = 1
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            if currentPage == 1 {
                WelcomeView(onStart: { currentPage = 2 })
            } else {
                EngineDashboardView()
            }
        }
    }
}

// MARK: - Page 1: Welcome Screen
struct WelcomeView: View {
    var onStart: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            Text("GAMEHUB")
                .font(.system(size: 64, weight: .black, design: .monospaced))
                .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
            
            Text("iPhone 15 Pro Max - Ultra Environment")
                .font(.caption)
                .foregroundColor(.gray)
            
            Button(action: onStart) {
                Text("INITIALIZE ENGINE")
                    .fontWeight(.bold)
                    .padding()
                    .frame(width: 280)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
    }
}

// MARK: - Page 2: Engine & Library
struct EngineDashboardView: View {
    @State private var selectedDirectX = "DirectX 11"
    @State private var isRunning = false
    
    var body: some View {
        HStack(spacing: 0) {
            // Sidebar Settings
            VStack(alignment: .leading, spacing: 20) {
                Text("Environment Settings").font(.headline).foregroundColor(.blue)
                
                Picker("Graphics Engine", selection: $selectedDirectX) {
                    Text("DirectX 9").tag("DirectX 9")
                    Text("DirectX 11").tag("DirectX 11")
                    Text("Vulkan").tag("Vulkan")
                }.pickerStyle(.menu)
                
                Toggle("C++ Redistributables", isOn: .constant(true))
                Toggle("High-Performance Mode", isOn: .constant(true))
                
                Spacer()
                
                Button(action: { isRunning.toggle() }) {
                    Text(isRunning ? "STOP SESSION" : "LAUNCH .EXE")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isRunning ? Color.red : Color.green)
                        .cornerRadius(10)
                }
            }
            .padding()
            .frame(width: 300)
            .background(Color(white: 0.1))

            // Library / Game View
            ZStack {
                Color.black
                if isRunning {
                    VirtualGamepadView()
                } else {
                    VStack {
                        Image(systemName: "folder.badge.plus")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("Import .exe or ISO from Documents").foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

// MARK: - Virtual Gamepad Overlay
struct VirtualGamepadView: View {
    var body: some View {
        ZStack {
            // Placeholder for Game Content
            Text("WIN32_ENV_RUNNING...").foregroundColor(.green).font(.system(size: 10))
            
            // PS5 Style Controls
            HStack {
                Circle().frame(width: 100, height: 100).opacity(0.3) // D-Pad
                Spacer()
                VStack {
                    HStack {
                        Circle().frame(width: 40, height: 40).overlay(Text("Δ"))
                    }
                    HStack {
                        Circle().frame(width: 40, height: 40).overlay(Text("□"))
                        Spacer().frame(width: 40)
                        Circle().frame(width: 40, height: 40).overlay(Text("O"))
                    }
                    Circle().frame(width: 40, height: 40).overlay(Text("X"))
                }
            }
            .padding(40)
            .foregroundColor(.white)
        }
    }
}
