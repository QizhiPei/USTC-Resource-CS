import functools

from flask import Flask, session, g
from flask import redirect
from flask import request, make_response
from flask import render_template
from flask import url_for

from db import *

# 生成一个app
app = Flask(__name__, instance_relative_config=True)
app.secret_key = 'lab3'

# 对app执行请求页面地址到函数的绑定
@app.route("/", methods=["GET", "POST"])
@app.route("/login", methods=["GET", "POST"])
def login():
    """Log in a registered user by adding the user id to the session."""
    if request.method == "POST":
        # 客户端在login页面发起的POST请求
        username = request.form["username"]
        password = request.form["password"]
        ipaddr   = request.form["ipaddr"]
        database = request.form["database"]

        db = db_login(username, password, ipaddr, database)

        # 登录失败
        if db == None:
            return render_template("login_fail.html")
        else:
        # 登录成功
            session['username'] = username
            session['password'] = password
            session['ipaddr'] = ipaddr
            session['database'] = database

            return redirect(url_for('menu'))
    else :
        # 客户端GET 请求login页面时
        return render_template("login.html")


@app.route("/menu", methods=["GET", "POST"])
def menu():
    if request.method == "POST":
        if 'customer_management' in request.form:
            return redirect(url_for("customer_menu"))
        elif 'account_management' in request.form:
            return redirect(url_for("account_menu"))
        elif 'loan_management' in request.form:
            return redirect(url_for("loan_menu"))
        elif 'business_statistics' in request.form:
            return redirect(url_for("statistics_menu"))
    else:
        return render_template("menu.html")

@app.route("/customer/customer_menu", methods=["GET", "POST"])
def customer_menu():
    if request.method == "POST":
        if 'insert' in request.form:
            return redirect(url_for("insert_customer"))
        elif 'delete' in request.form:
            return redirect(url_for("delete_customer"))
        elif 'update' in request.form:
            return redirect(url_for("update_customer"))
        elif 'search' in request.form:
            return redirect(url_for("search_customer"))
        elif 'search_single' in request.form:
            return redirect(url_for("search_input_customer"))
        elif 'back' in request.form:
            return redirect(url_for("menu"))
    else:
        return render_template("customer/menu.html")

@app.route("/customer/insert", methods=["GET", "POST"])
def insert_customer():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        cusID = request.form["cusID"]
        cusname = request.form["cusname"]
        cusphone = request.form["cusphone"]
        address = request.form["address"]
        contact_phone = request.form["contact_phone"]
        contact_name = request.form["contact_name"]
        contact_Email = request.form["contact_Email"]
        relation = request.form["relation"]
        if "'" in cusname:
            db_close(db)
            return redirect(url_for('customer_menu'))
        db_insert_customer(db, cusID, cusname, cusphone, address, contact_phone, contact_name, contact_Email, relation)
        db_close(db)
        return redirect(url_for('customer_menu'))
    else:
        return render_template("customer/insert.html")


@app.route("/customer/delete", methods=["GET", "POST"])
def delete_customer():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                    session['ipaddr'], session['database'])
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        cusID = request.form["cusID"]
        db_delete_customer(db, cusID)
        db_close(db)
        return redirect(url_for('customer_menu'))
    else:
        return render_template("customer/delete.html")

@app.route("/customer/update", methods=["GET", "POST"])
def update_customer():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        cusID = request.form["cusID"]
        cusname = request.form["cusname"]
        cusphone = request.form["cusphone"]
        address = request.form["address"]
        contact_phone = request.form["contact_phone"]
        contact_name = request.form["contact_name"]
        contact_Email = request.form["contact_Email"]
        relation = request.form["relation"]
        db_update_customer(db, cusID, cusname, cusphone, address, contact_phone, contact_name, contact_Email, relation)
        db_close(db)
        return redirect(url_for('customer_menu'))
    else:
        return render_template("customer/update.html")

@app.route("/customer/search", methods=["GET", "POST"])
def search_customer():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
        tabs = db_search_customer(db)
        db_close(db)
    else:
        return redirect(url_for('login'))
    
    if request.method == "POST":
        if 'back' in request.form:
            return redirect(url_for('customer_menu'))

    else:
        return render_template("customer/search.html", rows = tabs, tablename='Customer')

