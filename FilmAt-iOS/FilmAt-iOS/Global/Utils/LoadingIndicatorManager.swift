//
//  LoadingIndicatorManager.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 2/1/25.
//

import UIKit

final class LoadingIndicatorManager {
    
    static func showLoading() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else { return }

            let loadingIndicatorView: UIActivityIndicatorView
            
            if let existedView = window.subviews.first(where: { $0 is UIActivityIndicatorView } ) as? UIActivityIndicatorView {
                loadingIndicatorView = existedView
            } else {
                loadingIndicatorView = UIActivityIndicatorView(style: .large)
                
                loadingIndicatorView.frame = window.frame
                loadingIndicatorView.color = UIColor(resource: .gray2)
                window.addSubview(loadingIndicatorView)
            }

            loadingIndicatorView.startAnimating()
        }
    }
    
    static func hideLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            guard let window = UIApplication.shared.windows.last else { return }
            window.subviews.filter({ $0 is UIActivityIndicatorView }).forEach { $0.removeFromSuperview() }
        }
    }
    
}
