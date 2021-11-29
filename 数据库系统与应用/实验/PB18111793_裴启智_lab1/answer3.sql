select id, address from reader where name = 'Rose';

select book.name, borrow_date
from book, reader, borrow
where reader.name = 'Rose' 
and reader.ID = borrow.Reader_ID 
and book.ID = borrow.book_ID;

select name 
from reader
where ID not in(
select Reader_ID 
from Borrow
);

select name, price
from book
where author = 'Ullman';

select book.name, book.ID
from book, borrow, reader
where reader.name = '李林'
and reader.ID = borrow.Reader_ID
and book.ID = borrow.book_ID
and borrow.Return_Date is null;

select distinct name
from reader, borrow
where reader.ID = borrow.Reader_ID
and reader.ID in(
select Reader_ID
from borrow
group by Reader_ID
having count(*) > 3
);

select name, ID
from reader 
where ID not in
(select distinct reader.ID
from reader, borrow
where reader.ID = borrow.Reader_ID
and borrow.book_ID in(
select book_ID
from reader, borrow
where reader.ID = borrow.Reader_ID
and reader.name = '李林')
);





select name, ID
from book
where name like '%Oracle%';

create view reader_borrow (Reader_ID, Reader_name, book_ID, book_Name, Borrow_Date)
As select reader.ID, reader.name, book.ID, book.name, borrow.Borrow_Date 
from reader, borrow, book
where reader.ID = borrow.Reader_ID
and book.ID = borrow.book_ID;

select Reader_ID, count(*)
from reader_borrow
where datediff(NOW(), reader_borrow.Borrow_Date) <= 365
group by Reader_ID;


