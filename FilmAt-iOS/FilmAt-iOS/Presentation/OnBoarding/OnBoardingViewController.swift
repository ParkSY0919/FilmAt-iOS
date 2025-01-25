//
//  OnBoardingViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import UIKit

class OnBoardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("onboarding vc")
        view.backgroundColor = .red
        
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: Config.Keys.Plist.baseURL) as? String,
              let url = URL(string: baseURL) else {
            fatalError("🚨BASE_URL을 찾을 수 없습니다🚨")
        }
        
        guard let accessToken = Bundle.main.object(forInfoDictionaryKey: Config.Keys.Plist.accessToken) as? String else {
            fatalError("🚨BASE_URL을 찾을 수 없습니다🚨")
        }
        
        print("baseURL : \(baseURL)\n accessToken : \(accessToken)")
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
