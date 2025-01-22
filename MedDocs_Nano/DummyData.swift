//import Foundation
//
//// Generate a dummy user with associated data
//func generateDummyData() {
//    // Step 1: Create a profile for the user
//    let profile = ProfileDataModel.sharedProfileData.addProfile(
//     email: "jane.doe@example.com",
//        firstName: "Jane",
//        middleName: nil,
//        lastName: "Doe",
//        DOB: Date(timeIntervalSince1970: 631152000), // Jan 1, 1990
//        phoneNumber: "+1234567890",
//        sex: .female,
//        bloodType: .aPositive,
//        allergies: [.food, .environmental],
//        address: "123 Main Street, Springfield, IL"
//    )
//    
//    // Step 2: Register the user
//    let user = UserDataModel.sharedUserData.registerUser(
//        email: profile.email,
//        password: "password123",
//        profile: profile
//    )
//    
//    // Step 3: Add medications for the user
//    MedicationDataModel.sharedMedicationData.addMedication(
//        userId: user.id,
//        medicineName: "Paracetamol",
//        dosage: 500,
//        type: .tablet,
//        notes: "Take after meals for fever",
//        frequency: .everyDay,
//        interval: nil,
//        startDate: Date(),
//        endDate: nil,
//        time: Date()
//    )
//    
//    MedicationDataModel.sharedMedicationData.addMedication(
//        userId: user.id,
//        medicineName: "Ibuprofen",
//        dosage: 200,
//        type: .capsule,
//        notes: "Take for headache",
//        frequency: .everyFewDays,
//        interval: 3,
//        startDate: Date(),
//        endDate: nil,
//        time: Date()
//    )
//    
//    // Step 4: Add an appointment for the user
//    AppointmentDataModel.sharedAppointmentData.addAppointment(
//        userId: user.id,
//        doctorName: "Dr. John Smith",
//        hospitalName: "City Hospital",
//        tag: "General Checkup",
//        notes: "Annual health check-up",
//        time: Date(),
//        date: Date(),
//        status: .pending
//    )
//    
//    // Step 5: Add reports for the user
//    ReportDataModel.sharedReportData.addReport(
//        userId: user.id,
//        imagePath: "/path/to/report1.pdf",
//        time: Date(),
//        date: Date()
//    )
//    
//    ReportDataModel.sharedReportData.addReport(
//        userId: user.id,
//        imagePath: "/path/to/report2.jpg",
//        time: Date(),
//        date: Date()
//    )
//    
//    // Step 6: Add prescriptions for the user
//    let prescription1 = Prescription(
//        id: UUID(),
//        userId: user.id,
//        imagePath: "/path/to/prescription1.jpg",
//        time: Date(),
//        date: Date()
//    )
//    
//    let prescription2 = Prescription(
//        id: UUID(),
//        userId: user.id,
//        imagePath: "/path/to/prescription2.jpg",
//        time: Date(),
//        date: Date()
//    )
//    
//    // Step 7: Add a report object containing all relevant user data
//    let report = tags(
//        id: UUID(),
//        userId: user.id,
//        tagName: "Annual Health Summary",
//        hospitalName: "City Hospital",
//        appointment: ["General Checkup"],
//        medication: ["Paracetamol", "Ibuprofen"],
//        notes: "Comprehensive health summary report",
//        prescriptions: [prescription1, prescription2],
//        reports: ReportDataModel.sharedReportData.getReports(for: user.id)
//    )
//    
//    print("Dummy data generated for user: \(user.profile.firstName) \(user.profile.lastName)")
//}
//
//// Generate and print dummy data
