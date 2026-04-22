# Dependency error report

Repository: wasi-http-template

## Command

```sh
moon check
```

## Error source

Dependency: `peter-jerry-ye/io@0.3.4`

`moon check` fails while calculating the build plan, before checking this
repository's source files.

The failing package is `http` inside `peter-jerry-ye/io@0.3.4`. It imports
`tonyfettes/encoding@0.3.7`, but `peter-jerry-ye/io@0.3.4` does not declare the
containing module as one of its imports. Moon therefore rejects that dependency
package relationship.

Observed error:

```text
Error: Failed to calculate build plan

Caused by:
    0: Failed to solve package relationship
    1: Import tonyfettes/encoding@0.3.7 exists in global environment,
               but its containing module is not imported by peter-jerry-ye/io@0.3.4, thus cannot be imported by its package 'http'
```

## Attempted fix

Ran:

```sh
moon add peter-jerry-ye/io
```

The command completed successfully but did not update `moon.mod.json` or any
tracked dependency file. Running `moon check` again produced the same error.

This needs a dependency-side fix or a compatible newer release of
`peter-jerry-ye/io`.
