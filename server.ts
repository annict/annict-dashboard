import { app, get } from "https://denopkg.com/syumai/dinatra/mod.ts";
import { renderFile } from "https://deno.land/x/dejs/dejs.ts";

app(get("/", async () => await renderFile("index.ejs", { name: "world" })));
