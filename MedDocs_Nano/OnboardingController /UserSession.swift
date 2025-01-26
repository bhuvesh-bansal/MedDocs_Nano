import Foundation

class UserSession {
    static let shared = UserSession()
    
    private let userDefaults = UserDefaults.standard
    private let userDataModel = UserDataModel.sharedUserData
    
    private init() {}
    
    var currentUser: User? {
        guard let userId = userDefaults.string(forKey: "loggedInUserId"),
              let uuid = UUID(uuidString: userId) else {
            return nil
        }
        
        return userDataModel.getAllUsers().first { $0.userId == uuid }
    }
    
    func logout() {
        userDefaults.removeObject(forKey: "loggedInUserId")
        userDefaults.synchronize()
    }
    
    var isLoggedIn: Bool {
        return currentUser != nil
    }
}
