import MySQLdb
from MySQLdb._exceptions import OperationalError

def db_login(user, passwd, server_addr, dbname):
    try:
        db = MySQLdb.connect(server_addr, user, passwd, dbname)
    except OperationalError:
        db = None

    return db

def db_close(db):
    if db is not None:
        db.close()

def db_showtable(db):
    cursor = db.cursor()
    cursor.execute("show tables")
    tabs = cursor.fetchall()
    res = list()

    for tab in tabs:
        cursor.execute("select count(*) from " + tab[0])
        row_cnt = cursor.fetchone()

        res.append((tab[0], row_cnt[0]))
    
    cursor.close()

    return res

# 增加客户
def db_insert_customer(db, cusID, cusname, cusphone, address, contact_phone, contact_name, contact_Email, relation):
    cursor = db.cursor()
    try:
        sql = "INSERT INTO customer VALUES('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', null, null)" %\
                (cusID, cusname, cusphone, address, contact_phone, contact_name, contact_Email, relation)
        cursor.execute(sql)
        db.commit()
    except:
        db.rollback()
    cursor.close()
# 删除客户
def db_delete_customer(db, cusID):
    cursor = db.cursor()
    try:
        sql = "DELETE FROM customer WHERE cusID = '%s'" % (cusID)
        cursor.execute(sql)
        db.commit()
    except:
        db.rollback()
    cursor.close()
# 修改客户
def db_update_customer(db, cusID, cusname, cusphone, address, contact_phone, contact_name, contact_Email, relation):
    cursor = db.cursor()
    try:
        sql = "UPDATE customer SET cusname = '%s', cusphone = '%s', address = '%s', contact_phone = '%s', contact_name = '%s', contact_Email='%s', relation='%s' WHERE cusID = '%s'"\
            % (cusname, cusphone, address, contact_phone, contact_name, contact_Email, relation, cusID)
        cursor.execute(sql)
        db.commit()
    except:
        db.rollback()
    cursor.close()

# 查询客户

def db_search_customer(db):
    cursor = db.cursor()
    cursor.execute("select * from customer")
    tabs = cursor.fetchall()
    res = list()
    
    for tab in tabs:
        cusID = tab[0]
        cusname = tab[1]
        cusphone = tab[2]
        address = tab[3]
        contact_phone = tab[4]
        contact_name = tab[5]
        contact_Email = tab[6]
        relation = tab[7]
        res.append((cusID, cusname, cusphone, address, contact_phone, contact_name, contact_Email, relation))

    cursor.close()
    return res

# 查询单个客户
def db_search_single_customer(db, cusID):
    cursor = db.cursor()
    sql = "SELECT * FROM customer WHERE cusID = '%s'" %(cusID)
    cursor.execute(sql)
    tabs = cursor.fetchall()
    res = list()
    
    for tab in tabs:
        cusID = tab[0]
        cusname = tab[1]
        cusphone = tab[2]
        address = tab[3]
        contact_phone = tab[4]
        contact_name = tab[5]
        contact_Email = tab[6]
        relation = tab[7]
        res.append((cusID, cusname, cusphone, address, contact_phone, contact_name, contact_Email, relation))

    cursor.close()
    return res

# 开储蓄账户
def db_open_saving_account(db, cusID, accountID, money, settime, interestrate, saveType):
    cursor = db.cursor()
    try:
        sql = "INSERT INTO accounts VALUES('%s', %s, '%s', 'saving')" %(accountID, money, settime)
        cursor.execute(sql)
        sql = "INSERT INTO saveacc VALUES('%s', %s, '%s')" %(accountID, interestrate, saveType)
        cursor.execute(sql)
        # 将创建时间作为初始的visit
        sql = "INSERT INTO cusforacc VALUES('%s', '888', '%s', '%s', 'saving')" %(accountID, cusID, settime)
        cursor.execute(sql)
        db.commit()
    except:
        db.rollback()
    cursor.close()

# 开支票账户
def db_open_checking_account(db, cusID, accountID, money, settime, overdraft):
    cursor = db.cursor()
    try:
        sql = "INSERT INTO accounts VALUES('%s', %s, '%s', 'checking')" %(accountID, money, settime)
        cursor.execute(sql)
        sql = "INSERT INTO checkacc VALUES('%s', %s )" %(accountID, overdraft)
        cursor.execute(sql)
        sql = "INSERT INTO cusforacc VALUES('%s', '888', '%s', '%s', 'checking')" %(accountID, cusID, settime)
        cursor.execute(sql)
        db.commit()
    except:
        db.rollback()
    cursor.close()

