//
//  QuizModel.swift
//  Mystory
//
//  Created by saba alrasheed on 20/06/1447 AH.
//

import Foundation
import UIKit
import SwiftUI

struct QuizScenario: Identifiable {
    let id = UUID()

    /// Localizable key for question 1 text
    let question1Key: String

    /// Localizable keys for the multiple-choice options
    let optionKeys: [String]

    /// Index of the correct option in `optionKeys`
    let correctOptionIndex: Int

    /// Localizable key for question 2 text (true/false)
    let question2Key: String

    /// Correct true/false answer for question 2
    let correctTrueFalse: Bool
}

// MARK: - All Scenarios

let quizScenarios: [QuizScenario] = [

    // Scenario 1
    QuizScenario(
        question1Key: "s1_q1_title",
        optionKeys: [
            "s1_q1_option1",
            "s1_q1_option2"
        ],
        correctOptionIndex: 1,
        question2Key: "s1_q2_title",
        correctTrueFalse: true
    ),

    // Scenario 2
    QuizScenario(
        question1Key: "s2_q1_title",
        optionKeys: [
            "s2_q1_option1",
            "s2_q1_option2"
        ],
        correctOptionIndex: 1,
        question2Key: "s2_q2_title",
        correctTrueFalse: true
    ),

    // Scenario 3
    QuizScenario(
        question1Key: "s3_q1_title",
        optionKeys: [
            "s3_q1_option1",
            "s3_q1_option2"
        ],
        correctOptionIndex: 1,
        question2Key: "s3_q2_title",
        correctTrueFalse: true
    ),

    // Scenario 4
    QuizScenario(
        question1Key: "s4_q1_title",
        optionKeys: [
            "s4_q1_option1",   // Laughed at him
            "s4_q1_option2"    // Asked if he was okay (correct)
        ],
        correctOptionIndex: 1,
        question2Key: "s4_q2_title",
        correctTrueFalse: true
    )
]
