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

// MARK: - BloodType

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

// MARK: - ReportsType

enum ReportsType: String, CaseIterable {
    case pdf = "PDF"
    case jpg = "JPG"
}

//enum ContactMethod: String, CaseIterable {
//    case phone = "Phone"
//    case email = "Email"
//    case sms = "SMS"
//}

// MARK: - AppointmentStatus

enum AppointmentStatus: String, CaseIterable {
    case pending = "Pending"
    case visited = "Visited"
    case skipped = "Skipped"
//    case upcoming = "Upcoming"
}

// MARK: - AllergyType

enum AllergyType: String, CaseIterable {
    case food = "Food"
    case drug = "Drug"
    case environmental = "Environmental"
    case other = "Other"
}

// MARK: - MedicineType

enum MedicineType: String, CaseIterable {
    case tablet = "Tablet"
    case capsule = "Capsule"
    case syrup = "Syrup"
//    case injection = "Injection"
//    case ointment = "Ointment"
}

// MARK: - Frequency

enum DosageFrequency: String, CaseIterable {
    case everyday = "Everyday"
    case everyFewDays = "Every Few Days"
}

//enum MeasurementUnit: String, CaseIterable {
//    case kg = "Kg"
//    case lbs = "Lbs"
//    case cm = "Cm"
//    case inches = "Inches"
//}

//enum SeverityLevel: String, CaseIterable {
//    case mild = "Mild"
//    case moderate = "Moderate"
//    case severe = "Severe"
//    case critical = "Critical"
//}

//enum ReportTag: String, CaseIterable {
//    case lab = "Lab"
//    case diagnostic = "Diagnostic"
//    case prescription = "Prescription"
//    case other = "Other"
//}

// MARK: - Structs

//struct Schedule {
//    var startDate: String
//    var time: String?
//    var duration: String? // e.g., "2 days"
//
//    var endDate: String? {
//        guard let duration = duration else { return nil }
//        return "\(startDate) + \(duration)"
//    }
//}

// MARK: - Login Details


struct UserLoginInfo {
    var id: UUID
    var email: String
    var password: String
}

// MARK: - Profile Info

struct ProfileInfo {
    var id: UUID
    var profileImage: String?
    var email: String
    var firstName: String
    var lastName: String
    var DOB: Date
    var phoneNumber: String
    var sex: Gender
    var bloodType: BloodType
    var allergies: [AllergyType]
    var address: String?
}

// MARK: - Medication

struct Dosage {
    var id: UUID
    var time : Date
}

struct Medication {
    var id: UUID
    var userId: UUID
    var medicineName: String
    var type: MedicineType
    var dosage: Int
    var notes: String
    var frequency: DosageFrequency
    var interval : Int?
    var dosageInterval : [Dosage]
    var startDate: Date
    var endDate: Date?
    var time: Date
}

// MARK: - Appointment

struct Appointment {
    var id: UUID
    var userId: UUID
    var clinicName : String
    var notes: String
    var time : TimeInterval
    var date: Date
    var status: AppointmentStatus
}

//// MARK: - Health Status
//
//struct HealthStatus {
//    var id: UUID 
//    var userId: UUID
//    var weight: Int
//    var weightUnit: MeasurementUnit
//    var height: Int
//    var heightUnit: MeasurementUnit
//    var bloodPressure: Int
//    var heartRate: Int
//    var temperature: Int
//    var sugarLevel: Int
//    var cholesterolLevel: Int
//    var severity: SeverityLevel
//    var date: Date
//    var time: TimeInterval
//}
//
//// MARK: - Prescription
//
//struct Prescription {
//    var id: UUID
//    var userId: UUID
//    var title: String
//    var patientName: String
//    var time : TimeInterval
//    var date : Date
//}

//// MARK: - Checkup
//
//struct CheckUp {
//    var id: UUID
//    var userId: UUID
//    var title: String
//    var notes: String
//    var time : TimeInterval
//    var date : Date
//}

// MARK: - Reports

struct Reports {
    var id: UUID
    var userId: UUID
    var tag: String
    var name : String
    var color : String
    var notes: String
    var prescription: [Prescription]
    var report : [Report]
}

struct Prescription {
    var id: UUID
    var userId: UUID
    var imagePath : String
    var time : TimeInterval
    var date : Date
}

