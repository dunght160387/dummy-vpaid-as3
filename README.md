# dummy-vpaid-as3

Get started
-----------

1. Install dependencies

```
npm install
```
(This command also will automatically download flex_sdk_4.6.zip (if not existed) and extract to folder ./vendor.
We use `./vendor/flex_sdk_4.6/bin/mxmlc` to compile our source code.)

1. Config

Extract lib/AS3-IABLib-master.zip to lib/AS3-IABLib-master, include lib/AS3-IABLib-master/bin/IABLib.swc as library for this project.
Also need some setting to init project (SDK, version, root dir, main class, output...).

1. Build

```
gulp
```

The compiled vpaid-client file will be found in ./build directory.
To change version, edit version in package.json as

```
{
    ...
    "version": "x.y.z",
    ...
}
```