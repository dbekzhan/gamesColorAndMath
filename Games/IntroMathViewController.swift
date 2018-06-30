//
//  IntroMathViewController.swift
//  Games
//
//  Created by Dimash Bekzhan on 6/29/18.
//  Copyright © 2018 Dimash Bekzhan. All rights reserved.
//

import UIKit

class IntroMathViewController: UIViewController {

    
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet var viewsDifficultyLevels: [UIView]!
    
    var selectedLevel: Levels? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewsDifficultyLevels.forEach { (view) in
            view.backgroundColor = UIColor.gray
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            tap.delegate = self as? UIGestureRecognizerDelegate
            
            view.addGestureRecognizer(tap)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewsDifficultyLevels.forEach({ (view) in
            view.backgroundColor = UIColor.gray
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        selectedLevel = nil
    }
    
    @IBAction func buttonSubmit(_ sender: UIButton) {
        if selectedLevel != nil {
            self.performSegue(withIdentifier: "mathSegue", sender: self)
        } else {
            let alert = createAlert(withMessage: "Please select difficulty level", action: nil)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        
        selectedLevel = Levels(rawValue: (sender.view?.tag)!)
        
        viewsDifficultyLevels.forEach { (view) in
            if view.tag == sender.view?.tag {
                view.backgroundColor = UIColor.orange
            } else {
                view.backgroundColor = UIColor.gray
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mathSegue" {
            guard let destinationVC = segue.destination as? MathViewController else { return }
            destinationVC.level = selectedLevel!
        }
        
        if segue.identifier == "unwindSegue" {
            guard let previousVC = segue.source as? MathViewController else { return }
            labelScore.text = "your score is \(previousVC.score)"
        }
    }
}
