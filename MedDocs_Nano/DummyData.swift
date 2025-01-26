import Foundation

func initializeSampleData() {
    // Sample Tags
    let tag1 = TagDataModel.sharedTagData.addTag(
        tagName: "Neck Pain",
        hospital: [],
        appointments: [],
        notes: "Pain in the neck",
        reports: []
    )
    let tag2 = TagDataModel.sharedTagData.addTag(
        tagName: "Back Pain",
        hospital: [],
        appointments: [],
        notes: "Back discomfort",
        reports: []
    )
    
    // Sample Hospitals
    let hospital1 = HospitalDataModel.sharedHospitalData.addHospital(
        hospitalName: "City Hospital",
        tags: [tag1.id, tag2.id]
    )
    let hospital2 = HospitalDataModel.sharedHospitalData.addHospital(
        hospitalName: "General Clinic",
        tags: [tag1.id]
    )
    
    // Sample User
    let user = UserDataModel.sharedUserData.registerUser(
        email: "john.doe@example.com",
        password: "password123"
    )
    
    // Sample Profile
    let profile = UserDataModel.sharedUserData.addProfile(
        userId: user.userId,
        profileImage: nil,
        email: "john.doe@example.com",
        firstName: "John",
        lastName: "Doe",
        dob: Date(),
        phoneNumber: "9876543210",
        sex: .male,
        bloodType: .oPositive,
        allergies: [.food, .drug],
        address: "1234 Elm St"
    )
    
    // Sample Medication
    let dosage1 = Dosage(id: UUID(), time: Date())
    let medication1 = MedicationDataModel.sharedMedicationData.addMedication(
        medicineName: "Paracetamol",
        hospitalName: "City Hospital",
        doctorName: "Dr. Smith",
        type: .tablet,
        dosage: [dosage1],
        notes: "For Fever",
        frequency: .everyDay,
        interval: nil,
        startDate: Date(),
        endDate: nil,
        time: Date(),
        tag: tag1.id,
        appointment: nil
    )
    
    // Sample Appointment
//    let appointment1 = AppointmentDataModel.sharedAppointmentData.addAppointment(
//        doctorName: "Dr. Smith",
//        hospitalName: "City Hospital",
//        tag: tag1.id,
//        medication: [medication1.id],
//        notes: "Follow-up for neck pain",
//        time: Date(),
//        date: Date(),
//        status: .pending
//    )
    
    // Assign the tag to the user by modifying the user's tags directly
    var userToUpdate = UserDataModel.sharedUserData.getAllUsers().first
    userToUpdate?.tags.append(tag1.id)  // Now it is mutable because we make `userToUpdate` a var
    
    // Update the user in the data model after modifying tags
    if let userToUpdate = userToUpdate {
        UserDataModel.sharedUserData.editUser(
            id: userToUpdate.userId,
            email: nil,
            password: nil,
            profileDetails: profile
        )
    }
    
    // Sample Report
    let report1 = ReportDataModel.sharedReportData.addReport(
        path: "Report/neck_pain.pdf",
        time: Date(),
        date: Date(),
        reportType: .pdf
    )
    
    // Linking reports to the tag
    TagDataModel.sharedTagData.editTag(tagId: tag1.id, reports: [report1.id])
}


