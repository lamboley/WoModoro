# Contributing to WoModoro

Thanks for taking the time to contribute to WoModoro!

Please review and follow the [Code of Conduct](CODE_OF_CONDUCT.md).

This is a small project maintained by one person. Issues and pull requests are
welcome.

## Reporting an issue

This project uses GitHub issues to manage the issues.

## Submitting a code change

### Git Setup

Before contributing, make sure you have set up your Git authorship correctly:

```bash
git config --global user.name "Your Full Name"
git config --global user.email your.email@example.com
```

### Opening PRs

PRs should generally address only 1 issue at a time. If you need to fix two bugs, open two separate PRs. This will keep the scope of your pull requests smaller and allow them to be reviewed and merged more quickly.

Generally, pull requests should consist of a single logical commit.

### Git Commit Conventions

Git commits shall be:

1. **atomic** (1 commit `=` 1 and only 1 _thing_),
2. **semantic** (using [semantic-release commit message syntax](https://semantic-release.gitbook.io/semantic-release/#commit-message-format)).

### Coding Guidelines

**Bash:**

- [Style guide](https://google.github.io/styleguide/shellguide.html)
- Know and avoid [BashPitfalls](https://mywiki.wooledge.org/BashPitfalls)

**Go:**

- [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments)
- [Effective Go](https://golang.org/doc/effective_go.html)
- Know and avoid [Go landmines](https://gist.github.com/lavalamp/4bd23295a9f32706a48f)
- [Go's commenting conventions](http://blog.golang.org/godoc-documenting-go-code)
- Avoid general utility packages.
- All filenames should be lowercase.
- All source files and directories should use underscores, not dashes.

**Vue:**

- Follow the [official Vue Style Guide](https://vuejs.org/style-guide/), especially Priority A and Priority B rules.
- Follow the [eslint-plugin-vue recommended rules](https://eslint.vuejs.org/rules/).
- Use the Vue 3 Composition API with `<script setup>`.
- Vue component filenames should use PascalCase.
- Composables should start with `use`.

**JavaScript:**

- Follow the [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript).
- Airbnb's rules are enforced by ESLint.
- Use modern ECMAScript modules (`import` and `export`).
- Prefer `const`; use `let` only when reassignment is required. Do not use `var`.

**CSS:**

- Follow the [Stylelint standard configuration](https://stylelint.io/user-guide/configure/).
- Avoid ID selectors and `!important` unless required by an external integration.
- The repository Stylelint configuration is authoritative.

## Linting

There are CI check for linting the code, you'll need to run the following command before opening a pull request:

- `make lint` must pass without errors
- `make test` must pass without errors

## License

By contributing, you agree that your contributions will be licensed under the [Apache License 2.0](LICENSE), the same license that covers this project.
