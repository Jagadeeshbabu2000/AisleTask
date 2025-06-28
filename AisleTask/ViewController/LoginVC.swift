
import UIKit

class LoginVC: UIViewController {

// MARK: - Setup UI
    
    var PhoneNumber = ""
    
    var otpTitleLbl: UILabel = {
    let otpTitleLbl = UILabel()
        otpTitleLbl.text = "Get OTP"
        otpTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        otpTitleLbl.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return otpTitleLbl
    }()
    
    var PhoneNumberTitleLbl:UILabel = {
        let PhoneNumberTitleLbl = UILabel()
        PhoneNumberTitleLbl.text = "Enter Your \nPhone Number"
        PhoneNumberTitleLbl.numberOfLines = 0
        PhoneNumberTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        PhoneNumberTitleLbl.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return PhoneNumberTitleLbl
    }()
    
    var countryCodeTF: UITextField = {
        let textField = UITextField()
        textField.text = "+91"
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textField.isEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var PhoneNumberTF:UITextField = {
        let PhoneNumberTF = UITextField()
        PhoneNumberTF.placeholder = "Enter PhoneNumber "
        PhoneNumberTF.keyboardType = .numberPad
        PhoneNumberTF.borderStyle = .roundedRect
        PhoneNumberTF.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        PhoneNumberTF.translatesAutoresizingMaskIntoConstraints = false
        return PhoneNumberTF
    }()
    
    var ContinueBtn:UIButton = {
        let ContinueBtn = UIButton()
        ContinueBtn.setTitle("Continue", for: .normal)
        ContinueBtn.setTitleColor(.black, for: .normal)
        ContinueBtn.backgroundColor = UIColor(named: "GoldenYellow")
        ContinueBtn.translatesAutoresizingMaskIntoConstraints = false
        ContinueBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        ContinueBtn.layer.cornerRadius = 20
        return ContinueBtn
    }()
 
    var param = [String: Any]()
    var indicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetupConstrants()
    }
    
// MARK: Setup UIElements Constrants
    
    func SetupConstrants() {
        
        PhoneNumberTF.text = PhoneNumber
        
        PhoneNumberTF.delegate = self
        ContinueBtn.addTarget(self, action: #selector(GotoOtpScreen), for: .touchUpInside)
        ContinueBtn.isEnabled = false
        ContinueBtn.alpha = 0.5
        PhoneNumberTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        
        self.view.addSubview(otpTitleLbl)
        self.view.addSubview(PhoneNumberTitleLbl)
        self.view.addSubview(countryCodeTF)
        self.view.addSubview(PhoneNumberTF)
        self.view.addSubview(ContinueBtn)

        
        NSLayoutConstraint.activate([
            otpTitleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            otpTitleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            otpTitleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            PhoneNumberTitleLbl.topAnchor.constraint(equalTo: otpTitleLbl.bottomAnchor, constant: 10),
            PhoneNumberTitleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            PhoneNumberTitleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            countryCodeTF.topAnchor.constraint(equalTo: PhoneNumberTitleLbl.bottomAnchor, constant: 10),
            countryCodeTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            countryCodeTF.widthAnchor.constraint(equalToConstant: 64),
            countryCodeTF.heightAnchor.constraint(equalToConstant: 44),
            
            PhoneNumberTF.topAnchor.constraint(equalTo: PhoneNumberTitleLbl.bottomAnchor, constant: 10),
            PhoneNumberTF.leadingAnchor.constraint(equalTo: countryCodeTF.leadingAnchor, constant: 80),
            PhoneNumberTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            PhoneNumberTF.heightAnchor.constraint(equalToConstant: 44),
            
            ContinueBtn.topAnchor.constraint(equalTo: countryCodeTF.bottomAnchor, constant: 30),
            ContinueBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            ContinueBtn.heightAnchor.constraint(equalToConstant: 44),
            ContinueBtn.widthAnchor.constraint(equalToConstant: 100),
    
        ])
        
    }
    
    @objc func GotoOtpScreen() {
        validatePhoneNumber()
    }
    
    @objc func textFieldDidChange() {
        let tfData = (PhoneNumberTF.text ?? "").trimmingCharacters(in: .whitespaces)
        ContinueBtn.isEnabled = tfData.count == 10
        ContinueBtn.alpha = tfData.count == 10 ? 1.0 : 0.5
    }
    
    
   private func validatePhoneNumber() {
        let phoneNumber = (PhoneNumberTF.text ?? "").trimmingCharacters(in: .whitespaces)
        
        guard !phoneNumber.isEmpty else {
            PhoneNumberTF.showError("Enter Phone Number")
            return
        }
        
        guard phoneNumber.count == 10 else {
            PhoneNumberTF.showError("Enter 10 Digit Number")
            return
        }
        
        guard GenericHelper().isIndianMobileNumber(phoneNumber) else {
            PhoneNumberTF.showError("Invalid Phone Number")
            return
        }
    
        param = ["number": "+91\(phoneNumber)"]
       
        showActivityIndicator(indicatorView)
       APIHandler.shared.postAPI(url: "\(WebAPI().BASEURL)\(WebAPI().LoginAPI)", parameters: param) { [self](result: Result<PhoneNumberModel, Error>) in
           self.hideIndicatorLoader(indicatorView)
           DispatchQueue.main.async { [self] in
               switch result {
               case .success(let response):
                   print("API Success: \(response)")
                   if response.status {
                       print("Login success, navigate to OTP screen")
                       // Navigation to OTP Screen
                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                       vc.strPhoneNumber = PhoneNumberTF.text  ?? ""
                       self.navigationController?.pushViewController(vc, animated: true)
                   } else {
                       self.showAlert(title: "Error", message: "Invalid response from server.")
                   }
                   
               case .failure(let error):
                   print("API Failure: \(error.localizedDescription)")
                   self.showAlert(title: "Error", message: error.localizedDescription)
               }
           }
       }
    }

}

// MARK: Extension TF Delegate

extension LoginVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
                guard let stringRange = Range(range, in: currentText) else {
                return false
            }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
           
        if updatedText.count > 10 {
           return false
        }
    
        return true
    }
    
}


