//
//  ViewController.swift
//  Social
//
//  Created by Сергей Кулагин on 17.06.2021.
//

import UIKit
import Foundation

class Session {
    
    var token: String = ""
    var userId: Int = 0
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var firstLoadView: UIView!
    @IBOutlet weak var secondLoadView: UIView!
    @IBOutlet weak var thirdLoadView: UIView!
    
    
    
    
    let toTabBarSegueIdentifier = "fromLoginToTabBar"
    
    override func viewDidLoad() {
        loginButton.layer.cornerRadius = 10
        addTapToHideKeyboard()
    }
    
    
    func showAlert(message: String, completion: @escaping(UIAlertAction) -> Void) {
        let alertController = UIAlertController (title: "Ошибка авторизации", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction (title: "Повторить ввод", style: .cancel, handler: completion)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func animationLoginButton() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.09
        animation.repeatCount = 3
        animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: loginButton.center.x - 8, y: loginButton.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: loginButton.center.x + 8, y: loginButton.center.y))
    loginButton.layer.add(animation, forKey: "position")
    }
    
    func loadAnimation(exit: Int, currentCount: Int) {
        UIView.animate(withDuration: 0.8) {[weak self] in
        self?.firstLoadView.alpha = 0
        self?.secondLoadView.alpha = 1
    } completion: { _ in
        UIView.animate(withDuration: 0.8) {[weak self] in
            self?.secondLoadView.alpha = 0
            self?.thirdLoadView.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.8) {[weak self] in
                self?.thirdLoadView.alpha = 0
                self?.firstLoadView.alpha = 1
            } completion: {[weak self] _ in
                if currentCount < exit {
                self?.loadAnimation(exit: exit, currentCount: currentCount + 1)
                }
            else {
                self?.firstLoadView.alpha = 0
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstLoadView.alpha = 1
        secondLoadView.alpha = 0
        thirdLoadView.alpha = 0
        loadAnimation(exit: 15, currentCount: 0)
    }
    
    @IBAction func pressLoginButton(_ sender: Any) {
        if  let login = loginTextField.text,
            let password = passwordTextField.text,
        !login.isEmpty,
        !password.isEmpty,
        login == "1",
        password == "2" {
            performSegue(withIdentifier: toTabBarSegueIdentifier, sender: nil)
        }
        else {
            animationLoginButton()
            showAlert(message: "Неправильный логин или пароль") { _ in
            return
            }
        }
    }
}

    extension UIViewController {
        func addTapToHideKeyboard() {
            let tap = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
            view.addGestureRecognizer(tap)
        
    }
}
