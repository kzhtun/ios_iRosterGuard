//
//  ViewController.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 27/09/2020.
//

import UIKit
import Toast_Swift

class LoginViewController: UIViewController {
    
    let App = UIApplication.shared.delegate as! AppDelegate
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var loginView: UIView!
    
    
    @IBOutlet weak var mGuardId: UITextField!
    @IBOutlet weak var mGuardIdLabel: UILabel!
    
    @IBOutlet weak var mPassword: UITextField!
    @IBOutlet weak var mPasswordLabel: UILabel!
    
    @IBOutlet weak var mLogin: UIButton!
    
    
    @IBAction func LoginOnClick(_ sender: UIButton) {
        
        if(validateFields()){
            callValidateUser()
        }
    }
    
    
    func validateFields()-> Bool{
        if(mGuardId.text == "") {
            mGuardIdLabel.text = "Guard ID should not be left blank"
            return false
        }
        
        if(mPassword.text == "") {
            mPasswordLabel.text = "Password should not be left blank"
            return false
        }
        
        return true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginView.layer.cornerRadius = 10;
        loginView.layer.masksToBounds = true;
        
        
        mTitle.textColor = UIColor.white
        
        mLogin.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1))
        mLogin.titleLabel?.textColor = UIColor.white
        mLogin.layer.cornerRadius = 20
        
        mGuardIdLabel.text = " "
        mPasswordLabel.text = " "
        
        mGuardId.text = "zTEST001"
        mPassword.text = "p@ssw0rd"
        
       
        print( getSecretKey(), getMobileKey())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Main View  Success")
    }
    
    
    private func callValidateUser(){
       // showLoading()
        
        Router.sharedInstance().ValidateUser(guardCode: mGuardId.text!, password: mPassword.text!, iNFC: "N", fcmToken: App.FCM_TOKEN, success:  { [self]
            (successObject) in
            
            // open Register Screen
            if( successObject.responsemessage?.uppercased() == "VALID"){
             //   self.dismissAlert()
                self.view.makeToast("VALID")
                
                App.GUARD_ID = mGuardId.text!
                App.AUT_TOKEN = successObject.token!
                
                let mainVC = self.storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
                
                mainVC.modalPresentationStyle = .fullScreen
                self.present(mainVC, animated: true, completion: nil)
                
            }else{ // open Message List Screen
            //    self.dismissAlert()
                self.view.makeToast("INVALID")
                //                self.view.makeToast("Registered device found.")
                //                self.App.AUT_TOKEN = successObject.token!
                //                self.getUserHP()
                     
                self.mGuardIdLabel.text = "Guard ID and Password does not match"
               
            }
            
            print(successObject)
            
            
        }, failure: {
            (failureObject) in
            print(failureObject as Any)
        })
        
    }
    
    private func showLoading(){
//        let alert = UIAlertController(title: nil, message: "Authenticating ...", preferredStyle: .alert)
//
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.medium
//        loadingIndicator.startAnimating();
//
//        alert.view.addSubview(loadingIndicator)
//        present(alert, animated: true, completion: nil)
    }
    
    internal func dismissAlert() {
        if let vc = self.presentedViewController, vc is UIAlertController {
            dismiss(animated: false, completion: nil)
        }
    }
}



