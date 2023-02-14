-- Keep a log of any SQL queries you execute as you solve the mystery.

-- Both Ananya and Arjan collaborated fully on the problem set, sitting together and working through and figuring out what to search and organizing leads. Ananya helped make suggestions on what additional databases it may be beneficial to JOIN onto my queries for additional clues and information that could be gleaned FROM a single search. Arjan ran most of the queries on his computer and planned the investigation collaboratively.



-- SELECT *
--   FROM crime_scene_reports
--   WHERE month = 7
--   AND day = 28
--   AND street = 'Humphrey Street'


-- SELECT *
--   FROM interviews
--   WHERE month = 7
--   AND day = 28


-- SELECT *
--   FROM bakery_security_logs
--   WHERE day = 28
--   AND month = 7
--   AND hour = 10
--   AND minute <= 25


-- SELECT *
--   FROM people
--   JOIN bakery_security_logs
--   ON bakery_security_logs.license_plate = people.license_plate
--   WHERE bakery_security_logs.id > 259
--   AND bakery_security_logs.id BETWEEN 260 AND 268


-- SELECT *
--   FROM atm_transactions
--   JOIN bank_accounts
--   ON atm_transactions.account_number = bank_accounts.account_number JOIN people ON bank_accounts.person_id = people.id WHERE atm_transactions.atm_location = 'Leggett Street' AND atm_transactions.day = 28 AND atm_transactions.month = 7


-- SELECT *
--   FROM atm_transactions
--   JOIN bank_accounts
--   ON atm_transactions.account_number = bank_accounts.account_number
--   JOIN people
--   ON bank_accounts.person_id = people.id
--   JOIN bakery_security_logs
--   ON bakery_security_logs.license_plate = people.license_plate
--   WHERE atm_transactions.atm_location = 'Leggett Street'
--   AND atm_transactions.day = 28
--   AND atm_transactions.month = 7
--   AND bakery_security_logs.id > 259
--   AND bakery_security_logs.id BETWEEN 260 AND 268


-- SELECT *
--   FROM phone_calls
--   WHERE year = 2021
--   AND month = 7
--   AND day = 28
--   AND duration < 60


-- SELECT *
--   FROM airports
--   JOIN flights
--   ON airports.id = flights.origin_airport_id
--   WHERE airports.city = 'Fiftyville'
--   AND day = 29
--   AND month = 7;


-- SELECT *
--   FROM airports
--   JOIN flights
--   ON airports.id = flights.origin_airport_id
--   JOIN passengers
--   ON flights.id = passengers.flight_id
--   JOIN people
--   ON people.passport_number = passengers.passport_number
--   WHERE airports.city = 'Fiftyville'
--   AND day = 29
--   AND month = 7
--   AND flights.hour = 8
--   AND (people.name = 'Bruce' or people.name = 'Diana')


-- SELECT city
--   FROM airports
--   WHERE id = 4


-- SELECT *
--   FROM phone_calls
--   JOIN people
--   ON people.phone_number = phone_calls.receiver
--   WHERE year = 2021
--   AND month = 7
--   AND day = 28
--   AND duration < 60
--   AND phone_calls.caller = '(367) 555-5533'




------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BELOW IS THE LOGIC AND PLANNING OF THE INVESTIGATION AND THE OUTPUTS OF THE SEARCH QUERIES IN SEQUENCE ORGANIZED BY LEADS ALONG WITH THE CORRESPONDING QUERY

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- crime occured 10:15am humphrey street bakery, 7/28/2021

-- Lead 1: | 161 | Ruth    | 2021 | 7     | 28  | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage FROM the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |

-- Lead 2: | 162 | Eugene  | 2021 | 7     | 28  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |

-- Lead 3: | 163 | Raymond | 2021 | 7     | 28  | As the thief was leaving the bakery, they called someone who talked to them for less than a minute.

-- Lead 4: | 163 | Raymond | 2021 | 7     | 28  | In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.

-- Lead 5: | 163 | Raymond | 2021 | 7     | 28  | The thief then asked the person on the other end of the phone to purchase the flight ticket.



-- Lead 1:

--SELECT * FROM bakery_security_logs WHERE day = 28 AND month = 7 AND hour = 10 AND minute <= 25

