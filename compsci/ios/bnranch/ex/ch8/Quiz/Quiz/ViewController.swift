//
//  ViewController.swift
//  Quiz
//
//  Created by Sviatoslav Zimine on 3/13/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    
    
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
        currentQuestionLabel.text = questions[currentQuestionIndex]
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel(){
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    @IBAction func showNextQuestion( _ sender: UIButton){
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question  = questions[currentQuestionIndex]
        nextQuestionLabel.text  = question
        answerLabel.text    = "???"
        
        animatedLabelTransitions() // call the label animation

    }
    
    @IBAction func showAnswer( _ sender: UIButton){
    
        let answer = answers[currentQuestionIndex]
        answerLabel.text    = answer
        
    }
    
    
    func animatedLabelTransitions() -> Void {
        
        
        // this defines a closure and assigns it to a variable
        //let animationClosure = { () -> Void  in
        //    self.questionLabel.alpha = 1
        //}
    
        //force any outstanding layout changes to occur
        view.layoutIfNeeded()
    
        //Animate the alpha, in a call pass the closure anonymously
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        /*
        UIView.animate(withDuration: 0.55,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations:{
                                        self.currentQuestionLabel.alpha = 0
                                        self.nextQuestionLabel.alpha = 1
                        
                                        self.view.layoutIfNeeded()
                        },
                       completion: { _ in
                         swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                         swap(&self.currentQuestionLabelCenterXConstraint,&self.nextQuestionLabelCenterXConstraint )
                        
                        self.updateOffScreenLabel()
                        }
        )
        */
        //bronze  spring animation
        UIView.animate(withDuration: 0.55,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: [.curveLinear],
                       animations:{
                            self.currentQuestionLabel.alpha = 0
                            self.nextQuestionLabel.alpha = 1
                        
                            self.view.layoutIfNeeded()
                        },
                       completion:{  _ in
                            swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                            swap(&self.currentQuestionLabelCenterXConstraint,&self.nextQuestionLabelCenterXConstraint )
            
                            self.updateOffScreenLabel()
                        })
    

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //set label's initial alpha
        nextQuestionLabel.alpha = 0.0
    }
    

}

