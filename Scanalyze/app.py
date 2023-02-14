import os

from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session, url_for
from flask_session import Session
from tempfile import mkdtemp
from werkzeug.security import check_password_hash, generate_password_hash
import datetime
import urllib.request
from werkzeug.utils import secure_filename

from helpers import apology, login_required

# Configure application
app = Flask(__name__)


# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)
app.secret_key = "secret key"
app.config['UPLOAD_FOLDER'] = 'static/images/input'
# Configure CS50 Library to use SQLite databasetr
db = SQL("sqlite:///scanalyze.db")

@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response

# performs database query to obtain authorized patient info and files and display them.
@app.route("/", methods=["GET"])
@login_required
def index():
    scans = db.execute("SELECT patientname, modality, date, file FROM scans WHERE user_id == ?", session["user_id"])
    return render_template("index.html", scans=scans)

@app.route("/scanalyzer", methods=["GET"])
@login_required
def scanalyzer():
    return render_template("scanalyzer.html")


@app.route("/upload", methods=["GET", "POST"])
@login_required
def upload_file():
    if request.method == "POST":

        # ensures a file was uploaded
        if 'file' not in request.files:
            flash('No file uploaded')
            return redirect(request.url)

        if request.form.get("patient-name") == '':
            flash('Patient name is required')
            return redirect(request.url)

        file = request.files['file']

        if file.filename == '' or request.form.get("modality") == '':
            flash('Proper File Upload and Modality Type must be Selected')
            return redirect(request.url)

        else:
            #saves form inputs to database entry
            filename = secure_filename(file.filename)
            patientname = request.form.get("patient-name")
            modality = request.form.get("modality")
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            flash('Scan successfully uploaded')
            db.execute("INSERT INTO scans (user_id, patientname, modality, file, date) VALUES ( ?, ?, ?, ?, ?)", session["user_id"], patientname, modality, filename, datetime.datetime.now())
            return render_template('upload.html')

    else:
        return render_template("/upload.html")


@app.route("/share", methods=["GET", "POST"])
def share():
    if request.method == "POST":

        # retrieve user input
        filename = request.form.get("file")
        recepientname = request.form.get("recepient")

        # do a query of all columns of scans to select relevent information about the scan that is to be copied under a new entry along with the receiving users' id.
        recepientid = (db.execute("SELECT id FROM users WHERE username == ?", recepientname))[0]["id"]
        patientname = (db.execute("SELECT patientname FROM scans WHERE file == ?", filename))[0]["patientname"]
        modality = (db.execute("SELECT modality FROM scans WHERE file == ?", filename))[0]["modality"]
        datetime = (db.execute("SELECT date FROM scans WHERE file == ?", filename))[0]["date"]

        # insert copied scan information into a new entry in scans with user_id of the recepient
        db.execute("INSERT INTO scans (user_id, patientname, modality, file, date) VALUES ( ?, ?, ?, ?, ?)", recepientid, patientname, modality, filename, datetime)
        return render_template('/share.html')

    else:
        # 
        scans = db.execute("SELECT file FROM scans WHERE user_id == ?", session["user_id"])
        names = db.execute("SELECT username FROM users WHERE users.id != ?", session["user_id"])
        names = [d['username'] for d in names]
        return render_template("/share.html", names=names, scans=scans)

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


@app.route("/lookup", methods=["GET", "POST"])
@login_required
def lookup():

    # sends options to dropdown form to display all patients the user is authorized to see
    if request.method == "GET":
        patients = db.execute("SELECT patientname FROM scans WHERE user_id == ?", session["user_id"])
        patientnames = [d['patientname'] for d in patients]
        return render_template("lookup.html", patientnames=patientnames)
    else:
        # returns information about selected patient
        scans = db.execute("SELECT patientname, modality, date, file FROM scans WHERE patientname == ? AND user_id == ?", request.form.get("patientname"), session["user_id"])
        return render_template("lookedup.html", scans=scans)


@app.route("/register", methods=["GET", "POST"])
def register():

    # obtain form inputs
    if (request.method == "POST"):
        username = request.form.get('username')
        password = request.form.get('password')
        confirmation = request.form.get('confirmation')

        # ensures all fields filled completely and correctly
        if not username:
            return apology('Username is a required field.')
        elif not password:
            return apology('Password is a required field.')
        if password != confirmation:
            return apology('Passwords do not match.')

        # Password security requirements below. Length and number requirement.
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


# deletes database entries
@app.route("/delete", methods=["GET", "POST"])
@login_required
def delete():
    if request.method == "POST":
        filename = request.form.get('file')
        print(filename)
        db.execute("DELETE FROM scans WHERE file == ? AND user_id == ?", filename, session["user_id"])
        return redirect("/")
    else:
        scans = db.execute("SELECT DISTINCT file FROM scans WHERE user_id == ?", session["user_id"])
        return render_template("/delete.html", scans=scans)
