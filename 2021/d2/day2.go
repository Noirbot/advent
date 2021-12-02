package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	file, err := os.Open("input.txt")

	if err != nil {
		log.Fatal(err)
	}

	defer file.Close()

	scanner := bufio.NewScanner(file)
	var lines [][]string
	for scanner.Scan() {
		line := scanner.Text()
		split := strings.Split(line, " ")
		lines = append(lines, split)
	}

	var depth int64 = 0
	var progress int64 = 0
	for _, line := range lines {
		i, _ := strconv.ParseInt(line[1], 0, 64)
		switch line[0] {
		case "forward":
			progress += i
		case "up":
			depth -= i
		case "down":
			depth += i
		}
	}

	fmt.Printf("Part 1: %d\n", depth*progress)

	depth = 0
	progress = 0
	var aim int64 = 0
	for _, line := range lines {
		i, _ := strconv.ParseInt(line[1], 0, 64)
		switch line[0] {
		case "forward":
			progress += i
			depth += i * aim
		case "up":
			aim -= i
		case "down":
			aim += i
		}
	}

	fmt.Printf("Part 2: %d\n", depth*progress)
}
