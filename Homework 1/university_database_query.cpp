#include <iostream>
#include <fstream>
#include <vector>
#include <map>
#include <string>
#include <sstream>
#include <algorithm>

// Define classes for Course, Student, Section, GradeReport, and Prerequisite

class Course
{
public:
std::string courseNumber;
std::string courseName;

static std::vector<Course> loadFromCSV(const std::string& filePath);
};

class Student
{
public:
std::string studentID;
std::string studentName;

static std::vector<Student> loadFromCSV(const std::string& filePath);
};

class Section
{
public:
std::string sectionID;
std::string courseNumber;
std::string semester;
int year;

static std::vector<Section> loadFromCSV(const std::string& filePath);
};

class GradeReport
{
public:
std::string studentID;
std::string sectionID;
char grade;

static std::vector<GradeReport> loadFromCSV(const std::string& filePath);
};

class Prerequisite
{
public:
std::string courseNumber;
std::string prerequisiteNumber;

static std::vector<Prerequisite> loadFromCSV(const std::string& filePath);
};

// Function definitions for loading CSV files
std::vector<Course> Course::loadFromCSV(const std::string& filePath)
{
    std::vector<Course> courses;
    std::ifstream file(filePath);
    std::string line;
    while (std::getline(file, line))
    {
        std::stringstream ss(line);
        Course course;
        std::getline(ss, course.courseNumber, ',');
        std::getline(ss, course.courseName, ',');
        courses.push_back(course);
    }
    return courses
}

// Define other loadFromCSV methos for Student, Section, GradeReport, and Prerequisite

