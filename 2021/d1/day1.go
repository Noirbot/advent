package main

import (
	"bufio"
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
)

func main() {
	file, err := os.Open("input.txt")

	if err != nil {
		log.Fatal(err)
	}

	defer file.Close()

	scanner := bufio.NewScanner(file)
	var current string
	var nums []int64
	for scanner.Scan() {
		current = scanner.Text()
		i, _ := strconv.ParseInt(current, 0, 64)
		nums = append(nums, i)
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	var prev int64 = math.MaxInt64
	var count int64
	for _, val := range nums {
		if val > prev {
			count++
		}
		prev = val
	}

	fmt.Printf("Part 1: %d\n", count)

	max := len(nums)
	prev = math.MaxInt64
	count = 0
	for i := 0; i+3 <= max; i++ {
		slice := nums[i : i+3]
		var sum int64 = 0
		for index := range slice {
			sum += slice[index]
		}

		if sum > prev {
			count++
		}
		prev = sum
	}

	fmt.Printf("Part 2: %d\n", count)
}