@app.route("/customer/search_input", methods=["GET", "POST"])
def search_input_customer():
    if 'username' in session:
            db = db_login(session['username'], session['password'], 
                    session['ipaddr'], session['database'])
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        if 'back' in request.form:
            return redirect(url_for('customer_menu'))
        cusID = request.form["cusID"]
        tabs = db_search_single_customer(db, cusID)
        db_close(db)
        return render_template("customer/search_single.html", rows = tabs)
    else:
        return render_template("customer/search_input.html")

@app.route("/account/menu", methods=["GET", "POST"])
def account_menu():
    if request.method == "POST":
        if 'insert1' in request.form:
            return redirect(url_for('open_saving_account'))
        elif 'insert2' in request.form:
            return redirect(url_for('open_checking_account'))
        elif 'delete' in request.form:
            return redirect(url_for('delete_account'))
        elif 'update' in request.form:
            return redirect(url_for('update_account'))
        elif 'search' in request.form:
            return redirect(url_for('search_account'))
        elif 'search_single' in request.form:
            return redirect(url_for("search_input_account"))
        elif 'back' in request.form:
            return redirect(url_for('menu'))
    else:
        return render_template("account/menu.html")

@app.route("/account/saving_account", methods=["GET", "POST"])
def open_saving_account():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        cusID = request.form["cusID"]
        accountID = request.form["accountID"]
        money = request.form["money"]
        settime = request.form["settime"]
        interestrate = request.form["interestrate"]
        saveType = request.form["saveType"]
        db_open_saving_account(db, cusID, accountID, money, settime, interestrate, saveType)
        db_close(db)
        return redirect(url_for('account_menu'))
    else:
        return render_template("account/saving_account.html")

@app.route("/account/checking_account", methods=["GET", "POST"])
def open_checking_account():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        cusID = request.form["cusID"]
        accountID = request.form["accountID"]
        money = request.form["money"]
        settime = request.form["settime"]
        overdraft = request.form["overdraft"]
        db_open_checking_account(db, cusID, accountID, money, settime, overdraft)
        db_close(db)
        return redirect(url_for('account_menu'))
    else:
        return render_template("account/checking_account.html")

@app.route("/account/delete", methods=["GET", "POST"])
def delete_account():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        accountID = request.form["accountID"]
        db_delete_account(db, accountID)
        db_close(db)
        return redirect(url_for('account_menu'))
    else:
        return render_template("account/delete.html", tablename='Account')

@app.route("/account/update", methods=["GET", "POST"])
def update_account():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        accountID = request.form["accountID"]
        money = request.form["money"]
        interestrate = request.form["interestrate"]
        savetype = request.form["savetype"]
        overdraft = request.form["overdraft"]
        db_update_account(db, accountID, money, interestrate, savetype, overdraft)
        db_close(db)
        return redirect(url_for('account_menu'))
    else:
        return render_template("account/update.html")

@app.route("/account/search", methods=["GET", "POST"])
def search_account():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
        tabs = db_search_account(db)
        db_close(db)
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        if 'back' in request.form:
            return redirect(url_for('account_menu'))
    else:
        return render_template("account/search.html", rows=tabs, tablename='Account')
        
@app.route("/account/search_input", methods=["GET", "POST"])
def search_input_account():
    if 'username' in session:
            db = db_login(session['username'], session['password'], 
                    session['ipaddr'], session['database'])
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        if 'back' in request.form:
            return redirect(url_for('account_menu'))
        accountID = request.form["accountID"]
        tabs = db_search_single_account(db, accountID)
        db_close(db)
        return render_template("account/search_single.html", rows = tabs)
    else:
        return render_template("account/search_input.html")

@app.route("/loan/menu", methods=["GET", "POST"])
def loan_menu():
    if request.method == "POST":
        if 'create' in request.form:
            return redirect(url_for('create_loan'))
        elif 'delete' in request.form:
            return redirect(url_for('delete_loan'))
        elif 'search' in request.form:
            return redirect(url_for('search_loan'))
        elif 'search_single' in request.form:
            return redirect(url_for("search_input_loan"))
        elif 'pay' in request.form:
            return redirect(url_for('pay_loan'))
        elif 'back' in request.form:
            return redirect(url_for('menu'))
    else:
        return render_template("loan/menu.html")

@app.route("/loan/create", methods=["GET", "POST"])
def create_loan():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        loanID = request.form["loanID"]
        money = request.form["money"]
        cusID = request.form["cusID"]
        db_create_loan(db, loanID, cusID, money)
        db_close(db)
        return redirect(url_for('loan_menu'))
    else:
        return render_template("loan/create.html")

