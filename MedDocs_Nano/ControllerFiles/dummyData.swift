//
//  dummyData.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 16/01/25.
//

import Foundation

// MARK: - User Login Info Dummy Data
let user1 = UserLoginInfo(id: UUID(), email: "john.doe@example.com", password: "password123")
let user2 = UserLoginInfo(id: UUID(), email: "jane.doe@example.com", password: "securepassword")

// MARK: - Profile Info Dummy Data
let profile1 = ProfileInfo(
    id: user1.id,
    profileImage: "profile1.png",
    email: user1.email,
    firstName: "John",
    lastName: "Doe",
    dob: Date(timeIntervalSince1970: 567648000), // Example: 01-Jan-1988
    phoneNumber: "123-456-7890",
    sex: .male,
    bloodType: .aPositive,
    allergies: [.peanuts],
    address: "123 Main Street, Springfield"
)

let profile2 = ProfileInfo(
    id: user2.id,
    profileImage: "profile2.png",
    email: user2.email,
    firstName: "Jane",
    lastName: "Doe",
    dob: Date(timeIntervalSince1970: 631152000), // Example: 01-Jan-1990
    phoneNumber: "987-654-3210",
    sex: .female,
    bloodType: .bNegative,
    allergies: [.pollen],
    address: "456 Elm Street, Metropolis"
)

// MARK: - Medication Dummy Data
let medication1 = Medication(
    id: UUID(),
    userId: user1.id,
    medicineName: "Aspirin",
    type: .tablet,
    dosage: 2,
    notes: "Take with food",
    frequency: .everyday,
    interval: 1,
    dosageInterval: [Dosage(id: <#UUID#>, time: Date())],
    startDate: Date(),
    endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date()),
    time: Date()
)

let medication2 = Medication(
    id: UUID(),
    userId: user2.id,
    medicineName: "Cough Syrup",
    type: .syrup,
    dosage: 10,
    notes: "Take 3 times a day",
    frequency: .everyFewDays,
    interval: 3,
    dosageInterval: [
        Dosage(id: <#UUID#>, time: Calendar.current.date(byAdding: .hour, value: 8, to: Date())!),
        Dosage(id: <#UUID#>, time: Calendar.current.date(byAdding: .hour, value: 16, to: Date())!),
        Dosage(id: <#UUID#>, time: Calendar.current.date(byAdding: .hour, value: 24, to: Date())!)
    ],
    startDate: Date(),
    endDate: Calendar.current.date(byAdding: .day, value: 5, to: Date()),
    time: Date()
)

// MARK: - Appointment Dummy Data
let appointment1 = Appointment(
    id: UUID(),
    userId: user1.id,
    clinicName: "Springfield Clinic",
    notes: "Annual Checkup",
    time: Date().timeIntervalSince1970,
    date: Date(),
    status: .pending
)

let appointment2 = Appointment(
    id: UUID(),
    userId: user2.id,
    clinicName: "Metropolis Health Center",
    notes: "Dental Cleaning",
    time: Date().timeIntervalSince1970,
    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
    status: .pending
)

// MARK: - Reports Dummy Data
let report1 = Reports(
    id: UUID(),
    userId: user1.id,
    tag: "Blood Test",
    name: "Blood Test Report",
    color: "#FF5733",
    notes: "All parameters are normal",
    prescriptions: [    ],
    reports: [
        Report(id: UUID(), userId: user1.id, imagePath: "report1.png", time: Date().timeIntervalSince1970, date: Date())
    ]
)

let report2 = Reports(
    id: UUID(),
    userId: user2.id,
    tag: "X-Ray",
    name: "Chest X-Ray Report",
    color: "#33FF57",
    notes: "No abnormalities detected",
    prescriptions: [],
    reports: [
        Report(id: UUID(), userId: user2.id, imagePath: "report2.png", time: Date().timeIntervalSince1970, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
    ]
)

// MARK: - Populate Data
func populateDummyData() {
    // Adding users
    UserDataModel.sharedUserData.registerUser(email: user1.email, password: user1.password)
    UserDataModel.sharedUserData.registerUser(email: user2.email, password: user2.password)

    // Adding profiles
    ProfileDataModel.sharedProfileData.addProfile(
        email: profile1.email,
        firstName: profile1.firstName,
        lastName: profile1.lastName,
        DOB: profile1.dob,
        phoneNumber: profile1.phoneNumber,
        sex: profile1.sex,
        bloodType: profile1.bloodType,
        allergies: profile1.allergies,
        address: profile1.address
    )

    ProfileDataModel.sharedProfileData.addProfile(
        email: profile2.email,
        firstName: profile2.firstName,
        lastName: profile2.lastName,
        DOB: profile2.dob,
        phoneNumber: profile2.phoneNumber,
        sex: profile2.sex,
        bloodType: profile2.bloodType,
        allergies: profile2.allergies,
        address: profile2.address
    )

    // Adding medications
    MedicationDataModel.sharedMedicationData.addMedication(
        userId: medication1.userId,
        medicineName: medication1.medicineName,
        dosage: medication1.dosage,
        type: medication1.type,
        notes: medication1.notes,
        frequency: medication1.frequency,
        interval: medication1.interval,
        dosageInterval: medication1.dosageInterval,
        startDate: medication1.startDate,
        endDate: medication1.endDate,
        time: medication1.time
    )

    MedicationDataModel.sharedMedicationData.addMedication(
        userId: medication2.userId,
        medicineName: medication2.medicineName,
        dosage: medication2.dosage,
        type: medication2.type,
        notes: medication2.notes,
        frequency: medication2.frequency,
        interval: medication2.interval,
        dosageInterval: medication2.dosageInterval,
        startDate: medication2.startDate,
        endDate: medication2.endDate,
        time: medication2.time
    )

    // Adding appointments
    AppointmentDataModel.sharedAppointmentData.addAppointment(
        userId: appointment1.userId,
        clinicName: appointment1.clinicName,
        notes: appointment1.notes,
        time: Date(timeIntervalSince1970: appointment1.time),
        date: appointment1.date,
        status: appointment1.status
    )

    AppointmentDataModel.sharedAppointmentData.addAppointment(
        userId: appointment2.userId,
        clinicName: appointment2.clinicName,
        notes: appointment2.notes,
        time: Date(timeIntervalSince1970: appointment2.time),
        date: appointment2.date,
        status: appointment2.status
    )

    // Adding reports
    ReportsDataModel.sharedReportsData.addReport(
        userId: report1.userId,
        tag: report1.tag,
        name: report1.name,
        color: report1.color,
        notes: report1.notes,
        prescription: report1.prescriptions,
        report: report1.reports
    )

    ReportsDataModel.sharedReportsData.addReport(
        userId: report2.userId,
        tag: report2.tag,
        name: report2.name,
        color: report2.color,
        notes: report2.notes,
        prescription: report2.prescriptions,
        report: report2.reports
    )
}

// Call populateDummyData to initialize
//populateDummyData()

