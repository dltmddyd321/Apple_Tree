//
//  ViewController.swift
//  ApplePie
//
//  Created by 이승용 on 2021/07/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent","bug","program"]
    
    let incorrectMovesAllowed = 7
    //게임에서 사용할 7번의 기회 상수
    
    var totalWins = 0 {
        didSet {
            newRound()
        } // 값이 변경되면 함수 호출
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var currentGame:Game!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    func newRound() {
        if !listOfWords.isEmpty { //게임의 단어 요소가 남았다면
            let newWord = listOfWords.removeFirst()
            //배열에서 첫 번째 원소를 꺼내고 기존 배열에서는 삭제함
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLtters: [])
            enableLetterBtn(true)
            //모든 버튼을 활성화하는 함수
            updateUI()
        } else { //게임의 단어 요소가 더 이상 남지 않았다면
            enableLetterBtn(false)
            //모든 버튼을 비활성화하는 함수
        }
        
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        
        let wordWithSpacing = letters.joined(separator: " ")
        correctLabel.text = wordWithSpacing
        scoreLabel.text = "Wins \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

    @IBAction func btnTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        //특정 버튼을 누르면 이후 해당 버튼 텍스트 상태가 비활성화 모드로 변경됨
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0{ //클리어에 실패할 시
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func enableLetterBtn(_ enable:Bool) {
        for button in letterButtons {
            button.isEnabled = enable // 모든 버튼 활성화
        }
    }
    
}

