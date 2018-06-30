//
//  MathViewController.swift
//  Games
//
//  Created by Dimash Bekzhan on 6/29/18.
//  Copyright © 2018 Dimash Bekzhan. All rights reserved.
//

import UIKit

enum Levels: Int {
    case zero = 0
    case first = 1
    case second, third
}

class MathViewController: UIViewController {

    var level: Levels = .zero
    
    //MARK: -Timer
    var timeInterval: Double {
        return Double(5 * level.rawValue)
    }
    var timerCount = 0
    var indexProgressBar = 0
    var timer = Timer()
    
    // MARK: -Variable numbers
    var randomNumber: Int {
        let numberOfPlaces = level.rawValue
        return generateRandomNumber(withNumberOfDecimalPlaces: numberOfPlaces)
    }
    var randomMulptiplier: Int {
        return generateRandomNumber(withNumberOfDecimalPlaces: 1)
    }
    var rightAnswer: Int = 0
    var score: Int = 0 {
        didSet {
            labelScore.text = "score is \(score)"
            if score < 0 {
                self.resetLabel()
                progressViewTimer.progress = 0
                let alert = createAlert(withMessage: "Your score is negative, you loose!", action: {
                    self.timer.invalidate()
                    self.performSegue(withIdentifier: "unwindSegue", sender: self)
                })
                
                self.present(alert, animated: true)
            }
        }
    }
    
    // MARK: - Changing constraints
    var topAnchor: NSLayoutConstraint?
    var bottomAnchor: NSLayoutConstraint?
    
    
    @IBOutlet weak var progressViewTimer: UIProgressView!
    
    @IBOutlet weak var textFieldAnswer: UITextField!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    
    // label math equation
    lazy var labelTask: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(labelTask)
        
        topAnchor = labelTask.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100)
        bottomAnchor = labelTask.bottomAnchor.constraint(equalTo: textFieldAnswer.topAnchor, constant: -20)
        
        setUpInitialConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        score = 0
        timerCount = 0
        indexProgressBar = 0
        progressViewTimer.progress = 0
        
        resetLabel()
        moveLabel()
    }
    
    func setUpInitialConstraints() {
        topAnchor?.isActive = true
        bottomAnchor?.isActive = false
        labelTask.widthAnchor.constraint(equalToConstant: 300).isActive = true
        labelTask.heightAnchor.constraint(equalToConstant: 30).isActive = true
        labelTask.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    func resetLabel() {
        
        let randomNumber = self.randomNumber
        let randomMultiplier = self.randomMulptiplier
        rightAnswer = randomNumber * randomMultiplier
        labelTask.text = "\(randomNumber) * \(randomMultiplier)"
        
        resetTimer()
        
        topAnchor?.isActive = true
        bottomAnchor?.isActive = false
        self.view.layoutIfNeeded()
    }
    
    func moveLabel() {
        
        self.topAnchor?.isActive = false
        self.bottomAnchor?.isActive = true
        
        UIView.animate(withDuration: timeInterval, animations: {
            // self.labelTimer.text = self.timer.description
            self.view.layoutIfNeeded()
        }, completion: { (hasFailed: Bool) in
            if hasFailed {
                self.score -= 1
                print(self.score)
                self.resetLabel()
            }
        })
    }
    
    func resetTimer() {
        timerCount = Int(timeInterval)
        indexProgressBar = 0
        progressViewTimer.progress = 0
        labelTimer.text = "\(timerCount)"
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timerCount -= 1
        indexProgressBar += 1
        print(timerCount)
        progressViewTimer.progress = Float(indexProgressBar) / Float(timeInterval - 1)
        print(progressViewTimer.progress)
        labelTimer.text = "\(timerCount)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSubmit(_ sender: UIButton) {
        guard let userAnswer = textFieldAnswer.text else { return }
        guard let number = Int(userAnswer) else { return }
        if number == rightAnswer {
            score += 1
        } else { score -= 1 }
        self.resetLabel()
        self.moveLabel()
    }
}
