# ParkingLot
technical Exam on ruby

# Target
I have a parking lot that can hold up to 'n' cars. Each slot is given a slot number starting with 1.
I may add/remove parking slots anytime.

I want to create a ticketing system that allows my customers to use my parking lot.

When a car enters my parking lot, I want to have a ticket issued to the driver. 

The ticket issuing process includes the teller documenting the plate number and the color of the car.

The system will allocate an available parking slot to the car. We assume that our customers are nice enough to always park in the slots allocated to them.

At the exit the customer returns the ticket which then marks the slot they were using as available.

Due to government regulation, the system should provide me with the ability to find out: 

a. Plate numbers of all cars of a particular color

b. Slot number in which a car with a given plate number is parked

c. Slot numbers of all slots where a car of a particular color is parked

# output
Implement a solution in Ruby that will handle the interactive mode & file mode. The same codebase should support both modes of input - we don't want two distinct submissions.

1. It should provide us with an interactive command prompt based shell where commands can be typed in.
2. It should accept a filename as a parameter at the command prompt and read the commands from that file.

Please use git. We expect you to send us a zip/tarball of your source code when you're done that includes the full git repository in the tarball so we can look at your commit logs and understand how your solution evolved.

# Samples
The teller interacts with the system via a simple set of commands which produce a specific output. Please take a look at the example below, which includes all the commands you need to support - they're self explanatory.

**Example: Interactive**

To run the program and launch the shell:

```bash
"$ my_program
```

Assuming a parking lot with 6 slots, the following commands should be run in sequence by typing them in at a prompt and should produce output as described below the command:

```bash
"Input: create_parking_lot 6
Output: Created a parking lot with 6 slots

Input: park ABC-1234 White
Output: Allocated slot number: 1

Input: park ABC-9999 White
Output: Allocated slot number: 2

Input: park ABC-0001 Black
Output: Allocated slot number: 3

Input: park ABC-7777 Red
Output: Allocated slot number: 4

Input: park ABC-2701 Blue
Output: Allocated slot number: 5

Input: park ABC-3141 Black
Output: Allocated slot number: 6

Input: leave 4
Output: Slot number 4 is free

Input: status
Output:
Slot No. | Plate Number | Colour
1 | ABC-1234 | White
2 | ABC-9999 | White
3 | ABC-0001 | Black
5 | ABC-2701 | Blue
6 | ABC-3141 | Black

Input: park ABC-333 White
Output: Allocated slot number: 4

Input: park ABC-9998 White
Output: Sorry, parking lot is full

Input: plate_numbers_for_cars_with_colour White
Output: ABC-1234, ABC-9999, ABC-333

Input: slot_numbers_for_cars_with_colour White
Output: 1, 2, 4

Input: slot_number_for_registration_number ABC-3141
Output: 6

Input: slot_number_for_registration_number DEF-1111
Output: Not found
```

**Example: File**

To run the program:

```bash
"$ my_program file_inputs.txt > output.txt
```

Input (in file):

```bash
"create_parking_lot 6
park ABC-1234 White
park ABC-9999 White
park ABC-0001 Black
park ABC-7777 Red
park ABC-2701 Blue
park ABC-3141 Black
leave 4
status
park ABC-333 White
park ABC-9998 White
plate_numbers_for_cars_with_colour White
slot_numbers_for_cars_with_colour White
slot_number_for_registration_number ABC-3141
slot_number_for_registration_number ABD-1111
```

Output (to console, newline after every output):
```bash
"Created a parking lot with 6 slots
Allocated slot number: 1
Allocated slot number: 2
Allocated slot number: 3
Allocated slot number: 4
Allocated slot number: 5
Allocated slot number: 6
Slot number 4 is free

Slot No. | Plate No | Colour
1 | ABC-1234 | White
2 | ABC-9999 | White
3 | ABC-0001 | Black
5 | ABC-2701 | Blue
6 | ABC-3141 | Black

Allocated slot number: 4
Sorry, parking lot is full
ABC-1234, ABC-9999, ABC-333
1, 2, 4
6
Not found
```