@app.route("/loan/delete", methods=["GET", "POST"])
def delete_loan():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
    else:
        return redirect(url_for('login'))

    if request.method == "POST":
        loanID = request.form["loanID"]
        db_delete_loan(db, loanID)
        db_close(db)
        return redirect(url_for('loan_menu'))
    else:
        return render_template("loan/delete.html")

@app.route("/loan/search", methods=["GET", "POST"])
def search_loan():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
        tabs = db_search_loan(db)
        db_close(db)
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        if 'back' in request.form:
            return redirect(url_for('loan_menu'))
    else:
        return render_template("loan/search.html", rows = tabs, tablename='Loan')

@app.route("/loan/search_input", methods=["GET", "POST"])
def search_input_loan():
    if 'username' in session:
            db = db_login(session['username'], session['password'], 
                    session['ipaddr'], session['database'])
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        if 'back' in request.form:
            return redirect(url_for('loan_menu'))
        loanID = request.form["loanID"]
        tabs = db_search_single_loan(db, loanID)
        db_close(db)
        return render_template("loan/search_single.html", rows = tabs)
    else:
        return render_template("loan/search_input.html")

@app.route("/loan/pay_loan", methods=["GET", "POST"])
def pay_loan():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        loanID = request.form["loanID"]
        cusID = request.form["cusID"]
        money = request.form["money"]
        paytime = request.form["paytime"]
        db_pay_loan(db, loanID, cusID, money, paytime)
        db_close(db)
        return redirect(url_for('loan_menu'))
    else:
        return render_template("loan/pay_loan.html", tablename='Loan')

@app.route("/statistics/menu", methods=["GET", "POST"])
def statistics_menu():
    if request.method == "POST":
        if 'classify' in request.form:
            return redirect(url_for('statistics_classify'))
        elif 'month' in request.form:
            return redirect(url_for('statistics_month'))
        elif 'quarter' in request.form:
            return redirect(url_for('statistics_quarter'))
        elif 'year' in request.form:
            return redirect(url_for('statistics_year'))
        elif 'back' in request.form:
            return redirect(url_for('menu'))
    else:
        return render_template("statistics/menu.html")

@app.route("/statistics/classify", methods=["GET", "POST"])
def statistics_classify():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
        tabs1 = db_summary_classify_saving(db)
        tabs2 = db_summary_classify_loan(db)
        db_close(db)
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        if 'back' in request.form:
            return redirect(url_for('statistics_menu'))
    else:
        return render_template("statistics/classify.html", rows1 = tabs1, rows2 = tabs2)

@app.route("/statistics/month", methods=["GET", "POST"])
def statistics_month():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
        tabs = db_summary_month(db)
        db_close(db)
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        if 'back' in request.form:
            return redirect(url_for('statistics_menu'))
    else:
        return render_template("statistics/month.html", rows = tabs)

@app.route("/statistics/quarter", methods=["GET", "POST"])
def statistics_quarter():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
        tabs = db_summary_quarter(db)
        db_close(db)
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        if 'back' in request.form:
            return redirect(url_for('statistics_menu'))
    else:
        return render_template("statistics/quarter.html", rows = tabs)

@app.route("/statistics/year", methods=["GET", "POST"])
def statistics_year():
    if 'username' in session:
        db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
        tabs = db_summary_year(db)
        db_close(db)
    else:
        return redirect(url_for('login'))
    if request.method == "POST":
        if 'back' in request.form:
            return redirect(url_for('statistics_menu'))
    else:
        return render_template("statistics/year.html", rows = tabs)

# # 请求url为host/table的页面返回结果
# @app.route("/table", methods=(["GET", "POST"]))
# def table():
#     # 出于简单考虑，每次请求都需要连接数据库，可以尝试使用其它context保存数据库连接
#     if 'username' in session:
#         db = db_login(session['username'], session['password'], 
#                         session['ipaddr'], session['database'])
#     else:
#         return redirect(url_for('login'))
    
#     tabs = db_showtable(db)

#     db_close(db)
#     if request.method == "POST":
#         if 'clear' in request.form:
#             return render_template("table.html", rows = '', dbname=session['database'])
#         elif 'search' in request.form:
#             return render_template("table.html", rows = tabs, dbname=session['database'])

#     else:
#         return render_template("table.html", rows = tabs, dbname=session['database'])


#返回不存在页面的处理
@app.errorhandler(404)

def not_found(e):
    return render_template("404.html")

if __name__ == "__main__":

    app.run(host = "127.0.0.1", port = "8866", debug=True)