-- +-----+------+-------+-----+------+--------+----------+---------------+
-- | id  | year | month | day | hour | minute | activity | license_plate |
-- +-----+------+-------+-----+------+--------+----------+---------------+
-- | 258 | 2021 | 7     | 28  | 10   | 8      | entrance | R3G7486       |
-- | 259 | 2021 | 7     | 28  | 10   | 14     | entrance | 13FNH73       |
-- | 260 | 2021 | 7     | 28  | 10   | 16     | exit     | 5P2BI95       |
-- | 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
-- | 262 | 2021 | 7     | 28  | 10   | 18     | exit     | 6P58WS2       |
-- | 263 | 2021 | 7     | 28  | 10   | 19     | exit     | 4328GD8       |
-- | 264 | 2021 | 7     | 28  | 10   | 20     | exit     | G412CB7       |
-- | 265 | 2021 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       |
-- | 266 | 2021 | 7     | 28  | 10   | 23     | exit     | 322W7JE       |
-- | 267 | 2021 | 7     | 28  | 10   | 23     | exit     | 0NTHK55       |
-- | 268 | 2021 | 7     | 28  | 10   | 35     | exit     | 1106N58       |
-- | 269 | 2021 | 7     | 28  | 10   | 42     | entrance | NRYN856       |
-- | 270 | 2021 | 7     | 28  | 10   | 44     | entrance | WD5M8I6       |
-- | 271 | 2021 | 7     | 28  | 10   | 55     | entrance | V47T75I       |
-- +-----+------+-------+-----+------+--------+----------+---------------+

--SELECT * FROM people JOIN bakery_security_logs ON bakery_security_logs.license_plate = people.license_plate WHERE bakery_security_logs.id > 259 AND bakery_security_logs.id BETWEEN 260 AND 268

-- +--------+---------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+
-- |   id   |  name   |  phone_number  | passport_number | license_plate | id  | year | month | day | hour | minute | activity | license_plate |
-- +--------+---------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+
-- | 221103 | Vanessa | (725) 555-4692 | 2963008352      | 5P2BI95       | 260 | 2021 | 7     | 28  | 10   | 16     | exit     | 5P2BI95       |
-- | 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       | 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
-- | 243696 | Barry   | (301) 555-4174 | 7526138472      | 6P58WS2       | 262 | 2021 | 7     | 28  | 10   | 18     | exit     | 6P58WS2       |
-- | 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       | 263 | 2021 | 7     | 28  | 10   | 19     | exit     | 4328GD8       |
-- | 398010 | Sofia   | (130) 555-0289 | 1695452385      | G412CB7       | 264 | 2021 | 7     | 28  | 10   | 20     | exit     | G412CB7       |
-- | 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       | 265 | 2021 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       |
-- | 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       | 266 | 2021 | 7     | 28  | 10   | 23     | exit     | 322W7JE       |
-- | 560886 | Kelsey  | (499) 555-9472 | 8294398571      | 0NTHK55       | 267 | 2021 | 7     | 28  | 10   | 23     | exit     | 0NTHK55       |
-- +--------+---------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+


-- Lead 2:

--SELECT * FROM atm_transactions JOIN bank_accounts ON atm_transactions.account_number = bank_accounts.account_number JOIN people ON bank_accounts.person_id = people.id WHERE atm_transactions.atm_location = 'Leggett Street' AND atm_transactions.day = 28 AND atm_transactions.month = 7

