//
//  ViewControllerTutorial1.swift
//  ForCaBanana
//
//  Created by student on 02/05/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerTutorial2: UIViewController {
    var leng: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if leng == "pt-BR"{
            self.textLabel.text = "Aperte no botão de som para ter uma dica de quais letras podem estar na palavra. Cuidado, você só tem 6 vidas."
        }else if self.leng == "en-US"{
            self.textLabel.text = "Press the sound button to get a hint of which letters may be in the word. Beware, you only have 6 lives."
        }else if self.leng == "es-MX"{
            self.textLabel.text = "Presione el botón de sonido para tener una pista de qué letras pueden estar en la palabra. Cuidado, sólo tienes 6 vidas."
        }else {
            self.textLabel.text = "Appuyez sur le bouton de son pour avoir une idée des lettres pouvant figurer dans le mot. Attention, vous n'avez que 6 vies."
        }
        TextToVoice(word: self.textLabel.text!, lang: self.leng)
        
    }
    @IBOutlet weak var textLabel: UITextView!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func TextToVoice(word: String, lang: String){
        let utter = AVSpeechUtterance(string: word)
        utter.voice = AVSpeechSynthesisVoice(language: lang)
        let voice = AVSpeechSynthesizer()
        voice.speak(utter)
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let novaView = segue.destination as? ViewControllerSelector{
            novaView.leng = self.leng
        }
        if let novaView = segue.destination as? ViewControllerTutorial1{
            novaView.leng = self.leng
        }
        
    }
    
    
}
