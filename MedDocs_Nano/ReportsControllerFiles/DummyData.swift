//
//  DummyData.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 16/01/25.
//

import Foundation

// Sample User Data

let sampleUser = User(
    id: UUID(),
    profile: ProfileInfo(
        id: UUID(),
        profileImage: "user1_profile.jpg",
        email: "john.doe@example.com",
        firstName: "John",
        middleName: "Michael",
        lastName: "Doe",
        dob: Date(timeIntervalSince1970: 0), // Replace with actual DOB
        phoneNumber: "+1 123 456 7890",
        sex: .male,
        bloodType: .aPositive,
        allergies: [.drug],
        address: "123 Main St, Anytown, USA"
    ),
    loginInfo: UserLoginInfo(
        id: UUID(),
        email: "john.doe@example.com",
        password: "password123"
    )
)

// Sample Medication Data

let sampleMedication1 = Medication(
    id: UUID(),
    userId: sampleUser.id,
    medicineName: "Ibuprofen",
    type: .tablet,
    dosage: 400,
    notes: "Take with food",
    frequency: .everyday,
    interval: nil,
    startDate: Date(),
    endDate: Date(timeIntervalSinceNow: 60 * 60 * 24 * 7), // 1 week from now
    time: Date().addingTimeInterval(60 * 60 * 9) // 9:00 AM
)

let sampleMedication2 = Medication(
    id: UUID(),
    userId: sampleUser.id,
    medicineName: "Vitamin C",
    type: .capsule,
    dosage: 500,
    notes: "Take daily",
    frequency: .everyday,
    interval: nil,
    startDate: Date(),
    endDate: nil, // No end date
    time: Date().addingTimeInterval(60 * 60 * 8) // 8:00 AM
)

// Sample Appointment Data

let sampleAppointment1 = Appointment(
    id: UUID(),
    userId: sampleUser.id,
    clinicName: "Doctor Smith's Clinic",
    notes: "Follow up on blood test results",
    time: Date(timeIntervalSinceNow: 60 * 60 * 24 * 48), // 48 hours from now
    date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 48), // 48 hours from now
    status: .pending
)

let sampleAppointment2 = Appointment(
    id: UUID(),
    userId: sampleUser.id,
    clinicName: "Dental Clinic",
    notes: "Routine check-up",
    time: Date(timeIntervalSinceNow: 60 * 60 * 24 * 7 * 2), // 2 weeks from now
    date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 7 * 2), // 2 weeks from now
    status: .pending
)

// Sample Report Data

let sampleReport1 = Report(
    id: UUID(),
    userId: sampleUser.id,
    imagePath: "report1.pdf",
    time: Date(),
    date: Date()
)

let sampleReport2 = Report(
    id: UUID(),
    userId: sampleUser.id,
    imagePath: "report2.jpg",
    time: Date(timeIntervalSinceNow: -60 * 60 * 24), // 1 day ago
    date: Date(timeIntervalSinceNow: -60 * 60 * 24) // 1 day ago
)

// Sample Prescription Data

let samplePrescription1 = Prescription(
    id: UUID(),
    userId: sampleUser.id,
    imagePath: "prescription1.jpg",
    time: Date(),
    date: Date()
)

let samplePrescription2 = Prescription(
    id: UUID(),
    userId: sampleUser.id,
    imagePath: "prescription2.pdf",
    time: Date(timeIntervalSinceNow: -60 * 60 * 24 * 3), // 3 days ago
    date: Date(timeIntervalSinceNow: -60 * 60 * 24 * 3) // 3 days ago
)

// Sample Reports Data

let sampleReports = Reports(
    id: UUID(),
    userId: sampleUser.id,
    tag: "Checkup",
    name: "Annual Checkup",
    color: "#FFC107", // Yellow
    notes: "General health checkup",
    prescriptions: [samplePrescription1, samplePrescription2],
    reports: [sampleReport1, sampleReport2]
)

// Populate Data Models (Example)

// UserDataModel.sharedUserData.registerUser(email: sampleUser.loginInfo.email, password: sampleUser.loginInfo.password, profile: sampleUser.profile)
// MedicationDataModel.sharedMedicationData.addMedication(userId: sampleUser.id, medicineName: sampleMedication1.medicineName, dosage: sampleMedication1.dosage, type: sampleMedication1.type, notes: sampleMedication1.notes, frequency: sampleMedication1.frequency, interval: sampleMedication1.interval, startDate: sampleMedication1.startDate, endDate: sampleMedication1.endDate, time: sampleMedication1.time)
// MedicationDataModel.sharedMedicationData.addMedication(userId: sampleUser.id, medicineName: sampleMedication2.medicineName, dosage: sampleMedication2.dosage, type: sampleMedication2.type, notes: sampleMedication2.notes, frequency: sampleMedication2.frequency, interval: sampleMedication2.interval, startDate: sampleMedication2.startDate, endDate: sampleMedication2.endDate, time: sampleMedication2.time)
// AppointmentDataModel.sharedAppointmentData.addAppointment(userId: sampleUser.id, clinicName: sampleAppointment1.clinicName, notes: sampleAppointment1.notes, time: sampleAppointment1.time, date: sampleAppointment1.date, status: sampleAppointment1.status)
// AppointmentDataModel.sharedAppointmentData.addAppointment(userId: sampleUser.id, clinicName: sampleAppointment2.clinicName, notes: sampleAppointment2.notes, time: sampleAppointment2.time, date: sampleAppointment2.date, status: sampleAppointment2.status)
// ReportsDataModel.sharedReportsData.addReport(userId: sampleUser.id, tag: sampleReports.tag, name: sampleReports.name, color: sampleReports.color, notes: sampleReports.notes, prescription: sampleReports.prescriptions, report: sampleReports.reports)

// Note: This is a simplified example. You would typically populate your data models in a more appropriate context (e.g., during app startup, data loading from a database).
