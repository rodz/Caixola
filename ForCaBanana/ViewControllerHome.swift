//
//  ViewControllerHome.swift
//  ForCaBanana
//
//  Created by student on 25/04/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class ViewControllerHome: UIViewController {
    var leng: String = "pt-BR"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.flagButtom.setTitle("Portugues", for: .normal)
        hide()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var portugueseButtom: UIButton!
    @IBAction func portugueseButtom(_ sender: Any) {
         self.flagButtom.setTitle("Portugues", for: .normal)
        self.leng = "pt-BR"
        hide()
    }
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var englishButtom: UIButton!
    @IBAction func englishButtom(_ sender: Any) {
        self.flagButtom.setTitle("English", for: .normal)
        self.leng = "en-US"
        hide()
    }
    @IBOutlet weak var frenchButtom: UIButton!
    @IBAction func frenchButtom(_ sender: Any) {
        self.flagButtom.setTitle("Francais", for: .normal)
        self.leng = "fr-FR"
        hide()
    }
    @IBOutlet weak var flagButtom: UIButton!
    @IBAction func flagButtom(_ sender: Any) {
        showFlags()
    }
    @IBOutlet weak var EspButtom: UIButton!
    @IBAction func EspButtom(_ sender: Any) {
        self.leng = "es-MX"
        self.flagButtom.setTitle("Espanol", for: .normal)
        hide()
    }
    func hide(){
        self.EspButtom.isHidden = true
        self.frenchButtom.isHidden = true
        self.portugueseButtom.isHidden = true
        self.englishButtom.isHidden = true
        self.backgroundLabel.isHidden = true
    }
    func showFlags(){
        self.EspButtom.isHidden = false
        self.frenchButtom.isHidden = false
        self.portugueseButtom.isHidden = false
        self.englishButtom.isHidden = false
        self.backgroundLabel.isHidden = false
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let novaView = segue.destination as? ViewControllerSelector{
            //novaView.corLabel.text = corTextField.text
            novaView.leng = self.leng
            
        }

    }

}