# 销毁账户
def db_delete_account(db, accountID):
    cursor = db.cursor()
    try:
        sql = "DELETE FROM saveacc WHERE accountID = '%s'" %(accountID)
        cursor.execute(sql)
        sql = "DELETE FROM checkacc WHERE accountID = '%s'" %(accountID)
        cursor.execute(sql)
        sql = "DELETE FROM cusforacc WHERE accountID = '%s'" %(accountID)
        cursor.execute(sql)
        sql = "DELETE FROM accounts WHERE accountID = '%s'" %(accountID)
        cursor.execute(sql)
        db.commit()
    except:
        db.rollback()
    cursor.close()

# 修改账户
def db_update_account(db, accountID, money, interestrate, savetype, overdraft):
    cursor = db.cursor()
    try:
        cursor.execute("SELECT accountType from accounts WHERE accountID = '%s'" %(accountID))
        Type = cursor.fetchall()
        for tab in Type:
            if(tab[0] == 'saving'):
                sql = "UPDATE saveacc SET interestrate = %s, savetype=%s WHERE accountID = '%s'" %(interestrate, savetype, accountID)
                cursor.execute(sql)
            elif(tab[0] == 'checking'):
                sql = "UPDATE checkacc SET overdraft = %s WHERE accountID = '%s'" %(overdraft, accountID)
                cursor.execute(sql)
        sql = "UPDATE accounts SET money = %s WHERE accountID = '%s'" %(money, accountID)
        cursor.execute(sql)
        db.commit()
    except:
        db.rollback()
    cursor.close()


# 查询所有账户
def db_search_account(db):
    cursor = db.cursor()
    cursor.execute("select accounts.accountID, cusforacc.cusID, accounts.accountType, cusforacc.visit from accounts, cusforacc WHERE accounts.accountID = cusforacc.accountID")
    tabs = cursor.fetchall()
    res = list()
    for tab in tabs:
        accountID = tab[0]
        cusID = tab[1]
        accounttype = tab[2]
        visit = tab[3]
        res.append((accountID, cusID, accounttype, visit))
    cursor.close()
    return res

# 查询单个账户，并更新访问时间
def db_search_single_account(db, accountID):
    cursor = db.cursor()
    try:
        sql = "UPDATE cusforacc SET visit = now() WHERE accountID = '%s' " % (accountID)
        cursor.execute(sql)
        db.commit()
    except:
        db.rollback()
    
    sql = "SELECT accounts.accountID, cusforacc.cusID, accounts.accountType, cusforacc.visit FROM accounts, cusforacc WHERE accounts.accountID = cusforacc.accountID and cusforacc.accountID = '%s'" % (accountID)
    cursor.execute(sql)
    tabs = cursor.fetchall()
    res = list()
    for tab in tabs:
        accountID = tab[0]
        cusID = tab[1]
        accounttype = tab[2]
        visit = tab[3]
        res.append((accountID, cusID, accounttype, visit))
    cursor.close()
    return res

# 增加贷款信息
def db_create_loan(db, loanID, cusID, money):
    cursor = db.cursor()
    try:
        sql = "INSERT INTO loan VALUES('%s', %s, '888', '0')" %(loanID, money)
        cursor.execute(sql)
        sql = "INSERT INTO cusforloan VALUES('%s', '%s')" %(loanID, cusID)
        cursor.execute(sql)
        db.commit()
    except:
        db.rollback()
    cursor.close()

# 删除贷款信息
def db_delete_loan(db, loanID):
    cursor = db.cursor()
    try:
        sql = "DELETE FROM cusforloan WHERE loanID = '%s'" %(loanID)
        cursor.execute(sql)
        sql = "DELETE FROM loan WHERE loanID = '%s'" %(loanID)
        cursor.execute(sql)
        db.commit()
    except:
        db.rollback()
    cursor.close()

# 查询贷款信息
def db_search_loan(db):
    cursor = db.cursor()
    sql = "SELECT cusforloan.loanID, cusforloan.cusID, loan.money, loan.state FROM loan, cusforloan WHERE loan.loanID = cusforloan.loanID"
    cursor.execute(sql)
    tabs = cursor.fetchall()
    res = list()
    for tab in tabs:
        loanID = tab[0]
        cusID = tab[1]
        money= tab[2]
        state = tab[3]
        res.append((loanID, cusID, money, state))
    cursor.close()
    return res

