//
//  OTPVC.swift
//  AisleTask
//
//  Created by K V Jagadeesh babu on 26/06/25.
//

import UIKit

class OTPVC: UIViewController {
    
    var strPhoneNumber = ""
    var timer: Timer?
    var totalTime = 59
    

    var param = [String: Any]()
    let indicatorView = UIActivityIndicatorView()
    
    var PhoneNumberTitleLbl: UILabel = {
        let PhoneNumberTitleLbl = UILabel()
        PhoneNumberTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        PhoneNumberTitleLbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return PhoneNumberTitleLbl
    }()
    
    var EditBtn: UIButton = {
        let EditBtn = UIButton()
        EditBtn.setImage(UIImage(named: "Edit"), for: .normal)
        EditBtn.translatesAutoresizingMaskIntoConstraints = false
        return EditBtn
    }()
    
    var OTPTitleLbl:UILabel = {
        let OTPTitleLbl = UILabel()
        OTPTitleLbl.text = "Enter The\nOTP"
        OTPTitleLbl.numberOfLines = 0
        OTPTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        OTPTitleLbl.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return OTPTitleLbl
    }()
    
    var OTPTF:UITextField = {
        let OTPTF = UITextField()
        OTPTF.placeholder = "Enter OTP "
        OTPTF.keyboardType = .numberPad
        OTPTF.borderStyle = .roundedRect
        OTPTF.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        OTPTF.translatesAutoresizingMaskIntoConstraints = false
        return OTPTF
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
    
    var TimerLbl:UILabel = {
        let TimerLbl = UILabel()
        TimerLbl.translatesAutoresizingMaskIntoConstraints = false
        TimerLbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        TimerLbl.text = "0.60"
        return TimerLbl
    }()
    var ResendBtn: UIButton = {
        let ResendBtn = UIButton()
        ResendBtn.setTitle("Resend", for: .normal)
        ResendBtn.setTitleColor(.black, for: .normal)
        ResendBtn.translatesAutoresizingMaskIntoConstraints = false
        ResendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        ResendBtn.isHidden = true
        return ResendBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupConstrants()
        startTimer()
    }
    
    
    // MARK: Setup UIElements Constrants
    
    func SetupConstrants() {
        
        EditBtn.addTarget(self, action: #selector(GoToEditScreen), for: .touchUpInside)
        ResendBtn.addTarget(self, action: #selector(resendOTPTapped), for: .touchUpInside)
        OTPTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        ContinueBtn.addTarget(self, action: #selector(GotoTabbarVC), for: .touchUpInside)
        
        
        OTPTF.delegate = self
        view.addSubview(PhoneNumberTitleLbl)
        view.addSubview(EditBtn)
        view.addSubview(OTPTitleLbl)
        view.addSubview(OTPTF)
        view.addSubview(ContinueBtn)
        view.addSubview(TimerLbl)
        view.addSubview(ResendBtn)
        
        
        
        PhoneNumberTitleLbl.text = "+91\(strPhoneNumber)"
        NSLayoutConstraint.activate([
            
            PhoneNumberTitleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            PhoneNumberTitleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            PhoneNumberTitleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            EditBtn.centerYAnchor.constraint(equalTo: PhoneNumberTitleLbl.centerYAnchor),
            EditBtn.leadingAnchor.constraint(equalTo: PhoneNumberTitleLbl.leadingAnchor, constant: 169),
            EditBtn.widthAnchor.constraint(equalToConstant: 20),
            EditBtn.heightAnchor.constraint(equalToConstant: 20),
            
            OTPTitleLbl.topAnchor.constraint(equalTo: PhoneNumberTitleLbl.topAnchor, constant: 35),
            OTPTitleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            OTPTF.topAnchor.constraint(equalTo: OTPTitleLbl.bottomAnchor, constant: 15),
            OTPTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            OTPTF.widthAnchor.constraint(equalToConstant: 120),
            OTPTF.heightAnchor.constraint(equalToConstant: 44),
            
            
            ContinueBtn.topAnchor.constraint(equalTo: OTPTF.bottomAnchor, constant: 30),
            ContinueBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            ContinueBtn.heightAnchor.constraint(equalToConstant: 44),
            ContinueBtn.widthAnchor.constraint(equalToConstant: 100),
            
            TimerLbl.topAnchor.constraint(equalTo: OTPTF.bottomAnchor, constant: 38),
            TimerLbl.leadingAnchor.constraint(equalTo: ContinueBtn.leadingAnchor, constant: 110),
            
            ResendBtn.topAnchor.constraint(equalTo: OTPTF.bottomAnchor, constant: 38),
            ResendBtn.leadingAnchor.constraint(equalTo: ContinueBtn.leadingAnchor,constant: 110),
            
        ])
        
    }
    
    @objc func GoToEditScreen() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        vc.PhoneNumber = strPhoneNumber
        self.navigationController?.popViewController(animated: true)
    }
    
    //Set Timer
    func startTimer() {
        TimerLbl.text = "01:00"
        totalTime = 59
        timer?.invalidate()
        TimerLbl.isHidden = false
        ResendBtn.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if totalTime > 0 {
            let minutes = totalTime / 60
            let seconds = totalTime % 60
            TimerLbl.text = String(format: "%02d:%02d", minutes, seconds)
            totalTime -= 1
        } else {
            timer?.invalidate()
            timer = nil
            TimerLbl.isHidden = true
            ResendBtn.isHidden = false
        }
    }
    
    @objc func resendOTPTapped() {
        print("Resend OTP tapped")
        startTimer()
    }
    
    @objc func textFieldDidChange() {
        let tfData = (OTPTF.text ?? "").trimmingCharacters(in: .whitespaces)
        ContinueBtn.isEnabled = tfData.count == 4
        ContinueBtn.alpha = tfData.count == 4 ? 1.0 : 0.5
    }
    
    @objc func GotoTabbarVC() {
        validateOTP()
    }
    
    private func validateOTP() {
        _ = (OTPTF.text ?? "").trimmingCharacters(in: .whitespaces)
        
        param = ["number": "+91\(strPhoneNumber)",
                 "otp": "\(OTPTF.text ?? "")"]
        
        showActivityIndicator(indicatorView)
        APIHandler.shared.postAPI(url: "\(WebAPI().BASEURL)\(WebAPI().OTPAPI)", parameters: param) { (result: Result<OTPModel, Error>) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let response):
                    hideIndicatorLoader(indicatorView)
                    print("API Success: \(response)")
                    if !response.token.isEmpty {
                        strstore.strToken = response.token
                        print("OTP success, navigate to Tab bar screen")
                        // Navigation to Tab bar Screen
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        self.showAlert(title: "Error", message: "Enter wrong OTP.")
                    }
                    
                case .failure(let error):
                    hideIndicatorLoader(indicatorView)
                    print("API Failure: \(error.localizedDescription)")
                    self.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
}

// MARK: Extension TF Delegate

extension OTPVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
                guard let stringRange = Range(range, in: currentText) else {
                return false
            }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
           
        if updatedText.count > 4 {
           return false
        }
    
        return true
    }
    
}

