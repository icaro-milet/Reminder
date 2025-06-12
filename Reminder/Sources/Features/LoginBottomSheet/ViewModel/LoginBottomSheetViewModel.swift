//
//  LoginBottomSheetViewModel.swift
//  Reminder
//
//  Created by milet on 12/06/25.
//

import Foundation
import Firebase

class LoginBottomSheetViewModel {
    
    func doAuth(usernameLogin: String, password: String) {
        print(usernameLogin)
        Auth.auth().signIn(withEmail: usernameLogin, password: password) { [weak self] authResult, error in
            if let error = error {
                print("autenticação falhou \(error)")
            } else {
                print("Sucesso", authResult)
            }
        }
    }
}
