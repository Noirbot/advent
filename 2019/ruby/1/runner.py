import math

with open('input.txt') as file:
    for cnt, line in enumerate(file):
        mass = math.floor(int(line) / 3) - 2
        print(mass)
