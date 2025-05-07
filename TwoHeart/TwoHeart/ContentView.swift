//
//  ContentView.swift
//  TwoHeart
//
//  Created by 최진선 on 5/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var name1: String = ""
    @State private var name2: String = ""
    
    @State private var matchScore: Int? = nil
    @State private var isSubmitted: Bool = false

    var body: some View {
        Spacer()
        
        
        VStack(spacing: 20) {
            Text("👼🏻")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("two heart logic")
                .font(.largeTitle)
                .fontWeight(.light)
            
            TextField("Enter Name 1", text: $name1)
                .disabled(isSubmitted)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Enter Name 2", text: $name2)
                .disabled(isSubmitted)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            if !isSubmitted {
                Button(action: {
                    calculateMatchScore()
                }) {
                    Text("Check Match 💘")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background((name1.isEmpty || name2.isEmpty) ? Color(.systemGray4) : Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(name1.isEmpty || name2.isEmpty)
            }
            
            if let score = matchScore {
                VStack(spacing: 12) {
                    Text("Match Score: \(score)%")
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(.red)
                    
                    Text(matchMessage(for: score))
                        .font(.body)
                        .foregroundColor(.gray)
                    
                    Button("🔄 Start Over") {
                        reset()
                    }
                    .font(.subheadline)
                    .padding(.top, 10)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
            }


            Spacer()
        }
        .padding()
    }
    
    func calculateMatchScore() {
        let combined = name1 + name2
        let unicodeSum = combined.unicodeScalars.map { Int($0.value) }.reduce(0, +)
        matchScore = unicodeSum % 101
    }
    
    func matchMessage(for score: Int) -> String {
        switch score {
        case 90...100:
            return "✨ Perfect chemistry! You two are a great match!"
        case 70..<90:
            return "😊 A good match! Could be something special!"
        case 40..<70:
            return "🙂 Nice as friends! Take it slow and see."
        default:
            return "😅 Hmm... maybe not the best day for love."
        }
    }
    
    func reset() {
        name1 = ""
        name2 = ""
        matchScore = nil
        isSubmitted = false
    }


}

#Preview {
    ContentView()
}
