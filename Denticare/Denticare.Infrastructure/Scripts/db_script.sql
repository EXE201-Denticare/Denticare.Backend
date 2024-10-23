CREATE TABLE Area
(
    AreaID INT IDENTITY(1,1) PRIMARY KEY,
    AreaName VARCHAR(MAX) NOT NULL
);

CREATE TABLE Dentist
(
    DentistID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    FullName VARCHAR(100) NULL,
    Email VARCHAR(100) NULL,
    Password VARCHAR(MAX) NULL,
    PhoneNumber VARCHAR(10) NULL,
    CitizenID VARCHAR(12) NULL,
    Image VARCHAR(MAX) NULL,
    Bio VARCHAR(MAX) NULL,
    RefreshToken VARCHAR(MAX) NULL,
    RefreshTokenExpiryTime DATETIME2 NULL,
    PasswordResetToken VARCHAR(MAX) NULL,
    PasswordResetTokenExpiryTime DATETIME2 NULL
);

CREATE TABLE DentistWorkingSchedule
(
    WorkingScheduleID INT IDENTITY(1,1) PRIMARY KEY,
    WorkingDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    DentistID UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT FK_DentistWorkingSchedule_Dentist_DentistID
        FOREIGN KEY (DentistID) REFERENCES Dentist (DentistID) ON DELETE CASCADE
);

CREATE INDEX IX_DentistWorkingSchedule_DentistID
    ON DentistWorkingSchedule (DentistID);

CREATE TABLE [User]
(
    UserID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    FullName VARCHAR(100) NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(MAX) NULL,
    PhoneNumber VARCHAR(10) NULL,
    CitizenID VARCHAR(12) NULL,
    Image VARCHAR(MAX) NULL,
    DateOfBirth DATETIME2 NULL,
    Address VARCHAR(255) NULL,
    Bio VARCHAR(MAX) NULL,
    RefreshToken VARCHAR(MAX) NULL,
    RefreshTokenExpiryTime DATETIME2 NULL,
    Role SMALLINT NOT NULL,
    PasswordResetToken VARCHAR(MAX) NULL,
    PasswordResetTokenExpiryTime DATETIME2 NULL
);

CREATE TABLE Clinic
(
    ClinicID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    ClinicName VARCHAR(200) NOT NULL,
    LicenseNumber VARCHAR(50) NULL,
    Address VARCHAR(300) NULL,
    Email VARCHAR(100) NULL,
    PhoneNumber VARCHAR(12) NULL,
    StartTime VARCHAR(10) NOT NULL,
    EndTime VARCHAR(10) NOT NULL,
    WorkingFrom VARCHAR(10) NULL,
    WorkingTo VARCHAR(10) NULL,
    State INT NOT NULL,
    OwnerID UNIQUEIDENTIFIER NOT NULL,
    AreaID INT NOT NULL,
    CONSTRAINT FK_Clinic_Area_AreaID
        FOREIGN KEY (AreaID) REFERENCES Area (AreaID) ON DELETE CASCADE,
    CONSTRAINT FK_Clinic_User_OwnerID
        FOREIGN KEY (OwnerID) REFERENCES [User] (UserID) ON DELETE CASCADE
);

CREATE INDEX IX_Clinic_AreaID
    ON Clinic (AreaID);

CREATE INDEX IX_Clinic_OwnerID
    ON Clinic (OwnerID);

CREATE TABLE Appointment
(
    AppointmentID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    CustomerID UNIQUEIDENTIFIER NOT NULL,
    ClinicID UNIQUEIDENTIFIER NOT NULL,
    DentistID UNIQUEIDENTIFIER NOT NULL,
    BookingDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    Note VARCHAR(300) NULL,
    Status INT NOT NULL,
    CONSTRAINT FK_Appointment_Clinic_ClinicID
        FOREIGN KEY (ClinicID) REFERENCES Clinic (ClinicID) ON DELETE CASCADE,
    CONSTRAINT FK_Appointment_Dentist_DentistID
        FOREIGN KEY (DentistID) REFERENCES Dentist (DentistID) ON DELETE CASCADE,
    CONSTRAINT FK_Appointment_User_CustomerID
        FOREIGN KEY (CustomerID) REFERENCES [User] (UserID) ON DELETE CASCADE
);

CREATE INDEX IX_Appointment_ClinicID
    ON Appointment (ClinicID);

CREATE INDEX IX_Appointment_CustomerID
    ON Appointment (CustomerID);

CREATE INDEX IX_Appointment_DentistID
    ON Appointment (DentistID);