-- +-----+----------------+------+-------+-----+----------------+------------------+--------+----------------+-----------+---------------+--------+---------+----------------+-----------------+---------------+
-- | id  | account_number | year | month | day |  atm_location  | transaction_type | amount | account_number | person_id | creation_year |   id   |  name   |  phone_number  | passport_number | license_plate |
-- +-----+----------------+------+-------+-----+----------------+------------------+--------+----------------+-----------+---------------+--------+---------+----------------+-----------------+---------------+
-- | 267 | 49610011       | 2021 | 7     | 28  | Leggett Street | withdraw         | 50     | 49610011       | 686048    | 2010          | 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
-- | 336 | 26013199       | 2021 | 7     | 28  | Leggett Street | withdraw         | 35     | 26013199       | 514354    | 2012          | 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
-- | 269 | 16153065       | 2021 | 7     | 28  | Leggett Street | withdraw         | 80     | 16153065       | 458378    | 2012          | 458378 | Brooke  | (122) 555-4581 | 4408372428      | QX4YZN3       |
-- | 264 | 28296815       | 2021 | 7     | 28  | Leggett Street | withdraw         | 20     | 28296815       | 395717    | 2014          | 395717 | Kenny   | (826) 555-1652 | 9878712108      | 30G67EN       |
-- | 288 | 25506511       | 2021 | 7     | 28  | Leggett Street | withdraw         | 20     | 25506511       | 396669    | 2014          | 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       |
-- | 246 | 28500762       | 2021 | 7     | 28  | Leggett Street | withdraw         | 48     | 28500762       | 467400    | 2014          | 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       |
-- | 266 | 76054385       | 2021 | 7     | 28  | Leggett Street | withdraw         | 60     | 76054385       | 449774    | 2015          | 449774 | Taylor  | (286) 555-6063 | 1988161715      | 1106N58       |
-- | 313 | 81061156       | 2021 | 7     | 28  | Leggett Street | withdraw         | 30     | 81061156       | 438727    | 2018          | 438727 | Benista | (338) 555-6650 | 9586786673      | 8X428L0       |
-- +-----+----------------+------+-------+-----+----------------+------------------+--------+----------------+-----------+---------------+--------+---------+----------------+-----------------+---------------+

--SELECT * FROM atm_transactions JOIN bank_accounts ON atm_transactions.account_number = bank_accounts.account_number JOIN people ON bank_accounts.person_id = people.id JOIN bakery_security_logs ON bakery_security_logs.license_plate = people.license_plate WHERE atm_transactions.atm_location = 'Leggett Street' AND atm_transactions.day = 28 AND atm_transactions.month = 7 AND bakery_security_logs.id > 259 AND bakery_security_logs.id BETWEEN 260 AND 268

-- +-----+----------------+------+-------+-----+----------------+------------------+--------+----------------+-----------+---------------+--------+--------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+
-- | id  | account_number | year | month | day |  atm_location  | transaction_type | amount | account_number | person_id | creation_year |   id   |  name  |  phone_number  | passport_number | license_plate | id  | year | month | day | hour | minute | activity | license_plate |
-- +-----+----------------+------+-------+-----+----------------+------------------+--------+----------------+-----------+---------------+--------+--------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+
-- | 267 | 49610011       | 2021 | 7     | 28  | Leggett Street | withdraw         | 50     | 49610011       | 686048    | 2010          | 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       | 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
-- | 246 | 28500762       | 2021 | 7     | 28  | Leggett Street | withdraw         | 48     | 28500762       | 467400    | 2014          | 467400 | Luca   | (389) 555-5198 | 8496433585      | 4328GD8       | 263 | 2021 | 7     | 28  | 10   | 19     | exit     | 4328GD8       |
-- | 288 | 25506511       | 2021 | 7     | 28  | Leggett Street | withdraw         | 20     | 25506511       | 396669    | 2014          | 396669 | Iman   | (829) 555-5269 | 7049073643      | L93JTIZ       | 265 | 2021 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       |
-- | 336 | 26013199       | 2021 | 7     | 28  | Leggett Street | withdraw         | 35     | 26013199       | 514354    | 2012          | 514354 | Diana  | (770) 555-1861 | 3592750733      | 322W7JE       | 266 | 2021 | 7     | 28  | 10   | 23     | exit     | 322W7JE       |
-- | 266 | 76054385       | 2021 | 7     | 28  | Leggett Street | withdraw         | 60     | 76054385       | 449774    | 2015          | 449774 | Taylor | (286) 555-6063 | 1988161715      | 1106N58       | 268 | 2021 | 7     | 28  | 10   | 35     | exit     | 1106N58       |
-- +-----+----------------+------+-------+-----+----------------+------------------+--------+----------------+-----------+---------------+--------+--------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+

-- Lead 3:

--SELECT * FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60

-- +-----+----------------+----------------+------+-------+-----+----------+
-- | id  |     caller     |    receiver    | year | month | day | duration |
-- +-----+----------------+----------------+------+-------+-----+----------+
-- | 221 | (130) 555-0289 | (996) 555-8899 | 2021 | 7     | 28  | 51       |
-- | 224 | (499) 555-9472 | (892) 555-8872 | 2021 | 7     | 28  | 36       |
-- | 233 | (367) 555-5533 | (375) 555-8161 | 2021 | 7     | 28  | 45       |
-- | 251 | (499) 555-9472 | (717) 555-1342 | 2021 | 7     | 28  | 50       |
-- | 254 | (286) 555-6063 | (676) 555-6554 | 2021 | 7     | 28  | 43       |
-- | 255 | (770) 555-1861 | (725) 555-3243 | 2021 | 7     | 28  | 49       |
-- | 261 | (031) 555-6622 | (910) 555-3251 | 2021 | 7     | 28  | 38       |
-- | 279 | (826) 555-1652 | (066) 555-9701 | 2021 | 7     | 28  | 55       |
-- | 281 | (338) 555-6650 | (704) 555-2131 | 2021 | 7     | 28  | 54       |
-- +-----+----------------+----------------+------+-------+-----+----------+

