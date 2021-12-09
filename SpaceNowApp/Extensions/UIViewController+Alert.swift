//
//  UIViewController+Alert.swift
//  SpaceNowApp
//
//  Created by sonam taya on 9/12/21.
//

import UIKit

extension  UIViewController {

    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
