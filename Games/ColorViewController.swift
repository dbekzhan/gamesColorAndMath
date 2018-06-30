//
//  ColorViewController.swift
//  Games
//
//  Created by Dimash Bekzhan on 6/29/18.
//  Copyright © 2018 Dimash Bekzhan. All rights reserved.
//

import UIKit


class ColorViewController: UIViewController {

    //MARK: -Outlets
    
    @IBOutlet weak var labelColor: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    
    lazy var alertController: UIAlertController = {
        let alertController = UIAlertController(title: "Ooops", message: "This game doesn't give a damn second chance. You loose, with a score of \(score)", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            print("pressed action")
        })
        alertController.addAction(alertAction)
        return alertController
    }()
    
    var score: Int = 0 {
        didSet {
            if self.score < 0 {
                self.present(alertController, animated: true, completion: {
                    self.labelScore.text = "Your score is \(self.score) at a moment"
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        score = 0
        labelScore.text = "Your score is \(score) at a moment"
        setRandomTriple()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setRandomTriple() {
        let randomTriple = getRandomTriple()
        labelColor.textColor = randomTriple.textColor.rawValue
        labelColor.text = randomTriple.describedColor.rawValue.name!
        
        labelColor.backgroundColor = randomTriple.backColor.rawValue
    }
    
    //MARK: -Actions
    @IBAction func buttonAnswer(_ sender: UIButton) {
        let rightAnswer = (labelColor.text == labelColor.backgroundColor?.name!)
        
        guard let title = sender.titleLabel?.text?.uppercased() else { return }
        let aString = NSString(string: title)
        let userAnswer = aString.boolValue
        
        if userAnswer == rightAnswer {
            score += 1
            labelScore.text = "Correct! Now your score is \(score)"
        } else {
            score -= 1
            labelScore.text = "Incorrect! Now your score is \(score)"
        }
        setRandomTriple()
    }
}

extension ColorViewController {
    
    //MARK: -Helper functions
    func getRandomTriple() -> (textColor: Color, backColor: Color, describedColor: Color) {
        var textColor: Color!
        var backColor: Color!
        
        repeat {
            textColor = randomizerOfColor()
            backColor = randomizerOfColor()
        } while textColor == backColor
        
        let describedColor = randomizerOfColor()
        
        return (textColor, backColor, describedColor)
    }
    
    func randomizerOfColor() -> Color {
        let count = UInt32(Color.cases.count)
        let randomIndex = Int(arc4random_uniform(count))
        return Color.cases[randomIndex]
    }
}
