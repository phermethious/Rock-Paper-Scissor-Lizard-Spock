
//  Created by Brian Wall on 9/28/26.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🪨", "📄", "✂️", "🦎", "🖖"]
    @State private var appMove = Int.random(in: 0...4)
    @State private var score = 0
    @State private var playerMove: Int? = nil
    @State private var matchPhrases = ""
    @State private var gamesPlayed = 0
    @State private var wins = 0
    @State private var gameResult = "Choose your move!"
    
    // Computed win percentage
    var winPercentage: Double {
        guard gamesPlayed > 0 else { return 0.0 }
        return (Double(wins) / Double(gamesPlayed)) * 100
    }
    
    var body: some View {
            ZStack {
                ForEach(0..<5) { number in
                    Button(action: {
                        play(choice: number)
                    }) {
                            Text(emojis[number])
                            .font(.system(size: 70))
                            .rotationEffect(.degrees(-Double(number) * 72))
                    }
                    .offset(y: -100)
                    .rotationEffect(.degrees(Double(number) * 72))
                }
            }
            .frame(height: 300)
        VStack(spacing: 5) {
            if let playerMove = playerMove {
                Text("You have chosen: \(emojis[playerMove])")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            
            if gamesPlayed > 0 {
                Text("The computer has chosen: \(emojis[appMove])")
                    .font(.headline)
            }
                
            Text(gamesPlayed == 0 ? "Choose your move!" : gameResult)
                            .font(.title2)
                            .foregroundColor(gamesPlayed == 0 ? .gray : (gameResult == "You Win!" ? .green : (gameResult == "You Lose!" ? .red : .orange)))
            if gamesPlayed > 0 {
                Text(matchPhrases)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .italic()
            }
            
            VStack(spacing: 5) {
                Text("Score: \(score)")
                    .font(.title)
                Text("Games Played: \(gamesPlayed)")
                Text(String(format: "Win Percentage: %.1f%%", winPercentage))
            }
            
            Button("Reset Stats") {
                resetGame()
            }
            .font(.title3)
            .padding(.bottom, 5)
            .padding(.top, 5)
            .padding(.horizontal, 5)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(5)
        }
        .frame(height: 250)
    }
    
    func play(choice: Int) {
        appMove = Int.random(in: 0...4)
        playerMove = choice
        gamesPlayed += 1
        let winningMoves: [Int: [Int]] = [
            0: [1, 4],
            1: [2, 3],
            2: [0, 4],
            3: [0, 2],
            4: [1, 3]
        ]
        
        let winPhrases: [String: String] = [
            "0,2": "Rock crushes Scissors",
            "0,3": "Rock crushes Lizard",
            "1,0": "Paper covers Rock",
            "1,4": "Paper disproves Spock",
            "2,1": "Scissors cuts Paper",
            "2,3": "Scissors decapitates Lizard",
            "3,1": "Lizard eats Paper",
            "3,4": "Lizard poisons Spock",
            "4,0": "Spock vaporizes Rock",
            "4,2": "Spock smashes Scissors"
        ]
        
        if choice == appMove {
            gameResult = "It's a Tie!"
            matchPhrases = ""
        } else if let beatBy = winningMoves[appMove], beatBy.contains(choice) {
            gameResult = "You Win!"
            matchPhrases = winPhrases["\(choice),\(appMove)"] ?? ""
            score += 1
            wins += 1
        } else {
            gameResult = "You Lose!"
            matchPhrases = winPhrases["\(appMove),\(choice)"] ?? ""
            score -= 1
        }
    }
    
    func resetGame() {
        score = 0
        wins = 0
        gamesPlayed = 0
        playerMove = nil
        gameResult = "Choose your move!"
    }
}


