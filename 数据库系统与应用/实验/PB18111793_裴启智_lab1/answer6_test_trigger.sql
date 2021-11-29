insert into Borrow value('b5', 'r6', '2021-04-10', NULL);

update Borrow set Return_Date = '2021-04-11' where book_ID = 'b5' and Reader_ID = 'r6';