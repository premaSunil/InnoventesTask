//
//  Toast.swift
//  RegistrationDemo
//
//  Created by Sunil.Godhumala on 06/03/21.
//

import UIKit
enum ToastPosition: Int {
    case top
    case middle
    case bottom
}

class Toast: UIView {
    @IBOutlet weak var labelToast: UILabel!
    @IBOutlet private weak var contentView: UIView!
    private var toastTitle: String!
    
    // MARK: - Button Actions
    @IBAction private func buttonCrossTapped(_ sender: Any) {
        let window = UIApplication.shared.windows.first
        if let toastView  = window?.viewWithTag(999) as? Toast {
            UIView.animate(withDuration: 0.2, animations: {
                toastView.alpha = 0.0
            }) { (_) in
                toastView.removeFromSuperview()
            }
        }    }
    
    func removeToast() {
        let window = UIApplication.shared.windows.first
        if let toastView  = window?.viewWithTag(999) as? Toast {
            toastView.removeFromSuperview()
        }
    }
    
    class func show(withText text: String, position: ToastPosition, withduration: Double? = 3.0) {
        
        DispatchQueue.main.async {
            let window = UIApplication.shared.windows.first
            let toastView = Bundle.main.loadNibNamed(R.nib.toast.name, owner: self, options: nil)?.first as! Toast
            toastView.translatesAutoresizingMaskIntoConstraints = false
            toastView.removeToast()
            toastView.labelToast.text = text
            toastView.labelToast.textColor = .white
            toastView.contentView.backgroundColor = UIColor.disableAppColorButton()
            toastView.layoutIfNeeded()
            toastView.tag = 999
            toastView.alpha = 0.0
            window?.addSubview(toastView)
            window?.bringSubviewToFront(toastView)

            UIView.animate(withDuration: 0.2, animations: {
                toastView.alpha = 1.0
            }) { (_) in
                DispatchQueue.main.asyncAfter(deadline: .now() + withduration!) {
                    UIView.animate(withDuration: 0.2, animations: {
                        toastView.alpha = 0.0
                    }) { (_) in
                        toastView.removeFromSuperview()
                    }
                }
            }
            
            switch position {
            case .top:
                let centerXContraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window!, attribute: .centerX, multiplier: 1.0, constant: 0)
                let topYConstraint = NSLayoutConstraint(item: toastView, attribute: .top, relatedBy: .equal, toItem: window!, attribute: .top, multiplier: 1.0, constant: 40)
                let leadingContraint = NSLayoutConstraint(item: toastView, attribute: .left, relatedBy: .greaterThanOrEqual, toItem: window!, attribute: .left, multiplier: 1.0, constant: 10)
                let trailingContraint = NSLayoutConstraint(item: window!, attribute: .right, relatedBy: .greaterThanOrEqual, toItem: toastView, attribute: .right, multiplier: 1.0, constant: 10)
                
                window?.addConstraint(centerXContraint)
                window?.addConstraint(topYConstraint)
                window?.addConstraint(leadingContraint)
                window?.addConstraint(trailingContraint)
            case .middle:
                let centerXContraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window!, attribute: .centerX, multiplier: 1.0, constant: 0)
                let centerYConstraint = NSLayoutConstraint(item: toastView, attribute: .centerY, relatedBy: .equal, toItem: window!, attribute: .centerY, multiplier: 1.0, constant: 0)
                let leadingContraint = NSLayoutConstraint(item: toastView, attribute: .left, relatedBy: .greaterThanOrEqual, toItem: window!, attribute: .left, multiplier: 1.0, constant: 10)
                let trailingContraint = NSLayoutConstraint(item: toastView, attribute: .right, relatedBy: .greaterThanOrEqual, toItem: window!, attribute: .right, multiplier: 1.0, constant: 10)
                
                window?.addConstraint(centerXContraint)
                window?.addConstraint(centerYConstraint)
                window?.addConstraint(leadingContraint)
                window?.addConstraint(trailingContraint)
            case .bottom:
                let centerXContraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window!, attribute: .centerX, multiplier: 1.0, constant: 0)
                centerXContraint.priority = UILayoutPriority(rawValue: 970)
                let bottomYConstraint = NSLayoutConstraint(item: toastView, attribute: .centerY, relatedBy: .equal, toItem: window!, attribute: .centerY, multiplier: 1.0, constant: 0)
                let leadingContraint = NSLayoutConstraint(item: toastView, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: window!, attribute: .bottom, multiplier: 1.0, constant: 40)
                let trailingContraint = NSLayoutConstraint(item: toastView, attribute: .right, relatedBy: .greaterThanOrEqual, toItem: window!, attribute: .right, multiplier: 1.0, constant: 10)
                
                window?.addConstraint(centerXContraint)
                window?.addConstraint(bottomYConstraint)
                window?.addConstraint(leadingContraint)
                window?.addConstraint(trailingContraint)
            }
        }

    }
}


import Toast

struct MakeToast {
    
    func showMakeTostTop(viewcontroller: UIViewController, message: String ) {
        var tostStyle = ToastStyle()
        tostStyle.backgroundColor = UIColor.enableAppColorButton()
        tostStyle.messageColor = UIColor.white
//        tostStyle.messageFont = R.font.nunitoRegular(size: 10)!
        viewcontroller.view.makeToast(message, duration: 0.6, position: .bottom, style: tostStyle)
    }
}

extension UIColor {
    
    static func enableAppColorButton() -> UIColor {
        return UIColor(red: 0.00, green: 0.45, blue: 0.81, alpha: 1.00)
    }
    
    static func disableAppColorButton() -> UIColor {
        return UIColor(red: 0.54, green: 0.75, blue: 0.94, alpha: 1.00)
    }
    
}
