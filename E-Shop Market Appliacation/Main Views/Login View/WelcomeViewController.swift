//
//  WelcomeViewController.swift
//  E-Shop Market Appliacation
//
//  Created by Kerim Civelek on 28.09.2022.
//

import UIKit
import JGProgressHUD
import NVActivityIndicatorView

class WelcomeViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var resendButtonOutlet: UIButton!
    
    
    
    //MARK: - Vars
    
    let hud = JGProgressHUD(style: .dark)
    var activityIndicator: NVActivityIndicatorView?
    
    
    
    //MARK: - View Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextfield.isSecureTextEntry = true

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: view.frame.width/2 - 30, y: view.frame.height/2 - 30, width: 60, height: 60), type: .ballPulse, color: .black, padding: nil)
    }
    

    //MARK: - IBActions

    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismissView()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if textFieldHaveText(){
            //Login User
            loginUser()
            
        }else{
            hud.textLabel.text = "All fields are required"
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 3)
        }
        
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        if textFieldHaveText(){
            //Register User
            registerUser()
            
        }else{
            hud.textLabel.text = "All fields are required"
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 3)
        }
    }
    
    
    @IBAction func forgotButtonPressed(_ sender: Any) {
        
        if emailTextfield.text != ""{
            resetThePassword()
        }else{
            hud.textLabel.text = "Please insert email!"
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 3)
        }
    }
    
    
    @IBAction func resendMailButtonPressed(_ sender: Any) {
        
        guard let emailTextfield = emailTextfield.text else {return}
        
        MUser.resendVerificationEmail(email: emailTextfield) { error in
            print("Error resending email:", error!.localizedDescription)
        }
    }
    
    
    
    
    //MARK: - Login User
    
    private func loginUser(){
        
        showLoadingIndicator()
        
        MUser.loginUserWith(email: emailTextfield.text!, password: passwordTextfield.text!) { error, isEmailVerified in
            
            if error == nil {
                
                if isEmailVerified{
                    
                    self.dismissView()
                    print("Email is verified")
                }else{
                    self.hud.textLabel.text = "Please Verify Your Email!"
                    self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.hud.show(in: self.view)
                    self.hud.dismiss(afterDelay: 3)
                    self.resendButtonOutlet.isHidden = false
                }
            }else{
                print("Error login in the user", error!.localizedDescription)
                self.hud.textLabel.text = error!.localizedDescription
                self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 3)
            }
            
            self.hideLoadingIndicator()
        }
    }
    
    

    
   
    //MARK: - Register User
    
    private func registerUser(){
        showLoadingIndicator()
        
        MUser.registerUserWith(email: emailTextfield.text!, password: passwordTextfield.text!) { error in
            
            if error == nil{
                
                self.hud.textLabel.text = "Verification email sent!"
                self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 3)
                
                self.emailTextfield.text = ""
                self.passwordTextfield.text = ""
            }else{
                print("Error registiration:",error!.localizedDescription)
                self.hud.textLabel.text = "All fields are required or \(error!.localizedDescription)"
                self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 3)
                
                self.emailTextfield.text = ""
                self.passwordTextfield.text = ""
            }
            self.hideLoadingIndicator()
        }
    }

    
    
    //MARK: - Helpers
    
    private func resetThePassword(){
        
        guard let email = emailTextfield.text else{return}
        
        MUser.resetPasswordFor(email: email) { error in
            if error == nil{
                self.hud.textLabel.text = "Reset password email sent!"
                self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 3)
            }else{
                self.hud.textLabel.text = error!.localizedDescription
                self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 3)
            }
        }
    }
    
    
    private func textFieldHaveText()-> Bool{
        return (emailTextfield.text != "" && passwordTextfield.text != "")
    }
    
    
    private func dismissView(){
        self.dismiss(animated: true)
    }
    
    
    //MARK: - Activity Indicator
    
    private func showLoadingIndicator(){
        
        if activityIndicator != nil {
            self.view.addSubview(activityIndicator!)
            activityIndicator!.startAnimating()
        }
    }

    private func hideLoadingIndicator(){
        
        if activityIndicator != nil {
            activityIndicator!.removeFromSuperview()
            activityIndicator!.stopAnimating()
        }
    }
}
