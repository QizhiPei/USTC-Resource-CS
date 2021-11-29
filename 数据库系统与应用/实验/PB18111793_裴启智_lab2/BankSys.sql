/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2021/5/18 20:13:47                           */
/*==============================================================*/


drop table if exists Account;

drop table if exists CheckingAccount;

drop table if exists Customer;

drop table if exists Department;

drop table if exists DepositAccount;

drop table if exists Employee;

drop table if exists Lend;

drop table if exists Linkman;

drop table if exists Loans;

drop table if exists OpenCheckingAccount;

drop table if exists OpenDepositAccount;

drop table if exists Payment;

drop table if exists Responsible;

drop table if exists SubBank;

/*==============================================================*/
/* Table: Account                                               */
/*==============================================================*/
create table Account
(
   AccountID            char(16) not null,
   BankName             char(32) not null,
   AccountBalance       float,
   AccountOpenDate      date,
   primary key (AccountID)
);

/*==============================================================*/
/* Table: CheckingAccount                                       */
/*==============================================================*/
create table CheckingAccount
(
   AccountID            char(16) not null,
   BankName             char(32),
   AccountBalance       float,
   AccountOpenDate      date,
   Overdraft            float,
   primary key (AccountID)
);

/*==============================================================*/
/* Table: Customer                                              */
/*==============================================================*/
create table Customer
(
   CustomerID           char(18) not null,
   Lin_CustomerID       char(18),
   LinkmanPhone         decimal(11),
   CustomerName         char(32),
   CustomePhone         decimal(11),
   CustomeAddress       char(128),
   primary key (CustomerID)
);

/*==============================================================*/
/* Table: Department                                            */
/*==============================================================*/
create table Department
(
   DepartmentID         char(16) not null,
   BankName             char(32) not null,
   DepartmentName       char(32),
   DepartmentType       char(16),
   DepartmentLeaderID   char(18),
   primary key (DepartmentID)
);

/*==============================================================*/
/* Table: DepositAccount                                        */
/*==============================================================*/
create table DepositAccount
(
   AccountID            char(16) not null,
   BankName             char(32),
   AccountBalance       float,
   AccountOpenDate      date,
   Interest             float,
   CurrencyType         char(32),
   primary key (AccountID)
);

/*==============================================================*/
/* Table: Employee                                              */
/*==============================================================*/
create table Employee
(
   EmployeeID           char(18) not null,
   DepartmentID         char(16) not null,
   EmployeeName         char(32),
   EmployeePhone        decimal(11),
   EmployeeAddress      char(128),
   EmployeeEnrollmentDate date,
   primary key (EmployeeID)
);

/*==============================================================*/
/* Table: Lend                                                  */
/*==============================================================*/
create table Lend
(
   CustomerID           char(18) not null,
   LoansID              char(32) not null,
   primary key (CustomerID, LoansID)
);

/*==============================================================*/
/* Table: Linkman                                               */
/*==============================================================*/
create table Linkman
(
   CustomerID           char(18) not null,
   LinkmanPhone         decimal(11) not null,
   LinkmanName          char(32),
   LinkmanEmail         char(32),
   Relationship         char(32),
   primary key (CustomerID, LinkmanPhone)
);

/*==============================================================*/
/* Table: Loans                                                 */
/*==============================================================*/
create table Loans
(
   LoansID              char(32) not null,
   BankName             char(32) not null,
   LoansMoney           float,
   LoansPaymentTimes    decimal,
   primary key (LoansID)
);

/*==============================================================*/
/* Table: OpenCheckingAccount                                   */
/*==============================================================*/
create table OpenCheckingAccount
(
   BankName             char(32) not null,
   CustomerID           char(18) not null,
   AccountID            char(16),
   LastVisit            date,
   primary key (BankName, CustomerID)
);

/*==============================================================*/
/* Table: OpenDepositAccount                                    */
/*==============================================================*/
create table OpenDepositAccount
(
   CustomerID           char(18) not null,
   BankName             char(32) not null,
   AccountID            char(16),
   LastVisit            date,
   primary key (CustomerID, BankName)
);

/*==============================================================*/
/* Table: Payment                                               */
/*==============================================================*/
create table Payment
(
   LoansID              char(32) not null,
   PaymentNo            decimal not null,
   PayDate              date,
   PayMoney             float,
   primary key (LoansID, PaymentNo)
);

/*==============================================================*/
/* Table: Responsible                                           */
/*==============================================================*/
create table Responsible
(
   CustomerID           char(18) not null,
   EmployeeID           char(18) not null,
   ServiceType          char(32) not null,
   primary key (CustomerID, EmployeeID)
);

/*==============================================================*/
/* Table: SubBank                                               */
/*==============================================================*/
create table SubBank
(
   BankName             char(32) not null,
   BankCity             char(32),
   BankProperty         float,
   primary key (BankName)
);

alter table Account add constraint FK_Establish foreign key (BankName)
      references SubBank (BankName) on delete restrict on update restrict;

alter table CheckingAccount add constraint FK_Checking_Account foreign key (AccountID)
      references Account (AccountID) on delete restrict on update restrict;

alter table Customer add constraint FK_Assign foreign key (Lin_CustomerID, LinkmanPhone)
      references Linkman (CustomerID, LinkmanPhone) on delete restrict on update restrict;

alter table Department add constraint FK_SubBank_Department foreign key (BankName)
      references SubBank (BankName) on delete restrict on update restrict;

alter table DepositAccount add constraint FK_Deposit_Account foreign key (AccountID)
      references Account (AccountID) on delete restrict on update restrict;

alter table Employee add constraint FK_Belong foreign key (DepartmentID)
      references Department (DepartmentID) on delete restrict on update restrict;

alter table Lend add constraint FK_Lend foreign key (CustomerID)
      references Customer (CustomerID) on delete restrict on update restrict;

alter table Lend add constraint FK_Lend2 foreign key (LoansID)
      references Loans (LoansID) on delete restrict on update restrict;

alter table Linkman add constraint FK_Assign2 foreign key (CustomerID)
      references Customer (CustomerID) on delete restrict on update restrict;

alter table Loans add constraint FK_Distribute foreign key (BankName)
      references SubBank (BankName) on delete restrict on update restrict;

alter table OpenCheckingAccount add constraint FK_OpenCheckingAccount foreign key (BankName)
      references SubBank (BankName) on delete restrict on update restrict;

alter table OpenCheckingAccount add constraint FK_OpenCheckingAccount2 foreign key (CustomerID)
      references Customer (CustomerID) on delete restrict on update restrict;

alter table OpenDepositAccount add constraint FK_OpenDepositAccount foreign key (CustomerID)
      references Customer (CustomerID) on delete restrict on update restrict;

alter table OpenDepositAccount add constraint FK_OpenDepositAccount2 foreign key (BankName)
      references SubBank (BankName) on delete restrict on update restrict;

alter table Payment add constraint FK_Loans_Payment foreign key (LoansID)
      references Loans (LoansID) on delete restrict on update restrict;

alter table Responsible add constraint FK_Responsible foreign key (CustomerID)
      references Customer (CustomerID) on delete restrict on update restrict;

alter table Responsible add constraint FK_Responsible2 foreign key (EmployeeID)
      references Employee (EmployeeID) on delete restrict on update restrict;

