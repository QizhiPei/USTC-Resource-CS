#实现对Book表ID的修改
Delimiter //
create procedure update_id(in old_id char(8), in new_id char(8), out state int)
begin
	declare s int default 0;
    declare temp int;
    declare continue handler for sqlexception set s = 1;
	start transaction;

	alter table borrow drop constraint FK_Borrow_book_ID;
    select count(*) from book where ID = old_id into temp;
    if temp = 0 then #在book表中找不到要修改的id
		set s = 2;
	end if;
    
    update book set ID = new_id where ID = old_id;
    update borrow set book_ID = new_id where book_ID = old_id;
    
    alter table borrow add constraint FK_Borrow_book_ID FOREIGN KEY(book_ID) REFERENCES Book(ID);
    if s = 0 then
		set state = 0;
        commit;
	else
		set state = -1000;
        rollback;
	end if;
end //