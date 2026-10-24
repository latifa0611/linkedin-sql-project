---------------------------------------------------------
------------------ DDL ------------------

-- Company
DROP TABLE Company CASCADE CONSTRAINTS;

CREATE TABLE Company (
    Company_ID      INT PRIMARY KEY,
    Name            VARCHAR2(100) NOT NULL,
    Description     VARCHAR2(255)
);

---------------------------------------------------------
-- Job
DROP TABLE Job CASCADE CONSTRAINTS;

CREATE TABLE Job (
    Job_ID          INT PRIMARY KEY,
    Title           VARCHAR2(100) NOT NULL,
    Description     VARCHAR2(255),
    Salary          DECIMAL(10,2),
    Posted_date     DATE,
    Requirements    VARCHAR2(255),
    Company_ID      INT,
    CONSTRAINT FK_Job_Company
        FOREIGN KEY (Company_ID) REFERENCES Company(Company_ID)
        ON DELETE CASCADE
);

---------------------------------------------------------
-- Candidate
DROP TABLE Candidate CASCADE CONSTRAINTS;

CREATE TABLE Candidate (
    Candidate_ID    INT PRIMARY KEY,
    Phone_number    VARCHAR2(20),
    Email           VARCHAR2(100),
    Education       VARCHAR2(100),
    Experience      VARCHAR2(100),
    L_name          VARCHAR2(50),
    F_name          VARCHAR2(50)
);

---------------------------------------------------------
-- Candidate_Skills
DROP TABLE Candidate_Skills CASCADE CONSTRAINTS;

CREATE TABLE Candidate_Skills (
    Candidate_ID    INT,
    Skills          VARCHAR2(100),
    PRIMARY KEY (Candidate_ID, Skills),
    CONSTRAINT FK_CandidateSkills_Candidate
        FOREIGN KEY (Candidate_ID) REFERENCES Candidate(Candidate_ID)
        ON DELETE CASCADE
);

---------------------------------------------------------
-- Application
DROP TABLE Application CASCADE CONSTRAINTS;

CREATE TABLE Application (
    Application_number INT PRIMARY KEY,
    Job_ID              INT,
    Status              VARCHAR2(50),
    Submission_date     DATE,
    Candidate_ID        INT,
    CONSTRAINT FK_Application_Job
        FOREIGN KEY (Job_ID) REFERENCES Job(Job_ID)
        ON DELETE CASCADE,
    CONSTRAINT FK_Application_Candidate
        FOREIGN KEY (Candidate_ID) REFERENCES Candidate(Candidate_ID)
        ON DELETE CASCADE
);

---------------------------------------------------------
-- Interview
DROP TABLE Interview CASCADE CONSTRAINTS;

CREATE TABLE Interview (
    Interview_number INT PRIMARY KEY,
    Schedule_date    DATE,
    Schedule_time    VARCHAR2(8), 
    Outcome          VARCHAR2(50),
    Feedback         VARCHAR2(255),
    Job_ID           INT,
    Candidate_ID     INT,
    CONSTRAINT FK_Interview_Job
        FOREIGN KEY (Job_ID) REFERENCES Job(Job_ID)
        ON DELETE CASCADE,
    CONSTRAINT FK_Interview_Candidate
        FOREIGN KEY (Candidate_ID) REFERENCES Candidate(Candidate_ID)
        ON DELETE CASCADE
);

---------------------------------------------------------
-- Job_Interview
DROP TABLE Job_Interview CASCADE CONSTRAINTS;

CREATE TABLE Job_Interview (
    Job_ID           INT,
    Interview_number INT,
    PRIMARY KEY (Job_ID, Interview_number),
    CONSTRAINT FK_JobInterview_Job
        FOREIGN KEY (Job_ID) REFERENCES Job(Job_ID)
        ON DELETE CASCADE,
    CONSTRAINT FK_JobInterview_Interview
        FOREIGN KEY (Interview_number) REFERENCES Interview(Interview_number)
        ON DELETE CASCADE
);

---------------------------------------------------------
-------------------- DML --------------------

-- COMPANY
INSERT INTO Company VALUES 
(1, 'TechNova Solutions', 'A leading software development company specializing in web and AI applications.'),
(2, 'GreenFuture Ltd.', 'Environmental consulting and sustainability solutions.'),
(3, 'HealthBridge Inc.', 'Healthcare technology and data analytics company.'),
(4, 'EduWorld Systems', 'E-learning and digital education services provider.'),
(5, 'SecureNet Corp.', 'Cybersecurity and network protection firm.');

-- JOB
INSERT INTO Job VALUES
(101, 'Software Engineer', 'Develop and maintain software systems.', 8500.00,
 TO_DATE('2025-01-15','YYYY-MM-DD'), 'BSc in CS, 2+ years experience', 1),
(102, 'Environmental Analyst', 'Conduct environmental impact assessments.', 6200.00,
 TO_DATE('2025-02-10','YYYY-MM-DD'), 'Degree in Environmental Science', 2),
(103, 'Data Scientist', 'Analyze healthcare data to improve outcomes.', 9500.00,
 TO_DATE('2025-03-05','YYYY-MM-DD'), 'Experience with Python and ML', 3),
(104, 'Curriculum Developer', 'Design interactive online courses.', 7000.00,
 TO_DATE('2025-04-12','YYYY-MM-DD'), 'Education background required', 4),
(105, 'Cybersecurity Specialist', 'Monitor and secure client systems.', 9800.00,
 TO_DATE('2025-05-01','YYYY-MM-DD'), 'Certification in cybersecurity', 5);


