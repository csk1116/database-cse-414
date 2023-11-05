-- tested by Azure SQL Server

-- a.
CREATE TABLE InsuranceCo (
    name VARCHAR(50) PRIMARY KEY,
    phone BIGINT
);

CREATE TABLE Person (
    ssn INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Driver (
    d_ssn INT PRIMARY KEY REFERENCES Person(ssn),
    driverID BIGINT
);

CREATE TABLE NonProfessionalDriver (
    n_ssn INT PRIMARY KEY REFERENCES Driver(d_ssn)
);

CREATE TABLE ProfessionalDriver (
    p_ssn INT PRIMARY KEY REFERENCES Driver(d_ssn),
    medicalHistory VARCHAR(500)
);

CREATE TABLE Vehicle (
    licensePlate VARCHAR PRIMARY KEY,
    year INT,
    v_name VARCHAR(50) FOREIGN KEY REFERENCES InsuranceCo(name),
    maxLiability REAL,
    v_ssn INT FOREIGN KEY REFERENCES Person(ssn)
);

CREATE TABLE Car (
    c_licensePlate VARCHAR PRIMARY KEY REFERENCES Vehicle(licensePlate),
    make VARCHAR(50)
);

CREATE TABLE Drives (
    d_licensePlate VARCHAR FOREIGN KEY REFERENCES Car(c_licensePlate),
    d_ssn INT FOREIGN KEY REFERENCES NonProfessionalDriver(n_ssn),
    PRIMARY KEY(d_licensePlate, d_ssn)
);

CREATE TABLE Truck (
    t_licensePlate VARCHAR PRIMARY KEY REFERENCES Vehicle(licensePlate),
    capacity INT,
    t_ssn INT FOREIGN KEY REFERENCES ProfessionalDriver(p_ssn)
);

-- b. Because vehicle insured by InsuranceCo is a many-to-one relationship, I store "insures" into Vehicle by 
----- referencing (foreign key) Vehicle.v_name to InsuranceCo.name to remove the redundancy of creating a "insures" table.
----- Moreover, I put maxLiability in Vehicle because InsuranceCo can adjust it according to the vehicle.

-- c. Truck operated by ProfessionalDriver is a many-to-one relationship. Therefore, I can store "operates" into Truck. 
----- However, NonProfessionalDriver drives a car is a many-to-many relationship, which means I have to create a table
----- "drives" to store possible combinations between car and nonprofessional driver. I set both of the foreign key 
----- (d_licensePlate, d_ssn) to be a primary key to constraint duplicate combinations. 


