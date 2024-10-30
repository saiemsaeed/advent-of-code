const fs = require("node:fs");

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
  const data = fs.readFileSync("puzzle.txt", "utf8");
  const dataArr = data.split("\n");
  let result = 0;
  for (let line of dataArr) {
    const firstNumber = getFirstNumber(line) * 10;
    const lastNumber = getLastNumber(line);
    result += firstNumber + lastNumber;
  }
  console.log(result);
} catch (err) {
  console.error(err);
}
