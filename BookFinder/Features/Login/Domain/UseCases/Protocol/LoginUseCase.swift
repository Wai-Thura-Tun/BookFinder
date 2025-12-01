//
//  LoginUseCase.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 1/11/2568 BE.
//

import Foundation

protocol LoginUseCase {
    func execute(email: String, password: String) async -> Result<Void, AuthError>
}
