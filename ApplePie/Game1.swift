//
//  Game1.swift
//  ApplePie
//
//  Created by 이승용 on 2021/07/01.
//

import Foundation

struct Game { //게임 알고리즘을 위한 구조체 선언
    var word:String
    var incorrectMovesRemaining:Int
    var guessedLtters: [Character]
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLtters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) {
        guessedLtters.append(letter)
        if !word.contains(letter) {
            //입력받은 단어를 통해 배열에 포함되어 있는 유무를 파악
            incorrectMovesRemaining -= 1
        }
    }
}
