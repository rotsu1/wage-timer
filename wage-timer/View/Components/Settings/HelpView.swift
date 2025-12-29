//
//  HelpView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 28/12/2025.
//

import SwiftUI

struct HelpStep: Identifiable {
    let id = UUID()
    let text: LocalizedStringKey
    let imageName: String
}

struct HelpView: View {
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    Text("How to set up Shortcuts and Automation")
                        .font(.title)
                        .bold()
                    
                    // Shortcut Section
                    SectionView(
                        title: "How to set up Shortcuts",
                        steps: [
                            HelpStep(text: "Open the **Shortcuts** app and go to the **Library** tab.", imageName: "shortcut_step_1"),
                            HelpStep(text: "Tap **All Shortcuts**.", imageName: ""),
                            HelpStep(text: "Tap the + button in the top right corner.", imageName: "shortcut_step_2"),
                            HelpStep(text: "Scroll down to find **App Timer** and tap it.", imageName: "shortcut_step_3"),
                            HelpStep(text: "Tap **Start Recording**.", imageName: "shortcut_step_4"),
                            HelpStep(text: "Enter the name of the app you want to track.", imageName: "shortcut_step_5"),
                            HelpStep(text: "Repeat this process for **Stop Recording** with the same app name.", imageName: "")
                        ]
                    )
                    
                    Divider()
                    
                    // Automation Section
                    SectionView(
                        title: "How to set up Automation",
                        steps: [
                            HelpStep(text: "Go to the **Automation** tab.", imageName: ""),
                            HelpStep(text: "Tap **New Automation** or the + button in the top right.", imageName: ""),
                            HelpStep(text: "Scroll down and tap **App**.", imageName: "automation_step_1"),
                            HelpStep(text: "Select the app you want to track (the one you entered in the shortcut).", imageName: ""),
                            HelpStep(text: "Change the setting to **Run Immediately** (instead of **Ask Before Running**) and tap **Next**.", imageName: "automation_step_2"),
                            HelpStep(text: "Tap **My Shortcuts**.", imageName: ""),
                            HelpStep(text: "Select the **Start Recording** shortcut you created earlier.", imageName: "automation_step_3"),
                            HelpStep(text: "Repeat this automation process for **Stop Recording** (set it to run when the app **closes**).", imageName: ""),
                            HelpStep(text: "Your automation should look like this when you're done.", imageName: "automation_step_4")
                        ]
                    )
                }
                .navigationTitle("Help & Usage")
                .foregroundStyle(.white)
                .padding()
            }
        }
    }
}

struct SectionView: View {
    let title: LocalizedStringKey
    let steps: [HelpStep]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(title)
                .font(.title2)
                .bold()
            
            ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top, spacing: 12) {
                        Text("\(index + 1).")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .frame(width: 24, alignment: .leading)
                        
                        Text(step.text)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    // Image for the step
                    if !step.imageName.isEmpty {
                        Image(step.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 300)
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading, 36) // Align with text
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        HelpView()
    }
}
