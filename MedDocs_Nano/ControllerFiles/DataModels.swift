//
//  DataModels.swift
//  MedDocs
//
//  Created by student-2 on 10/12/24.

import Foundation
import UIKit

// MARK: - Enums



// MARK: - Gender

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
}

enum BloodType: String, CaseIterable {
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

enum ReportsType: String, CaseIterable {
    case pdf = "PDF"
    case jpg = "JPG"
}

enum AppointmentStatus: String, CaseIterable {
    case pending = "Pending"
    case visited = "Visited"
    case skipped = "Skipped"
}

enum AllergyType: String, CaseIterable {
    case food = "Food"
    case drug = "Drug"
    case environmental = "Environmental"
    case other = "Other"
}

enum MedicineType: String, CaseIterable {
    case tablet = "Tablet"
    case capsule = "Capsule"
    case syrup = "Syrup"
}

enum DosageFrequency: String, CaseIterable {
    case everyday = "Everyday"
    case everyFewDays = "Every Few Days"
}

struct UserLoginInfo {
    var id: UUID
    var email: String
    var password: String
}

struct ProfileInfo {
    var id: UUID
    var profileImage: String?
    var email: String
    var firstName: String
    var lastName: String
    var dob: Date
    var phoneNumber: String
    var sex: Gender
    var bloodType: BloodType
    var allergies: [AllergyType]
    var address: String?
}

struct Dosage {
    var id: UUID
    var time: Date
}

struct Medication {
    var id: UUID
    var userId: UUID
    var medicineName: String
    var type: MedicineType
    var dosage: Int
    var notes: String
    var frequency: DosageFrequency
    var interval: Int?
    var dosageInterval: [Dosage]
    var startDate: Date
    var endDate: Date?
    var time: Date
}

struct Appointment {
    var id: UUID
    var userId: UUID
    var clinicName: String
    var notes: String
    var time: TimeInterval
    var date: Date
    var status: AppointmentStatus
}

struct Reports {
    var id: UUID
    var userId: UUID
    var tag: String
    var name: String
    var color: String
    var notes: String
    var prescriptions: [Prescription]
    var reports: [Report]
}

struct Prescription {
    var id: UUID
    var userId: UUID
    var imagePath: String
    var time: TimeInterval
    var date: Date
}

struct Report {
    var id: UUID
    var userId: UUID
    var imagePath: String
    var time: TimeInterval
    var date: Date
}

// MARK: - Data Models



// MARK: - User Data Model

class UserDataModel {
    private var users: [UserLoginInfo] = []
    static let sharedUserData = UserDataModel()

    private init() {}

    func registerUser(email: String, password: String) -> UserLoginInfo {
        let newUser = UserLoginInfo(id: UUID(), email: email, password: password)
        users.append(newUser)

        ProfileDataModel.sharedProfileData.addProfile(
            email: email,
            firstName: "",
            lastName: "",
            DOB: Date(),
            phoneNumber: "",
            sex: .male,
            bloodType: .oPositive,
            allergies: [],
            address: nil
        )

        return newUser
    }

    func loginUser(email: String, password: String) -> UserLoginInfo? {
        return users.first { $0.email == email && $0.password == password }
    }

    func deleteUser(by id: UUID) {
        users.removeAll { $0.id == id }
        ProfileDataModel.sharedProfileData.deleteProfile(by: id)
    }

    func editUser(id: UUID, email: String?, password: String?) {
        if let index = users.firstIndex(where: { $0.id == id }) {
            if let email = email { users[index].email = email }
            if let password = password { users[index].password = password }
        }
    }
}


// MARK: - Profile Data Models

class ProfileDataModel {
    private var profiles: [ProfileInfo] = []
    static let sharedProfileData = ProfileDataModel()

    private init() {}

    func addProfile(email: String, firstName: String, lastName: String, DOB: Date, phoneNumber: String, sex: Gender, bloodType: BloodType, allergies: [AllergyType], address: String?) {
        let newProfile = ProfileInfo(
            id: UUID(),
            profileImage: nil,
            email: email,
            firstName: firstName,
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

    func editProfile(id: UUID, profileImage: String?, email: String?, firstName: String?, lastName: String?, DOB: Date?, phoneNumber: String?, sex: Gender?, bloodType: BloodType?, allergies: [AllergyType]?, address: String?) {
        if let index = profiles.firstIndex(where: { $0.id == id }) {
            if let profileImage = profileImage { profiles[index].profileImage = profileImage }
            if let email = email { profiles[index].email = email }
            if let firstName = firstName { profiles[index].firstName = firstName }
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


// MARK: - Medication Data Models

class MedicationDataModel {
    private var medicationData: [Medication] = []
    static let sharedMedicationData = MedicationDataModel()

    private init() {}

    func addMedication(userId: UUID, medicineName: String, dosage: Int, type: MedicineType, notes: String, frequency: DosageFrequency, interval: Int?, dosageInterval: [Dosage], startDate: Date, endDate: Date?, time: Date) -> Medication {
        let newMedication = Medication(
            id: UUID(),
            userId: userId,
            medicineName: medicineName,
            type: type,
            dosage: dosage,
            notes: notes,
            frequency: frequency,
            interval: interval,
            dosageInterval: dosageInterval,
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

    func editMedication(id: UUID, medicineName: String?, dosage: Int?, type: MedicineType?, notes: String?, frequency: DosageFrequency?, interval: Int?, dosageInterval: [Dosage]?, startDate: Date?, endDate: Date?, time: Date?) {
        if let index = medicationData.firstIndex(where: { $0.id == id }) {
            if let medicineName = medicineName { medicationData[index].medicineName = medicineName }
            if let dosage = dosage { medicationData[index].dosage = dosage }
            if let type = type { medicationData[index].type = type }
            if let notes = notes { medicationData[index].notes = notes }
            if let frequency = frequency { medicationData[index].frequency = frequency }
            if let interval = interval { medicationData[index].interval = interval }
            if let dosageInterval = dosageInterval { medicationData[index].dosageInterval = dosageInterval }
            if let startDate = startDate { medicationData[index].startDate = startDate }
            if let endDate = endDate { medicationData[index].endDate = endDate }
            if let time = time { medicationData[index].time = time }
        }
    }
}

// MARK: - Appointment Data Models

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
            time: time.timeIntervalSince1970,
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
            if let time = time { appointmentData[index].time = time.timeIntervalSince1970 }
            if let date = date { appointmentData[index].date = date }
            if let status = status { appointmentData[index].status = status }
        }
    }
}

// MARK: - Reports Data Models

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

// MARK: - HomeScreen Data Models

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
            let fullName = "\(profile.firstName) \(profile.lastName)"
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


  

