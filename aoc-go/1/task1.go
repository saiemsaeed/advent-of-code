package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	file, err := os.ReadFile("puzzle.txt")
	if err != nil {
		panic(err)
	}

	content := string(file)
	contentArr := strings.Split(content, "\n")

	var sum int

	for _, line := range contentArr {
		if line == "" {
			continue
		}

		var firstNum int
		var lastNum int

		for _, char := range line {
			n, err := strconv.Atoi(string(char))
			if err != nil {
				continue
			}

			firstNum = n
			break
		}

		for i := range line {
			index := len(line) - 1 - i
			n, err := strconv.Atoi(string(line[index]))
			if err != nil {
				continue
			}

			lastNum = n
			break
		}

		lineSum := firstNum*10 + lastNum

		if err != nil {
			continue
		}

		sum += lineSum
	}

	fmt.Println(sum)
}
