

Inspired by [GoogleChromeLabs/lighthousebot](https://github.com/GoogleChromeLabs/lighthousebot).


## Usage

### `workflow.yml` Example

The following workflow runs a Lighthouse audit on [https://jarv.is/](https://jarv.is/) and uploads the `.html` and `.json` results as artifacts to download.

```
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: jakejarvis/lighthouse-action@master
      with:
        url: 'https://jarv.is/'
    - uses: actions/upload-artifact@master
      with:
        name: report
        path: './report'
```


## To-Do

- Pre-package a headless Chrome image to speed up build
- Ability to customize flags passed to both Chrome and Lighthouse
- Batch URL testing
- Integration with Netlify's [Deploy Preview](https://www.netlify.com/docs/continuous-deployment/) to test PRs before deployment?


## License

[![CC0](http://mirrors.creativecommons.org/presskit/buttons/88x31/svg/cc-zero.svg)](https://creativecommons.org/publicdomain/zero/1.0/)

To the extent possible under law, [Jake Jarvis](https://jarv.is/) has waived all copyright and related or neighboring rights to this work.
