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
    case notMentioned = "NotMentioned"
    case none = "None"
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

// Ok Tested
struct Dosage: Codable {
    var id: UUID
    var time: Date
}

// Ok Tested
struct Medication: Codable {
    var id: UUID
    var userId : UUID
    var medicineName: String
    var hospitalName: String
    var doctorName: String
    var type: MedicineType
    var dosage: [Dosage]
    var notes: String
    var frequency: DosageFrequency
    var interval: Int?
    var startDate: Date
    var endDate: Date?
    var time: Date
    var tag: UUID
    var appointment : UUID?
}

// Ok Tested
struct Appointment: Codable {
    var clinicName: String
    var notes: String
    var doctorName: String
    var time: Date // Changed from TimeInterval
    var date: Date
    var status: AppointmentStatus
}

//ok Tested
struct Report: Codable {
    var id: UUID
    var path: String
    var time: Date
    var date: Date
    var reportType: ReportsType
}

//ok Tested
struct ProfileInfo: Codable {
    var userId : UUID
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

//ok Tested
struct LoginInfo: Codable {
    var userId: UUID
    var email: String
    var password: String
}

struct Tag: Codable {
    var id: UUID
    var tagName: String
    var hospital: [UUID]
    var appointments: [UUID]
    var notes: String
    var reports: [UUID]
}

struct User: Codable {
    var userId: UUID
    var profile: ProfileInfo
    var loginInfo: LoginInfo
    var tags: [UUID]
    var medications: [UUID]
    var appointments: [UUID]
    var hospitals : [UUID]
}

struct Hospital : Codable{
    var id: UUID
    var hospitalName: String
    var tags: [UUID]
}

// MARK: - Data Models
import Foundation

// MARK: - User Data Model
class UserDataModel {
    private var users: [User] = []
    private var profiles: [ProfileInfo] = []
    static let sharedUserData = UserDataModel()

    private init() {}

    // MARK: - User Management
    func registerUser(email: String, password: String) -> User {
        let uniqueUserId = UUID()

        let defaultProfile = ProfileInfo(
            userId: uniqueUserId,
            profileImage: nil,
            email: email,
            firstName: "First Name",
            lastName: "Last Name",
            dob: Date(),
            phoneNumber: "0000000000",
            sex: .male,
            bloodType: .unknown,
            allergies: [],
            address: nil
        )

        profiles.append(defaultProfile)

        let newUser = User(
            userId: uniqueUserId,
            profile: defaultProfile,
            loginInfo: LoginInfo(userId: uniqueUserId, email: email, password: password),
            tags: [],
            medications: [],
            appointments: [],
            hospitals: []
        )
        users.append(newUser)
        return newUser
    }

    func loginUser(email: String, password: String) -> User? {
        return users.first { $0.loginInfo.email == email && $0.loginInfo.password == password }
    }

    func deleteUser(by id: UUID) {
        users.removeAll { $0.userId == id }
        profiles.removeAll { $0.userId == id }
    }

    func editUser(id: UUID, email: String?, password: String?, profileDetails: ProfileInfo?) {
        if let index = users.firstIndex(where: { $0.userId == id }) {
            if let email = email { users[index].loginInfo.email = email }
            if let password = password { users[index].loginInfo.password = password }
            if let profileDetails = profileDetails { users[index].profile = profileDetails }
        }
    }

    func getAllUsers() -> [User] {
        return users
    }

    // MARK: - Profile Management
    func addProfile(
        userId: UUID,
        profileImage: String?,
        email: String,
        firstName: String,
        lastName: String,
        dob: Date,
        phoneNumber: String,
        sex: Gender,
        bloodType: BloodType,
        allergies: [AllergyType],
        address: String?
    ) -> ProfileInfo {
        let newProfile = ProfileInfo(
            userId: userId,
            profileImage: profileImage,
            email: email,
            firstName: firstName,
            lastName: lastName,
            dob: dob,
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
        return profiles.first { $0.userId == id }
    }

    func deleteProfile(by id: UUID) {
        profiles.removeAll { $0.userId == id }
    }

    func editProfile(
        id: UUID,
        profileImage: String?,
        email: String?,
        firstName: String?,
        lastName: String?,
        dob: Date?,
        phoneNumber: String?,
        sex: Gender?,
        bloodType: BloodType?,
        allergies: [AllergyType]?,
        address: String?
    ) {
        if let index = profiles.firstIndex(where: { $0.userId == id }) {
            if let profileImage = profileImage { profiles[index].profileImage = profileImage }
            if let email = email { profiles[index].email = email }
            if let firstName = firstName { profiles[index].firstName = firstName }
            if let lastName = lastName { profiles[index].lastName = lastName }
            if let dob = dob { profiles[index].dob = dob }
            if let phoneNumber = phoneNumber { profiles[index].phoneNumber = phoneNumber }
            if let sex = sex { profiles[index].sex = sex }
            if let bloodType = bloodType { profiles[index].bloodType = bloodType }
            if let allergies = allergies { profiles[index].allergies = allergies }
            if let address = address { profiles[index].address = address }
        }
    }
}

// MARK: - Medication Data Model
class MedicationDataModel {
    private var medications: [Medication] = []
    static let sharedMedicationData = MedicationDataModel()

