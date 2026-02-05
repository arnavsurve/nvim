# nvim

## External Dependencies

### tsgo (TypeScript)

[tsgo](https://github.com/nicknisi/tsgo) is Microsoft's native Go-based TypeScript language server. It's not managed by Mason — install it globally:

```sh
npm install --global @typescript/native-preview
```

Verify it's on your PATH:

```sh
tsgo --version
```

**Note:** tsgo is experimental. Most features work (completions, diagnostics, go-to-definition) but some (e.g. go-to-implementation) may not yet be available.