-- CANDIDATE
INSERT INTO Candidate VALUES
(201, '+966500112233', 'sara.khalid@email.com', 'BSc Computer Science', '2 years software dev', 'Khalid', 'Sara'),
(202, '+966501223344', 'fawaz.ali@email.com', 'BSc Environmental Eng.', '1 year field analysis', 'Ali', 'Fawaz'),
(203, '+966502334455', 'noor.ahmad@email.com', 'MSc Data Science', '3 years data analytics', 'Ahmad', 'Noor'),
(204, '+966503445566', 'abdulaziz.saleh@email.com', 'BEd Education', '5 years teaching exp.', 'Saleh', 'Abdulaziz'),
(205, '+966504556677', 'layla.abdullah@email.com', 'BSc Cybersecurity', '2 years IT security', 'Abdullah', 'Layla');

-- CANDIDATE SKILLS
INSERT INTO Candidate_Skills VALUES
(201, 'Java'),
(201, 'SQL'),
(202, 'Data Collection'),
(203, 'Machine Learning'),
(204, 'Curriculum Design'),
(205, 'Network Security'),
(205, 'Ethical Hacking'),
(203, 'Python'),
(202, 'Environmental Analysis'),
(204, 'E-Learning Tools');

-- APPLICATION
INSERT INTO Application VALUES
(301, 101, 'Under Review',        TO_DATE('2025-05-10','YYYY-MM-DD'), 201),
(302, 102, 'Accepted',            TO_DATE('2025-05-12','YYYY-MM-DD'), 202),
(303, 103, 'Rejected',            TO_DATE('2025-05-13','YYYY-MM-DD'), 203),
(304, 104, 'Interview Scheduled', TO_DATE('2025-05-14','YYYY-MM-DD'), 204),
(305, 105, 'Under Review',        TO_DATE('2025-05-15','YYYY-MM-DD'), 205);

-- INTERVIEW
INSERT INTO Interview VALUES
(401, TO_DATE('2025-05-20','YYYY-MM-DD'), '10:00:00', 'Passed',  'Excellent technical skills.',      101, 201),
(402, TO_DATE('2025-05-22','YYYY-MM-DD'), '09:30:00', 'Passed',  'Good field knowledge.',            102, 202),
(403, TO_DATE('2025-05-23','YYYY-MM-DD'), '11:00:00', 'Failed',  'Lacked deep data insights.',       103, 203),
(404, TO_DATE('2025-05-25','YYYY-MM-DD'), '13:00:00', 'Pending', 'Creative approach to teaching.',   104, 204),
(405, TO_DATE('2025-05-27','YYYY-MM-DD'), '15:00:00', 'Passed',  'Strong cybersecurity awareness.',  105, 205);

-- JOB_INTERVIEW
INSERT INTO Job_Interview VALUES
(101, 401),
(102, 402),
(103, 403),
(104, 404),
(105, 405);

---------------------------------------------------------
------------------ Queries ------------------

-- Query 1: Candidates with More Than 3 Years of Experience
SELECT F_name, L_name, Experience, Email
FROM Candidate
WHERE Experience LIKE '%3 years%' OR Experience LIKE '%5 years%' OR Experience LIKE '%more%';

-- Scenario:
-- The recruitment manager requested this query to list  highly experienced candidates and support selecting qualified applicants.
---------------------------------------------------------

-- Query 2: Number of Applications for Each Job
SELECT J.Title, COUNT(A.Application_number) AS Total_Applications
FROM Job J
JOIN Application A ON J.Job_ID = A.Job_ID
GROUP BY J.Title;

-- Scenario:
-- The HR department requested this query to show how many applications each job received to evaluate job demand.
---------------------------------------------------------

-- Query 3: Candidates Who Have Not Been Scheduled for an Interview
SELECT C.F_name, C.L_name, J.Title
FROM Candidate C
JOIN Application A ON C.Candidate_ID = A.Candidate_ID
JOIN Job J ON A.Job_ID = J.Job_ID
WHERE C.Candidate_ID NOT IN (
    SELECT DISTINCT Candidate_ID FROM Interview
);

-- Scenario:
-- The interview coordinator requisted this query to find candidates without scheduled interviews to ensure proper follow-up.
---------------------------------------------------------

-- Query 4: All Interviews Scheduled on a Specific Date
SELECT I.Interview_number, J.Title, I.Schedule_date, I.Schedule_time
FROM Interview I
JOIN Job J ON I.Job_ID = J.Job_ID
WHERE I.Schedule_date = TO_DATE('2025-05-22','YYYY-MM-DD');

-- Scenario:
-- The HR assistant requisted this query to display interviews on specific date to manage the daily schedule efficiently.
---------------------------------------------------------

--Query 5: Companies That Have Not Posted Any Jobs
SELECT C.Name
FROM Company C
LEFT JOIN Job J ON C.Company_ID = J.Company_ID
WHERE J.Job_ID IS NULL;

-- Scenario:
-- The system administrator requested this query to identify companies wuth no posted jobs to monitor inactive accounts.
---------------------------------------------------------

-- Query 6: Average Salary per Company
SELECT C.Name, AVG(J.Salary) AS Average_Salary
FROM Company C
JOIN Job J ON C.Company_ID = J.Company_ID
GROUP BY C.Name;

-- Scenario:
-- The analytics team requested this query to compare  average salary levels across companies for reporting purpose.
---------------------------------------------------------

-- Query 7: Update Job Salary (UPDATE)
UPDATE Job
SET Salary = Salary * 1.10
WHERE Company_ID = 1;

-- Scenario:
-- The company manager requested this update to raise job salaries by 10% to stay competitive in the market.
---------------------------------------------------------

-- Query 8: Delete Canceled Applications (DELETE)
DELETE FROM Application
WHERE Status = 'Canceled';

-- Scenario:
-- The system administrator requested this delete action to remove all canceled applications and keep the database clean.