#ifndef COURSE_H
#define COURSE_H

#include <string>

class Course {
public:
    std::string course_number;
    std::string course_name;
    int credit_hours;
    std::string department;
};

#endif