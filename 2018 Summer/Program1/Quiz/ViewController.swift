//
//  ViewController.swift
//  Quiz
//
//  Created by COP4655 on 5/10/18.
//  Copyright © 2018 COP4655. All rights reserved.

//  PROGRAMMER:     Miguel Ruelas
//  PANTHERID:      4808540
//  CLASS:          COP4655 RVCC 1185
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     #1
//  DUE:            Sunday 05/13/18

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var questionCountLabel: UILabel!
    @IBOutlet var answerCountLabel: UILabel!
    
    let questions: [String] = [
        "What is 7+7?",
        "What is the capital of Vermont?",
        "What is cognac made from?"]
    
    let answers: [String] = [
        "14",
        "Montpelier",
        "Grapes"]
    var currentQuestionIndex: Int = 0
    var questionCount: Int = 1
    var answerCount: Int = 0
    
    @IBAction func showNextQuestion(_ sender:UIButton)
    {
        currentQuestionIndex+=1
        if currentQuestionIndex == questions.count{
        currentQuestionIndex=0
        }
        let question:String = questions[currentQuestionIndex]
        questionLabel.text = question
        answerLabel.text = "???"
        questionCount+=1
        updateCounts()
    }
    @IBAction func showAnswer(_ sender:UIButton)
    {
        let answer: String = answers[currentQuestionIndex]
        if answerLabel.text  != answer{
            answerLabel.text = answer
            answerCount+=1
            updateCounts()
        }
        
    }
    
    func updateCounts()
    {
        questionCountLabel.text = String(questionCount)
        answerCountLabel.text = String(answerCount)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        questionLabel.text = questions[currentQuestionIndex]
        updateCounts()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

