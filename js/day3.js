// for the leaderboard place

const input = await Bun.file("inputs/day3.txt");
/**
 * @type {string}
 */
const inputText = await input.text();

const regexp = /(?:mul\((\d+),(\d+)\)|do\(\)|don\'t\(\))/g;

const parse = inputText.matchAll(regexp);

let result = 0;

let doing = true;

for (const match of parse) {
  const [instruction, a, b] = match;

  if (instruction === "do()") {
    doing = true;
    continue;
  } else if (instruction === "don't()") {
    doing = false;
    continue;
  }

  result += doing ? parseInt(a) * parseInt(b) : 0;
}

console.log(result);