    private init() {}

    func addMedication(
        medicineName: String,
        hospitalName: String,
        doctorName: String,
        type: MedicineType,
        dosage: [Dosage],
        notes: String,
        frequency: DosageFrequency,
        interval: Int?,
        startDate: Date,
        endDate: Date?,
        time: Date,
        tag: UUID,
        appointment: UUID?
    ) -> Medication {
        let newMedication = Medication(
            id: UUID(),
            userId: UUID(),
            medicineName: medicineName,
            hospitalName: hospitalName,
            doctorName: doctorName,
            type: type,
            dosage: dosage,
            notes: notes,
            frequency: frequency,
            interval: interval,
            startDate: startDate,
            endDate: endDate,
            time: time,
            tag: tag,
            appointment: appointment
        )
        medications.append(newMedication)
        return newMedication
    }

    func getMedications() -> [Medication] {
        return medications
    }

    func deleteMedication(by id: UUID) {
        medications.removeAll { $0.id == id }
    }

    func editMedication(
        id: UUID,
        medicineName: String?,
        hospitalName: String?,
        doctorName: String?,
        type: MedicineType?,
        dosage: [Dosage]?,
        notes: String?,
        frequency: DosageFrequency?,
        interval: Int?,
        startDate: Date?,
        endDate: Date?,
        time: Date?,
        tag: UUID?,
        appointment: UUID?
    ) {
        if let index = medications.firstIndex(where: { $0.id == id }) {
            if let medicineName = medicineName { medications[index].medicineName = medicineName }
            if let hospitalName = hospitalName { medications[index].hospitalName = hospitalName }
            if let doctorName = doctorName { medications[index].doctorName = doctorName }
            if let type = type { medications[index].type = type }
            if let dosage = dosage { medications[index].dosage = dosage }
            if let notes = notes { medications[index].notes = notes }
            if let frequency = frequency { medications[index].frequency = frequency }
            if let interval = interval { medications[index].interval = interval }
            if let startDate = startDate { medications[index].startDate = startDate }
            if let endDate = endDate { medications[index].endDate = endDate }
            if let time = time { medications[index].time = time }
            if let tag = tag { medications[index].tag = tag }
            if let appointment = appointment { medications[index].appointment = appointment }
        }
    }
}
class TagDataModel {
    private var tags: [Tag] = []
    static let sharedTagData = TagDataModel()

    private init() {}

    // Add a new tag
    func addTag(
        tagName: String,
        hospital: [UUID],
        appointments: [UUID],
        notes: String,
        reports: [UUID]
    ) -> Tag {
        let newTag = Tag(
            id: UUID(),
            tagName: tagName,
            hospital: hospital,
            appointments: appointments,
            notes: notes,
            reports: reports
        )
        tags.append(newTag)
        return newTag
    }

    // Get all tags
    func getAllTags() -> [Tag] {
        return tags
    }

    // Get tags for specific hospital
    func getTags(forHospital hospitalId: UUID) -> [Tag] {
        return tags.filter { $0.hospital.contains(hospitalId) }
    }

    // Delete a tag by its ID
    func deleteTag(by id: UUID) {
        tags.removeAll { $0.id == id }
    }

    // Edit a tag
    func editTag(
        tagId: UUID,
        tagName: String? = nil,
        hospital: [UUID]? = nil,
        appointments: [UUID]? = nil,
        notes: String? = nil,
        reports: [UUID]? = nil
    ) {
        guard let index = tags.firstIndex(where: { $0.id == tagId }) else {
            return
        }
        if let tagName = tagName {
            tags[index].tagName = tagName
        }
        if let hospital = hospital {
            tags[index].hospital = hospital
        }
        if let appointments = appointments {
            tags[index].appointments = appointments
        }
        if let notes = notes {
            tags[index].notes = notes
        }
        if let reports = reports {
            tags[index].reports = reports
        }
    }
}

class HospitalDataModel {
    private var hospitals: [Hospital] = []
    static let sharedHospitalData = HospitalDataModel()

