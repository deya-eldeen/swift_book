import Foundation

let HOST_TEAM_WON = 1
let WIN_POINTS = 1

// O(n) time | O(k) space , where n: are matches and k is the number of teams
func chessWinner(_ matches: [[String]], _ results: [Int]) -> String {
    var bestPlayer = ""
    var scores = [String: Int]()
    scores[bestPlayer] = 0
    for (idx, match) in matches.enumerated() {
        let (host, guest) = (match[0], match[1])
        let winning = (results[idx] == HOST_TEAM_WON) ? (host) : (guest)
        if scores[winning] == nil { scores[winning] = 0}
        scores[winning] = scores[winning]! + WIN_POINTS
        if scores[winning]! > scores[bestPlayer]! {
            bestPlayer = winning
        }
    }
    return bestPlayer
}


func generateData() -> ([[String]] , [Int]) {
    
    let players1 = ["Carlsen", "Ding Liren", "Nepomniachtchi", "Karjakin", "Aronian"]
    let players2 = ["Keymer", "Vitiugov", "Gukesh D", "Andreikin", "Grischuk"]

    var matches = [[String]] ()
    var results = [Int]()

    let possibleResults = [0,1]
    
    for _ in 0 ..< 10 {
        matches.append([players1.randomElement() ?? "", players2.randomElement() ?? ""])
        results.append(possibleResults.randomElement() ?? 0)
    }
    print(matches)
    print(results)
    
    return (matches, results)
}

func problem_04_solutions() {
    let data = generateData()
    printTimeElapsedWhenRunningCode(title:"solution12") {
        let bt = chessWinner(data.0, data.1)
        //print(bt)
    }
}
