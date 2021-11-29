Delimiter //
#drop function if exists check_status;
#检查每本图书的status是否正确，并返回status不正确的图书个数
create function check_status()
returns int
reads sql data
begin
	declare state int default 0;
    declare book_id_temp char(8);
    declare status_temp int default 0;
    declare sum int default 0;
    declare num int default 0;
    declare ct cursor for 
    (select ID, status from book);
    declare continue handler for not found set state = 1;
    
    select count(*) from book into sum; 
    open ct;
    repeat 
		fetch ct into book_id_temp, status_temp;
        if state = 0 then
			select count(*) 
            from borrow 
			where borrow.book_ID = book_id_temp 
			and borrow.Return_Date is null
			into num;
			if status_temp = num then 
				set sum = sum - 1;
			end if;
		end if;
		until state = 1
	end repeat;
	close ct;
    
	return sum;
end //