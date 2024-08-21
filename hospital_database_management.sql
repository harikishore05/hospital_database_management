create schema hospital_management
use hospital_management
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1),
    address VARCHAR(255),
    phone_number VARCHAR(15),
    email VARCHAR(100)
);


CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialization VARCHAR(100),
    phone_number VARCHAR(15),
    email VARCHAR(100)
);


CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    appointment_time TIME,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);


CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    head_of_department VARCHAR(100)
);


CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY,
    patient_id INT,
    admission_date DATE,
    discharge_date DATE,
    room_number VARCHAR(10),
    doctor_id INT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);


INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender, address, phone_number, email)
VALUES 
(1, 'John', 'Doe', '1980-05-15', 'M', '123 Main St', '123-456-7890', 'john.doe@example.com'),
(2, 'Jane', 'Doe', '1985-08-23', 'F', '456 Oak St', '123-555-7890', 'jane.doe@example.com'),
(3, 'Michael', 'Johnson', '1990-11-02', 'M', '789 Pine St', '234-456-7890', 'michael.johnson@example.com'),
(4, 'Emily', 'Davis', '1992-02-14', 'F', '321 Maple St', '345-567-7890', 'emily.davis@example.com'),
(5, 'Robert', 'Brown', '1975-09-12', 'M', '654 Birch St', '456-678-7890', 'robert.brown@example.com');



INSERT INTO Doctors (doctor_id, first_name, last_name, specialization, phone_number, email)
VALUES 
(1, 'Alice', 'Smith', 'Cardiology', '098-765-4321', 'alice.smith@example.com'),
(2, 'David', 'Jones', 'Neurology', '555-234-5678', 'david.jones@example.com'),
(3, 'Laura', 'Miller', 'Pediatrics', '555-345-6789', 'laura.miller@example.com'),
(4, 'James', 'Wilson', 'Orthopedics', '555-456-7890', 'james.wilson@example.com'),
(5, 'Sophia', 'Garcia', 'Dermatology', '555-567-8901', 'sophia.garcia@example.com');


INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, appointment_time, status)
VALUES
(1, 1, 1, '2024-08-21', '10:00:00', 'Scheduled'),
(2, 2, 2, '2024-08-22', '09:30:00', 'Scheduled'),
(3, 3, 3, '2024-08-23', '11:00:00', 'Scheduled'),
(4, 4, 4, '2024-08-24', '14:00:00', 'Scheduled'),
(5, 5, 5, '2024-08-25', '16:30:00', 'Scheduled'),
(6, 1, 3, '2024-08-26', '10:30:00', 'Scheduled'),
(7, 2, 4, '2024-08-27', '13:00:00', 'Scheduled'),
(8, 3, 5, '2024-08-28', '15:00:00', 'Scheduled');


INSERT INTO Departments (department_id, department_name, head_of_department)
VALUES (1, 'Cardiology', 'Dr. Alice Smith'),
(2, 'Neurology', 'Dr. David Jones'),
(3, 'Pediatrics', 'Dr. Laura Miller'),
(4, 'Orthopedics', 'Dr. James Wilson'),
(5, 'Dermatology', 'Dr. Sophia Garcia');


INSERT INTO Admissions (admission_id, patient_id, admission_date, discharge_date, room_number, doctor_id)
VALUES 
(1, 1, '2024-08-21', '2024-08-25', '101', 1),
(2, 2, '2024-08-22', '2024-08-24', '102', 2),
(3, 3, '2024-08-23', '2024-08-25', '103', 3),
(4, 4, '2024-08-24', '2024-08-27', '104', 4),
(5, 5, '2024-08-25', '2024-08-28', '105', 5);

CREATE INDEX idx_doctor_id ON Appointments (doctor_id);


SELECT 
    a.appointment_id, 
    p.first_name AS patient_name, 
    p.last_name AS patient_last_name,
    d.first_name AS doctor_name, 
    d.last_name AS doctor_last_name, 
    a.appointment_date, 
    a.appointment_time, 
    a.status
FROM 
    Appointments a
INNER JOIN 
    Patients p ON a.patient_id = p.patient_id
INNER JOIN 
    Doctors d ON a.doctor_id = d.doctor_id;



SELECT 
    p.patient_id, 
    p.first_name AS patient_name, 
    p.last_name AS patient_last_name, 
    a.appointment_id, 
    a.appointment_date, 
    a.appointment_time, 
    a.status
FROM 
    Patients p
LEFT JOIN 
    Appointments a ON p.patient_id = a.patient_id;


SELECT 
    d.doctor_id, 
    d.first_name AS doctor_name, 
    d.last_name AS doctor_last_name, 
    a.appointment_id, 
    a.appointment_date, 
    a.appointment_time, 
    a.status
FROM 
    Doctors d
RIGHT JOIN 
    Appointments a ON d.doctor_id = a.doctor_id;


SELECT 
    p.first_name AS patient_name, 
    p.last_name AS patient_last_name, 
    d.first_name AS doctor_name, 
    d.last_name AS doctor_last_name
FROM 
    Patients p
CROSS JOIN 
    Doctors d;


SELECT 
    p.first_name AS patient_name, 
    p.last_name AS patient_last_name, 
    d.first_name AS doctor_name, 
    d.last_name AS doctor_last_name, 
    a.appointment_date, 
    a.appointment_time, 
    a.status
FROM 
    Patients p
LEFT JOIN 
    Appointments a ON p.patient_id = a.patient_id
LEFT JOIN 
    Doctors d ON a.doctor_id = d.doctor_id

UNION

SELECT 
    p.first_name AS patient_name, 
    p.last_name AS patient_last_name, 
    d.first_name AS doctor_name, 
    d.last_name AS doctor_last_name, 
    a.appointment_date, 
    a.appointment_time, 
    a.status
FROM 
    Doctors d
LEFT JOIN 
    Appointments a ON d.doctor_id = a.doctor_id
LEFT JOIN 
    Patients p ON a.patient_id = p.patient_id;
