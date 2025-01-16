//
//  dummyData.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 16/01/25.
//

import Foundation

// MARK: - Expanded Dummy Data

// Users
let user1 = UserLoginInfo(
    id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174000")!,
    email: "johndoe@example.com",
    password: "securepassword"
)

let user2 = UserLoginInfo(
    id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174010")!,
    email: "janedoe@example.com",
    password: "anothersecurepassword"
)

// Profiles
let profile1 = ProfileInfo(
    id: user1.id,
    profileImage: nil,
    email: user1.email,
    firstName: "John",
    lastName: "Doe",
    dob: Date(timeIntervalSince1970: 315569952), // 1980-01-01
    phoneNumber: "+1234567890",
    sex: .male,
    bloodType: .oPositive,
    allergies: [.pollen, .gluten],
    address: "123 Main Street, Springfield"
)

let profile2 = ProfileInfo(
    id: user2.id,
    profileImage: nil,
    email: user2.email,
    firstName: "Jane",
    lastName: "Doe",
    dob: Date(timeIntervalSince1970: 567993600), // 1988-01-01
    phoneNumber: "+0987654321",
    sex: .female,
    bloodType: .abNegative,
    allergies: [.dairy, .peanuts],
    address: "456 Elm Street, Springfield"
)

// Dosages
let dosages1 = [
    Dosage(id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174002")!, time: Date().addingTimeInterval(60 * 60 * 8)),
    Dosage(id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174003")!, time: Date().addingTimeInterval(60 * 60 * 20))
]

let dosages2 = [
    Dosage(id: UUID(uuidString: "223e4567-e89b-12d3-a456-426614174002")!, time: Date().addingTimeInterval(60 * 60 * 10)),
    Dosage(id: UUID(uuidString: "223e4567-e89b-12d3-a456-426614174003")!, time: Date().addingTimeInterval(60 * 60 * 18))
]

// Medications
let medications = [
    Medication(
        id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174004")!,
        userId: profile1.id,
        medicineName: "Paracetamol",
        type: .tablet,
        dosage: 1,
        notes: "Take with food.",
        frequency: .everyday,
        interval: nil,
        dosageInterval: dosages1,
        startDate: Date(),
        endDate: nil,
        time: Date().addingTimeInterval(60 * 60 * 8)
    ),
    Medication(
        id: UUID(uuidString: "223e4567-e89b-12d3-a456-426614174004")!,
        userId: profile2.id,
        medicineName: "Cough Syrup",
        type: .syrup,
        dosage: 2,
        notes: "Shake well before use.",
        frequency: .everyFewDays,
        interval: 2,
        dosageInterval: dosages2,
        startDate: Date(),
        endDate: nil,
        time: Date().addingTimeInterval(60 * 60 * 10)
    )
]

// Appointments
let appointments = [
    Appointment(
        id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174005")!,
        userId: profile1.id,
        clinicName: "City Hospital",
        notes: "Follow-up for blood pressure.",
        time: 9 * 60 * 60, // 9:00 AM
        date: Date(),
        status: .pending
    ),
    Appointment(
        id: UUID(uuidString: "223e4567-e89b-12d3-a456-426614174005")!,
        userId: profile2.id,
        clinicName: "General Clinic",
        notes: "Consultation for allergy treatment.",
        time: 10 * 60 * 60, // 10:00 AM
        date: Date(),
        status: .visited
    )
]

// Reports
let reports = [
    Reports(
        id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174009")!,
        userId: profile1.id,
        tag: "General Checkup",
        name: "Health Records",
        color: "#00AFB9",
        notes: "Patient has shown improvement in recent tests.",
        prescriptions: [
            Prescription(
                id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174008")!,
                userId: profile1.id,
                imagePath: "prescription_1.jpg",
                time: 12 * 60 * 60, // 12:00 PM
                date: Date()
            )
        ],
        reports: [
            Report(
                id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174006")!,
                userId: profile1.id,
                imagePath: "report_1.jpg",
                time: 10 * 60 * 60, // 10:00 AM
                date: Date()
            )
        ]
    ),
    Reports(
        id: UUID(uuidString: "223e4567-e89b-12d3-a456-426614174009")!,
        userId: profile2.id,
        tag: "Allergy Test",
        name: "Allergy Reports",
        color: "#FF6B6B",
        notes: "Peanut allergy confirmed.",
        prescriptions: [
            Prescription(
                id: UUID(uuidString: "223e4567-e89b-12d3-a456-426614174008")!,
                userId: profile2.id,
                imagePath: "prescription_2.jpg",
                time: 13 * 60 * 60, // 1:00 PM
                date: Date()
            )
        ],
        reports: [
            Report(
                id: UUID(uuidString: "223e4567-e89b-12d3-a456-426614174006")!,
                userId: profile2.id,
                imagePath: "report_2.jpg",
                time: 14 * 60 * 60, // 2:00 PM
                date: Date()
            )
        ]
    )
]

