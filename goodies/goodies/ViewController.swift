//
//  ViewController.swift
//  goodies
//
//  Created by Mac on 10/13/20.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var logoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        logoLabel.alpha = 0.2
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5) {
                self.logoLabel.textColor = .systemGreen
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
}

