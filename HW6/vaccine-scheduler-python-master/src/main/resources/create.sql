CREATE TABLE Caregivers (
    Username varchar(255),
    Salt BINARY(16),
    Hash BINARY(16),
    PRIMARY KEY (Username)
);

CREATE TABLE Availabilities (
    Time date,
    Username varchar(255), 
    FOREIGN KEY (Username) REFERENCES Caregivers,
    PRIMARY KEY (Time, Username)
);

CREATE TABLE Vaccines (
    Name varchar(255),
    Doses int,
    PRIMARY KEY (Name)
);

CREATE TABLE Patients (
    Username varchar(255),
    Salt BINARY(16),
    Hash BINARY(16),
    PRIMARY KEY (Username)
);

CREATE TABLE Appointments (
    ID int IDENTITY(0,1),
    PatientName varchar(255), 
    VaccineName varchar(255), 
    Time date, 
    CaregiverName varchar(255),
    FOREIGN KEY (PatientName) REFERENCES Patients(Username),
    FOREIGN KEY (VaccineName) REFERENCES Vaccines(Name),
    FOREIGN KEY (Time, CaregiverName) REFERENCES Availabilities(Time, Username),
    PRIMARY KEY (ID)
);