    private init() {}

    // Add a new hospital
    func addHospital(hospitalName: String, tags: [UUID]) -> Hospital {
        let newHospital = Hospital(
            id: UUID(),
            hospitalName: hospitalName,
            tags: tags
        )
        hospitals.append(newHospital)
        return newHospital
    }

    // Get all hospitals
    func getAllHospitals() -> [Hospital] {
        return hospitals
    }

    // Get a specific hospital by ID
    func getHospital(by id: UUID) -> Hospital? {
        return hospitals.first { $0.id == id }
    }

    // Delete a hospital by its ID
    func deleteHospital(by id: UUID) {
        hospitals.removeAll { $0.id == id }
    }

    // Edit a hospital
    func editHospital(
        hospitalId: UUID,
        hospitalName: String? = nil,
        tags: [UUID]? = nil
    ) {
        guard let index = hospitals.firstIndex(where: { $0.id == hospitalId }) else {
            return
        }
        if let hospitalName = hospitalName {
            hospitals[index].hospitalName = hospitalName
        }
        if let tags = tags {
            hospitals[index].tags = tags
        }
    }
}

class ReportDataModel {
    private var reports: [Report] = []
    static let sharedReportData = ReportDataModel()

    private init() {}

    // Add a new report
    func addReport(
        path: String,
        time: Date,
        date: Date,
        reportType: ReportsType
    ) -> Report {
        let newReport = Report(
            id: UUID(),
            path: path,
            time: time,
            date: date,
            reportType: reportType
        )
        reports.append(newReport)
        return newReport
    }

    // Get all reports
    func getAllReports() -> [Report] {
        return reports
    }

    // Get reports by type
    func getReports(by type: ReportsType) -> [Report] {
        return reports.filter { $0.reportType == type }
    }

    // Delete a report by its ID
    func deleteReport(by id: UUID) {
        reports.removeAll { $0.id == id }
    }

    // Edit a report
    func editReport(
        reportId: UUID,
        path: String? = nil,
        time: Date? = nil,
        date: Date? = nil,
        reportType: ReportsType? = nil
    ) {
        guard let index = reports.firstIndex(where: { $0.id == reportId }) else {
            return
        }
        if let path = path {
            reports[index].path = path
        }
        if let time = time {
            reports[index].time = time
        }
        if let date = date {
            reports[index].date = date
        }
        if let reportType = reportType {
            reports[index].reportType = reportType
        }
    }
}

class AppointmentDataModel {
    private var appointmentData: [Appointment] = [
        
        Appointment(
               clinicName: "City Clinic",
               notes: "General Checkup",
               doctorName: "Dr Amit",
               time: Date(),
               date: Date(),
               status: .visited
           ),
           Appointment(
               clinicName: "Downtown Dental",
               notes: "Dental Cleaning",
               doctorName: "Dr Prasad",
               time: Date().addingTimeInterval(3600), // 1 hour later
               date: Date().addingTimeInterval(86400), // 1 day later
               status: .pending
           ),
           Appointment(
               clinicName: "Health Hub",
               notes: "Cardiology Consultation",
               doctorName: "Dr Shweta",
               time: Date().addingTimeInterval(7200), // 2 hours later
               date: Date().addingTimeInterval(172800), // 2 days later
               status: .pending
           )
    ]
    
    static let sharedAppointmentData = AppointmentDataModel()

    private init() {}
    
    func addAppointment(clinicName: String, notes: String, doctorname: String,time: Date, date: Date, status: AppointmentStatus)  {
        let newAppointment = Appointment(
            clinicName: clinicName,
            notes: notes,
            doctorName: doctorname,
            time: time, // Using Date directly
            date: date,
            status: status
        )
        appointmentData.append(newAppointment)
        
    }

    func getAppointments() -> [Appointment] {
        return appointmentData
    }
    
    func deleteAppointment(by clinec: String) {
        appointmentData.removeAll {$0.clinicName == clinec}
    }
    
    func editAppointment(clinicName: String?, notes: String?, time: Date?, date: Date?, status: AppointmentStatus?) {
        if let index = appointmentData.firstIndex(where: { $0.clinicName == clinicName }) {
            if let clinicName = clinicName { appointmentData[index].clinicName = clinicName }
            if let notes = notes { appointmentData[index].notes = notes }
            if let time = time { appointmentData[index].time = time }
            if let date = date { appointmentData[index].date = date }
            if let status = status { appointmentData[index].status = status }
        }
    }
}
