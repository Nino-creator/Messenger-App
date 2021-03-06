//
//  LoginViewController.swift
//  Messenger
//
//  Created by Nini mekhashishvili on 12/16/20.
//  Copyright © 2020 niniko mekhashishvili. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage (named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //Add fields and borders
    
    private let emailField: UITextField = {
       let field = UITextField()
        
       field.autocapitalizationType = .none
       field.autocorrectionType = .no
       field.returnKeyType = .continue
       field.layer.cornerRadius = 12
       field.layer.borderWidth = 1
       field.layer.borderColor = UIColor.lightGray.cgColor
       field.placeholder = "Email Address..."
       field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
       field.leftViewMode = .always
       field.backgroundColor = .white
       
       return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
         
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        field.backgroundColor = .white
          
        return field
       }()
    //Buttion
    private let loginButtion: UIButton = {
       let buttion = UIButton()
       buttion.setTitle("Log In", for: .normal)
       buttion.backgroundColor = .link
        buttion.setTitleColor(.white, for: .normal)
        buttion.layer.cornerRadius = 12
        buttion.layer.masksToBounds = true
        buttion.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
            
       return buttion
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        loginButtion.addTarget(self,
                               action: #selector(loginButtionTapped),
                               for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButtion)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        //frame our imageView (Layout)
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        
        passwordField.frame = CGRect(x: 30,
                                  y: emailField.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        
        loginButtion.frame = CGRect(x: 30,
                                     y: passwordField.bottom+10,
                                     width: scrollView.width-60,
                                     height: 52)
        
        
    }
    
    @objc private func loginButtionTapped() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count <= 6 else {
            alertUserLoginError()
            return
        }
        
        //Firebase Log in
    }
    //User alert
    func alertUserLoginError() {
        let alert = UIAlertController (title: "Woops",
                                       message: "Please enter all information to log in.",
                                       preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        
        present(alert, animated: true)
        
    }
    
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
   

}
extension LoginViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            loginButtionTapped()
        }
        
        return true
    }
    
}
