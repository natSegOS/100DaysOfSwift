//
//  ViewController.swift
//  Challenge3
//
//  Created by Nathan Segura on 3/18/22.
//  Copyright © 2022 Nathan Segura. All rights reserved.
//

import UIKit

extension String {
    mutating func replace(characterAtIndex index: Int, with character: Character) {
        let charIndex = self.index(self.startIndex, offsetBy: index)
        self.replaceSubrange(charIndex...charIndex, with: String(character))
    }
}

class ViewController: UIViewController {
    @IBOutlet var guessesLabel: UILabel!
    @IBOutlet var answerLabel: UITextField!
    
    var hearts = [UIImageView]()
    
    var health = 6 {
        didSet {
            if health < oldValue {
                hearts[health].alpha = 0
            }
            if health <= 0 {
                gameOver()
            }
        }
    }
    
    var allWords = [String]()
    var guessedLetters = [Character]()
    var totalGuesses = 0 {
        didSet {
            guessesLabel.text = "Total Guesses: \(totalGuesses)"
        }
    }
    var currentAnswer: String?
    
    override func loadView() {
        super.loadView()
        
        let heart1 = UIImageView(image: UIImage(named: "heart"))
        heart1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heart1)
        
        let heart2 = UIImageView(image: UIImage(named: "heart"))
        heart2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heart2)
        
        let heart3 = UIImageView(image: UIImage(named: "heart"))
        heart3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heart3)
        
        let heart4 = UIImageView(image: UIImage(named: "heart"))
        heart4.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heart4)
        
        let heart5 = UIImageView(image: UIImage(named: "heart"))
        heart5.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heart5)
        
        let heart6 = UIImageView(image: UIImage(named: "heart"))
        heart6.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heart6)
        
        NSLayoutConstraint.activate([
            heart1.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -100),
            heart1.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            heart1.widthAnchor.constraint(equalToConstant: 100),
            heart1.heightAnchor.constraint(equalToConstant: 100),
            
            heart2.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -100),
            heart2.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            heart2.widthAnchor.constraint(equalToConstant: 100),
            heart2.heightAnchor.constraint(equalToConstant: 100),
            
            heart3.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -100),
            heart3.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            heart3.widthAnchor.constraint(equalToConstant: 100),
            heart3.heightAnchor.constraint(equalToConstant: 100),
            
            heart4.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: 0),
            heart4.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            heart4.widthAnchor.constraint(equalToConstant: 100),
            heart4.heightAnchor.constraint(equalToConstant: 100),
            
            heart5.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: 0),
            heart5.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            heart5.widthAnchor.constraint(equalToConstant: 100),
            heart5.heightAnchor.constraint(equalToConstant: 100),
            
            heart6.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: 0),
            heart6.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            heart6.widthAnchor.constraint(equalToConstant: 100),
            heart6.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        hearts = [heart1, heart2, heart3, heart4, heart5, heart6]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
        
        DispatchQueue.global().async { [weak self] in
            if let wordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
                if let words = try? String(contentsOf: wordsURL) {
                    self?.allWords = words.components(separatedBy: "\n")
                }
            }
            
            self?.performSelector(onMainThread: #selector(self?.startGame), with: nil, waitUntilDone: false)
        }
    }
    
    @objc func startGame() {
        currentAnswer = allWords.randomElement()?.uppercased()
        health = 6
        totalGuesses = 0
        guessedLetters.removeAll()
        for heart in hearts {
            heart.alpha = 1
        }
        
        if let currentAnswer = currentAnswer {
            answerLabel.text = String(repeating: "?", count: currentAnswer.count)
        }
        
        print(currentAnswer)
    }
    
    @objc func restartGame() {
        let alertController = UIAlertController(title: "Restart Game", message: "Are you sure you want to restart the game?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .destructive) { [weak self] _ in
            self?.startGame()
        })
        
        present(alertController, animated: true)
    }
    
    func gameOver() {
        let alertController = UIAlertController(title: "Game Over", message: "You lost! I bet you can do it next time, though!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.startGame()
        })
        
        present(alertController, animated: true)
    }
    
    func gameWon() {
        let alertController = UIAlertController(title: "Congratulations", message: "Wow! Good job, you guessed the word! Do you want to play again?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Bring it on!", style: .default) { [weak self] _ in
            self?.startGame()
        })
        
        present(alertController, animated: true)
    }
    
    @IBAction func guessTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Guess a Letter", message: "What letter do you thing the word has?", preferredStyle: .alert)
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Guess", style: .default) { [weak self, weak alertController] _ in
            if let textField = alertController?.textFields?.first {
                guard let text = textField.text else { return }
                guard text != "" && text.count <= 1 else { return }
                
                self?.validateLetter(Character(text))
            }
        })
        
        present(alertController, animated: true)
    }
    
    func validateLetter(_ inputLetter: Character) {
        guard let currentAnswer = currentAnswer else { return }
        guard !guessedLetters.contains(inputLetter) else {
            let alertController = UIAlertController(title: "Already Guessed", message: "You already guessed that letter! Try choosing a different letter.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(alertController, animated: true)
            return
        }
        
        if currentAnswer.contains(String(inputLetter).uppercased()) {
            for (index, character) in currentAnswer.enumerated() {
                if String(character) == String(inputLetter).uppercased() {
                    answerLabel.text?.replace(characterAtIndex: index, with: character)
                }
            }
            
            if answerLabel.text == currentAnswer {
                gameWon()
            }
        } else {
            health -= 1
        }
        
        guessedLetters.append(inputLetter)
        totalGuesses += 1
    }
}
