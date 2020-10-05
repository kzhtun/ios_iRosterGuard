//
//  MainViewController.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 30/09/2020.
//

import UIKit
import LMCSideMenu
import FSCalendar

class MainViewController: UIViewController, LMCSideMenuCenterControllerProtocol, FSCalendarDelegate {
    let App = UIApplication.shared.delegate as! AppDelegate
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var interactor: MenuTransitionInteractor = MenuTransitionInteractor()
    
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mSubTitle: UILabel!
    
    @IBOutlet weak var mCalendar: FSCalendar!
    
    override func viewWillAppear(_ animated: Bool) {
        mTitle.textColor = UIColor.white
        mSubTitle.textColor = UIColor.white
        
        let currentDate = Date()
        
        // display format
        let format = DateFormatter()
        format.dateFormat = "E, dd-MMM-yyyy"
        format.timeZone = .some(TimeZone(abbreviation: "UTC+08")!)
        mSubTitle.text = format.string(from: currentDate).uppercased()
  
        mCalendar.layer.cornerRadius = 10;
        mCalendar.layer.masksToBounds = true;
        
    }
    
    @IBAction func menuOnClick(_ sender: Any) {
        presentLeftMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mCalendar.delegate = self

        let menuController = storyboard?.instantiateViewController(withIdentifier: String(describing: MenuController.self)) as! MenuController
       
        //Setup menu
        setupMenu(leftMenu: menuController, rightMenu: nil)
        
        //enable screen edge gestures if needed
        enableLeftMenuGesture()
        
        // Do any additional setup after loading the view.
        print("Main View Load")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
      
        let vc = self.storyBoard.instantiateViewController(withIdentifier: "JobListVC") as! JobListViewController

        vc.selectDate = date

        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
