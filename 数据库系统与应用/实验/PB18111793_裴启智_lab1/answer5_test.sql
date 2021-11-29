#原本b1 status = 1，b10 status = 0
update book set status = 0 where ID = 'b1';
update book set status = 1 where ID = 'b10';

update book set status = 1 where ID = 'b1';
update book set status = 0 where ID = 'b10';
