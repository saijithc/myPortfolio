# Agent Instructions & Project Best Practices

When working on this project, adhere strictly to the following guidelines and conventions.

## Core Development Principles

- **Small, reviewable diffs**: Keep PRs focused; avoid drive-by refactors unless explicitly requested.
- **Fast correctness loop**: After making edits, always run format and analyze commands. If code generation is involved, ensure you run `build_runner`.
- **Guard secrets**: Never commit credentials. Treat `assets/.env` as highly sensitive, even if it is referenced in `pubspec.yaml`.
- **Minimize AGENT tokens**: Be selective with file reads, avoid large copy/pastes, and keep explanations short and high-signal.

## Architecture & Code Quality

- **Respect app architecture**: Prefer using existing patterns and packages (Riverpod, GoRouter, Dio) over introducing new ones.
- **Readable code**: Optimize for clarity. Use descriptive names, write small functions, and maintain predictable control flow.
- **Keep files small**: Aim for **~250 lines per file**. Extract widgets or helper functions into separate files when needed.
- **Models**: Use **JsonSerializable** whenever creating a new data model.
- **Match structure**: Follow the existing folder structure and naming conventions rigorously.
- **Null Safety**: Fully leverage Dart's sound null safety to prevent runtime errors.
- **Linting & Analysis**: Adhere to the rules defined in `analysis_options.yaml`. Address any warnings or hints immediately.
- **Testing**: Whenever appropriate, ensure business logic and critical UI paths are covered by tests.

## UI & State Management

- **UI changes**: Keep typography, spacings, and colors consistent with existing widgets. Do not introduce new design systems or radical UI deviations unless requested.
- **Performance**: Use `const` constructors for widgets wherever possible to optimize the build cycle. Avoid unnecessary state updates.
- **State Management**: Keep business logic completely decoupled from UI components by using Riverpod effectively.
- **Responsive Design**: Ensure UI components are responsive. Use tools like `LayoutBuilder` and `MediaQuery` gracefully.
- **Error Handling**: Catch exceptions appropriately at the repository/provider level and surface meaningful UI states.

## Project Structure

Where things usually live:
- **App code**: `lib/`
- **Assets**: `assets/`