-- +-----+----------------+------+-------+-----+----------------+------------------+--------+----------------+-----------+---------------+--------+--------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+
-- | id  | account_number | year | month | day |  atm_location  | transaction_type | amount | account_number | person_id | creation_year |   id   |  name  |  phone_number  | passport_number | license_plate | id  | year | month | day | hour | minute | activity | license_plate |
-- +-----+----------------+------+-------+-----+----------------+------------------+--------+----------------+-----------+---------------+--------+--------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+
-- | 267 | 49610011       | 2021 | 7     | 28  | Leggett Street | withdraw         | 50     | 49610011       | 686048    | 2010          | 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       | 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
-- | 336 | 26013199       | 2021 | 7     | 28  | Leggett Street | withdraw         | 35     | 26013199       | 514354    | 2012          | 514354 | Diana  | (770) 555-1861 | 3592750733      | 322W7JE       | 266 | 2021 | 7     | 28  | 10   | 23     | exit     | 322W7JE       |
-- | 266 | 76054385       | 2021 | 7     | 28  | Leggett Street | withdraw         | 60     | 76054385       | 449774    | 2015          | 449774 | Taylor | (286) 555-6063 | 1988161715      | 1106N58       | 268 | 2021 | 7     | 28  | 10   | 35     | exit     | 1106N58       |
-- +-----+----------------+------+-------+-----+----------------+------------------+--------+----------------+-----------+---------------+--------+--------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+

-- Lead 4:

--SELECT * FROM airports JOIN flights ON airports.id = flights.origin_airport_id JOIN passengers ON flights.id = passengers.flight_id JOIN people ON people.passport_number = passengers.passport_number WHERE airports.city = 'Fiftyville' AND day = 29 AND month = 7 AND flights.hour = 8 AND (people.name = 'Bruce' or people.name = 'Diana')

-- +----+--------------+-----------------------------+------------+----+-------------------+------------------------+------+-------+-----+------+--------+-----------+-----------------+------+--------+--------+----------------+-----------------+---------------+
-- | id | abbreviation |          full_name          |    city    | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute | flight_id | passport_number | seat |   id   |  name  |  phone_number  | passport_number | license_plate |
-- +----+--------------+-----------------------------+------------+----+-------------------+------------------------+------+-------+-----+------+--------+-----------+-----------------+------+--------+--------+----------------+-----------------+---------------+
-- | 8  | CSF          | Fiftyville Regional Airport | Fiftyville | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     | 36        | 5773159633      | 4A   | 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       |
-- +----+--------------+-----------------------------+------------+----+-------------------+------------------------+------+-------+-----+------+--------+-----------+-----------------+------+--------+--------+----------------+-----------------+---------------+

--Bruce was the thief

--SELECT city FROM airports WHERE id = 4

-- +---------------+
-- |     city      |
-- +---------------+
-- | New York City |
-- +---------------+

-- he went to NYC

-- Lead 5:

--SELECT * FROM phone_calls JOIN people ON people.phone_number = phone_calls.receiver WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60 AND phone_calls.caller = '(367) 555-5533'

-- +-----+----------------+----------------+------+-------+-----+----------+--------+-------+----------------+-----------------+---------------+
-- | id  |     caller     |    receiver    | year | month | day | duration |   id   | name  |  phone_number  | passport_number | license_plate |
-- +-----+----------------+----------------+------+-------+-----+----------+--------+-------+----------------+-----------------+---------------+
-- | 233 | (367) 555-5533 | (375) 555-8161 | 2021 | 7     | 28  | 45       | 864400 | Robin | (375) 555-8161 |                 | 4V16VO0       |
-- +-----+----------------+----------------+------+-------+-----+----------+--------+-------+----------------+-----------------+---------------+

-- accomplice was robin