CREATE TABLE Book(
  ID CHAR(8) PRIMARY KEY,
  name VARCHAR(40) NOT NULL,
  author VARCHAR (10),
  price FLOAT,
  status INT DEFAULT 0
);

CREATE TABLE Reader(
  ID CHAR (8) PRIMARY KEY,
  name VARCHAR (10),
  age INT,
  address VARCHAR (20)
);

CREATE TABLE Borrow(
  book_ID CHAR (8),
  Reader_ID CHAR (8),
  Borrow_Date DATE,
  Return_Date DATE,
  CONSTRAINT PK_Borrow PRIMARY KEY(book_ID, Reader_ID),
  CONSTRAINT FK_Borrow_book_ID FOREIGN KEY(book_ID) REFERENCES Book(ID),
  CONSTRAINT FK_Borrow_Reader_ID FOREIGN KEY(Reader_ID) REFERENCES Reader(ID)
);