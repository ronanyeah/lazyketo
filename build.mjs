import lib from "elm-static-html-lib";
import { writeFile, readFile } from "fs";
import { promisify } from "util";

const write = promisify(writeFile);
const read = promisify(readFile);

(async () => {
  const recipes = JSON.parse(await read("./recipes.json"));
  const template = await read("./src/index.html", "UTF8");
  const cwd = process.cwd();
  const opts = {
    newLines: false,
    indent: 0
  };

  return Promise.all([
    write(
      "./public/index.html",
      template.replace(
        "CONTENT_HERE",
        await lib.elmStaticHtml(cwd, "Main.view", {
          ...opts,
          model: recipes,
          decoder: "Main.decoder"
        })
      )
    ),

    ...recipes.map(async info =>
      write(
        `./public/${info.url}.html`,
        template.replace(
          "CONTENT_HERE",
          await lib.elmStaticHtml(cwd, "Recipe.view", {
            ...opts,
            model: info,
            decoder: "Recipe.decoder"
          })
        )
      )
    )
  ]);
})().catch(console.error);
