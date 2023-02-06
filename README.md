![Magisk Logo](logo.png)

#### **This is not an officially supported [topjohnwu](https://github.com/topjohnwu) project**

# Lygisk

Lygisk is a [Magisk](https://github.com/topjohnwu/Magisk) fork correcting one of the few mistakes legendary [@topjohnwu](https://github.com/topjohnwu) did not fix (yet).

Lygisk fixes the needed `/data` access in `addon.d`,
which fails to reinstall Magisk during OTA 
if the device does not support FBE decryption in recovery
([more details below](#lygisk-vs-magisk)).

Brought to you by [@Linux4](https://github.com/Linux4),
[@programminghoch10](https://github.com/programminghoch10)
and [@binarynoise](https://github.com/binarynoise).

Thanks to [@jesec](https://github.com/jesec) for the initial work.
Read more about this [here](https://github.com/topjohnwu/Magisk/pull/3037).

## Downloads

Get the latest stable here: [Direct Download from GitHub](https://raw.githubusercontent.com/programminghoch10/Lygisk/deploy/stable/app-release.apk)

Any other variant can be downloaded by clicking its name below.

## Variants

We supply you with four variants of Lygisk:

* [**`Stable`**](https://raw.githubusercontent.com/programminghoch10/Lygisk/deploy/stable/app-release.apk): Stable and tested versions, which have been manually ported from Magisk stable and have been tested to work
* [**`Beta`**](https://raw.githubusercontent.com/programminghoch10/Lygisk/deploy/beta/app-release.apk): Automated ci-builds from the latest magisk stable
* [**`Canary`**](https://raw.githubusercontent.com/programminghoch10/Lygisk/deploy/canary/app-debug.apk): Automated ci-builds from the latest magisk canary
* [**`Madness`**](https://raw.githubusercontent.com/programminghoch10/Lygisk/deploy/madness/app-debug.apk): Automated ci-builds from the latest magisk master

We recommend `stable` or `beta` for normal usage.

If you want any of the latest Magisk features you can try `canary` but we can't guarantee anything there.
If you're a real madlad you can also use `madness` but only truly insane people would want to do that.

For `canary` or `madness` you need to add a custom update URL.

variant | custom update URL
-|-
stable | `https://programminghoch10.github.io/Lygisk/stable.json`
beta | `https://programminghoch10.github.io/Lygisk/beta.json`
canary | `https://programminghoch10.github.io/Lygisk/canary.json`
madness | `https://programminghoch10.github.io/Lygisk/madness.json`

*(`stable` and `beta` are just listed for completeness)*

## Installation

We recommend installation via recovery.
Just rename the downloaded file to `.zip` and sideload it.

Installing by patching bootimages should also work, 
but if you intend to use that way you might as well use [Magisk](https://github.com/topjohnwu/Magisk) in the first place.

### Migration

Migrating from Magisk to Lygisk is easy and does not remove installed modules.

In Magisk app select `Uninstall Magisk` and then `Restore bootimage`.
Then uninstall the Magisk app.
Now install Lygisk.

It's the same way for switching back to Magisk.

## Lygisk vs Magisk

Lygisk has been developed for one specific case:
* `A-only` device
* `/data` is encrypted
* the recovery cannot decrypt `/data`
* the recovery is `addon.d` capable
This is the case for every LineageOS device running the LineageOS recovery.

If you patch `boot.img` or you have `/data` not encrypted, use Magisk.
If you have an `addon.d`-compatible ROM (such as LineageOS) with encrypted `/data`, use Lygisk.

Magisk stores only parts of the install script in `addon.d`.
All other files required for installation are placed within `/data`, 
which (in our case) is encrypted and thus unavailable.
Lygisk will keep all required files for reinstallation ready within `addon.d`.
That is actually the whole reason why Lygisk exists: You don't need to re-flash Lygisk after OTA manually.

If you use Lygisk when your storage is not encrypted anyway, it won't give you an advantage, but it will still work.

## Bug reports

Please only report bugs to us if you are sure that they appear because of our work.
If you are unsure, just try out [Magisk](https://github.com/topjohnwu/Magisk) and if the same issue appears there, report it there.

Only report bugs on `stable` builds.
If you need to report a bug, install the [`debug` variant](https://raw.githubusercontent.com/programminghoch10/Lygisk/deploy/stable/app-debug.apk) first. 
In your bug report include a `logcat`, `dmesg`, the Lygisk logs found inside the app and `/tmp/recovery.log` for addond and install issues.

## Useful Links

Join our [Telegram Group](https://t.me/Lygisk) for asking quick questions or to get the latest news directly.

Anything further is equal to [Magisk](https://github.com/topjohnwu/Magisk).

You can go and check [their resources](https://github.com/topjohnwu/Magisk#Useful-Links).

## License

Our license obviously is the same as [Magisk's license](https://github.com/topjohnwu/Magisk#License)

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
