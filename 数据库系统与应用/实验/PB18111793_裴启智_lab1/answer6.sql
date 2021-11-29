Delimiter //
create trigger update_borrow_from after insert on borrow for each row
begin
	if new.Return_Date is null then
		update book set book.status = 1 where book.ID = new.book_ID;
    end if;
end // 

create trigger update_return_to after update on borrow for each row
begin
	if (old.Return_Date is null) and (new.Return_Date is not null) then
		update book set book.status = 0 where book.ID = new.book_ID;
    end if;
end // 