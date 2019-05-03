//
//  ViewControllerGame.swift
//  ForCaBanana
//
//  Created by student on 26/04/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerGame: UIViewController {
    
    
    
    var idiom: String = "pt-BR"
    var level: Int = 1
    var Portuguese: [WordComp] = [WordComp.init(word: "banana", link: "banana8Bits"), WordComp.init(word: "bala", link: "bala8bits")]
    var English: [WordComp] = [WordComp.init(word: "banana", link: "banana8Bits"), WordComp.init(word: "bee", link: "abelha8bits"), WordComp.init(word: "alien", link: "allien8bits")]
    var Spanish: [WordComp] = [WordComp.init(word: "banana", link: "banana8Bits"), WordComp.init(word: "anana", link: "abacaxi8bits")]
    var French: [WordComp] = [WordComp.init(word: "banane", link: "banana8Bits")]
    
    var game: GameMatch = GameMatch.init(word: "oi", link: "3d542ec6f880b9ff7ce98baf35e0a8fa.jpg")
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var workImage: UIImageView!
    @IBOutlet weak var acertosLabel: UILabel!
    @IBOutlet weak var errosLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(level)
        print(idiom)
        setUp(language: idiom, level: level)
        self.errosLabel.text = ""
        self.acertosLabel.text = ""
        self.gameOverBad.isHidden = true
        self.gameOverGood.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var gameOverBad: UIButton!
    @IBAction func gameOverBad(_ sender: Any) {
        setUp(language: self.idiom, level: self.level)
        self.gameOverBad.isHidden = true
    }
    @IBOutlet weak var gameOverGood: UIButton!
    @IBAction func gameOverGood(_ sender: Any) {
        setUp(language: self.idiom, level: self.level)
        self.gameOverGood.isHidden = true

    }
    func setUp(language: String, level: Int){
        var pala : WordComp
        if language == "pt-BR"{
            let random = Int(arc4random_uniform(UInt32(Portuguese.count)))
            pala = Portuguese[random]
        }else if language == "en-US"{
            let random = Int(arc4random_uniform(UInt32(English.count)))
            pala = English[random]
        }else if language == "es-MX"{
            let random = Int(arc4random_uniform(UInt32(Spanish.count)))
            pala = Spanish[random]
        }else {
            let random = Int(arc4random_uniform(UInt32(French.count)))
            pala = French[random]
        }
        
        if level == 3{
            self.voiceButtom.isHidden = true
        }
        
        game = GameMatch.init(word: pala.Word, link: pala.Image)
        self.workImage.image = UIImage(named: game.Image)
        self.acertosLabel.text = ""
        self.errosLabel.text = ""
        self.wordLabel.text = game.getInicialString()
        
    }

    /*
    @IBAction func enterLetterButtom(_ sender: Any) {
        
        self.addLetter(letter: (gameLetterTextField.text?.characters.first)!)
        self.gameLetterTextField.text = ""
        
    }
    
    @IBAction func entterWordButtom(_ sender: Any) {
        
        game = GameMatch.init(word: gameWordTextField.text!, link: "3d542ec6f880b9ff7ce98baf35e0a8fa.jpg")
        self.workImage.image = UIImage(named: game.Image)
        self.acertosLabel.text = ""
        self.errosLabel.text = ""
        
    }
    */
    @IBAction func entterLetterButtom(_ sender: Any) {
        LetraDAO.getLetra { (letra) in
            self.addLetter(letter: String(describing: letra.letra).characters.first!)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addLetter(letter: Character){
        if game.isLetter(letter: letter){
            if !game.alreadySelected(letter: letter){
                self.acertosLabel.text = self.acertosLabel.text! + " " + String(letter)
                self.wordLabel.text = game.putNewLetter(atual: self.wordLabel.text!, letra: letter)
                
            }
            game.addLetter(letter: letter)
        }else{
            if !game.alreadySelected(letter: letter){
                self.errosLabel.text = self.errosLabel.text! + " " + String(letter)
            }
            game.addLetter(letter: letter)
        }
        
        if game.isGameOver(){
            if game.Lifes == 0{
                self.gameOverBad.isHidden = false
            }else{
                self.gameOverGood.isHidden = false
            }
        }
        
    }
    @IBOutlet weak var voiceButtom: UIButton!
    @IBAction func voiceButtom(_ sender: Any) {
        TextToVoice(word: game.Word, lang: self.idiom)
        if self.level == 2{
            self.voiceButtom.isHidden = true
        }
    }
    
    func TextToVoice(word: String, lang: String){
        let utter = AVSpeechUtterance(string: word)
        utter.voice = AVSpeechSynthesisVoice(language: lang)
        let voice = AVSpeechSynthesizer()
        voice.speak(utter)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
