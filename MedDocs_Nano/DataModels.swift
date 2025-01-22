//
//  DataModels.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 16/01/25.
//

import Foundation

// MARK: - Enums

enum Gender: String, CaseIterable, Codable {
    case male = "Male"
    case female = "Female"
}

enum BloodType: String, CaseIterable, Codable {
    case aPositive = "A+"
    case aNegative = "A-"
    case bPositive = "B+"
    case bNegative = "B-"
    case abPositive = "AB+"
    case abNegative = "AB-"
    case oPositive = "O+"
    case oNegative = "O-"
    case unknown = "Unknown"
}

enum ReportsType: String, CaseIterable, Codable {
    case pdf = "PDF"
    case jpg = "JPG"
}

enum AppointmentStatus: String, CaseIterable, Codable {
    case pending = "Pending"
    case visited = "Visited"
    case skipped = "Skipped"
}

enum AllergyType: String, CaseIterable, Codable {
    case food = "Food"
    case drug = "Drug"
    case environmental = "Environmental"
    case other = "Other"
}

enum MedicineType: String, CaseIterable, Codable {
    case tablet = "Tablet"
    case capsule = "Capsule"
    case syrup = "Syrup"
}

enum DosageFrequency: String, CaseIterable, Codable {
    case everyDay = "EveryDay"
    case everyFewDays = "Every Few Days"
}

// MARK: - Structs

struct Dosage: Codable {
    var id: UUID
    var time: Date
}

struct Medication: Codable {
    var id: UUID
    var userId: UUID
    var medicineName: String
    var hospitalName: String
    var doctorName: String
    var type: MedicineType
    var dosage: Int
    var notes: String
    var frequency: DosageFrequency
    var interval: Int?
    var startDate: Date
    var endDate: Date?
    var time: Date
    var tags: [String]
}


struct Appointment: Codable {
    var id: UUID
    var userId: UUID
    var doctorName: String
    var hospitalName: String
    var tag: String
    var notes: String
    var time: Date
    var date: Date
    var status: AppointmentStatus
}

struct Report: Codable {
    var id: UUID
    var userId: UUID
    var imagePath: String
    var time: Date
    var date: Date
}

struct Prescription: Codable {
    var id: UUID
    var userId: UUID
    var imagePath: String
    var time: Date
    var date: Date
}

struct ProfileInfo: Codable {
    var id: UUID
    var profileImage: String?
    var email: String
    var firstName: String
    var middleName: String?
    var lastName: String
    var dob: Date
    var phoneNumber: String
    var sex: Gender
    var bloodType: BloodType
    var allergies: [AllergyType]
    var address: String?
}

struct UserLoginInfo: Codable {
    var id: UUID
    var email: String
    var password: String
}

struct User: Codable {
    var id: UUID
    var profile: ProfileInfo
    var loginInfo: UserLoginInfo
}

struct tags: Codable {
    var id: UUID
    var userId: UUID
    var tagName: String
    var hospitalName: String
    var appointment: [String]
    var medication: [String]
    var notes: String
    var prescriptions: [Prescription]
    var reports: [Report]
}

// MARK: - Data Models

class UserLoginDataModel {
    static let shared = UserLoginDataModel()
    private var userLogins: [UUID: UserLoginInfo] = [:]

    private init() {}

    // Register a new user
    func registerUser(email: String, password: String) -> UUID? {
        // Check if the email is already registered
        if userLogins.values.contains(where: { $0.email == email }) {
            print("Email is already registered.")
            return nil
        }

        // Create a new user ID and store the login info
        let userId = UUID()
        let userInfo = UserLoginInfo(id: userId, email: email, password: password)
        userLogins[userId] = userInfo
        return userId
    }

    // Get user by email and password (Login simulation)
    func getUser(email: String, password: String) -> UUID? {
        for (id, userInfo) in userLogins {
            if userInfo.email == email && userInfo.password == password {
                return id
            }
        }
        print("Invalid email or password.")
        return nil
    }

