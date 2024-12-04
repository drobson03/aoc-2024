const input = await Bun.file("inputs/day4.txt");
const inputText = await input.text();
const lines: string[] = inputText.split("\n");

const width = lines[0].length;
const height = lines.length;

function searchForXMAS(
  grid: string[],
  x: number,
  y: number,
  u: -1 | 0 | 1,
  v: -1 | 0 | 1,
): boolean {
  return (
    grid[x][y] === "X" &&
    grid[x + u]?.[y + v] === "M" &&
    grid[x + 2 * u]?.[y + 2 * v] === "A" &&
    grid[x + 3 * u]?.[y + 3 * v] === "S"
  );
}

// yes i did actually do this
function searchForMAS(grid: string[], x: number, y: number): boolean {
  return (
    grid[x]?.[y] === "A" &&
    ((grid[x - 1]?.[y - 1] === "M" &&
      grid[x + 1]?.[y - 1] === "S" &&
      grid[x - 1]?.[y + 1] === "M" &&
      grid[x + 1]?.[y + 1] === "S") ||
      (grid[x - 1]?.[y - 1] === "S" &&
        grid[x + 1]?.[y - 1] === "S" &&
        grid[x - 1]?.[y + 1] === "M" &&
        grid[x + 1]?.[y + 1] === "M") ||
      (grid[x - 1]?.[y - 1] === "S" &&
        grid[x + 1]?.[y - 1] === "M" &&
        grid[x - 1]?.[y + 1] === "S" &&
        grid[x + 1]?.[y + 1] === "M") ||
      (grid[x - 1]?.[y - 1] === "M" &&
        grid[x + 1]?.[y - 1] === "M" &&
        grid[x - 1]?.[y + 1] === "S" &&
        grid[x + 1]?.[y + 1] === "S"))
  );
}

const directions = [
  [1, 0], // right
  [-1, 0], // left
  [0, 1], // down
  [0, -1], // up
  [1, 1], // right down
  [1, -1], // right up
  [-1, 1], // left down
  [-1, -1], // left up
] as const;

let part1 = 0;
let part2 = 0;

for (let y = 0; y < height; y++) {
  for (let x = 0; x < width; x++) {
    for (const [u, v] of directions) {
      part1 += searchForXMAS(lines, x, y, u, v) ? 1 : 0;
    }

    part2 += searchForMAS(lines, x, y) ? 1 : 0;
  }
}

console.log(part1);
console.log(part2);
