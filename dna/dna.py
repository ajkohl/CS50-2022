import csv
import sys


def main():

    # TODO: Check for command-line usage
    # checks to make sure there are only 2 arguments for dna and returns error code and exits program if not
    if len(sys.argv) != 3:
        print("Usage: python dna.py database.csv sequence.txt")
        exit()

    memorydatabase = []

    # reads the database into relevent variables
    with open(sys.argv[1], 'r') as database_file:
        reader = csv.DictReader(database_file)
        subseqs = reader.fieldnames[1:]
        memorydatabase = list(reader)

    # Reads DNA sequence file into a variable
    with open(sys.argv[2], 'r') as sequence_file:
        memorysequence = sequence_file.read()

    # Finds longest match of each STR in DNA sequence
    dictionary = {}
    # loops through subseqs and saves for each substring, the STR longest match quantity in dictionary data structure
    for i in subseqs:
        dictionary[i] = longest_match(memorysequence, i)

    # Checks database for matching profiles
    for person in memorydatabase:
        strmatches = 0
        # sees for each person in database if the number of repeats for each STR in a particular sequence matches the amount had by a person in the database.
        for i in subseqs:
            if dictionary[i] == int(person[i]):
                # adds 1 for every match in a number of STRs found between sequence in question and person in database
                strmatches += 1
            # sees if the number of matching STR quantities between the database person and sequence in question are the same as the number of STRs that are in the database, effectively checking whether or not every number in the row of a person in the database matches the sequence in question
            if strmatches == len(subseqs):
                # if the previous condition is true, prints the matched person from database and returns
                print(person["name"])
                return

    if strmatches != len(subseqs):
        print("no match")
    return


def longest_match(sequence, subsequence):
    """Returns length of longest run of subsequence in sequence."""

    # Initialize variables
    longest_run = 0
    subsequence_length = len(subsequence)
    sequence_length = len(sequence)

    # Check each character in sequence for most consecutive runs of subsequence
    for i in range(sequence_length):

        # Initialize count of consecutive runs
        count = 0

        # Check for a subsequence match in a "substring" (a subset of characters) within sequence
        # If a match, move substring to next potential match in sequence
        # Continue moving substring and checking for matches until out of consecutive matches
        while True:

            # Adjust substring start and end
            start = i + count * subsequence_length
            end = start + subsequence_length

            # If there is a match in the substring
            if sequence[start:end] == subsequence:
                count += 1

            # If there is no match in the substring
            else:
                break

        # Update most consecutive matches found
        longest_run = max(longest_run, count)

    # After checking for runs at each character in seqeuence, return longest run found
    return longest_run


main()
