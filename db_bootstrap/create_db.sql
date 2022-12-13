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
    QuestionId INTEGER NOT NULL AUTO_INCREMENT,
    FormId INTEGER,
    QuestionText VARCHAR(200),
    RequiresResponse BOOLEAN,
    QuestionWeight INTEGER,
    PRIMARY KEY (QuestionId),
    FOREIGN KEY (FormId) REFERENCES Forms(FormId)
);

CREATE TABLE MCQuestions (
    MCQuestionId INTEGER PRIMARY KEY,
    QuestionId INTEGER,
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
    QuestionId INTEGER,
    FOREIGN KEY (ShortAnswerId) REFERENCES Questions(QuestionId)
);

CREATE TABLE SliderQuestions (
    SliderId INTEGER PRIMARY KEY,
    QuestionId INTEGER,
    FOREIGN KEY (SliderId) REFERENCES Questions(QuestionId)
);

CREATE TABLE CheckboxQuestions (
    CheckboxQuestionId INTEGER PRIMARY KEY,
    QuestionId INTEGER,
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
    FOREIGN KEY (FormId) REFERENCES Forms(FormId),
    FOREIGN KEY (AnalystUsername) REFERENCES Analysts(AnalystUsername)
);


-- ADD DATA

-- Creators
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('iseavers0', 'pL6UJEkq', 'iseavers0@qq.com', 'Ian', 'Seavers');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('nbryns1', '7nAqqkJzTkkC', 'nbryns1@hud.gov', 'Nikita', 'Bryns');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('gchasteney2', 'A9Pf1P', 'gchasteney2@unesco.org', 'Gretna', 'Chasteney');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('mtuminini3', 'ceWPm9dDNKN', 'mtuminini3@ehow.com', 'Marna', 'Tuminini');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('amackessock4', 'sqPrxXr', 'amackessock4@goo.gl', 'Amalita', 'MacKessock');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('apacht5', 'uZj43wuQsU', 'apacht5@arizona.edu', 'Aldis', 'Pacht');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('bwhitebread6', 'W71eJLQesK', 'bwhitebread6@hao123.com', 'Brigham', 'Whitebread');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('emacgille7', 'Diphzc3bKbbh', 'emacgille7@fema.gov', 'Euell', 'MacGille');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('dbaszniak8', 'aSrhNVs', 'dbaszniak8@squarespace.com', 'Dunn', 'Baszniak');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('mpatullo9', 'ZU4GtAExB2l6', 'mpatullo9@businessweek.com', 'Merlina', 'Patullo');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('fstollenberga', 'txnQGU', 'fstollenberga@ycombinator.com', 'Frasco', 'Stollenberg');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('kspybeyb', 'Y8UipQi', 'kspybeyb@hatena.ne.jp', 'Kacie', 'Spybey');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('mdrewec', 'lD2AJnhiDo', 'mdrewec@cyberchimps.com', 'Marwin', 'Drewe');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('abroud', 'i4Gq05Kop8x4', 'abroud@businessweek.com', 'Aldwin', 'Brou');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('elossmane', 'tv1FowBR', 'elossmane@seesaa.net', 'Ezekiel', 'Lossman');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('gblissittf', 'RYgHXa4MWoC', 'gblissittf@nymag.com', 'Grayce', 'Blissitt');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('xkrzysztofg', 'j10f5DnXHcPm', 'xkrzysztofg@oakley.com', 'Ximenes', 'Krzysztof');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('jwilsonh', 'fGYH6Avq', 'jwilsonh@columbia.edu', 'Julianne', 'Wilson');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('sdoohani', 'Z8rXnu', 'sdoohani@github.com', 'Stella', 'Doohan');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('akachelerj', 'fAbIUjGa', 'akachelerj@goo.gl', 'Archaimbaud', 'Kacheler');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('cmaclesek', 'VBr9RxchRt', 'cmaclesek@businessinsider.com', 'Corella', 'MacLese');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('mwardenl', 'Iy009amQhUX2', 'mwardenl@surveymonkey.com', 'Mariel', 'Warden');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('dbecarism', 'UVhbGSFtl7', 'dbecarism@dailymotion.com', 'Dukie', 'Becaris');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('tdaubern', 'HGMxK6tDa', 'tdaubern@vkontakte.ru', 'Tamiko', 'Dauber');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('kavramovico', 't1CF6bDISN7', 'kavramovico@addtoany.com', 'Kailey', 'Avramovic');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('ofallensp', 'Fh8I3jZD9s', 'ofallensp@admin.ch', 'Othilie', 'Fallens');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('fbenedettiniq', 'a1FlZMXZo', 'fbenedettiniq@nifty.com', 'Fawn', 'Benedettini');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('alanceterr', '859PVzUN', 'alanceterr@webs.com', 'Augie', 'Lanceter');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('erases', 'P2aISMaUDR', 'erases@cdbaby.com', 'Ellery', 'Rase');
insert into Creators (CreatorUsername, CreatorPassword, Email, FirstName, LastName) values ('sscottinit', 'E3emEIai', 'sscottinit@biblegateway.com', 'Shem', 'Scottini');