# 查询单笔贷款
def db_search_single_loan(db, loanID):
    cursor = db.cursor()
    sql = "SELECT cusforloan.loanID, cusforloan.cusID, loan.money, loan.state FROM loan, cusforloan WHERE loan.loanID = cusforloan.loanID and  loan.loanID = '%s'" % (loanID)
    cursor.execute(sql)
    tabs = cursor.fetchall()
    res = list()
    for tab in tabs:
        loanID = tab[0]
        cusID = tab[1]
        money= tab[2]
        state = tab[3]
        res.append((loanID, cusID, money, state))
    cursor.close()
    return res

# 发放贷款
def db_pay_loan(db, loanID, cusID, money, paytime):
    cursor = db.cursor()
    try:
        sql = "INSERT INTO payinfo VALUES('%s', '%s', %s, '%s')" %(loanID, cusID, money, paytime)
        cursor.execute(sql)
        db.commit()
    except:
        db.rollback()
    cursor.close()

def db_summary_classify_saving(db):
    cursor = db.cursor()
    # sql = "SELECT cusforacc.bank, SUM(accounts.money), COUNT(*) \
    #         FROM cusforacc, accounts \
    #         WHERE cusforacc.accountID = accounts.accountID and accounts.accounttype = 'saving'\
    #         GROUP BY cusforacc.bank \
    #         ORDER BY cusforacc.bank"
    sql = "SELECT * FROM savestat"
    cursor.execute(sql)
    tabs = cursor.fetchall()
    res = list()
    for tab in tabs:
        bank = tab[0]
        sum_money = tab[1]
        sum_account= tab[2]
        res.append((bank, sum_money, sum_account))
    cursor.close()
    return res


def db_summary_classify_loan(db):
    cursor = db.cursor()
    # sql = "SELECT bank, SUM(payinfo.money), COUNT(payinfo.cusID)\
    #     FROM loan, payinfo WHERE loan.loanID = payinfo.loanID GROUP BY bank"
    sql = "SELECT * FROM loanstat"
    cursor.execute(sql)
    tabs = cursor.fetchall()
    res = list()
    for tab in tabs:
        bank = tab[0]
        sum_money = tab[1]
        sum_pay= tab[2]
        res.append((bank, sum_money, sum_pay))
    cursor.close()
    return res

def db_summary_month(db):
    cursor = db.cursor()
    sql = "SELECT DATE_FORMAT(visit,'%Y%m') months, SUM(money), COUNT(accounts.accountID) \
            FROM cusforacc, accounts\
            WHERE cusforacc.accountID = accounts.accountID\
            GROUP BY months"
    cursor.execute(sql)
    tabs = cursor.fetchall()
    res = list()
    for tab in tabs:
        month = tab[0]
        sum_money = tab[1]
        sum_account= tab[2]
        res.append((month, sum_money, sum_account))
    cursor.close()
    return res

def db_summary_quarter(db):
    cursor = db.cursor()
    sql = "SELECT CONCAT(YEAR(visit),'_',quarter(visit)) quarters, SUM(money), COUNT(accounts.accountID) \
            FROM cusforacc, accounts \
            WHERE cusforacc.accountID = accounts.accountID \
            GROUP BY quarters"
    cursor.execute(sql)
    tabs = cursor.fetchall()
    res = list()
    for tab in tabs:
        quarter = tab[0]
        sum_money = tab[1]
        sum_account= tab[2]
        res.append((quarter, sum_money, sum_account))
    cursor.close()
    return res

def db_summary_year(db):
    cursor = db.cursor()
    sql = "SELECT DATE_FORMAT(visit,'%Y') years, SUM(money), COUNT(accounts.accountID) \
            FROM cusforacc, accounts \
            WHERE cusforacc.accountID = accounts.accountID \
            GROUP BY years"
    cursor.execute(sql)
    tabs = cursor.fetchall()
    res = list()
    for tab in tabs:
        year = tab[0]
        sum_money = tab[1]
        sum_account= tab[2]
        res.append((year, sum_money, sum_account))
    cursor.close()
    return res

if __name__ == "__main__":
    db = db_login("root", "1234", "127.0.0.1", "test")

    tabs = db_showtable(db)
    
    db_close(db)