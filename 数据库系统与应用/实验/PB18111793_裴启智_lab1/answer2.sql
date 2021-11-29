insert into Book value(null, '体系结构', 'pppp', 60.1, 1); #实体完整性
insert into Book value('b1', '数据库系统实现', 'Ullman', 59.0, 1);


insert into borrow value('b100', 'r3', '2021-2-22', null);#参照完整性

alter table borrow add constraint CK1 check(Borrow_Date is not null);#用户自定义完整性
insert into borrow value('b20', 'r1', null, null);

alter table book add constraint CK check(status >= 0);
insert into book value('b100', '体系结构', 'pppp', 60.1, -2);