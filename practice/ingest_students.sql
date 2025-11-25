CREATE TABLE IF NOT EXISTS students_secure (
    student_id INTEGER NOT NULL UNIQUE,
    email VARCHAR NOT NULL UNIQUE,
    age INTEGER CHECK (
        age >= 6
        AND age < 100
    ),
    grade INTEGER CHECK (
        grade >= 1
        AND grade <= 5
    ),
    payment_status VARCHAR DEFAULT 'Pending'
);

INSERT INTO
    students_secure (student_id, email, age, grade)
VALUES
    (201911250044, 'hmm@gmail.com', 7, 5);