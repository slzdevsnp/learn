//
//  ViewController.swift
//  Quiz
//
//  Created by Sviatoslav Zimine on 3/13/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = [
        "What is 7+7",
        "What is the capital of Vermont?",
        "What is cognact made from"
    ]
    
    let answers: [String] = [
        "14",
        "Montpelier",
        "Grapes"
    ]
    
    var currentQuestionIndex: Int = 0
    
    ///first question loaded after the app start
    override func viewDidLoad(){
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestionIndex]
    }
    
    
    @IBAction func showNextQuestion( _ sender: UIButton){
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question  = questions[currentQuestionIndex]
        questionLabel.text  = question
        answerLabel.text    = "???"
    }
    
    @IBAction func showAnswer( _ sender: UIButton){
    
        let answer = answers[currentQuestionIndex]
        answerLabel.text    = answer
    }
    
}

