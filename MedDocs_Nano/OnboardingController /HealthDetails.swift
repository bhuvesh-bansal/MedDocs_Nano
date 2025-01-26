import Foundation

struct HealthDetails: Codable {
    let id: String
    let height: Double
    let weight: Double
    let bloodPressure: String
    let bloodSugar: Double
    let heartRate: Int
    let medications: String
    let allergies: String
    let medicalConditions: String
    
    static func isValidBloodPressure(_ bloodPressure: String) -> Bool {
        let components = bloodPressure.split(separator: "/")
        guard components.count == 2,
              let systolic = Int(components[0]),
              let diastolic = Int(components[1]),
              systolic >= 70 && systolic <= 200,
              diastolic >= 40 && diastolic <= 130 else {
            return false
        }
        return true
    }
    
    
}
