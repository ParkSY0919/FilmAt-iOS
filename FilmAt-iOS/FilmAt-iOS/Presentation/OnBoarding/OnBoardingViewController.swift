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
        
        NetworkManager.shared.getTMDBAPI(apiHandler: .getCreditAPI(movieID: 610251), responseModel: CreditResponseModel.self) { result, networkResult in
            print("result: \(result)")
        }
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


