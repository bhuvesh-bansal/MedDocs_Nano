class UserManager {
    static let shared = UserManager()
    private var users: [AppUser] = []
    private var currentUser: AppUser?
    
    private init() {}
    
    // Login functionality
    func login(email: String, password: String) -> Bool {
        guard let user = users.first(where: { $0.email == email && $0.password == password }) else {
            return false
        }
        currentUser = user
        return true
    }
    
    // Sign up functionality
    func signUp(email: String, password: String) -> Bool {
        // Check if user already exists
        guard !users.contains(where: { $0.email == email }) else {
            return false
        }
        
        // Validate email and password
        guard AppUser.isValidEmail(email) && AppUser.isValidPassword(password) else {
            return false
        }
        
        let newUser = AppUser(email: email, password: password)
        users.append(newUser)
        currentUser = newUser
        return true
    }
    
    // Forgot password functionality
    func resetPassword(email: String) -> Bool {
        guard let index = users.firstIndex(where: { $0.email == email }) else {
            return false
        }
        // In a real app, you would send an email with a reset code
        // For this example, we'll just return true if the email exists
        return true
    }
    
    // Verify reset code
    func verifyCode(email: String, code: String) -> Bool {
        // In a real app, you would verify the code
        // For this example, we'll just check if the code is "1234"
        return code == "1234"
    }
    
    // Logout functionality
    func logout() {
        currentUser = nil
    }
    
    // Get current user
    func getCurrentUser() -> AppUser? {
        return currentUser
    }
}

