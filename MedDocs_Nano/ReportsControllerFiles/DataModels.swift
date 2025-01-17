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
    case everyday = "Everyday"
    case everyFewDays = "Every Few Days"
    // Consider more specific intervals like DAILY, WEEKLY, MONTHLY
}

// MARK: - Structs

struct User: Codable {
    var id: UUID
    var profile: ProfileInfo
    var loginInfo: UserLoginInfo
}

struct UserLoginInfo: Codable {
    var id: UUID
    var email: String
    var password: String
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

struct Dosage: Codable {
    var id: UUID
    var time: Date
}

struct Medication: Codable {
    var id: UUID
    var userId: UUID
    var medicineName: String
    var type: MedicineType
    var dosage: Int
    var notes: String
    var frequency: DosageFrequency
    var interval: Int?
    // Consider a separate DosageSchedule struct for more details
    var startDate: Date
    var endDate: Date?
    var time: Date
}

struct Appointment: Codable {
    var id: UUID
    var userId: UUID
    var clinicName: String
    var notes: String
    var time: Date // Changed from TimeInterval
    var date: Date
    var status: AppointmentStatus
}

struct Report: Codable {
    var id: UUID
    var userId: UUID
    var imagePath: String
    var time: Date // Changed from TimeInterval
    var date: Date
}

struct Prescription: Codable {
    var id: UUID
    var userId: UUID
    var imagePath: String
    var time: Date // Changed from TimeInterval
    var date: Date
}

struct Reports: Codable {
    var id: UUID
    var userId: UUID
    var tag: String
    var name: String
    var color: String
    var notes: String
    var prescriptions: [Prescription]
    var reports: [Report]
}

// MARK: - Data Models

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

    func addProfile(email: String, firstName: String, middleName: String?, lastName: String, DOB: Date, phoneNumber: String, sex: Gender, bloodType: BloodType, allergies: [AllergyType], address: String?) {
        let newProfile = ProfileInfo(
            id: UUID(),
            profileImage: nil,
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
    private var medicationData: [Medication] = []
    static let sharedMedicationData = MedicationDataModel()

    private init() {}

    func addMedication(userId: UUID, medicineName: String, dosage: Int, type: MedicineType, notes: String, frequency: DosageFrequency, interval: Int?, startDate: Date, endDate: Date?, time: Date) -> Medication {
        let newMedication = Medication(
            id: UUID(),
            userId: userId,
            medicineName: medicineName,
            type: type,
            dosage: dosage,
            notes: notes,
            frequency: frequency,
            interval: interval,
            startDate: startDate,
            endDate: endDate,
            time: time
        )
        medicationData.append(newMedication)
        return newMedication
    }

    func getMedications(for userId: UUID) -> [Medication] {
        return medicationData.filter { $0.userId == userId }
    }

    func deleteMedication(by id: UUID) {
        medicationData.removeAll { $0.id == id }
    }

    func editMedication(id: UUID, medicineName: String?, dosage: Int?, type: MedicineType?, notes: String?, frequency: DosageFrequency?, interval: Int?, startDate: Date?, endDate: Date?, time: Date?) {
        if let index = medicationData.firstIndex(where: { $0.id == id }) {
            if let medicineName = medicineName { medicationData[index].medicineName = medicineName }
            if let dosage = dosage { medicationData[index].dosage = dosage }
            if let type = type { medicationData[index].type = type }
            if let notes = notes { medicationData[index].notes = notes }
            if let frequency = frequency { medicationData[index].frequency = frequency }
            if let interval = interval { medicationData[index].interval = interval }
            if let startDate = startDate { medicationData[index].startDate = startDate }
            if let endDate = endDate { medicationData[index].endDate = endDate }
            if let time = time { medicationData[index].time = time }
        }
    }
}

class AppointmentDataModel {
    private var appointmentData: [Appointment] = []
    static let sharedAppointmentData = AppointmentDataModel()

    private init() {}

    func addAppointment(userId: UUID, clinicName: String, notes: String, time: Date, date: Date, status: AppointmentStatus) -> Appointment {
        let newAppointment = Appointment(
            id: UUID(),
            userId: userId,
            clinicName: clinicName,
            notes: notes,
            time: time, // Using Date directly
            date: date,
            status: status
        )
        appointmentData.append(newAppointment)
        return newAppointment
    }

    func getAppointments(for userId: UUID) -> [Appointment] {
        return appointmentData.filter { $0.userId == userId }
    }

    func deleteAppointment(by id: UUID) {
        appointmentData.removeAll { $0.id == id }
    }

    func editAppointment(id: UUID, clinicName: String?, notes: String?, time: Date?, date: Date?, status: AppointmentStatus?) {
        if let index = appointmentData.firstIndex(where: { $0.id == id }) {
            if let clinicName = clinicName { appointmentData[index].clinicName = clinicName }
            if let notes = notes { appointmentData[index].notes = notes }
            if let time = time { appointmentData[index].time = time }
            if let date = date { appointmentData[index].date = date }
            if let status = status { appointmentData[index].status = status }
        }
    }
}

class ReportsDataModel {
    private var reportsData: [Reports] = []
    static let sharedReportsData = ReportsDataModel()

    private init() {}

    func addReport(userId: UUID, tag: String, name: String, color: String, notes: String, prescription: [Prescription], report: [Report]) -> Reports {
        let newReport = Reports(
            id: UUID(),
            userId: userId,
            tag: tag,
            name: name,
            color: color,
            notes: notes,
            prescriptions: prescription,
            reports: report
        )
        reportsData.append(newReport)
        return newReport
    }

    func getReports(for userId: UUID) -> [Reports] {
        return reportsData.filter { $0.userId == userId }
    }

    func deleteReport(by id: UUID) {
        reportsData.removeAll { $0.id == id }
    }

    func editReport(id: UUID, tag: String?, name: String?, color: String?, notes: String?, prescription: [Prescription]?, report: [Report]?) {
        if let index = reportsData.firstIndex(where: { $0.id == id }) {
            if let tag = tag { reportsData[index].tag = tag }
            if let name = name { reportsData[index].name = name }
            if let color = color { reportsData[index].color = color }
            if let notes = notes { reportsData[index].notes = notes }
            if let prescription = prescription { reportsData[index].prescriptions = prescription }
            if let report = report { reportsData[index].reports = report }
        }
    }
}

class HomeScreenDataModel {
    static let shared = HomeScreenDataModel()

    private init() {}

    func fetchLatestAppointments(userId: UUID) -> [Appointment] {
        let allAppointments = AppointmentDataModel.sharedAppointmentData.getAppointments(for: userId)
        return Array(allAppointments.prefix(2))
    }

    func fetchLatestMedications(userId: UUID) -> [Medication] {
        let allMedications = MedicationDataModel.sharedMedicationData.getMedications(for: userId)
        return Array(allMedications.prefix(2))
    }

    func fetchUserProfile(userId: UUID) -> (profileImage: String?, fullName: String)? {
        if let profile = ProfileDataModel.sharedProfileData.getProfileByUserId(id: userId) {
            let fullName = [profile.firstName, profile.middleName, profile.lastName].compactMap { $0 }.joined(separator: " ")
            return (profile.profileImage, fullName)
        }
        return nil
    }

    func fetchHomeScreenData(userId: UUID) -> (appointments: [Appointment], medications: [Medication], profile: (String?, String)?) {
        let appointments = fetchLatestAppointments(userId: userId)
        let medications = fetchLatestMedications(userId: userId)
        let profile = fetchUserProfile(userId: userId)

        return (appointments, medications, profile)
    }
}
