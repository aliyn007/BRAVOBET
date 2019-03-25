//
//  Alert.swift
//  BRAVOBET
//
//  Created by Александр on 26.06.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import Foundation
import UIKit


class Alert {
    class func show(textTitle: String, text: String, buttonTitle: String = "OK", view: UIViewController) {
        let action = UIAlertController(title: "\(textTitle)", message: "\(text)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "ОК", style: .default, handler: nil)
        action.addAction(actionOk)
        view.present(action, animated: true, completion: nil)
    }
}
