//
//  ViewController.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 27/09/2020.
//


import UIKit
import Toast_Swift
import BEMCheckBox


class LoginViewController: UIViewController {
    
    let App = UIApplication.shared.delegate as! AppDelegate
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    @IBOutlet weak var mRemember: BEMCheckBox!
    
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var mGuardId: UITextField!
    @IBOutlet weak var mGuardIdLabel: UILabel!
    
    @IBOutlet weak var mPassword: UITextField!
    @IBOutlet weak var mPasswordLabel: UILabel!
    
    @IBOutlet weak var mLogin: UIButton!
    
   @IBOutlet weak var loginTopConstraint: NSLayoutConstraint!
   
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
        
//        mGuardId.text = "zTEST001"
//        mPassword.text = "p@ssw0rd"
     
        mGuardId.layer.cornerRadius = 15.0
        mGuardId.layer.masksToBounds = true
        mGuardId.setLeftPaddingPoints(10)
        
        mPassword.layer.cornerRadius = 15.0
        mPassword.layer.masksToBounds = true
        mPassword.setLeftPaddingPoints(10)
        
//        mRemember.boxType = BEMBoxType.square
//       
//        mRemember.lineWidth = 3
//        mRemember.animationDuration = 0.2
        
        
        print( getSecretKey(), getMobileKey())
      
        registerKeyboardNotifications()
      
      // get pref data
      let GuardID = UserDefaults.standard.string(forKey: "GuardID")
      let GuardPassword = UserDefaults.standard.string(forKey: "GuardPassword")
      
      if(GuardID != nil){
         mRemember.on = true
         mGuardId.text = GuardID
         mPassword.text = GuardPassword
      }
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
                
                callGetProfile()
                
                if(mRemember.on){
                  saveRememberMeInfo()
                }else{
                  deleteRememberMeInfo()
                }
               
                let mainVC = self.storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
                
                mainVC.modalPresentationStyle = .fullScreen
                self.present(mainVC, animated: true, completion: nil)
                
            }else{ // open Message List Screen
            //    self.dismissAlert()
                self.view.makeToast("INVALID")
               
                self.mGuardIdLabel.text = "Guard ID and Password does not match"
            }
            
            print(successObject)
            
            
        }, failure: {
            (failureObject) in
            print(failureObject as Any)
        })
        
    }
    
   private func saveRememberMeInfo(){
      UserDefaults.standard.set(mGuardId.text, forKey: "GuardID")
      UserDefaults.standard.set(mPassword.text, forKey: "GuardPassword")
   }
   
   private func deleteRememberMeInfo(){
      UserDefaults.standard.removeObject(forKey: "GuardID")
      UserDefaults.standard.removeObject(forKey: "GuardPassword")
   }
   
    private func callGetProfile(){
        Router.sharedInstance().GerUserProfile(guardId: App.GUARD_ID, success:  {
            (successObject) in
            
            if( successObject.responsemessage?.uppercased() == "SUCCESS"){
               self.view.makeToast("Fetching profile data success ")
                
                self.App.currentProfile = successObject.ProfileDetails![0]
           
                
            }else{ // open Message List Screen
                self.view.makeToast(successObject.responsemessage)
            }
            
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


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


extension LoginViewController {

   
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
      loginTopConstraint.constant =  100
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      print("keyboardWillHide")
    }
}