-- Respondents
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('cshoemark0', 'eonqyBA7oU', 'cshoemark0@dot.gov', 'Christopher', 'Shoemark');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('dpinnegar1', 'YFaiDbG', 'dpinnegar1@cpanel.net', 'Drake', 'Pinnegar');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('lrizzello2', 'nk0FTeOGk', 'lrizzello2@usgs.gov', 'Loutitia', 'Rizzello');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('blace3', 'mKk3c5cm', 'blace3@buzzfeed.com', 'Benyamin', 'Lace');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('iwetheril4', '9BcYYAfTvd', 'iwetheril4@github.com', 'Ivonne', 'Wetheril');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('gruse5', 'MnZ0BUf6f', 'gruse5@yahoo.com', 'Gabbi', 'Ruse');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('kashborn6', 'U4ptw7vq1K', 'kashborn6@t.co', 'Karlene', 'Ashborn');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('rgeddes7', '70Oggew', 'rgeddes7@irs.gov', 'Robers', 'Geddes');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('mcosgrove8', 'T4T1p5tv', 'mcosgrove8@gmpg.org', 'Matthaeus', 'Cosgrove');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('dstable9', '90qGmpnmj', 'dstable9@comsenz.com', 'Domingo', 'Stable');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('jcostalla', 'XQCRMDa1p', 'jcostalla@msu.edu', 'Jerry', 'Costall');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('lgilhoolieb', 'Qd7lntd', 'lgilhoolieb@dion.ne.jp', 'Lowe', 'Gilhoolie');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('ktidcombec', 'pb9cxNpMT', 'ktidcombec@google.com.br', 'Kali', 'Tidcombe');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('lweondd', 'lXEit2tdKlK', 'lweondd@ezinearticles.com', 'Loralie', 'Weond');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('pdummette', 'TPF4r7xX', 'pdummette@house.gov', 'Port', 'Dummett');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('bgabrielif', 'NxDCyn7', 'bgabrielif@elpais.com', 'Bernardina', 'Gabrieli');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('fmicklewiczg', 'kiuUco2', 'fmicklewiczg@ezinearticles.com', 'Felic', 'Micklewicz');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('kkuhleh', 'D8dkDCG6', 'kkuhleh@tamu.edu', 'Katha', 'Kuhle');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('fdawidowitschi', 'PctbItJk', 'fdawidowitschi@hostgator.com', 'Flossi', 'Dawidowitsch');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('esamwayesj', 'hTY4GO', 'esamwayesj@theglobeandmail.com', 'Emalee', 'Samwayes');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('tfroggattk', 'cZ48cXZieBFV', 'tfroggattk@flickr.com', 'Tim', 'Froggatt');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('rclaguel', 'WHBztsQK1M7Y', 'rclaguel@fema.gov', 'Rikki', 'Clague');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('wmathonm', 'pbAwa7L4', 'wmathonm@cnet.com', 'Welby', 'Mathon');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('zrableyn', 'dva2QIHghbsM', 'zrableyn@sakura.ne.jp', 'Zena', 'Rabley');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('totleyo', 'Q9vnoZr', 'totleyo@shinystat.com', 'Taylor', 'Otley');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('sprattp', 'T1ip8Bnl8OW', 'sprattp@desdev.cn', 'Shalna', 'Pratt');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('cgladbeckq', 'kG4nyz', 'cgladbeckq@sciencedirect.com', 'Christal', 'Gladbeck');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('jpinchinr', '1YtwBz6', 'jpinchinr@mysql.com', 'Jordanna', 'Pinchin');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('gbirdwhistles', 'HvlBMfS9BaXC', 'gbirdwhistles@dmoz.org', 'Giulietta', 'Birdwhistle');
insert into Respondents (RespondentUsername, RespondentPassword, Email, FirstName, LastName) values ('ftamblynt', 'IFbEiDFD', 'ftamblynt@yale.edu', 'Freida', 'Tamblyn');

