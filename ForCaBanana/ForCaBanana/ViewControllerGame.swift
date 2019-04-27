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
    
    var Portuguese: [WordComp] = [WordComp.init(word: "Banana", link: "3d542ec6f880b9ff7ce98baf35e0a8fa.jpg"), WordComp.init(word: "Abelha", link: "956450_1.jpg")]
    var game: GameMatch = GameMatch.init(word: "oi", link: "3d542ec6f880b9ff7ce98baf35e0a8fa.jpg")
    
    @IBOutlet weak var workImage: UIImageView!
    @IBOutlet weak var acertosLabel: UILabel!
    @IBOutlet weak var errosLabel: UILabel!
    @IBOutlet weak var gameWordTextField: UITextField!
    @IBOutlet weak var gameLetterTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errosLabel.text = ""
        self.acertosLabel.text = ""
        // Do any additional setup after loading the view.
    }

    @IBAction func enterLetterButtom(_ sender: Any) {
        
        self.addLetter(letter: (gameLetterTextField.text?.characters.first)!)
        self.gameLetterTextField.text = ""
        
    }
    
    @IBAction func entterWordButtom(_ sender: Any) {
        
        game = GameMatch.init(word: gameWordTextField.text!, link: "3d542ec6f880b9ff7ce98baf35e0a8fa.jpg")
        self.workImage.image = UIImage(named: game.Image)
        self.gameWordTextField.text = ""
        self.acertosLabel.text = ""
        self.errosLabel.text = ""
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addLetter(letter: Character){
        
        if game.isLetter(letter: letter){
            if !game.alreadySelected(letter: letter){
                self.acertosLabel.text = self.acertosLabel.text! + " " + String(letter)
            }
            game.addLetter(letter: letter)
        }else{
            if !game.alreadySelected(letter: letter){
                self.errosLabel.text = self.errosLabel.text! + " " + String(letter)
            }
            game.addLetter(letter: letter)
        }
        
    }
    @IBAction func voiceButtom(_ sender: Any) {
        TextToVoice(word: game.Word, lang: "pt-BR")
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
