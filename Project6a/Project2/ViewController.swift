//
//  ViewController.swift
//  Project2
//
//  Created by Nathan Segura on 2/24/22.
//  Copyright © 2022 Nathan Segura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    var score = 0
    var correctAnswer = 0
    var questionsAnswered = 0
    let maxQuestions = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(viewScoreTapped))
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) | Score: \(score)"
    }
    
    enum AnswerStatus {
        case correct
        case incorrect
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        questionsAnswered += 1
        
        var result: AnswerStatus
        
        if sender.tag == correctAnswer {
            result = .correct
            score += 1
        } else {
            result = .incorrect
            score -= 1
        }
        
        let alertController: UIAlertController
        
        if questionsAnswered >= maxQuestions {
            alertController = UIAlertController(title: "Game Ended", message: "You completed 'Guess the Flag!' with a final score of \(score)/\(maxQuestions)!", preferredStyle: .alert)
            
            score = 0
            questionsAnswered = 0
        } else if result == .incorrect {
            alertController = UIAlertController(title: "Oops!", message: "The flag you chose belongs to \(countries[sender.tag].uppercased())\nScore: \(score)", preferredStyle: .alert)
        } else {
            alertController = UIAlertController(title: "Correct!", message: "Score: \(score)", preferredStyle: .alert)
        }
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(alertController, animated: true)
    }
    
    @objc func viewScoreTapped() {
        let scoreMessage = "I got an awesome score of \(score) on 'Guess the Flag!'"
        let activityViewController = UIActivityViewController(activityItems: [scoreMessage], applicationActivities: [])
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(activityViewController, animated: true)
    }
}

