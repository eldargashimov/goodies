//
//  ViewController.swift
//  goodies
//
//  Created by Mac on 10/13/20.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var logoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = LightColors.lightGreen
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5) {
                self.logoLabel.textColor = LightColors.green
                self.logoLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.logoLabel.alpha = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    UIView.animate(withDuration: 0.5) {
                        self.logoLabel.transform = .identity
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            self.performSegue(withIdentifier: "launchForMain", sender: nil)
                        }
                    }
                }
            }
        }
    }
    
//    private func getRecipies() -> [DishParse.Recipe] {
//
//        let parser = Parser()
//        var dishes = [DishParse.Recipe]()
//        DispatchQueue.global().async {
//            let idArray = parser.getIdArray(count: 5) { [weak self] alert in
//                self?.present(alert, animated: true, completion: nil)
//                Parser.internetConnectIsEnable = false.self
//            }
//            dishes = parser.getRecipes(idArray: idArray){ [weak self] alert in
//                self?.present(alert, animated: true, completion: nil)
//                Parser.internetConnectIsEnable = false.self
//            }
//        }
//        return dishes
//    }
}

