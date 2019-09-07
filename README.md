# GitHub Action for [Lighthouse Auditing](https://developers.google.com/web/tools/lighthouse/)

<p align="center"><img src="https://raw.githubusercontent.com/jakejarvis/lighthouse-action/master/screenshots/logo.png" alt="Lighthouse Logo" width="300px"></p>

> **⚠️ Note:** To use this action, you must have access to the [GitHub Actions](https://github.com/features/actions) feature. GitHub Actions are currently only available in public beta. You can [apply for the GitHub Actions beta here](https://github.com/features/actions/signup/).

This action integrates Google's helpful [Lighthouse audits](https://developers.google.com/web/tools/lighthouse/) for webpages — specifically testing for Performance, Accessibility, Best Practices, SEO, and Progressive Web Apps. Right now, the action will print the five scores (out of 100) to the output and upload HTML and JSON versions of the report as artifacts. In the next release, the action will let you specify thresholds for each test and optionally fail this step if they are not met.

<p align="center"><img src="https://raw.githubusercontent.com/jakejarvis/lighthouse-action/master/screenshots/screenshot-report.png" alt="Example HTML report"></p>
<p align="center"><img src="https://raw.githubusercontent.com/jakejarvis/lighthouse-action/master/screenshots/screenshot-output.png" alt="Example command line output"></p>
<p align="center"><img src="https://raw.githubusercontent.com/jakejarvis/lighthouse-action/master/screenshots/screenshot-artifact.png" alt="Example HTML report" width="320px"></p>

Inspired by [GoogleChromeLabs/lighthousebot](https://github.com/GoogleChromeLabs/lighthousebot).


## Usage

### `workflow.yml` Example

The following workflow runs a Lighthouse audit on [https://jarv.is/](https://jarv.is/), shows the five scores in the output of the step, and uploads the `.html` and `.json` results as artifacts to download (as shown above).

```
jobs:
  audit:
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


### Netlify Deploy Preview

This GitHub action integrates with Netlify's [Deploy Preview](https://www.netlify.com/docs/continuous-deployment/) to test PRs before deployment. To enable, you need to pass in your Netlify site like this:

```
jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
    - uses: jakejarvis/lighthouse-action@master
      with:
        url: 'https://jarv.is/'
        # Netlify site used to generate deploy preview URL
        netlify_site: 'jakejarvis.netlify.com'
```

On pull requests, the number will be extracted from the Github event data and used to generate the deploy preview URL as follows: `https://deploy-preview-$PR_NUMBER--$NETLIFY_SITE` and override the URL. The URL will be used as fallback on pushes event.


## To-Do

- **Make CI fail if scores do not meet specified thresholds.**
- Ability to customize flags passed to both Chrome and Lighthouse
- Batch URL testing


## License

This project is distributed under the [MIT license](LICENSE.md).
