//
//  ProfileViewController.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 07/10/2020.
//

import UIKit
import LMCSideMenu

class ProfileViewController: UIViewController, LMCSideMenuCenterControllerProtocol {
    let App = UIApplication.shared.delegate as! AppDelegate
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var interactor: MenuTransitionInteractor = MenuTransitionInteractor()
    
    @IBOutlet weak var mSubmit: UIButton!
    
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mGuardName: UILabel!
    @IBOutlet weak var mGuardId: UILabel!
    @IBOutlet weak var mGuardPos: UILabel!
    @IBOutlet weak var mPhone: UILabel!
  
    @IBOutlet weak var mNewPassword: UITextField!
    @IBOutlet weak var mConfirmPassword: UITextField!
    
    
    @IBOutlet weak var mNewPasswordLabel: UILabel!
    
    @IBOutlet weak var mConfirmPasswordLabel: UILabel!
    
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var passwordInfoView: UIView!
    
    
    @IBAction func mSubmitOnClick(_ sender: Any) {
        
        if(validatePassword()){
            callUpdatePassword()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayProfileData()
        
        mSubmit.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1))
        mSubmit.titleLabel?.textColor = UIColor.white
        mSubmit.layer.cornerRadius = 20
        
        mNewPasswordLabel.text = " "
        mConfirmPasswordLabel.text = " "
        
        
        userInfoView.layer.cornerRadius = 10
        userInfoView.layer.masksToBounds = true;
        
        passwordInfoView.layer.cornerRadius = 10
        passwordInfoView.layer.masksToBounds = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let menuController = storyboard?.instantiateViewController(withIdentifier: String(describing: MenuController.self)) as! MenuController
       
        mNewPassword.layer.cornerRadius = 12
        mNewPassword.layer.masksToBounds = true
        mNewPassword.setLeftPaddingPoints(10)
        
        mConfirmPassword.layer.cornerRadius = 12
        mConfirmPassword.layer.masksToBounds = true
        mConfirmPassword.setLeftPaddingPoints(10)
        
        //Setup menu
        setupMenu(leftMenu: menuController, rightMenu: nil)
        
        //enable screen edge gestures if needed
        enableLeftMenuGesture()
    }
    
    @IBAction func menuOnClick(_ sender: Any) {
        presentLeftMenu()
    }
    
    private func displayProfileData(){
        mGuardId.text = App.currentProfile?.guardcode
        mGuardName.text = App.currentProfile?.guardname
        mPhone.text = App.currentProfile?.HPNo
    }
    
    private func callUpdatePassword(){
        Router.sharedInstance().UpdatePassword(guardId: App.GUARD_ID, password:  mNewPassword.text!, success:  {
            (successObject) in
            
            if( successObject.responsemessage?.uppercased() == "VALID"){
               self.view.makeToast("Update password success ")
                
                // Alert Dialog
                let alert = UIAlertController(title:"" , message: "Your password has been changed successfully. Do you want to logout now.", preferredStyle: .alert)
                
                
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    
                    let loginVC = self.storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
                  
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: false, completion: nil)
                    
                }))
                
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
                
            }else{ // open Message List Screen
                self.view.makeToast(successObject.responsemessage)
            }
            
        }, failure: {
            (failureObject) in
            print(failureObject as Any)
        })
    }
    
    func validatePassword()->Bool{
        mNewPasswordLabel.text = " "
        mConfirmPasswordLabel.text = " "
        
        if(mNewPassword.text == ""){
            mNewPasswordLabel.text = " New password should not be left blank"
            return false
        }
        
        if(mConfirmPassword.text == ""){
            mConfirmPasswordLabel.text = " Confirm password should not be left blank"
            return false
        }
        
        if(mNewPassword.text != mConfirmPassword.text){
            mConfirmPasswordLabel.text = " New password and confirm password does not match"
            return false
        }
        
        return true
    }
}
