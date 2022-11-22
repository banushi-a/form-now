CREATE DATABASE form_now_db;
CREATE USER 'webapp'@'%' IDENTIFIED BY 'abc123';
GRANT ALL PRIVILEGES ON form_now_db.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

USE form_now_db;

-- Initialize Database here :)
CREATE TABLE Creators (
    CreatorUsername VARCHAR(20) PRIMARY KEY,
    CreatorPassword VARCHAR(40),
    Email VARCHAR(40), 
    FirstName VARCHAR(40),
    LastName VARCHAR(40)
);

CREATE TABLE Respondents (
    RespondentUsername VARCHAR(20) PRIMARY KEY,
    RespondentPassword VARCHAR(40),
    Email VARCHAR(40),
    FirstName VARCHAR(40),
    LastName VARCHAR(40)
);

CREATE TABLE Analysts (
    AnalystUsername VARCHAR(20) PRIMARY KEY,
    AnalystPassword VARCHAR(40),
    Email VARCHAR(40),
    FirstName VARCHAR(40),
    LastName VARCHAR(40)
);

CREATE TABLE Forms (
    FormId INTEGER PRIMARY KEY,
    CreatorUsername VARCHAR(20),
    FormName VARCHAR(40),
    FOREIGN KEY (CreatorUsername) REFERENCES Creators(CreatorUsername)
);

CREATE TABLE Questions (
    QuestionId INTEGER PRIMARY KEY,
    FormId INTEGER,
    QuestionText VARCHAR(200),
    RequiresResponse BOOLEAN,
    QuestionWeight INTEGER,
    FOREIGN KEY (FormId) REFERENCES Forms(FormId)
);

CREATE TABLE MCQuestions (
    MCQuestionId INTEGER PRIMARY KEY,
    FOREIGN KEY (MCQuestionId) REFERENCES Questions(QuestionId)
);

CREATE TABLE MCQuestionPossibilities (
    MCQuestionPossibilityId INTEGER PRIMARY KEY,
    MCQuestionId INTEGER,
    MCQuestionPossibilityText VARCHAR(100),
    MCQuestionCorrect BOOLEAN,
    FOREIGN KEY (MCQuestionId) REFERENCES MCQuestions(MCQuestionId)
);

CREATE TABLE ShortAnswerQuestions (
    ShortAnswerId INTEGER PRIMARY KEY,
    FOREIGN KEY (ShortAnswerId) REFERENCES Questions(QuestionId)
);

CREATE TABLE SliderQuestions (
    SliderId INTEGER PRIMARY KEY,
    FOREIGN KEY (SliderId) REFERENCES Questions(QuestionId)
);

CREATE TABLE CheckboxQuestions (
    CheckboxQuestionId INTEGER PRIMARY KEY,
    FOREIGN KEY (CheckboxQuestionId) REFERENCES Questions(QuestionId)
);

CREATE TABLE CheckboxQuestionPossibilities (
    CheckboxQuestionPosibilityId INTEGER PRIMARY KEY,
    CheckboxQuestionId INTEGER,
    CheckboxQuestionPosibilityText VARCHAR(100),
    CheckboxQuestionCorrect BOOLEAN,
    FOREIGN KEY (CheckboxQuestionId) REFERENCES CheckboxQuestions(CheckboxQuestionId)
);

CREATE TABLE FormsRespondents (
    FormId INTEGER,
    RespondentUsername VARCHAR(20),
    EarnedWeight INTEGER,
    PossibleWeight INTEGER,
    PRIMARY KEY (FormId, RespondentUsername),
    FOREIGN KEY (FormId) REFERENCES Forms(FormId),
    FOREIGN KEY (RespondentUsername) REFERENCES Respondents(RespondentUsername)
);

-- changed this to not be dependent on FormRespondents since we 
-- can get that information from JOINING up through the tables
-- + this follows our ER diagram more closely
CREATE TABLE FormsRespondentsQuestions (
    QuestionId INTEGER,
    RespondentUsername VARCHAR(20),
    Answer VARCHAR(200),
    PRIMARY KEY (QuestionId, RespondentUsername),
    FOREIGN KEY (QuestionId) REFERENCES Questions(QuestionId),
    FOREIGN KEY (RespondentUsername) REFERENCES Respondents(RespondentUsername)
);

CREATE TABLE AnalystsForms (
    AnalystUsername VARCHAR(20),
    FormId INTEGER,
    Observations VARCHAR(200),
    PRIMARY KEY (AnalystUsername, FormId),
    FOREIGN KEY (FormId) REFERENCES Forms(FormId)
);


-- ADD DATA

INSERT INTO Creators
    (CreatorUsername, CreatorPassword, Email, FirstName, LastName)
VALUES
    ('creator1', 'creator1password', 'creator1@gmail.com', 'creator', 'one');