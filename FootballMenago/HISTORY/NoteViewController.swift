//
//  NoteViewController.swift
//  FootballMenago
//
//  Created by Artur on 15/03/2021.
//

import UIKit

class NoteViewController: UIViewController {

    var jsonGame: JsonClassGames?
    
    //Labels:
    @IBOutlet weak var fastNoteLabel: UILabel!
    @IBOutlet weak var fazeAtackPlusLabel: UILabel!
    @IBOutlet weak var fazeAttackMinusLabel: UILabel!
    @IBOutlet weak var fazeDefPlusLabel: UILabel!
    @IBOutlet weak var fazeDefMinusLabel: UILabel!
    
    //TextViews:
    @IBOutlet weak var fastNoteTV: UITextView!
    @IBOutlet weak var fazeAttackPlusTV: UITextView!
    @IBOutlet weak var fazeAttackMinusTV: UITextView!
    @IBOutlet weak var fazeDefPlusTV: UITextView!
    @IBOutlet weak var fazeDefMinusTV: UITextView!
    
    //Button's
    @IBOutlet weak var backButtons: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad(){
        jsonGame = JsonClassGames()
        let game = jsonGame?.gamesObject?.games[Tmp.tmpGame]
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
        
        fastNoteTV.text = game?.fastNote
        fazeAttackPlusTV.text = game?.attackFazePlus
        fazeAttackMinusTV.text = game?.attackFazeMinus
        fazeDefPlusTV.text = game?.defenseFazePlus
        fazeDefMinusTV.text = game?.defenseFazeMinus
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        // MARK: Zapisz Button Clicked
        let alert = UIAlertController(title: "Potwierdzenie", message: "Czy na pewno chcesz zapisać zmiany?", preferredStyle: UIAlertController.Style.alert)
        
        let tak = UIAlertAction(title: "Zapisz", style: .default, handler:{(action) -> Void in self.saveFunc()})
        let nie = UIAlertAction(title: "Anuluj", style: .cancel, handler:{(action) -> Void in })
        nie.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(tak)
        alert.addAction(nie)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveFunc() {
        var game = jsonGame?.gamesObject?.games[Tmp.tmpGame]
        game?.fastNote = fastNoteTV.text
        game?.attackFazePlus = fazeAttackPlusTV.text
        game?.attackFazeMinus = fazeAttackMinusTV.text
        game?.defenseFazePlus = fazeDefPlusTV.text
        game?.defenseFazeMinus = fazeDefMinusTV.text
        
        jsonGame?.gamesObject?.games[Tmp.tmpGame] = game!
        jsonGame?.save()
        
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        // MARK: Back Button Clicked
        let alert = UIAlertController(title: "Uwaga", message: "Chcesz wyjść bez zapisywania?", preferredStyle: UIAlertController.Style.alert)
        
        let tak = UIAlertAction(title: "Zapisz i Wyjdź", style: .default, handler:{(action) ->
            Void in
            self.saveFunc()
            self.exitFunc()
        })
        let nie = UIAlertAction(title: "Wyjdź", style: .cancel, handler:{(action) -> Void in self.exitFunc()})
        nie.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(tak)
        alert.addAction(nie)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func exitFunc() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GameHistoryView")
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.frame
        self.view.addSubview(nextViewController.view)
    }
    
}
