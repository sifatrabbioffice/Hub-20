import SwiftUI

@main
struct GameHubApp: App {
    var body: some Scene {
        WindowGroup {
            LandingPage()
        }
    }
}

// --- Page 1: High-End Welcome ---
struct LandingPage: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            LibraryView()
        } else {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("GAMEHUB")
                        .font(.system(size: 60, weight: .black, design: .monospaced))
                        .foregroundStyle(LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom))
                    
                    Text("iPhone 15 Pro Max - A17 Pro Optimized")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    ProgressView()
                        .tint(.blue)
                        .scaleEffect(1.5)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation { isActive = true }
                }
            }
        }
    }
}

// --- Page 2: Library & Engine Settings ---
struct LibraryView: View {
    @State private var engineStatus = "Initializing DirectX 11..."
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(white: 0.1).ignoresSafeArea()
                VStack {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(0..<4) { i in
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.darkGray)
                                    .frame(height: 200)
                                    .overlay(Text("Add PC Game .exe").foregroundColor(.gray))
                            }
                        }
                        .padding()
                    }
                    
                    // Engine Control Panel
                    VStack(alignment: .leading, spacing: 10) {
                        Text("System Environment").font(.headline).foregroundColor(.white)
                        HStack {
                            Label("DirectX 11", systemImage: "bolt.fill").foregroundColor(.green)
                            Label("C++ 2015-2022", systemImage: "cpu").foregroundColor(.blue)
                        }
                        Text("Status: \(engineStatus)").font(.system(size: 12)).foregroundColor(.cyan)
                    }
                    .padding()
                    .background(Color.black.opacity(0.8))
                }
            }
            .navigationTitle("GameHub Library")
            .toolbar {
                Button("Settings") { /* Access Wine/Emulator Config */ }
            }
        }
    }
}

extension Color { static let darkGray = Color(white: 0.2) }
