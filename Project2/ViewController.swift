//
//  ViewController.swift
//  Project2
//
//  Created by Dragan Petrovic on 9/5/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCountries()
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestion()
    }
    
    func createCountries() {
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }
    
    func askQuestion(action: UIAlertAction! =  nil) {
        questionsCount += 1
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased() + "  Score: \(score)"
    }
    
    func restartGame(action: UIAlertAction! =  nil) {
        score = 0
        questionsCount = 0
        askQuestion()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var alertTitle: String
        var allertMessage: String
        var allertActionButtonTitle: String
        var alertActionHandler: (UIAlertAction) -> Void
        
        if sender.tag == correctAnswer {
            score += 1
            alertTitle = "Correct"
            allertMessage = "Your score is \(score)."
            allertActionButtonTitle = "Continue"
            alertActionHandler = askQuestion
        } else {
            alertTitle = "Wrong"
            allertMessage = "This is the flag of \(countries[sender.tag].uppercased())! Your score is \(score)."
            allertActionButtonTitle = "Continue"
            alertActionHandler = askQuestion
        }
        
        if questionsCount == 10 && score >= 7 {
            alertTitle = "Great Job ! You won this game !"
            allertMessage = "The score is \(score) of \(questionsCount). Click replay to start a new game !"
            allertActionButtonTitle = "Play a new game"
            alertActionHandler = restartGame
        } else if questionsCount == 10 && score < 7 {
            alertTitle = "Oh No! You lose this game :( !"
            allertMessage = "The score is \(score) of \(questionsCount). Click replay to start a new game !"
            allertActionButtonTitle = "Play a new game"
            alertActionHandler = restartGame
        }
        title = countries[correctAnswer].uppercased() + "  Score: \(score)"

        let ac = UIAlertController(title: alertTitle, message: allertMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: allertActionButtonTitle, style: .default, handler: alertActionHandler))
        present(ac, animated: true)
    }
    
}

