![Magisk Logo](logo.png)

#### **This is not an officially supported topjohnwu project**

# Lygisk

This is a [Magisk](https://github.com/topjohnwu/Magisk) fork correcting one of the few mistakes legendary [@topjohnwu](github.com/topjohnwu) has made.

This version fixes the needed `/data` access in `addon.d`,
which fails to reinstall Magisk if the device does not support FBE decryption in recovery.

Bought to you by [@Linux4](https://github.com/Linux4) and [@programminghoch10](https://github.com/programminghoch10).

Thanks to [@jesec](https://github.com/jesec) for the initial work.
Read more about this [here](https://github.com/topjohnwu/Magisk/pull/3037).

## Downloads

Get the latest stable here: [Direct Download from GitHub](https://github.com/programminghoch10/Magisk/blob/deploy/stable/app-release.apk?raw=true)


## Variants

We supply you with four variants of Lygisk:

* **`Stable`**: Stable and tested versions, which have been manually ported from Magisk stable and have been tested to work
* **`Beta`**: Automated ci-builds from the latest magisk stable
* **`Canary`**: Automated ci-builds from the latest magisk canary
* **`Madness`**: Automated ci-builds from the latest magisk master

We recommend `stable` or `beta` for normal usage.

If you want any of the latest Magisk features you can try `canary` but we can't guarantee anything there.
If you're a real madlad you can also use `madness` but only truly insane people would want to do that.

For `canary` or `madness` you need to add a custom update URL.

variant | custom update URL
- | -
stable | `https://programminghoch10.github.io/Lygisk/stable.json`
beta | `https://programminghoch10.github.io/Lygisk/beta.json`
canary | `https://programminghoch10.github.io/Lygisk/canary.json`
madness | `https://programminghoch10.github.io/Lygisk/madness.json`

*(`stable` and `beta` are just listed for completeness)*

## Installation

We recommend installation via recovery.

Installing by patching bootimages should also work, 
but if you intend to use that way you might as well use [Magisk](https://github.com/topjohnwu/Magisk) in the first place.

### Migration

Migrating from Magisk to Lygisk is easy and does not remove installed modules.

In Magisk app select `Uninstall Magisk` and then `Restore bootimage`.
Then uninstall the Magisk app.
Now install Lygisk.

It's the same way for switching back to Magisk.

## Bug reports

Please only report bugs to us if you are sure that they appear because of our work.
If you are unsure, just try out [Magisk](https://github.com/topjohnwu/Magisk) and if the same issue appears there, report it there.

Do not report issues on the `beta` builds.


## Useful Links

Anything further is equal to [Magisk](https://github.com/topjohnwu/Magisk).

You can go and check [their resources](https://github.com/topjohnwu/Magisk#Useful-Links).


## License

#### Our license obviously is the same as [Magisk's license](https://github.com/topjohnwu/Magisk#License)

```
Magisk, including all git submodules are free software:
you can redistribute it and/or modify it under the terms of the
GNU General Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```
