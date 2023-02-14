import os

from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from tempfile import mkdtemp
from werkzeug.security import check_password_hash, generate_password_hash
import datetime

from helpers import apology, login_required, lookup, usd

# Configure application
app = Flask(__name__)

# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")

# Make sure API key is set
if not os.environ.get("API_KEY"):
    raise RuntimeError("API_KEY not set")


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/", methods=["GET"])
@login_required
def index():
    """Show portfolio of stocks"""
    stocks = db.execute(
        "SELECT symbol, shares, SUM(shares) AS total_shares FROM transactions WHERE user_id == ? GROUP BY symbol HAVING SUM(shares) > 0", session["user_id"])
    cash = db.execute("SELECT cash FROM users WHERE id == ?", session["user_id"])[0]["cash"]

    total = float(cash)

    for stock in stocks:
        stock["name"] = lookup(stock["symbol"])["name"]
        stock["price"] = float(lookup(stock["symbol"])["price"])
        stock["total"] = lookup(stock['symbol'])['price'] * stock['total_shares']
        total += stock["total"]

    return render_template("/index.html", stocks=stocks, cash=round(float(cash), 2), total=round(float(total), 2), usd=usd)


@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock"""
    if request.method == "POST":

        ticker = request.form.get("symbol").upper()
        shares = request.form.get("shares")

        if not lookup(ticker):
            return apology("invalid stock ticker")
        if not shares or int(shares) < 1:
            return apology("invalid quantity requested")
        if shares.isdigit:
            price = lookup(ticker)["price"]
            cost = int(shares) * price
            cash = db.execute("SELECT cash FROM users WHERE id == ?", session["user_id"])[0]

            if cost <= float(cash["cash"]):
                cash = float(cash["cash"]) - cost
                time = datetime.datetime.now()
                db.execute("UPDATE users SET cash = ? WHERE id == ?", cash, session["user_id"])
                db.execute("INSERT INTO transactions (user_id, date, symbol, shares, price) VALUES ( ?, ?, ?, ?, ?)",
                           session["user_id"], time, ticker, shares, price)
            else:
                return apology("Sorry, you do not have enough funds to purchase this many shares")
            return redirect("/")
        else:
            return apology("invalid share quantity")
    else:
        return render_template("/buy.html")


@app.route("/history", methods=["GET"])
@login_required
def history():
    """Show history of transactions"""
    stocks = db.execute("SELECT * FROM transactions WHERE user_id == ?", session["user_id"])
    return render_template("/history.html", stocks=stocks, usd=usd)


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute("SELECT * FROM users WHERE username = ?", request.form.get("username"))

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], request.form.get("password")):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""
    if request.method == "GET":
        return render_template("quote.html")
    else:
        symbol = request.form.get("symbol")
        if not symbol:
            return apology('Please enter a stock symbol')
        quote = lookup(symbol)
        if not quote:
            return apology('symbol not found')
        name = quote["name"]
        price = quote["price"]
        return render_template("quoted.html", name=name, symbol=symbol.upper(), price=price)


@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""
    if (request.method == "POST"):
        username = request.form.get('username')
        password = request.form.get('password')
        confirmation = request.form.get('confirmation')

        if not username:
            return apology('Username is a required field.')
        elif not password:
            return apology('Password is a required field.')
        if password != confirmation:
            return apology('Passwords do not match.')

        # personal touch: password security requirements below. Length and number requirement.
        if len(password) < 6:
            return apology('password must be longer than 6 characters')

        if not any(char.isdigit() for char in password):
            return apology('your password must contain at least 1 number')

        hashedpass = generate_password_hash(password)

        if len(db.execute("SELECT username FROM users WHERE username == ?", username)) == 0:
            db.execute("INSERT INTO users (username, hash) VALUES (?, ?)", username, hashedpass)
            return redirect("/")
        else:
            return apology('This username already exists; please enter another username.')

    else:
        return render_template("register.html")


@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    """Sell shares of stock"""
    if request.method == "POST":
        if request.form.get("shares").isdigit:
            ticker = request.form.get("symbol").upper()
            saleShares = int(request.form.get("shares"))

            if not lookup(ticker):
                return apology("invalid stock ticker")
            if not saleShares or int(saleShares) < 1:
                return apology("invalid quantity requested")
            price = lookup(ticker)["price"]
            cost = int(saleShares) * price
            cash = db.execute("SELECT cash FROM users WHERE id == ?", session["user_id"])[0]
            ownedShares = db.execute("SELECT SUM(shares) FROM transactions WHERE user_id == ? AND symbol == ? GROUP BY symbol HAVING SUM(shares) > 0",
                                     session["user_id"], ticker)[0]["SUM(shares)"]
            print(ownedShares)
            if saleShares <= ownedShares:
                cash = float(cash["cash"]) + cost
                time = datetime.datetime.now()
                db.execute("UPDATE users SET cash = ? WHERE id == ?", cash, session["user_id"])
                db.execute("INSERT INTO transactions (user_id, date, symbol, shares, price) VALUES ( ?, ?, ?, ?, ?)",
                           session["uswer_id"], time, ticker, -1 * int(saleShares), price)
            else:
                return apology("invalid quantity of shares.")
            return redirect("/")
        else:
            return apology("Share must be a quantity")
    else:
        myStocks = db.execute("SELECT DISTINCT symbol FROM transactions WHERE user_id == ?",
                              session["user_id"])
        print(myStocks)
        return render_template("/sell.html", myStocks=myStocks)
