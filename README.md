# GitHub Action for [Lighthouse Audits](https://developers.google.com/web/tools/lighthouse/)

<p align="center"><img src="https://raw.githubusercontent.com/jakejarvis/lighthouse-action/master/screenshots/logo.png" alt="Lighthouse Logo" width="300px"></p>

> **⚠️ Note:** To use this action, you must have access to the [GitHub Actions](https://github.com/features/actions) feature. GitHub Actions are currently only available in public beta. You can [apply for the GitHub Actions beta here](https://github.com/features/actions/signup/).

This action integrates Google's helpful [Lighthouse audits](https://developers.google.com/web/tools/lighthouse/) for webpages — specifically testing for Performance, Accessibility, Best Practices, SEO, and Progressive Web Apps. Right now, the action will print the five scores (out of 100) to the output and upload HTML and JSON versions of the report as artifacts. In the next release, the action will let you specify thresholds for each test and optionally fail this step if they are not met.

<p align="center"><img src="https://raw.githubusercontent.com/jakejarvis/lighthouse-action/master/screenshots/screenshot-report.png" alt="Example HTML report"></p>
<p align="center"><img src="https://raw.githubusercontent.com/jakejarvis/lighthouse-action/master/screenshots/screenshot-artifact.png" alt="Example HTML report" width="320px"></p>

Inspired by [GoogleChromeLabs/lighthousebot](https://github.com/GoogleChromeLabs/lighthousebot).


## Usage

### `workflow.yml` Example

The following workflow runs a Lighthouse audit on [https://jarv.is/](https://jarv.is/), shows the five scores in the output of the step, and uploads the `.html` and `.json` results as artifacts to download (as shown above).

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

- **Make CI fail if scores do not meet specified thresholds.**
- Currently a *painfully* long build (around 2-3 mins) — maybe pre-package a headless Chrome image to speed up build?
- Ability to customize flags passed to both Chrome and Lighthouse
- Batch URL testing
- Integration with Netlify's [Deploy Preview](https://www.netlify.com/docs/continuous-deployment/) to test PRs before deployment?


## License

[![CC0](http://mirrors.creativecommons.org/presskit/buttons/88x31/svg/cc-zero.svg)](https://creativecommons.org/publicdomain/zero/1.0/)

To the extent possible under law, [Jake Jarvis](https://jarv.is/) has waived all copyright and related or neighboring rights to this work.
