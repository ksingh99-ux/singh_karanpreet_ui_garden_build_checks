# UI Garden Build Checks - Assignment 13

By Karanpreet Singh

This is my UI component library from Assignment 12. For this assignment I added code quality checks so bad code can't get committed or pushed:

- **Prettier** checks that the code is formatted the same way everywhere
- **ESLint** checks the code for mistakes
- **Tests** make sure the components still work
- **Husky** runs all three checks before every commit
- **GitHub Actions** runs the same checks again on GitHub after every push
- **Docker** builds the app and runs it at http://localhost:8018

## What you need

- Node.js and npm
- Git
- Docker Desktop (open and running)

## How to run the app on localhost:8018

1. Clone the repo and go into the folder:

```bash
git clone https://github.com/ksingh99-ux/singh_karanpreet_ui_garden_build_checks.git
cd singh_karanpreet_ui_garden_build_checks
```

2. Build the Docker image:

```bash
docker build -t singh_karanpreet_coding_assignment13 .
```

3. Run the container:

```bash
docker run -d --name singh_karanpreet_coding_assignment13 -p 8018:8018 singh_karanpreet_coding_assignment13
```

4. Open http://localhost:8018 (or http://127.0.0.1:8018) in your browser.

To stop it:

```bash
docker stop singh_karanpreet_coding_assignment13
docker rm singh_karanpreet_coding_assignment13
```

### About the Dockerfile

- Container name: `singh_karanpreet_coding_assignment13`
- Working folder inside the container: `/singh_karanpreet_ui_garden_build_checks`
- It installs the packages, makes a production build with `npm run build`, and serves it on port 8018 using `serve`.

## Husky pre-commit checks

Every time I run `git commit`, Husky runs these three commands first (they are in `.husky/pre-commit`):

```sh
npm run check-format
npm run lint
npm test
```

If any of them fails, the commit is stopped. The code has to be fixed before it can be committed.

You can try it yourself:

- Mess up the formatting in any file, then commit. Prettier stops it.
- Add an unused variable like `const unused = 5;` in `src/App.tsx`, then commit. ESLint stops it.
- Break a test by changing the expected text in a `.tests.tsx` file, then commit. The tests stop it.

Run `git restore .` to undo the changes after.

## GitHub Actions

The workflow is in `.github/workflows/ci.yml`. Every time code is pushed to GitHub, it:

1. Installs the project
2. Runs the Prettier check
3. Runs ESLint
4. Runs the tests
5. Makes a production build

If something fails, the run shows a red X in the Actions tab and GitHub sends an email saying the build failed. This matters because someone can skip Husky with `git commit --no-verify`, but GitHub will still catch the bad code.

## Useful commands

```bash
npm install            # install everything (also sets up Husky)
npm start              # run the app in dev mode
npm run storybook      # open Storybook
npm run format         # fix formatting
npm run check-format   # check formatting
npm run lint           # run ESLint
npm test               # run the tests
npm run build          # make a production build
```

## What I did for this assignment

1. Copied my Assignment 12 project into a new folder and ran `npm install`.
2. Installed Prettier, ESLint, eslint-config-prettier and Husky.
3. Added `format`, `check-format` and `lint` scripts to `package.json`.
4. Made a `.prettierrc` file for the Prettier rules and a `.prettierignore` file.
5. Formatted the whole project and fixed the ESLint warnings in the Storybook files.
6. Set up Husky so the pre-commit hook runs Prettier, ESLint and the tests.
7. Added the GitHub Actions workflow and pushed to GitHub. The first run failed because GitHub used a different Node version, so I changed it to Node 24 and it passed.
8. Updated the Dockerfile for the new folder name and port 8018, built it, and checked the app at http://localhost:8018.
