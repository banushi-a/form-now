CREATE DATABASE form_now_db;
CREATE USER 'webapp'@'%' IDENTIFIED BY 'abc123';
GRANT ALL PRIVILEGES ON cool_db.* TO 'webapp'@'%';
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
    CreatorUsername VARCHAR(20) FOREIGN KEY,
    FormName VARCHAR(40)
);

CREATE TABLE MCQuestions (
    MCQuestionId INTEGER PRIMARY KEY,
    FormId INTEGER FOREIGN KEY,
    MCQuestionText VARCHAR(200),
    MCQuestionWeight INTEGER,
    RequiresResponse BOOLEAN
);

CREATE TABLE MCQuestionPossibilities (
    MCQuestionPossibilityId INTEGER PRIMARY KEY,
    MCQuestionId INTEGER FOREIGN KEY,
    MCQuestionPossibilityText VARCHAR(100),
    MCQuestionCorrect BOOLEAN
);

CREATE TABLE ShortAnswerQuestions (
    ShortAnswerId INTEGER PRIMARY KEY,
    FormId INTEGER FOREIGN KEY,
    ShortAnswerQuestionText VARCHAR(200),
    ShortAnswerQuestionWeight INTEGER,
    RequiresResponse BOOLEAN
);

CREATE TABLE SliderQuestions (
    SliderId INTEGER PRIMARY KEY,
    FormId INTEGER FOREIGN KEY,
    SliderText VARCHAR(200),
    SliderQuestionWeight INTEGER,
    RequiresResponse BOOLEAN
);

CREATE TABLE CheckboxQuestions (
    CheckboxQuestionId INTEGER PRIMARY KEY,
    FormId INTEGER FOREIGN KEY,
    CheckboxQuestionText VARCHAR(200),
    CheckboxQuestionTotalWeight INTEGER,
    RequiresResponse BOOLEAN
);

CREATE TABLE CheckboxQuestionPossibilities (
    CheckboxQuestionPosibilityId INTEGER PRIMARY KEY,
    CheckboxQuestionId INTEGER FOREIGN KEY,
    CheckboxQuestionPosibilityText VARCHAR(100),
    CheckboxQuestionCorrect BOOLEAN
);

CREATE TABLE FormsRespondents (
    FormId INTEGER,
    RespondentUsername VARCHAR(20),
    EarnedWeight INTEGER,
    PossibleWeight INTEGER,
    PRIMARY KEY(FormId, RespondentUsername)
);

CREATE TABLE FormsRespondentsQuestions (
    FormId INTEGER,
    RespondentUsername VARCHAR(20),
    QuestionId INTEGER,
    Answer VARCHAR(200),
    PRIMARY KEY(FormId, RespondentUsername, QuestionId)
);

CREATE TABLE AnalystsForms (
    AnalystUsername VARCHAR(20),
    FormId INTEGER,
    Observations VARCHAR(200),
    PRIMARY KEY(AnalystUsername, FormId)
);