struct Report {
    var id: UUID
    var userId: UUID
    var imagePath : String
    var time : TimeInterval
    var date : Date
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
            sex: Gender.male,
            bloodType: BloodType.oPositive,
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
        if let profile = ProfileDataModel.sharedProfileData.getProfileByUserId(id: id) {
            ProfileDataModel.sharedProfileData.deleteProfile(by: profile.id)
        }
    }

    func editUser(id: UUID, email: String?, password: String?) {
        if let index = users.firstIndex(where: { $0.id == id }) {
            if let email = email {
                users[index].email = email
            }
            if let password = password {
                users[index].password = password
            }
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
            DOB: DOB,
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
            if let profileImage = profileImage {
                profiles[index].profileImage = profileImage
            }
            if let email = email {
                profiles[index].email = email
            }
            if let firstName = firstName {
                profiles[index].firstName = firstName
            }
            if let lastName = lastName {
                profiles[index].lastName = lastName
            }
            if let DOB = DOB {
                profiles[index].DOB = DOB
            }
            if let phoneNumber = phoneNumber {
                profiles[index].phoneNumber = phoneNumber
            }
            if let sex = sex {
                profiles[index].sex = sex
            }
            if let bloodType = bloodType {
                profiles[index].bloodType = bloodType
            }
            if let allergies = allergies {
                profiles[index].allergies = allergies
            }
            if let address = address {
                profiles[index].address = address
            }
        }
    }
}


// MARK: - Medication Data Models

class MedicationDataModel {
    private var medicationData: [Medication] = []
    static let sharedMedicationData = MedicationDataModel()

    private init() {}

    func addMedication(userId: UUID, medicineName: String, dose: Int, type: MedicineType, notes: String, time: Date, date: Date, duration: Int) -> Medication {
        let newMedication = Medication(
            id: UUID(),
            userId: userId,
            medicineName: medicineName,
            type: type,
            dosage: dose,
            notes: notes,
            frequency: .everyday, // Default value for frequency, adjust as needed
            interval: duration,
            dosageInterval: [],
            startDate: date,
            endDate: nil,
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

    func editMedication(id: UUID, medicineName: String?, dose: Int?, type: MedicineType?, notes: String?, time: Date?, date: Date?, duration: Int?) {
        if let index = medicationData.firstIndex(where: { $0.id == id }) {
            if let medicineName = medicineName {
                medicationData[index].medicineName = medicineName
            }
            if let dose = dose {
                medicationData[index].dosage = dose
            }
            if let type = type {
                medicationData[index].type = type
            }
            if let notes = notes {
                medicationData[index].notes = notes
            }
            if let time = time {
                medicationData[index].time = time
            }
            if let date = date {
                medicationData[index].startDate = date
                medicationData[index].endDate = date.addingTimeInterval(TimeInterval(duration ?? 0 * 24 * 60 * 60))
            }
            if let duration = duration {
                medicationData[index].endDate = medicationData[index].startDate.addingTimeInterval(TimeInterval(duration * 24 * 60 * 60))
            }
        }
    }
}

// MARK: - Appointment Data Models

class AppointmentDataModel {
    private var appointmentData: [Appointment] = []
    static let sharedAppointmentData = AppointmentDataModel()

    private init() {}

    func addAppointment(userId: UUID, clinicName: String, notes: String, time: Date, date: Date, status: AppointmentStatus) -> Appointment {
        let newAppointment = Appointment(id: UUID(), userId: userId, clinicName: clinicName, notes: notes, time: time.timeIntervalSince1970, date: date, status: status)
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
            if let clinicName = clinicName {
                appointmentData[index].clinicName = clinicName
            }
            if let notes = notes {
                appointmentData[index].notes = notes
            }
            if let time = time {
                appointmentData[index].time = time.timeIntervalSince1970
            }
            if let date = date {
                appointmentData[index].date = date
            }
            if let status = status {
                appointmentData[index].status = status
            }
        }
    }
}

// MARK: - Reports Data Models

class ReportsDataModel {
    private var reportsData: [Reports] = []
    static let sharedReportsData = ReportsDataModel()

    private init() {}

    func addReport(userId: UUID, tag: String, time: TimeInterval, date: Date, notes: String, reportData: Data, reportType: String) -> Reports {
        let newReport = Reports(
            id: UUID(),
            userId: userId,
            tag: tag,
            name: "Report \(UUID().uuidString)",
            color: "#000000",
            notes: notes,
            prescription: [],
            report: [Report(id: UUID(), userId: userId, imagePath: "path/to/image", time: time, date: date)]
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

    func editReport(id: UUID, tag: String?, time: TimeInterval?, date: Date?, notes: String?, reportData: Data?, reportType: String?) {
        if let index = reportsData.firstIndex(where: { $0.id == id }) {
            if let tag = tag {
                reportsData[index].tag = tag
            }
            if let time = time, reportsData[index].report.count > 0 {
                reportsData[index].report[0].time = time // Modify the time inside the first Report object
            }
            if let date = date, reportsData[index].report.count > 0 {
                reportsData[index].report[0].date = date // Modify the date inside the first Report object
            }
            if let notes = notes {
                reportsData[index].notes = notes
            }
            if let reportData = reportData {
                reportsData[index].report = [Report(id: UUID(), userId: reportsData[index].userId, imagePath: "path/to/updated/image", time: time ?? 0, date: date ?? Date())] // Updated report data
            }
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


  

