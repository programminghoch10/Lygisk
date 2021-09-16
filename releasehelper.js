const { execSync } = require('child_process')
const args = process.argv.slice(2)

/*
* Arguments:
*   branch - which release branch to generate json for, either stable or beta
*   version (optional) - version name of this release, defaults to commit hash
*/

let branch = args[0]
switch (branch) {
  case "stable":
  case "beta":
    break;
  case "canary":
    branch = "beta"
    break;
  default:
    console.error("Invalid Branch!")
    process.exit(1);
}

let gitbranch = "master"
if (branch == "beta") gitbranch = "ci-build"
execSync(`git checkout origin/${gitbranch} gradle.properties`)

let version = args[1] == undefined ? execSync(`git log -1 --pretty=%h origin/${gitbranch}`).toString().trimEnd() : args[1]
let versionCode = execSync("cat gradle.properties | grep 'magisk.versionCode'").toString().split("=")[1].trimEnd()
let stubVersionCode = execSync("cat gradle.properties | grep 'magisk.stubVersion'").toString().split("=")[1].trimEnd()

var template = `
{
  "magisk": {
    "version": "${version}",
    "versionCode": "${versionCode}",
    "link": "https://cdn.jsdelivr.net/gh/programminghoch10/Magisk@deploy/${branch}/app-release.apk",
    "note": "https://programminghoch10.github.io/Magisk/${branch}/note.md"
  },
  "stub": {
    "versionCode": "${stubVersionCode}",
    "link": "https://cdn.jsdelivr.net/gh/programminghoch10/Magisk@deploy/${branch}/stub-release.apk"
  }
}
`
template = template.trim()

execSync(`echo '${template}' > ${branch}.json`)
execSync("rm gradle.properties")
