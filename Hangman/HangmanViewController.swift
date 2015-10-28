//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var guessText: UITextField!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var incorrectLabel: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    
    
    var hangman:Hangman!
    var imageDictionary = [0:UIImage(named: "basic-hangman-img/hangman1.gif"),1:UIImage(named: "basic-hangman-img/hangman2.gif"), 2:UIImage(named: "basic-hangman-img/hangman3.gif"),
        3:UIImage(named: "basic-hangman-img/hangman4.gif"), 4:UIImage(named: "basic-hangman-img/hangman5.gif"),5:UIImage(named: "basic-hangman-img/hangman6.gif"),6:UIImage(named: "basic-hangman-img/hangman7.gif")]
    var incorrect = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessText.delegate = self
        reset()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func guessPressed(sender: AnyObject) {
        if incorrect >= 6 {
            return
        }
        else if hangman.answer == hangman.knownString{
            return
        }
        
        
        if let guess = guessText.text{
            if guess == ""{
                return
            }
            let i = guess.startIndex
            let letter = String(guess[i])
            let correct = hangman.guessLetter(letter.capitalizedString)
            if !correct {
               incorrect += 1
            }
            updateView()
            guessText.text = ""
        }
    }
    
    func updateView(){
        hangmanImage.image = imageDictionary[incorrect]!
        correctLabel.text = hangman.knownString
        if let str = hangman.guessedLetters as? AnyObject as? [String]{
            if str.count > 0 {
                incorrectLabel.text = str.description
            }
        }
    }
    
    
    func reset(){
        incorrect = 0
        hangman = Hangman()
        hangman.start()
        updateView()
        guessText.text = ""
        incorrectLabel.text = "Guessed Letters"
    }
    
    @IBAction func newGamePressed(sender: UIButton) {
        reset()
        
    }
    
}

