const input = await Bun.file("inputs/day6.txt");
const inputLines: string[] = (await input.text()).split("\n");

const width = inputLines[0].length;
const height = inputLines.length;

let x = 0;
let y = 0;
let facing: "UP" | "DOWN" | "LEFT" | "RIGHT" = "UP";

for (let i = 0; i < inputLines.length; i++) {
  for (let j = 0; j < inputLines[i].length; j++) {
    const char = inputLines[i][j];
    if (char === "^" || char === "v" || char === "<" || char === ">") {
      console.log("FOUND:", i, j, char);
      y = i;
      x = j;
      facing =
        char === "^"
          ? "UP"
          : char === "v"
            ? "DOWN"
            : char === "<"
              ? "LEFT"
              : "RIGHT";
    }
  }
}

const positions = new Set();

while (0 <= x && x < width && 0 <= y && y < height) {
  console.log("START:", x, y, facing);
  const origX = x;
  const origY = y;

  switch (facing) {
    case "UP":
      if (inputLines[y - 1]?.[x] === "#") {
        facing = "RIGHT";
      } else {
        y--;
      }
      break;
    case "DOWN":
      if (inputLines[y + 1]?.[x] === "#") {
        facing = "LEFT";
      } else {
        y++;
      }
      break;
    case "LEFT":
      if (inputLines[y]?.[x - 1] === "#") {
        facing = "UP";
      } else {
        x--;
      }
      break;
    case "RIGHT":
      if (inputLines[y]?.[x + 1] === "#") {
        facing = "DOWN";
      } else {
        x++;
      }
      break;
  }

  if (
    0 <= x &&
    x < width &&
    0 <= y &&
    y < height &&
    (origX !== x || origY !== y)
  ) {
    positions.add(`${x},${y}`);
  }
  console.log("MOVE:", x, y, facing);
}

console.log(positions.size);
