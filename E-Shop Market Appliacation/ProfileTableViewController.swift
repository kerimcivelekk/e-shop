//
//  ProfileTableViewController.swift
//  E-Shop Market Appliacation
//
//  Created by Kerim Civelek on 30.09.2022.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var finishRegistrationButtonOutlet: UIButton!
    @IBOutlet weak var purchaseHistoryButtonOutlet: UIButton!
    
    // MARK: - Vars
    
    var editButtonOutlet: UIBarButtonItem!

    
    
    //MARK: - View Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Check logged in status
        
        checkLoginStatus()
        checkOnboardingStatus()
    }
    
    

    // MARK: - Tableview data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 3
    }

    
    // MARK: - Tableview delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
   
    // MARK: - Helpers
    
    private func checkOnboardingStatus(){
        
        if MUser.currentUser() != nil{
            
            if MUser.currentUser()!.onBoard{
                finishRegistrationButtonOutlet.setTitle("Account is Active", for: .normal)
                finishRegistrationButtonOutlet.isEnabled = false
            }else{
                finishRegistrationButtonOutlet.setTitle("Finish registration", for: .normal)
                finishRegistrationButtonOutlet.isEnabled = true
                finishRegistrationButtonOutlet.tintColor = .red
            }
            
        }else{
            finishRegistrationButtonOutlet.setTitle("Logged out", for: .normal)
            finishRegistrationButtonOutlet.isEnabled = false
            purchaseHistoryButtonOutlet.isEnabled = false
        }
        
    }
    
    

    private func checkLoginStatus(){
        
        if MUser.currentUser() == nil{
            createRightBarButton(title: "Login")
        }else{
            createRightBarButton(title: "Edit")
        }
    }
    
    private func createRightBarButton(title: String){
        
        editButtonOutlet = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(rightBarButtonItemPressed))
        
        self.navigationItem.rightBarButtonItem = editButtonOutlet
    }
    
    // MARK: - IBActions
    
    @objc func rightBarButtonItemPressed(){
        
        if editButtonItem.title == "Login"{
            //Show Login View
            showLoginView()
        }else{
            //Goto profile
            goToEditProfile()
        }
    }

    
    
    // MARK: - Navigation

    private func showLoginView(){
        let loginView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginView")
        
        self.present(loginView, animated: true)
    }
    
    private func goToEditProfile(){
        print("as")
    }


}
