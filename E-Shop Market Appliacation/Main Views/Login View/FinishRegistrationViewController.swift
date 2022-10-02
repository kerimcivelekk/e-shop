//
//  FinishRegistrationViewController.swift
//  E-Shop Market Appliacation
//
//  Created by Kerim Civelek on 30.09.2022.
//

import UIKit
import JGProgressHUD

class FinishRegistrationViewController: UIViewController {
    
    //MARK: - IBOutles
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var surnameTextfield: UITextField!
    @IBOutlet weak var addressTextfield: UITextField!
    @IBOutlet weak var doneButtonOutlet: UIButton!
    
    
    //MARK: - Vars
    
    let hud = JGProgressHUD(style: .dark)

    
    
    //MARK: - View Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextfield.addTarget(self, action: #selector(self.textfieldDidChange(_:)), for: .editingChanged)
        surnameTextfield.addTarget(self, action: #selector(self.textfieldDidChange(_:)), for: .editingChanged)
                                   addressTextfield.addTarget(self, action: #selector(self.textfieldDidChange(_:)), for: .editingChanged)

       
    }
    
    @objc func textfieldDidChange(_ textfield: UITextField){
        updateDoneButtonStatus()
    }
    

 
    // MARK: - IBActions
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        finishOnboarding()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // MARK: - Helper
    
    private func updateDoneButtonStatus(){
        
        if nameTextfield.text != "" && surnameTextfield.text != "" && addressTextfield.text != ""{
            
            doneButtonOutlet.tintColor = .white
            doneButtonOutlet.backgroundColor = .black
            doneButtonOutlet.isEnabled = true
        }else{
            doneButtonOutlet.tintColor = .white
            doneButtonOutlet.backgroundColor = .gray
            doneButtonOutlet.isEnabled = false
        }
    }

    private func finishOnboarding(){
        
        let withValues: [String: Any] = [kFIRSTNAME: nameTextfield.text!, kLASTNAME: surnameTextfield.text!, kONBOARD: true, kFULLADDRESS: addressTextfield.text!, kFULLNAME: nameTextfield.text! + " " + surnameTextfield.text!]
        
        
        updateCurrentUserInFirestore(withValues: withValues) { error in
            
            if error == nil {
                self.hud.textLabel.text = "Updated!"
                self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 3)
                
                self.dismiss(animated: true)
            }else{
                print("Error updating user:",error!.localizedDescription)
                self.hud.textLabel.text = error!.localizedDescription
                self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 3)
            }
        }
    }

}
