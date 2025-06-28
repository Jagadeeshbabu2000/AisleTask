import Foundation
import UIKit

class GenericHelper {
    
    func isIndianMobileNumber(_ strData: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
            if strData.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
                return false
            }
            guard strData.count == 10, let firstChar = strData.first else {
                return false
            }
            return ["6", "7", "8", "9"].contains(String(firstChar))
    }
    
    
}

extension UITextField {
    func showError(_ textData:String) {
        dismissError()
        let labelError = UILabel(frame: CGRect(x: 0, y: 46, width: 300, height: 18))
        labelError.text = textData
        labelError.tag = 786
        labelError.font = UIFont.systemFont(ofSize: 16, weight: .light)
        labelError.textColor = UIColor.red
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 7.8
        self.addSubview(labelError)
    }
    
    func dismissError() {
        if let tferror = self.viewWithTag(786){
            tferror.removeFromSuperview()
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.layer.borderWidth = 1.0
        }
        
    }
}

extension UIViewController {
    
    func showActivityIndicator(_ indicator:UIActivityIndicatorView) {
        if #available(iOS 13.0, *) {
            indicator.style = UIActivityIndicatorView.Style.large
        }
        indicator.color = .lightGray
        indicator.center = view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func hideIndicatorLoader(_ indicator:UIActivityIndicatorView) {
        DispatchQueue.main.async {
            indicator.stopAnimating()
        }
    }
    
    func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    
    
}

class strstore {
    static var strToken = ""
}
