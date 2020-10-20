//
//  MenuController.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 01/10/2020.
//

import UIKit

class MenuController: UIViewController {
    let App = UIApplication.shared.delegate as! AppDelegate
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var MenuTableView: UITableView!
    
    @IBOutlet weak var mWelcomeMsg: UILabel!
    @IBOutlet weak var mLastLogin: UILabel!
    
    var menuArray = [
        ["m_dashboard", "CALENDAR"],
        ["m_joblist", "JOB LIST by SITE"],
        ["m_joblist", "JOB LIST by WEEK"],
        ["m_profile", "PROFILE"],
        ["m_logout", "LOGOUT"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MenuTableView.tableFooterView = UIView()
       
        mWelcomeMsg.text = "Welcome " + App.currentProfile!.guardname
        
        let format = DateFormatter()
        format.timeZone = .some(TimeZone(abbreviation: "UTC+08")!)
        format.dateFormat = "dd-MMM-yyyy hh:mm a"
        
        mLastLogin.text = "Last Login: \(format.string(from: Date()))"
        
    }
  
    override func viewDidAppear(_ animated: Bool) {
        print("View Did Appear")
    }
   
}

// MARK: Extension
extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        cell.configure(icon: menuArray[indexPath.row][0]
        , menuName: menuArray[indexPath.row][1])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        switch indexPath.item{
        case 0:
            let mainVC = self.storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC, animated: false, completion: nil)
            break

        case 1:
            let jobVC = self.storyBoard.instantiateViewController(withIdentifier: "JobListVC") as! JobListViewController
            jobVC.isGroup = true
            jobVC.modalPresentationStyle = .fullScreen
            self.present(jobVC, animated: false, completion: nil)
            break
            
        case 2:
            let jobVC = self.storyBoard.instantiateViewController(withIdentifier: "JobListVC") as! JobListViewController
            jobVC.isGroup = false
            jobVC.modalPresentationStyle = .fullScreen
            self.present(jobVC, animated: false, completion: nil)
            break

        case 3:
            let profileVC = self.storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
          
            profileVC.modalPresentationStyle = .fullScreen
            self.present(profileVC, animated: false, completion: nil)
            break
            
        case 4:
            let loginVC = self.storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
          
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: false, completion: nil)
            break
            
        default:
            print("Click Default")
        }

    }
}
