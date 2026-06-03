const fs = require("node:fs");

const stringNumbers = {
  one: 1,
  two: 2,
  three: 3,
  four: 4,
  five: 5,
  six: 6,
  seven: 7,
  eight: 8,
  nine: 9,
  1: 1,
  2: 2,
  3: 3,
  4: 4,
  5: 5,
  6: 6,
  7: 7,
  8: 8,
  9: 9,
};

const getFirstNumber = (line) => {
  for (let char of line) {
    const num = parseInt(char, 10);
    if (!Number.isNaN(num)) {
      return num;
    }
  }
};

const getLastNumber = (line) => {
  const lineReverse = line.split("").reverse().join("");
  for (let char of lineReverse) {
    const num = parseInt(char, 10);
    if (!Number.isNaN(num)) {
      return num;
    }
  }
};

try {
  let data = fs.readFileSync("puzzle.txt", "utf8");

  const dataArr = data.split("\n");
  let result = 0;
  for (let line of dataArr) {
    if (!line) continue;

    const res = line.matchAll(
      RegExp(
        "(?=(1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine))",
        "g",
      ),
    );

    const ln = [...res].map((match) => stringNumbers[match[1]]).join("");

    const firstNumber = getFirstNumber(ln) * 10;
    const lastNumber = getLastNumber(ln);
    result += firstNumber + lastNumber;
  }
  console.log(result);
} catch (err) {
  console.error(err);
}
