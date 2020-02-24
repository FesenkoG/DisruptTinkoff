//
//  KeycheinService.swift
//  Authentication-iOS13.0
//
//  Created by Georgy Fesenko on 24/02/2020.
//

import KeychainAccess

public protocol KeychainAuthenticationServiceProtocol {
    var isPinCodeExist: Bool { get }

    @discardableResult
    func storeUserCredentials(email: String, password: String) -> Error?
    @discardableResult
    func storePinCode(pinNumbers: [Int]) -> Error?

    func validatePinCode(pinNumbers: [Int]) -> Bool
    func validateCredentials(email: String, password: String) -> Bool

    @discardableResult
    func clear() -> Bool
}

public final class KeychainAuthenticationService: KeychainAuthenticationServiceProtocol {
    private enum Keys: String {
        case pin
        case email
        case password
    }
    private let keychain: Keychain

    public init(keychain: Keychain = Keychain()) {
        self.keychain = keychain
    }

    public var isPinCodeExist: Bool {
        do {
            return try keychain.get(Keys.pin.rawValue) != nil
        } catch {
            return false
        }
    }

    @discardableResult
    public func storeUserCredentials(email: String, password: String) -> Error? {
        do {
            try keychain.set(email, key: Keys.email.rawValue)
            try keychain.set(password, key: Keys.password.rawValue)
            return nil
        } catch {
            return error
        }
    }

    public func storePinCode(pinNumbers: [Int]) -> Error? {
        do {
            let pinNumbersString = convertArrayToString(pinNumbers)
            try keychain.set(pinNumbersString, key: Keys.pin.rawValue)
            return nil
        } catch {
            return error
        }
    }

    public func validatePinCode(pinNumbers: [Int]) -> Bool {
        do {
            let pinNumbersString = convertArrayToString(pinNumbers)
            return try keychain.get(Keys.pin.rawValue) == pinNumbersString
        } catch {
            return false
        }
    }

    public func validateCredentials(email: String, password: String) -> Bool {
        do {
            let storedEmail = try keychain.get(Keys.email.rawValue)
            let storedPassword = try keychain.get(Keys.password.rawValue)

            return storedEmail == email && storedPassword == password
        } catch {
            return false
        }
    }

    @discardableResult
    public func clear() -> Bool {
        do {
            try keychain.removeAll()
            return true
        } catch {
            return false
        }
    }

    internal func convertArrayToString(_ array: [Int]) -> String {
        return array.reduce(into: "") { $0 = $0 + String($1) }
    }
}
