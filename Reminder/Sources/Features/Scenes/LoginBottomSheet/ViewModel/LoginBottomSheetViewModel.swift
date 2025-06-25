//
//  LoginBottomSheetViewModel.swift
//  Reminder
//
//  Created by milet on 12/06/25.
//

import Foundation
import Firebase

class LoginBottomSheetViewModel {
    var successResult: ((String) -> Void)?
    var errorResult: ((String) -> Void)?
    
    func doAuth(usernameLogin: String, password: String) {
        print("autenticação feita do sucesso")
        Auth.auth().signIn(withEmail: usernameLogin, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.errorResult?("Erro ao realizar login, verifique as credenciais")
            } else {
                self?.successResult?(usernameLogin)
            }
        }
    }
}
