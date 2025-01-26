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

// Classes to represent data
class StudentData {
public:
    string name;
    int student_number;
    int student_class;
    string major;

    StudentData(string name, int student_number, int student_class, string major)
        : name(name), student_number(student_number), student_class(student_class), major(major) {}
};

class CourseData {
public:
    string course_name;
    string course_number;
    int credit_hours;
    string department;

    CourseData(string course_name, string course_number, int credit_hours, string department)
        : course_name(course_name), course_number(course_number), credit_hours(credit_hours), department(department) {}
};

class SectionData {
public:
    int section_identifier;
    string course_number;
    string semester;
    int year;
    string instructor;

    SectionData(int section_identifier, string course_number, string semester, int year, string instructor)
        : section_identifier(section_identifier), course_number(course_number), semester(semester), year(year), instructor(instructor) {}
};

class GradeReportData {
public:
    int student_number;
    int section_identifier;
    string grade;

    GradeReportData(int student_number, int section_identifier, string grade)
        : student_number(student_number), section_identifier(section_identifier), grade(grade) {}
};

class PrerequisiteData {
public:
    string course_number;
    string prerequisite_number;

    PrerequisiteData(string course_number, string prerequisite_number)
        : course_number(course_number), prerequisite_number(prerequisite_number) {}
};

// Function to parse CSV files
template <typename T>
vector<T> loadCSV(const string& file_path, function<T(vector<string>&)> createObject) {
    vector<T> data;
    ifstream file(file_path);
    string line;

    // Skip the header line
    getline(file, line);

    while (getline(file, line)) {
        stringstream ss(line);
        string cell;
        vector<string> row;
        while (getline(ss, cell, ',')) {
            cell.erase(remove(cell.begin(), cell.end(), '\r'), cell.end()); // Remove potential carriage returns
            row.push_back(cell);
        }
        data.push_back(createObject(row));
    }
    return data;
}

// Load functions for each type of data
vector<StudentData> loadStudents(const string& file_path) {
    return loadCSV<StudentData>(file_path, [](vector<string>& row) {
        return StudentData(row[0], stoi(row[1]), stoi(row[2]), row[3]);
    });
}

vector<CourseData> loadCourses(const string& file_path) {
    return loadCSV<CourseData>(file_path, [](vector<string>& row) {
        return CourseData(row[0], row[1], stoi(row[2]), row[3]);
    });
}

vector<SectionData> loadSections(const string& file_path) {
    return loadCSV<SectionData>(file_path, [](vector<string>& row) {
        return SectionData(stoi(row[0]), row[1], row[2], stoi(row[3]), row[4]);
    });
}

vector<GradeReportData> loadGradeReports(const string& file_path) {
    return loadCSV<GradeReportData>(file_path, [](vector<string>& row) {
        return GradeReportData(stoi(row[0]), stoi(row[1]), row[2]);
    });
}

vector<PrerequisiteData> loadPrerequisites(const string& file_path) {
    return loadCSV<PrerequisiteData>(file_path, [](vector<string>& row) {
        return PrerequisiteData(row[0], row[1]);
    });
}

// Functions to query data
void retrieveTranscript(const string& student_name, const vector<StudentData>& students, const vector<CourseData>& courses, const vector<SectionData>& sections, const vector<GradeReportData>& grades) {
    bool student_found = false;
    for (const auto& student : students) {
        if (student.name == student_name) {
            student_found = true;
            cout << "Name: " << student.name << "\n";
            cout << "Student Number: " << student.student_number << "\n";
            cout << "Class: " << student.student_class << "\n";
            cout << "Major: " << student.major << "\n";
            cout << "Courses Enrolled:\n";

            for (const auto& grade : grades) {
                if (grade.student_number == student.student_number) {
                    for (const auto& section : sections) {
                        if (section.section_identifier == grade.section_identifier) {
                            for (const auto& course : courses) {
                                if (course.course_number == section.course_number) {
                                    cout << "- " << section.section_identifier << ", " << course.course_name << ", " << section.semester << ", " << section.year << ", Grade: " << grade.grade << "\n";
                                }
                            }
                        }
                    }
                }
            }
            break;
        }
    }
    if (!student_found) {
        cout << "Error: Student \"" << student_name << "\" not found.\n";
    }
}

void studentsInSection(const string& course_name, const string& semester, int year, const vector<CourseData>& courses, const vector<SectionData>& sections, const vector<StudentData>& students, const vector<GradeReportData>& grades) {
    bool section_found = false;
    for (const auto& course : courses) {
        if (course.course_name == course_name) {
            cout << "Course Name: " << course.course_name << "\n";
            cout << "Course Number: " << course.course_number << "\n";
            cout << "Credit Hours: " << course.credit_hours << "\n";
            cout << "Department: " << course.department << "\n";
            cout << "Student(s) Enrolled:\n";

            for (const auto& section : sections) {
                if (section.course_number == course.course_number && section.semester == semester && section.year == year) {
                    section_found = true;
                    for (const auto& grade : grades) {
                        if (grade.section_identifier == section.section_identifier) {
                            for (const auto& student : students) {
                                if (student.student_number == grade.student_number) {
                                    cout << "- " << student.name << ", Grade: " << grade.grade << "\n";
                                }
                            }
                        }
                    }
                }
            }
            break;
        }
    }
    if (!section_found) {
        cout << "Error: Section \"" << course_name << ", " << semester << " " << year << "\" not found.\n";
    }
}

void prerequisites(const string& course_name, const vector<CourseData>& courses, const vector<PrerequisiteData>& prerequisites) {
    bool course_found = false;
    for (const auto& course : courses) {
        if (course.course_name == course_name) {
            course_found = true;
            cout << "Course Name: " << course.course_name << "\n";
            cout << "Course Number: " << course.course_number << "\n";
            cout << "Credit Hours: " << course.credit_hours << "\n";
            cout << "Department: " << course.department << "\n";
            cout << "Prerequisites:\n";

            for (const auto& prerequisite : prerequisites) {
                if (prerequisite.course_number == course.course_number) {
                    for (const auto& prereq_course : courses) {
                        if (prereq_course.course_number == prerequisite.prerequisite_number) {
                            cout << "- " << prereq_course.course_name << ", " << prereq_course.course_number << ", " << prereq_course.credit_hours << ", " << prereq_course.department << "\n";
                        }
                    }
                }
            }
            break;
        }
    }
    if (!course_found) {
        cout << "Error: Course \"" << course_name << "\" not found.\n";
    }
}

int main() {
    // Load data from CSV files
    vector<StudentData> students = loadStudents("Student.csv");
    vector<CourseData> courses = loadCourses("Course.csv");
    vector<SectionData> sections = loadSections("Section.csv");
    vector<GradeReportData> grades = loadGradeReports("Grade_Report.csv");
    vector<PrerequisiteData> prerequisites_list = loadPrerequisites("Prerequisite.csv");

    // Example queries
    retrieveTranscript("Smith", students, courses, sections, grades);
    cout << "\n";
    studentsInSection("Database", "Fall", 2008, courses, sections, students, grades);
    cout << "\n";
    prerequisites("Database", courses, prerequisites_list);

    return 0;
}