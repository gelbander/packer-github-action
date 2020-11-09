
# GitHub Action: Packer Build

> GitHub Action for running Packer [build](https://www.packer.io/docs/commands/build).

## Table of Contents

- [GitHub Action: Packer Build](#github-action-packer-build)
  - [Table of Contents](#table-of-contents)
  - [Usage](#usage)
    - [Inputs](#inputs)
      - [`varList`](#varlist)

## Usage

Add the Action to your [GitHub Workflow](https://help.github.com/en/actions/configuring-and-managing-workflows/configuring-a-workflow#creating-a-workflow-file) like so:

```yaml
---

name: Packer

on:
  push:

jobs:
  packer:
    runs-on: ubuntu-latest
    name: packer

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v2

      # build artifact
      - name: Packer build
        uses: gelbander/packer-github-action@v1
        with:
          workingDir: '.'
          templateFileName: 'basic.json'
          varList: 'git_sha=${{ github.sha }}'
        env:
          GOOGLE_APPLICATION_CREDENTIALS: service_account.json
          SERVICE_ACCOUNT_BASE64: ${{ secrets.SERVICE_ACCOUNT_BASE64 }}

      # additional steps
```

### Inputs

| Name               | Description                    | Required | Default       |
| ------------------ | ------------------------------ | -------- | ------------- |
| `workingDir`       | Working directory              | no       | `.`           |
| `templateFileName` | Configuration file             | no       | `packer.json` |
| `varList`          | `key=val,key2=val2`            | no       |               |
| `varFileName`      | target to `-var-file` argument | no       |               |

#### `varList`

Key-value pairs eg. (`key=value,key2=value2` translates into:

```
$ packer build \
    -var 'key=value' \
    -var 'key2=value2' \
    packer.json
```