    // Delete a user by their ID
    func deleteUser(by id: UUID) {
        if userLogins[id] != nil {
            userLogins.removeValue(forKey: id)
            print("User deleted successfully.")
        } else {
            print("User not found.")
        }
    }

    // List all registered users (for testing or debugging)
    func listAllUsers() {
        for (id, userInfo) in userLogins {
            print("User ID: \(id), Email: \(userInfo.email)")
        }
    }
}


class UserDataModel {
    private var users: [User] = []
    static let sharedUserData = UserDataModel()

    private init() {}

    func registerUser(email: String, password: String, profile: ProfileInfo) -> User {
        let newUser = User(
            id: UUID(),
            profile: profile,
            loginInfo: UserLoginInfo(id: UUID(), email: email, password: password)
        )
        users.append(newUser)
        return newUser
    }

    func loginUser(email: String, password: String) -> User? {
        return users.first { $0.loginInfo.email == email && $0.loginInfo.password == password }
    }

    func deleteUser(by id: UUID) {
        users.removeAll { $0.id == id }
    }

    func editUser(id: UUID, email: String?, password: String?, profile: ProfileInfo?) {
        if let index = users.firstIndex(where: { $0.id == id }) {
            if let email = email { users[index].loginInfo.email = email }
            if let password = password { users[index].loginInfo.password = password }
            if let profile = profile { users[index].profile = profile }
        }
    }
}

class ProfileDataModel {
    private var profiles: [ProfileInfo] = []
    static let sharedProfileData = ProfileDataModel()

    private init() {}

    func addProfile(
        userId: UUID,
        profileImage: String?,
        email: String,
        firstName: String,
        middleName: String?,
        lastName: String,
        DOB: Date,
        phoneNumber: String,
        sex: Gender,
        bloodType: BloodType,
        allergies: [AllergyType],
        address: String?
    ) -> ProfileInfo {
        let newProfile = ProfileInfo(
            id: userId, // Use the same ID as the user
            profileImage: profileImage,
            email: email,
            firstName: firstName,
            middleName: middleName,
            lastName: lastName,
            dob: DOB,
            phoneNumber: phoneNumber,
            sex: sex,
            bloodType: bloodType,
            allergies: allergies,
            address: address
        )
        profiles.append(newProfile)
        return newProfile
    }


    func getProfileByUserId(id: UUID) -> ProfileInfo? {
        return profiles.first { $0.id == id }
    }

    func deleteProfile(by id: UUID) {
        profiles.removeAll { $0.id == id }
    }

    func editProfile(id: UUID, profileImage: String?, email: String?, firstName: String?, middleName: String?, lastName: String?, DOB: Date?, phoneNumber: String?, sex: Gender?, bloodType: BloodType?, allergies: [AllergyType]?, address: String?) {
        if let index = profiles.firstIndex(where: { $0.id == id }) {
            if let profileImage = profileImage { profiles[index].profileImage = profileImage }
            if let email = email { profiles[index].email = email }
            if let firstName = firstName { profiles[index].firstName = firstName }
            if let middleName = middleName { profiles[index].middleName = middleName }
            if let lastName = lastName { profiles[index].lastName = lastName }
            if let DOB = DOB { profiles[index].dob = DOB }
            if let phoneNumber = phoneNumber { profiles[index].phoneNumber = phoneNumber }
            if let sex = sex { profiles[index].sex = sex }
            if let bloodType = bloodType { profiles[index].bloodType = bloodType }
            if let allergies = allergies { profiles[index].allergies = allergies }
            if let address = address { profiles[index].address = address }
        }
    }
}

class MedicationDataModel {
    private var medications: [Medication] = []
    static let sharedMedicationData = MedicationDataModel()

    private init() {}

