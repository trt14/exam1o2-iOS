//
//  ViewController.swift
//  exam1o2
//
//  Created by Tarooti on 05/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnSkipRestart: UIButton!
    
    @IBOutlet weak var lblTimer: UILabel!
    
    @IBOutlet weak var lblRandomWord: UILabel!
    
    @IBOutlet weak var btnStartNext: UIButton!

    @IBOutlet weak var lblScore: UILabel!
    
    // CountDown for timer
    var CountDown = 59
    var timer :Timer!
    var score = 0
    //flag use it to start a timer
    var flag = 0
    // Display saved words (an array)
    var textWords = ""
    // Here you can insert any word to display to User
    var arr_words = ["heavy","shark","hare","watch","delay","sleep","pig","deer","cartoon","Strong","Coach","Quiz","Football","Ronaldo","Messi","fun","something"]
    // Used to save a correct one
    var arr_save_words = [String]()
    var RandomNumber :Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //init values for buttons and labels
        btnSkipRestart.isHidden = true
        btnStartNext.setTitle("Start Game", for: .normal)
        lblTimer.text = "01:00"
        lblScore.text = "Score : 0"
        lblRandomWord.text = ""
        
    }
    
  
    
    @IBAction func btnActionStartNext(_ sender: UIButton) {

        if flag == 0 {
            //start timer
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            flag = 1
            // start a new Word
            goNextWord(Skipped: 1)
            //Display a skip button
            btnSkipRestart.isHidden = false
            //init array to null
            arr_save_words = []
            //init label of score to 0 ;
            lblScore.text = "Score : 0"
            //init score to zero
            score = 0
            //init textWords to null
            textWords = ""
            // change button title to New Card
            btnStartNext.setTitle("New Card", for: .normal)



        }else{
            goNextWord(Skipped: 0)
            //increse a score +1
            score += 1
        }
        
    }
    //skip button
    @IBAction func btnActionSkip(_ sender: UIButton) {
        goNextWord(Skipped: 1)
    }
    
    
    func goNextWord(Skipped:Int){
        // 0 : to save a corrct one in array  , else User cicked one a skipped then go to next Word without save anything
        if Skipped == 0 {
            print("BeforeSkipped\(RandomNumber)")

            arr_save_words.append(arr_words[RandomNumber])
             RandomNumber = Int.random(in: 0..<arr_words.count)
            print("Skipped\(RandomNumber)")
            lblRandomWord.text = arr_words[RandomNumber]

        }else{
            RandomNumber = Int.random(in: 0..<arr_words.count)
           lblRandomWord.text = arr_words[RandomNumber]

        }
        
    }
    // update timer on every seconed
    @objc func updateTimer(){
        
        if CountDown > 0 {
            
            CountDown -= 1
            if(CountDown < 10 ){
                lblTimer.text = "00:0\(CountDown)"

            }else{
                lblTimer.text = "00:\(CountDown)"

            }
            //set a score
            lblScore.text = "Score :\(score)"


        }else{
            // End of timer
            timer.invalidate()
            CountDown = 59
            flag = 0
            btnStartNext.setTitle("Start Game", for: .normal)
            lblTimer.text = "01:00"
            btnSkipRestart.isHidden = true
            // saves words from array to text for display on label
            textWords = arr_save_words.joined(separator: "\n")
            lblRandomWord.text = textWords
            lblScore.text = "Score :\(score)"
        }

        
    }
    
    
    
}

