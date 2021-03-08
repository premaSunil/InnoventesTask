//
//  PanValidationViewModel.swift
//  RegistrationDemo
//
//  Created by mnarasimha murthy on 06/03/21.
//

import Foundation

class PanValidationViewModel: NSObject {
    
    func validatePan(_ panString: String) -> Bool {
        let regularExpression = "[A-Z]{3}(P|H){1}[A-Z]{1}[0-9]{4}[A-Z]{1}"
        let panCardValidation = NSPredicate(format : "SELF MATCHES %@", regularExpression)
        return panCardValidation.evaluate(with: panString)
    }
    
    func dateOfValidation( _ dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        if dateFormatter.date(from: dateString) != nil {
            return true
        } else {
            return false
        }
    }

}
