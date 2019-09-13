# GitHub Action for [Lighthouse Auditing](https://developers.google.com/web/tools/lighthouse/)

<p align="center"><img src="https://raw.githubusercontent.com/jakejarvis/lighthouse-action/master/screenshots/logo.png" alt="Lighthouse Logo" width="300"></p>

> **⚠️ Note:** To use this action, you must have access to the [GitHub Actions](https://github.com/features/actions) feature. GitHub Actions are currently only available in public beta. You can [apply for the GitHub Actions beta here](https://github.com/features/actions/signup/).

This action integrates Google's helpful [Lighthouse audits](https://developers.google.com/web/tools/lighthouse/) for webpages — specifically testing for Performance, Accessibility, Best Practices, SEO, and Progressive Web Apps. Right now, the action will print the five scores (out of 100) to the output and upload HTML and JSON versions of the report as artifacts. In the next release, the action will let you specify thresholds for each test and optionally fail this step if they are not met.

<p align="center"><img src="https://raw.githubusercontent.com/jakejarvis/lighthouse-action/master/screenshots/screenshot-report.png" alt="Example HTML report"></p>
<p align="center"><img src="https://raw.githubusercontent.com/jakejarvis/lighthouse-action/master/screenshots/screenshot-output.png" alt="Example command line output"></p>
<p align="center"><img src="https://raw.githubusercontent.com/jakejarvis/lighthouse-action/master/screenshots/screenshot-artifact.png" alt="Example HTML report" width="320"></p>

Inspired by [GoogleChromeLabs/lighthousebot](https://github.com/GoogleChromeLabs/lighthousebot).


## Usage

### `workflow.yml` Example

The following workflow runs a Lighthouse audit on [https://jarv.is/](https://jarv.is/), shows the five scores in the output of the step, and uploads the `.html` and `.json` results as artifacts to download (as shown above).

```yaml
name: Audit live site
on: push

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
    - name: Audit live URL
      uses: jakejarvis/lighthouse-action@master
      with:
        url: 'https://jarv.is/'
    - name: Upload results as an artifact
      uses: actions/upload-artifact@master
      with:
        name: report
        path: './report'
```


### Pull Request Audits with [Netlify Deploy Preview](https://www.netlify.com/docs/continuous-deployment/)

<p align="center"><img src="https://raw.githubusercontent.com/jakejarvis/lighthouse-action/master/screenshots/netlify-logo.png" alt="Netlify Logo" width="300"></p>

This GitHub action integrates with [Netlify's Deploy Preview](https://www.netlify.com/docs/continuous-deployment/) feature, allowing you to test PRs before accepting them. To enable, you need to pass in your Netlify site's URL (on the Netlify subdomain — also called your "site name" in the Netlify dashboard — **not your custom domain**) to the `netlify_site` input variable:

```yaml
name: Audit pull request
on: pull_request

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
    - name: Audit Netlify deploy preview
      uses: jakejarvis/lighthouse-action@master
      with:
        netlify_site: 'blissful-heisenberg-16c40f.netlify.com'
    - uses: actions/upload-artifact@master
      with:
        name: report
        path: './report'
```

<p align="center"><img src="https://raw.githubusercontent.com/jakejarvis/lighthouse-action/master/screenshots/netlify-subdomain.png" alt="Netlify subdomain in dashboard" width="700"></p>

On pull requests, the PR number will be extracted from the GitHub event data and used to generate the deploy preview URL as follows: `https://deploy-preview-[[PR_NUMBER]]--[[NETLIFY_SITE]].netlify.com`. You can combine the two above examples and include both `url` and `netlify_site` and run on `on: [push, pull_request]` and the appropriate URL will be automatically selected depending on the type of event.


## To-Do

- **Make CI fail if scores do not meet specified thresholds.**
- Ability to customize flags passed to both Chrome and Lighthouse
- Batch URL testing


## License

This project is distributed under the [MIT license](LICENSE.md).