-- Analysts
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('blonghorne0', 'cvf2u1', 'blonghorne0@cbslocal.com', 'Beau', 'Longhorne');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('ibambrough1', 'Y9RpEZGfEZ3K', 'ibambrough1@mediafire.com', 'Isaac', 'Bambrough');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('jsteffens2', 'biXAoe', 'jsteffens2@oakley.com', 'Jayson', 'Steffens');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('fjann3', 'MrkzAwScluO', 'fjann3@arstechnica.com', 'Frederigo', 'Jann');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('oquinion4', 'YmRzybF', 'oquinion4@sakura.ne.jp', 'Orville', 'Quinion');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('gpittem5', '8UADwCT', 'gpittem5@tinyurl.com', 'Gabriella', 'Pittem');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('cchalcroft6', 'jZvL5edsDRC', 'cchalcroft6@unblog.fr', 'Care', 'Chalcroft');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('slinthead7', 'eTNVuJer464', 'slinthead7@printfriendly.com', 'Sheelagh', 'Linthead');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('gjeffray8', 'pcWUHb', 'gjeffray8@japanpost.jp', 'Giffy', 'Jeffray');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('kbanane9', '1GoLWUuFaF8', 'kbanane9@pinterest.com', 'Kyla', 'Banane');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('jseabournea', 'UnVcKtc', 'jseabournea@studiopress.com', 'Jamal', 'Seabourne');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('lkeizmanb', 'ms5kHUux', 'lkeizmanb@virginia.edu', 'Loralie', 'Keizman');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('lleynhamc', '53oZ7RdPIU', 'lleynhamc@hostgator.com', 'Lorene', 'Leynham');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('lnolletd', 'jjisd2TAf', 'lnolletd@usnews.com', 'Linell', 'Nollet');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('adwyre', 'NIHUO6Aurtwc', 'adwyre@dagondesign.com', 'Alfie', 'Dwyr');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('cmacknockerf', 'cI9FnCAMQ', 'cmacknockerf@answers.com', 'Cilka', 'MacKnocker');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('cwoolertong', 'e6dzdY', 'cwoolertong@networkadvertising.org', 'Cchaddie', 'Woolerton');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('ckippingh', '6fW87w2RS0', 'ckippingh@google.ru', 'Carr', 'Kipping');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('fissacofi', 'MEkmOuZK', 'fissacofi@goo.ne.jp', 'Ferguson', 'Issacof');
insert into Analysts (AnalystUsername, AnalystPassword, Email, FirstName, LastName) values ('dchapleoj', 'Kopg0qF', 'dchapleoj@ow.ly', 'Douglass', 'Chapleo');

