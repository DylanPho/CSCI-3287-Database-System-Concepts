// Name: Dylan Phoutthavong
// Date: January 25th, 2025
// Course: CSCI 3287
// Task(s): 
            // - Retrieve the transcript—a list of all courses and grades—of ‘Smith’
            // - List the names of students who took the section of the ‘Database’ course offered in fall 2008 and their grades in that section
            // - List the prerequisites of the ‘Database’ course

#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <map>
#include <algorithm>
using namespace std;

// Classes for holding data
class StudentData {
public:
    string Name;
    int Student_number;
    int Class;
    string Major;
};

class CourseData {
public:
    string Course_name;
    string Course_number;
    int Credit_hours;
    string Department;
};

class SectionData {
public:
    int Section_identifier;
    string Course_number;
    string Semester;
    int Year;
    string Instructor;
};

class Grade_ReportData {
public:
    int Student_number;
    int Section_identifier;
    string Grade;
};

class PrerequisiteData {
public:
    string Course_number;
    string Prerequisite_number;
};

// Function to split a string by a delimiter
vector<string> split(const string& s, char delimiter) {
    vector<string> tokens;
    string token;
    istringstream tokenStream(s);
    while (getline(tokenStream, token, delimiter)) {
        tokens.push_back(token);
    }
    return tokens;
}

// Function to load CSV data into a vector of classes
template <typename T>
void loadCSV(const string& filename, vector<T>& container, T (*parser)(const vector<string>&)) {
    ifstream file(filename);
    string line;
    getline(file, line); // Skip the header
    while (getline(file, line)) {
        vector<string> tokens = split(line, ',');
        container.push_back(parser(tokens));
    }
}

// Parsers for each CSV type
StudentData parseStudent(const vector<string>& tokens) {
    return {tokens[0], stoi(tokens[1]), stoi(tokens[2]), tokens[3]};
}

CourseData parseCourse(const vector<string>& tokens) {
    return {tokens[0], tokens[1], stoi(tokens[2]), tokens[3]};
}

SectionData parseSection(const vector<string>& tokens) {
    return {stoi(tokens[0]), tokens[1], tokens[2], stoi(tokens[3]), tokens[4]};
}

Grade_ReportData parseGradeReport(const vector<string>& tokens) {
    return {stoi(tokens[0]), stoi(tokens[1]), tokens[2]};
}

PrerequisiteData parsePrerequisite(const vector<string>& tokens) {
    return {tokens[0], tokens[1]};
}

// Query functions
void retrieveTranscript(const string& studentName, const vector<StudentData>& students,
                        const vector<CourseData>& courses, const vector<SectionData>& sections,
                        const vector<Grade_ReportData>& gradeReports) {
    // Find the student
    auto studentIt = find_if(students.begin(), students.end(), [&studentName](const StudentData& s) {
        return s.Name == studentName;
    });

    if (studentIt == students.end()) {
        cout << "Student not found." << endl;
        return;
    }

    int studentNumber = studentIt->Student_number;

    cout << "Transcript for " << studentName << ":\n";
    for (const auto& gradeReport : gradeReports) {
        if (gradeReport.Student_number == studentNumber) {
            auto sectionIt = find_if(sections.begin(), sections.end(), [&gradeReport](const SectionData& s) {
                return s.Section_identifier == gradeReport.Section_identifier;
            });

            if (sectionIt != sections.end()) {
                auto courseIt = find_if(courses.begin(), courses.end(), [&sectionIt](const CourseData& c) {
                    return c.Course_number == sectionIt->Course_number;
                });

                if (courseIt != courses.end()) {
                    cout << courseIt->Course_number << " - " << courseIt->Course_name << " | Grade: "
                         << gradeReport.Grade << " | Semester: " << sectionIt->Semester
                         << " " << sectionIt->Year << endl;
                }
            }
        }
    }
}

void studentsInSection(const string& courseName, const string& semester, int year,
                       const vector<CourseData>& courses, const vector<SectionData>& sections,
                       const vector<StudentData>& students, const vector<Grade_ReportData>& gradeReports) {
    // Find the course
    auto courseIt = find_if(courses.begin(), courses.end(), [&courseName](const CourseData& c) {
        return c.Course_name == courseName;
    });

    if (courseIt == courses.end()) {
        cout << "Course not found." << endl;
        return;
    }

    string courseNumber = courseIt->Course_number;

    cout << "Students in " << courseName << " (" << semester << " " << year << "):\n";
    for (const auto& section : sections) {
        if (section.Course_number == courseNumber && section.Semester == semester && section.Year == year) {
            for (const auto& gradeReport : gradeReports) {
                if (gradeReport.Section_identifier == section.Section_identifier) {
                    auto studentIt = find_if(students.begin(), students.end(), [&gradeReport](const StudentData& s) {
                        return s.Student_number == gradeReport.Student_number;
                    });

                    if (studentIt != students.end()) {
                        cout << studentIt->Name << " | Grade: " << gradeReport.Grade << endl;
                    }
                }
            }
        }
    }
}

void listPrerequisites(const string& courseName, const vector<CourseData>& courses, const vector<PrerequisiteData>& prerequisites) {
    // Find the course
    auto courseIt = find_if(courses.begin(), courses.end(), [&courseName](const CourseData& c) {
        return c.Course_name == courseName;
    });

    if (courseIt == courses.end()) {
        cout << "Course not found." << endl;
        return;
    }

    string courseNumber = courseIt->Course_number;

    cout << "Prerequisites for " << courseName << ":\n";
    for (const auto& prerequisite : prerequisites) {
        if (prerequisite.Course_number == courseNumber) {
            auto prereqCourseIt = find_if(courses.begin(), courses.end(), [&prerequisite](const CourseData& c) {
                return c.Course_number == prerequisite.Prerequisite_number;
            });

            if (prereqCourseIt != courses.end()) {
                cout << prereqCourseIt->Course_number << " - " << prereqCourseIt->Course_name << endl;
            }
        }
    }
}

int main() {
    // Load data
    vector<StudentData> students;
    vector<CourseData> courses;
    vector<SectionData> sections;
    vector<Grade_ReportData> gradeReports;
    vector<PrerequisiteData> prerequisites;

    loadCSV("Student.csv", students, parseStudent);
    loadCSV("Course.csv", courses, parseCourse);
    loadCSV("Section.csv", sections, parseSection);
    loadCSV("Grade_Report.csv", gradeReports, parseGradeReport);
    loadCSV("Prerequisite.csv", prerequisites, parsePrerequisite);

    // Example queries
    retrieveTranscript("Smith", students, courses, sections, gradeReports);
    studentsInSection("Database", "Fall", 2008, courses, sections, students, gradeReports);
    listPrerequisites("Database", courses, prerequisites);

    return 0;
}