#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <map>
#include <algorithm>
using namespace std;

// Helper function to trim whitespace from a string
string trim(const string &str) {
    size_t first = str.find_first_not_of(" \t\n\r");
    if (first == string::npos) return "";
    size_t last = str.find_last_not_of(" \t\n\r");
    return str.substr(first, (last - first + 1));
}

// Utility function to load CSV data into a vector of strings
vector<vector<string>> loadCSV(const string &filename) {
    vector<vector<string>> data;
    ifstream file(filename);
    string line;

    // Skip the first line (header)
    bool isHeader = true;
    while (getline(file, line)) {
        if (isHeader) {
            isHeader = false;
            continue;
        }

        vector<string> row;
        stringstream ss(line);
        string cell;

        while (getline(ss, cell, ',')) {
            row.push_back(trim(cell)); // Trim each cell
        }

        data.push_back(row);
    }

    file.close();
    return data;
}

// Define the Student class
class Student {
public:
    string name;
    string studentNumber;
    int classLevel;
    string major;

    Student() : name(""), studentNumber(""), classLevel(0), major("") {}
    Student(string name, string number, int classLevel, string major)
        : name(name), studentNumber(number), classLevel(classLevel), major(major) {}
};

// Define the Course class
class Course {
public:
    string courseName;
    string courseNumber;
    int creditHours;
    string department;

    Course() : courseName(""), courseNumber(""), creditHours(0), department("") {}
    Course(string number, string name, int hours, string dept)
        : courseName(name), courseNumber(number), creditHours(hours), department(dept) {}
};

// Define the Section class
class Section {
public:
    string sectionID;
    string courseNumber;
    string semester;
    string year;

    Section() : sectionID(""), courseNumber(""), semester(""), year("") {}
    Section(string id, string courseNumber, string semester, string year)
        : sectionID(id), courseNumber(courseNumber), semester(semester), year(year) {}
};

// Define the GradeReport class
class GradeReport {
public:
    string studentNumber;
    string sectionID;
    string grade;

    GradeReport() : studentNumber(""), sectionID(""), grade("") {}
    GradeReport(string studentNumber, string sectionID, string grade)
        : studentNumber(studentNumber), sectionID(sectionID), grade(grade) {}
};

// Define the Prerequisite class
class Prerequisite {
public:
    string courseNumber;
    string prerequisiteNumber;

    Prerequisite() : courseNumber(""), prerequisiteNumber("") {}
    Prerequisite(string courseNumber, string prerequisiteNumber)
        : courseNumber(courseNumber), prerequisiteNumber(prerequisiteNumber) {}
};

// Function to retrieve and display the transcript of a student
void retrieveTranscript(const string &studentName, const map<string, Student> &students, const vector<GradeReport> &gradeReports, const map<string, Section> &sections, const map<string, Course> &courses) {
    for (const auto &[key, student] : students) {
        if (student.name == studentName) {
            cout << "\nName: " << student.name << endl;
            cout << "Student Number: " << student.studentNumber << endl;
            cout << "Class: " << student.classLevel << endl;
            cout << "Major: " << student.major << endl;
            cout << "Courses Enrolled:" << endl;

            for (const auto &gradeReport : gradeReports) {
                if (gradeReport.studentNumber == student.studentNumber) {
                    if (sections.find(gradeReport.sectionID) != sections.end()) {
                        Section section = sections.at(gradeReport.sectionID);
                        cout << "- " << section.sectionID << ", " << section.courseNumber << ", "
                             << section.semester << ", " << section.year << ", Grade: "
                             << gradeReport.grade << endl;
                    }
                }
            }
            return;
        }
    }
    cout << "\nStudent " << studentName << " not found." << endl;
}

// Function to search for students in a course section
void studentsInSection(const string &courseName, const string &courseNumber, const string &semester, const string &year, const map<string, Course> &courses, const map<string, Section> &sections, const vector<GradeReport> &gradeReports, const map<string, Student> &students) {
    cout << "\nCourse Name: " << courseName << endl;
    cout << "Course Number: " << courseNumber << endl;
    cout << "Semester: " << semester << endl;
    cout << "Year: " << year << endl;
    cout << "Student(s) Enrolled:" << endl;

    for (const auto &[key, section] : sections) {
        if (section.courseNumber == courseNumber && section.semester == semester && section.year == year) {
            for (const auto &gradeReport : gradeReports) {
                if (gradeReport.sectionID == section.sectionID) {
                    if (students.find(gradeReport.studentNumber) != students.end()) {
                        const Student &student = students.at(gradeReport.studentNumber);
                        cout << "- " << student.name << ", Grade: " << gradeReport.grade << endl;
                    }
                }
            }
            return;
        }
    }
    cout << "\nNo sections found for the specified course and semester." << endl;
}