-- Forms
insert into Forms (FormId, CreatorUsername, FormName) values (1, 'cmaclesek', 'Cardguard');
insert into Forms (FormId, CreatorUsername, FormName) values (2, 'tdaubern', 'It');
insert into Forms (FormId, CreatorUsername, FormName) values (3, 'elossmane', 'Zamit');
insert into Forms (FormId, CreatorUsername, FormName) values (4, 'dbaszniak8', 'Zoolab');
insert into Forms (FormId, CreatorUsername, FormName) values (5, 'akachelerj', 'Y-find');
insert into Forms (FormId, CreatorUsername, FormName) values (6, 'gblissittf', 'Zoolab');
insert into Forms (FormId, CreatorUsername, FormName) values (7, 'mtuminini3', 'Vagram');
insert into Forms (FormId, CreatorUsername, FormName) values (8, 'xkrzysztofg', 'Fintone');
insert into Forms (FormId, CreatorUsername, FormName) values (9, 'amackessock4', 'Span');
insert into Forms (FormId, CreatorUsername, FormName) values (10, 'gblissittf', 'Prodder');
insert into Forms (FormId, CreatorUsername, FormName) values (11, 'erases', 'Tampflex');
insert into Forms (FormId, CreatorUsername, FormName) values (12, 'amackessock4', 'Redhold');
insert into Forms (FormId, CreatorUsername, FormName) values (13, 'apacht5', 'Lotlux');
insert into Forms (FormId, CreatorUsername, FormName) values (14, 'sdoohani', 'Rank');
insert into Forms (FormId, CreatorUsername, FormName) values (15, 'kspybeyb', 'Tempsoft');
insert into Forms (FormId, CreatorUsername, FormName) values (16, 'mtuminini3', 'Sonair');
insert into Forms (FormId, CreatorUsername, FormName) values (17, 'mdrewec', 'Wrapsafe');
insert into Forms (FormId, CreatorUsername, FormName) values (18, 'iseavers0', 'Zaam-Dox');
insert into Forms (FormId, CreatorUsername, FormName) values (19, 'mwardenl', 'Gembucket');
insert into Forms (FormId, CreatorUsername, FormName) values (20, 'fbenedettiniq', 'Trippledex');


-- Questions
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (1, 'How many Infinity Stones are there?', false, 5);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (2, 'What is the only food that cannot go bad?', true, 7);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (3, 'Which was Rene Magrittes first surrealist painting?', true, 1);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (4, 'What 90s boy band member bought Myspace in 2011?', false, 2);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (5, 'What is the most visited tourist attraction in the world?', false, 9);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (6, 'What is the name of Hagrids pet spider?', true, 4);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (7, 'What is the heaviest organ in the human body?', false, 6);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (8, 'Who made the third most 3-pointers in the Playoffs in NBA history?', true, 5);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (9, 'Which of these EU countries does not use the euro as its currency?', true, 7);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (10, 'Which US city is the sunniest major city and sees more than 320 sunny days each year?', false, 6);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (11, 'Do you consider yourself an introvert or an extrovert?', false, 8);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (12, 'what would yours say?', true, 10);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (13, 'How do you make decisions?', true, 3);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (14, 'What challenge would you like to see your best friend take on?', false, 6);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (15, 'How long do you think you could survive on your own?', false, 7);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (16, 'At what age did you think you become an adult and when do you actually think you did?', true, 3);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (17, 'What''s the strangest situation you ever found yourself in?', false, 3);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (18, 'Do you consider yourself an introvert or an extrovert?', true, 7);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (19, 'What is the last big goal you accomplished?', false, 7);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (20, 'What bad decision did you make that actually turned out to be a good decision?', false, 3);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (1, 'Have you ever seen a movie that you thought was better than the book?', true, 6);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (1, 'What is the quickest way for you to lose respect for someone?', true, 1);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (2, 'but you think in your mind it should be easy?', true, 1);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (2, 'What is your current philosophy about money?', false, 10);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (2, 'what would yours say?', false, 7);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (2, 'What is money to you?', true, 4);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (3, 'What is the last encounter you had with a random stranger?', false, 10);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (3, 'What was your most recent experience of going down the rabbit hole?', false, 3);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (3, 'What holiday do you think more people should celebrate?', true, 8);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (4, 'What''s something that you use regularly that you wish you didn''t have to?', true, 3);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (5, 'What is the quickest way for you to lose respect for someone?', true, 8);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (6, 'What food have you never tried?', true, 10);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (6, 'Why haven''t you done it yet?', false, 8);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (7, 'What holiday do you think more people should celebrate?', false, 7);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (2, 'At what age did you think you become an adult and when do you actually think you did?', false, 7);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (8, 'Do you have a favorite brand?', true, 4);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (8, 'What has been your 15 minutes of fame up to this point?', false, 6);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (8, 'What have you been thinking about lately that has kept you up at night?', true, 6);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (9, 'Have you ever seen a movie that you thought was better than the book?', true, 8);
insert into Questions (FormId, QuestionText, RequiresResponse, QuestionWeight) values (10, 'What challenge would you like to see your best friend take on?', false, 10);


