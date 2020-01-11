--Vse sovpadeniya sluchayni i ne nosyat smislovuyu nagrusku

INSERT INTO cathedral
VALUES 
(1, 'RA-1', 'Some interesting cathedra with name RA-1'),
(2, 'RO-2', 'Some interesting cathedra with name RO-2'),
(3, 'RA-2', 'Some interesting cathedra with name RA-2'),
(4, 'LI-1', 'Some interesting cathedra with name LI-1'),
(5, 'IY-L', 'Some interesting cathedra with name IY-L'),
(6, 'FDF-4', 'Some interesting cathedra with name FDF-4'),
(7, 'LALALA', 'Some interesting cathedra with name LALALA'),
(8, 'RO-5', 'Some interesting cathedra with name RO-5'),
(9, 'MI-R', 'Some interesting cathedra with name MI-R'),
(10, 'Some Joke', 'Some interesting cathedra with name SOME JOKE'),
(11, 'RA-7', 'Some interesting cathedra with name RA-7');

INSERT INTO teachers
VALUES
(1, 'Andreev Vasiliy Stepanovich', 'Magistr', 'Engineer', 1),
(2, 'Baranov Igor Igorevich', 'Docent', 'Teacher', 2),
(3, 'Avakin Stepan Vasilyevich', 'Burbun', 'Engineer', 3),
(4, 'Putin Vladimir Wolfovich', 'Magistr', 'President', 4),
(5, 'Golovnev Nikolay Vasilyevich', 'Student', 'Programmer', 5),
(6, 'Djeyms Pont', 'Docent', 'Programmer', 6),
(7, 'Bakin Ilya Petrovich', 'Student', 'Programmer', 7),
(8, 'Lenin Vladimir Ilyich', 'Aspirant', 'President', 8),
(9, 'Batman Batman Batman', 'Aspirant', 'Superhero', 9),
(10, 'Burunduk', 'Magistr', 'Burunduk', 10);

INSERT INTO subjects
VALUES 
(1, 'Mathematics', 72, 3, 23),
(2, 'Physics', 36, 2, 20),
(3, 'Programming Databases', 72, 5, 27),
(4, 'Informatics and IKT', 36, 1, 25),
(5, 'History', 36, 2, 40),
(6, 'Economics', 18, 7, 40),
(7, 'Communism for Stupid', 18, 8, 50),
(8, 'Assembler', 144, 4, 60),
(9, 'Computer Graphics', 144, 4, 60);

INSERT INTO teaching_subjects
VALUES 
(1, 1),
(1, 3),
(2, 1), 
(3, 9),
(4, 2), 
(5, 3), 
(6, 4), 
(7, 5), 
(8, 6), 
(9, 7),
(10, 2),
(10, 8);