CREATE TABLE ClinicDentist
(
    ClinicDentistID INT IDENTITY(1,1) PRIMARY KEY,
    DentistID UNIQUEIDENTIFIER NOT NULL,
    ClinicID UNIQUEIDENTIFIER NOT NULL,
    UserID UNIQUEIDENTIFIER NULL,
    CONSTRAINT FK_ClinicDentist_Clinic_ClinicID
        FOREIGN KEY (ClinicID) REFERENCES Clinic (ClinicID) ON DELETE CASCADE,
    CONSTRAINT FK_ClinicDentist_Dentist_DentistID
        FOREIGN KEY (DentistID) REFERENCES Dentist (DentistID) ON DELETE CASCADE,
    CONSTRAINT FK_ClinicDentist_User_UserID
        FOREIGN KEY (UserID) REFERENCES [User] (UserID) ON DELETE CASCADE
);

CREATE INDEX IX_ClinicDentist_UserID
    ON ClinicDentist (UserID);

CREATE INDEX IX_ClinicDentist_ClinicID
    ON ClinicDentist (ClinicID);

CREATE INDEX IX_ClinicDentist_DentistID
    ON ClinicDentist (DentistID);

CREATE TABLE ClinicFeedback
(
    ClinicFeedbackID INT IDENTITY(1,1) PRIMARY KEY,
    Description VARCHAR(800) NULL,
    Rating INT NOT NULL,
    CustomerID UNIQUEIDENTIFIER NOT NULL,
    ClinicID UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT FK_ClinicFeedback_Clinic_ClinicID
        FOREIGN KEY (ClinicID) REFERENCES Clinic (ClinicID) ON DELETE CASCADE,
    CONSTRAINT FK_ClinicFeedback_User_CustomerID
        FOREIGN KEY (CustomerID) REFERENCES [User] (UserID) ON DELETE CASCADE
);

CREATE INDEX IX_ClinicFeedback_ClinicID
    ON ClinicFeedback (ClinicID);

CREATE INDEX IX_ClinicFeedback_CustomerID
    ON ClinicFeedback (CustomerID);

CREATE TABLE ClinicImage
(
    ClinicImageID INT IDENTITY(1,1) PRIMARY KEY,
    ImageURL VARCHAR(MAX) NULL,
    ClinicID UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT FK_ClinicImage_Clinic_ClinicID
        FOREIGN KEY (ClinicID) REFERENCES Clinic (ClinicID) ON DELETE CASCADE
);

CREATE INDEX IX_ClinicImage_ClinicID
    ON ClinicImage (ClinicID);

CREATE TABLE DentalService
(
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(MAX) NOT NULL,
    Description VARCHAR(MAX) NOT NULL,
    Price DECIMAL NOT NULL,
    ClinicID UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT FK_DentalService_Clinic_ClinicID
        FOREIGN KEY (ClinicID) REFERENCES Clinic (ClinicID) ON DELETE CASCADE
);

CREATE INDEX IX_DentalService_ClinicID
    ON DentalService (ClinicID);

CREATE TABLE AppointmentService
(
    AppointmentServiceID INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentID UNIQUEIDENTIFIER NOT NULL,
    CurrentPrice DECIMAL NOT NULL,
    ServiceID INT NOT NULL,
    CONSTRAINT FK_AppointmentService_Appointment_AppointmentID
        FOREIGN KEY (AppointmentID) REFERENCES Appointment (AppointmentID) ON DELETE CASCADE,
    CONSTRAINT FK_AppointmentService_DentalService_ServiceID
        FOREIGN KEY (ServiceID) REFERENCES DentalService (ServiceID) ON DELETE CASCADE
);

CREATE INDEX IX_AppointmentService_AppointmentID
    ON AppointmentService (AppointmentID);

CREATE INDEX IX_AppointmentService_ServiceID
    ON AppointmentService (ServiceID);

CREATE TABLE [Transaction]
(
    TransactionID BIGINT IDENTITY(1,1) PRIMARY KEY,
    Amount DECIMAL NOT NULL,
    Status INT NOT NULL,
    CustomerID UNIQUEIDENTIFIER NOT NULL,
    AppointmentID UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT FK_Transaction_Appointment_AppointmentID
        FOREIGN KEY (AppointmentID) REFERENCES Appointment (AppointmentID) ON DELETE CASCADE,
    CONSTRAINT FK_Transaction_User_CustomerID
        FOREIGN KEY (CustomerID) REFERENCES [User] (UserID) ON DELETE CASCADE
);

CREATE INDEX IX_Transaction_AppointmentID
    ON [Transaction] (AppointmentID);

CREATE INDEX IX_Transaction_CustomerID
    ON [Transaction] (CustomerID);