    func addMedication(userId: UUID, medicineName: String, dosage: Int, type: MedicineType, notes: String, frequency: DosageFrequency, interval: Int?, startDate: Date, endDate: Date?, time: Date) -> Medication {
        let newMedication = Medication(
            id: UUID(),
            userId: userId,
            medicineName: medicineName,
            hospitalName: "Hospital Name", // Example
            doctorName: "Doctor Name", // Example
            type: type,
            dosage: dosage,
            notes: notes,
            frequency: frequency,
            interval: interval,
            startDate: startDate,
            endDate: endDate,
            time: time,
            tags: [] // Empty array for now
        )
        medications.append(newMedication)
        return newMedication
    }

    func getMedications(for userId: UUID) -> [Medication] {
        return medications.filter { $0.userId == userId }
    }

    func deleteMedication(by id: UUID) {
        medications.removeAll { $0.id == id }
    }

    func editMedication(id: UUID, medicineName: String?, dosage: Int?, type: MedicineType?, notes: String?, frequency: DosageFrequency?, interval: Int?, startDate: Date?, endDate: Date?, time: Date?) {
        if let index = medications.firstIndex(where: { $0.id == id }) {
            if let medicineName = medicineName { medications[index].medicineName = medicineName }
            if let dosage = dosage { medications[index].dosage = dosage }
            if let type = type { medications[index].type = type }
            if let notes = notes { medications[index].notes = notes }
            if let frequency = frequency { medications[index].frequency = frequency }
            if let interval = interval { medications[index].interval = interval }
            if let startDate = startDate { medications[index].startDate = startDate }
            if let endDate = endDate { medications[index].endDate = endDate }
            if let time = time { medications[index].time = time }
        }
    }
}

class AppointmentDataModel {
    private var appointments: [Appointment] = []
    static let sharedAppointmentData = AppointmentDataModel()

    private init() {}

    func addAppointment(userId: UUID, doctorName: String, hospitalName: String, tag: String, notes: String, time: Date, date: Date, status: AppointmentStatus) -> Appointment {
        let newAppointment = Appointment(
            id: UUID(),
            userId: userId,
            doctorName: doctorName,
            hospitalName: hospitalName,
            tag: tag,
            notes: notes,
            time: time,
            date: date,
            status: status
        )
        appointments.append(newAppointment)
        return newAppointment
    }

    func getAppointments(for userId: UUID) -> [Appointment] {
        return appointments.filter { $0.userId == userId }
    }

    func deleteAppointment(by id: UUID) {
        appointments.removeAll { $0.id == id }
    }

    func editAppointment(id: UUID, doctorName: String?, hospitalName: String?, tag: String?, notes: String?, time: Date?, date: Date?, status: AppointmentStatus?) {
        if let index = appointments.firstIndex(where: { $0.id == id }) {
            if let doctorName = doctorName { appointments[index].doctorName = doctorName }
            if let hospitalName = hospitalName { appointments[index].hospitalName = hospitalName }
            if let tag = tag { appointments[index].tag = tag }
            if let notes = notes { appointments[index].notes = notes }
            if let time = time { appointments[index].time = time }
            if let date = date { appointments[index].date = date }
            if let status = status { appointments[index].status = status }
        }
    }
}

class ReportDataModel {
    private var reports: [Report] = []
    static let sharedReportData = ReportDataModel()

    private init() {}

    func addReport(userId: UUID, imagePath: String, time: Date, date: Date) -> Report {
        let newReport = Report(
            id: UUID(),
            userId: userId,
            imagePath: imagePath,
            time: time,
            date: date
        )
        reports.append(newReport)
        return newReport
    }

    func getReports(for userId: UUID) -> [Report] {
        return reports.filter { $0.userId == userId }
    }

    func deleteReport(by id: UUID) {
        reports.removeAll { $0.id == id }
    }

    func editReport(id: UUID, imagePath: String?, time: Date?, date: Date?) {
        if let index = reports.firstIndex(where: { $0.id == id }) {
            if let imagePath = imagePath { reports[index].imagePath = imagePath }
            if let time = time { reports[index].time = time }
            if let date = date { reports[index].date = date }
        }
    }
}