-- MCQuestions
insert into MCQuestions (MCQuestionId, QuestionId) values (1, 1);
insert into MCQuestions (MCQuestionId, QuestionId) values (2, 2);
insert into MCQuestions (MCQuestionId, QuestionId) values (3, 3);
insert into MCQuestions (MCQuestionId, QuestionId) values (4, 4);
insert into MCQuestions (MCQuestionId, QuestionId) values (5, 5);
insert into MCQuestions (MCQuestionId, QuestionId) values (6, 6);
insert into MCQuestions (MCQuestionId, QuestionId) values (7, 7);
insert into MCQuestions (MCQuestionId, QuestionId) values (8, 8);
insert into MCQuestions (MCQuestionId, QuestionId) values (9, 9);
insert into MCQuestions (MCQuestionId, QuestionId) values (10, 10);


-- MCQuestionPossibilities
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (1, 1, '3', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (2, 1, '5', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (3, 1, '6', true);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (4, 1, '10', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (5, 2, 'Dark chocolate', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (6, 2, 'Peanut butter', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (7, 2, 'Canned tuna', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (8, 2, 'Honey', true);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (9, 3, 'Not to Be Reproduced', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (10, 3, 'Personal Values', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (11, 3, 'The Lovers', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (12, 3, 'The Lost Jockey', true);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (13, 4, 'Nick Lachey', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (14, 4, 'Justin Timberlake', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (15, 4, 'Shawn Stockman', true);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (16, 4, 'AJ McLean', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (17, 5, 'Eiffel Tower', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (18, 5, 'Statue of Liberty', true);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (19, 5, 'Great Wall of China', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (20, 5, 'Colosseum', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (21, 6, 'Nigini', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (22, 6, 'Crookshanks', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (23, 6, 'Aragog', true);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (24, 6, 'Mosag', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (25, 7, 'Brain', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (26, 7, 'Liver', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (27, 7, 'Skin', true);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (28, 7, 'Heart', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (29, 8, 'Kevin Durant', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (30, 8, 'JJ Reddick', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (31, 8, 'Lebron James', true);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (32, 8, 'Kyle Korver', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (33, 9, 'Poland', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (34, 9, 'Denmark', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (35, 9, 'Sweden', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (36, 9, 'All of the above', true);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (37, 10, 'Phoenix', true);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (38, 10, 'Miami', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (39, 10, 'San Francisco', false);
insert into MCQuestionPossibilities (MCQuestionPossibilityId, MCQuestionId, MCQuestionPossibilityText, MCQuestionCorrect) values (40, 10, 'Austin', false);


-- ShortAnswerQuestions
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (1, 11);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (2, 12);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (3, 13);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (4, 14);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (5, 15);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (6, 16);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (7, 17);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (8, 18);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (9, 19);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (10, 20);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (11, 21);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (12, 22);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (13, 23);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (14, 24);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (15, 25);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (16, 26);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (17, 27);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (18, 28);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (19, 29);
insert into ShortAnswerQuestions (ShortAnswerId, QuestionId) values (20, 30);


-- SliderQuestions
insert into SliderQuestions (SliderId, QuestionId) values (1, 31);
insert into SliderQuestions (SliderId, QuestionId) values (2, 32);
insert into SliderQuestions (SliderId, QuestionId) values (3, 33);
insert into SliderQuestions (SliderId, QuestionId) values (4, 34);
insert into SliderQuestions (SliderId, QuestionId) values (5, 35);
insert into SliderQuestions (SliderId, QuestionId) values (6, 36);
insert into SliderQuestions (SliderId, QuestionId) values (7, 37);


-- CheckboxQuestions
insert into CheckboxQuestions (CheckboxQuestionId, QuestionId) values (1, 38);
insert into CheckboxQuestions (CheckboxQuestionId, QuestionId) values (2, 39);
insert into CheckboxQuestions (CheckboxQuestionId, QuestionId) values (3, 40);


-- CheckboxQuestionPossibilities
insert into CheckboxQuestionPossibilities (CheckboxQuestionPosibilityId, CheckboxQuestionId, CheckboxQuestionPosibilityText, CheckboxQuestionCorrect) values (1, 1, 'nothing', true);
insert into CheckboxQuestionPossibilities (CheckboxQuestionPosibilityId, CheckboxQuestionId, CheckboxQuestionPosibilityText, CheckboxQuestionCorrect) values (2, 1, 'something', true);
insert into CheckboxQuestionPossibilities (CheckboxQuestionPosibilityId, CheckboxQuestionId, CheckboxQuestionPosibilityText, CheckboxQuestionCorrect) values (3, 2, 'yes', false);
insert into CheckboxQuestionPossibilities (CheckboxQuestionPosibilityId, CheckboxQuestionId, CheckboxQuestionPosibilityText, CheckboxQuestionCorrect) values (4, 2, 'no', true);
insert into CheckboxQuestionPossibilities (CheckboxQuestionPosibilityId, CheckboxQuestionId, CheckboxQuestionPosibilityText, CheckboxQuestionCorrect) values (5, 3, 'nothing', false);
insert into CheckboxQuestionPossibilities (CheckboxQuestionPosibilityId, CheckboxQuestionId, CheckboxQuestionPosibilityText, CheckboxQuestionCorrect) values (6, 3, 'something new', true);
insert into CheckboxQuestionPossibilities (CheckboxQuestionPosibilityId, CheckboxQuestionId, CheckboxQuestionPosibilityText, CheckboxQuestionCorrect) values (7, 3, 'more responsibilities', false);


-- FormsRespondents
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (1, 'rgeddes7', 3, 5);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (2, 'jcostalla', 3, 9);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (3, 'wmathonm', 4, 4);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (4, 'ftamblynt', 5, 10);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (5, 'rclaguel', 5, 6);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (6, 'rclaguel', 1, 7);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (7, 'gruse5', 5, 5);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (8, 'cshoemark0', 7, 7);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (9, 'lrizzello2', 2, 4);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (10, 'lgilhoolieb', 1, 4);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (11, 'dpinnegar1', 4, 6);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (12, 'gbirdwhistles', 7, 8);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (13, 'dpinnegar1', 5, 8);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (14, 'kashborn6', 6, 9);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (15, 'zrableyn', 4, 4);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (16, 'dstable9', 10, 10);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (17, 'fmicklewiczg', 4, 10);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (18, 'gruse5', 2, 8);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (19, 'jpinchinr', 8, 8);
insert into FormsRespondents (FormId, RespondentUsername, EarnedWeight, PossibleWeight) values (20, 'lgilhoolieb', 3, 10);


-- FormsRespondentsQuestions
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (1, 'bgabrielif', '6');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (2, 'blace3', 'Honey');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (3, 'cgladbeckq', 'The Lost Jockey');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (4, 'cshoemark0', 'Justin Timberlake');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (5, 'dpinnegar1', 'Eiffel Tower');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (11, 'dpinnegar1', 'Eiffel Tower');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (13, 'dpinnegar1', 'Eiffel Tower');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (6, 'dstable9', 'Aragog');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (7, 'esamwayesj', 'Liver');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (8, 'fdawidowitschi', 'Lebron James');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (9, 'fmicklewiczg', 'All of the above');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (10, 'ftamblynt', 'Miami');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (11, 'gbirdwhistles', 'Now I need to ponder my existence and ask myself if I''m truly real.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (12, 'gruse5', 'When motorists sped in and out of traffic all she could think of was those in need of a transplant.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (13, 'iwetheril4', 'The tortoise jumped into the lake with dreams of becoming a sea turtle.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (14, 'jcostalla', 'Wisdom is easily acquired when hiding under the bed with a saucepan on your head.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (15, 'jpinchinr', 'He never understood why what when and where left out who.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (16, 'kashborn6', 'It must be five o''clock somewhere.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (17, 'kkuhleh', 'If you spin around three times you''ll start to feel melancholy.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (18, 'ktidcombec', 'The doll spun around in circles in hopes of coming alive.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (19, 'lgilhoolieb', 'They say people remember important moments in their life well yet no one even remembers their own birth.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (20, 'lrizzello2', 'There have been days when I wished to be separated from my body but today wasn’t one of those days.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (21, 'lweondd', 'Karen believed all traffic laws should be obeyed by all except herself.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (22, 'mcosgrove8', 'Facing his greatest fear he ate his first marshmallow.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (23, 'pdummette', 'The busker hoped that the people passing by would throw money but they threw tomatoes instead so he exchanged his hat for a juicer.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (24, 'rclaguel', 'He had accidentally hacked into his company''s server.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (25, 'rgeddes7', 'Karen realized the only way she was getting into heaven was to cheat.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (26, 'sprattp', 'Malls are great places to shop; I can find everything I need under one roof.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (27, 'tfroggattk', 'The gloves protect my feet from excess work.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (28, 'totleyo', 'I know many children ask for a pony but I wanted a bicycle with rockets strapped to it.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (29, 'wmathonm', 'She did not cheat on the test for it was not the right thing to do.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (30, 'zrableyn', 'The father handed each child a roadmap at the beginning of the 2-day road trip and explained it was so they could find their way home.');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (31, 'cgladbeckq', '3');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (32, 'cgladbeckq', '5');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (33, 'cgladbeckq', '2');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (34, 'zrableyn', '1');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (35, 'zrableyn', '5');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (36, 'rclaguel', '7');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (37, 'rclaguel', '10');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (38, 'rclaguel', 'nothing');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (39, 'rclaguel', 'no');
insert into FormsRespondentsQuestions (QuestionId, RespondentUsername, Answer) values (40, 'lrizzello2', 'something new and more responsibilities');


-- AnalystsForms
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('adwyre', 1,'He colored deep space a soft yellow.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('blonghorne0', 2, 'The fish listened intently to what the frogs had to say.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('cchalcroft6', 3, 'When she didn’t like a guy who was trying to pick her up she started using sign language.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('ckippingh', 4, 'It was the scarcity that fueled his creativity.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('cmacknockerf', 5, 'The fact that there''s a stairway to heaven and a highway to hell explains life well.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('cwoolertong', 6, 'There aren''t enough towels in the world to stop the sewage flowing from his mouth.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('dchapleoj', 7, 'Mary plays the piano.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('fissacofi', 8, 'Everyone says they love nature until they realize how dangerous she can be.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('fjann3', 9, 'Toddlers feeding raccoons surprised even the seasoned park ranger.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('gjeffray8', 10, 'She lived on Monkey Jungle Road and that seemed to explain all of her strangeness.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('gpittem5', 11, 'The fog was so dense even a laser decided it wasn''t worth the effort.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('ibambrough1', 12, 'Her fragrance of choice was fresh garlic.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('jseabournea', 13, 'It''s always a good idea to seek shelter from the evil gaze of the sun.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('jsteffens2', 14, '100 years old is such a young age if you happen to be a bristlecone pine.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('kbanane9', 15, 'Love is not like pizza.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('lkeizmanb', 16, 'Joe discovered that traffic cones make excellent megaphones.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('lleynhamc', 17, 'Sarah ran from the serial killer holding a jug of milk.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('lnolletd', 18, 'The knives were out and she was sharpening hers.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('oquinion4', 19, 'While on the first date he accidentally hit his head on the beam.');
insert into AnalystsForms (AnalystUsername, FormId, Observations) values ('slinthead7', 20, 'His thought process was on so many levels that he gave himself a phobia of heights.');


ALTER TABLE Questions AUTO_INCREMENT=100;