// Function to list prerequisites of a course
void prerequisites(const string &courseName, const map<string, Course> &courses, const vector<Prerequisite> &prerequisites) {
    string courseNumber = "";

    // Check for course name in courses to get the course number
    for (const auto &[key, course] : courses) {
        if (course.courseNumber == courseNumber) {
            courseName = course.courseName;
            cout << "\nCourse Name: " << course.courseName << endl;
            cout << "Course Number: " << course.courseNumber << endl;
            cout << "Credit Hours: " << course.creditHours << endl;
            cout << "Department: " << course.department << endl;
            break;
        }
    }

    if (courseName.empty()) {
        cout << "\nCourse \"" << courseName << "\" not found." << endl;
        return;
    }

    // Check for prerequisites using the course number
    cout << "Prerequisites:" << endl;
    bool hasPrerequisites = false;
    for (const auto &prereq : prerequisites) {
        if (prereq.courseNumber == courseNumber) {
            hasPrerequisites = true;
            if (courses.find(prereq.prerequisiteNumber) != courses.end()) {
                const Course &prereqCourse = courses.at(prereq.prerequisiteNumber);
                cout << "- " << prereqCourse.courseName << ", " << prereqCourse.courseNumber
                     << ", " << prereqCourse.creditHours << ", " << prereqCourse.department << endl;
            }
        }
    }

    if (!hasPrerequisites) {
        cout << "- None" << endl;
    }
}

// Main function
int main() {
    // Load data from CSV files
    vector<vector<string>> studentData = loadCSV("Student.csv");
    vector<vector<string>> courseData = loadCSV("Course.csv");
    vector<vector<string>> sectionData = loadCSV("Section.csv");
    vector<vector<string>> gradeReportData = loadCSV("Grade_Report.csv");
    vector<vector<string>> prerequisiteDataRaw = loadCSV("Prerequisite.csv");

    // Parse Student data
    map<string, Student> students;
    for (const auto &row : studentData) {
        if (row.size() < 4) continue;
        students[row[1]] = Student(row[0], row[1], stoi(row[2]), row[3]);
    }

    // Parse Course data
    map<string, Course> courses;
    for (const auto &row : courseData) {
        if (row.size() < 4) continue;
        courses[row[0]] = Course(row[0], row[1], stoi(row[2]), row[3]);
    }

    // Parse Section data
    map<string, Section> sections;
    for (const auto &row : sectionData) {
        if (row.size() < 4) continue;
        sections[row[0]] = Section(row[0], row[1], row[2], row[3]);
    }

    // Parse Grade Report data
    vector<GradeReport> gradeReports;
    for (const auto &row : gradeReportData) {
        if (row.size() < 3) continue;
        gradeReports.push_back(GradeReport(row[0], row[1], row[2]));
    }

    // Parse Prerequisite data
    vector<Prerequisite> prerequisiteList;
    for (const auto &row : prerequisiteDataRaw) {
        if (row.size() < 2) continue;
        prerequisiteList.push_back(Prerequisite(row[0], row[1]));
    }

    // Menu for user input
    int choice;
    cout << "Choose an option:\n"
         << "1. Retrieve a student transcript\n"
         << "2. Search for students in a course section\n"
         << "3. Find the prerequisites for a course\n"
         << "Enter your choice: ";
    cin >> choice;
    cin.ignore(); // Ignore newline after the integer input

    if (choice == 1) {
        string studentName;
        cout << "\nEnter the name of the student to retrieve their transcript: ";
        getline(cin, studentName);
        retrieveTranscript(studentName, students, gradeReports, sections, courses);
    } else if (choice == 2) {
        string courseName, courseNumber, semester, year;
        cout << "\nEnter the course name: ";
        getline(cin, courseName);
        cout << "Enter the course number: ";
        getline(cin, courseNumber);
        cout << "Enter the semester: ";
        getline(cin, semester);
        cout << "Enter the year: ";
        getline(cin, year);
        studentsInSection(courseName, courseNumber, semester, year, courses, sections, gradeReports, students);
    } else if (choice == 3) {
        string courseName;
        cout << "\nEnter the course number to list prerequisites: ";
        getline(cin, courseName);
        prerequisites(courseName, courses, prerequisiteList);
    } else {
        cout << "\nInvalid choice." << endl;
    }

    return 0;
}