'use strict';

var gulp = require('gulp');
var _ = require('lodash');
var gutil = require('gulp-util');
var pjson = require('./package.json');

//flash compile
var shell = require('gulp-shell');
var flexSDK = './vendor/flex_sdk_4.6/bin/mxmlc';
var flashSrcPath = './src';
var mainFlash = 'SampleAd';
var outputFlash = 'dummy-vpaid-as3';
var outputFlashVersion = pjson.version;
var libFiles = './lib/AS3-IABLib-master/bin/IABLib.swc';

var buildPath = './build';

gulp.task('compile:flash', function () {
    gutil.log('compile:flash start...');

    var files = [
        {
            path: flashSrcPath + '/vn/lowngow/' + mainFlash + '.as',
            fileOutputPath: buildPath + '/' + outputFlash + '-' + outputFlashVersion + '.swf'
        }
    ];

    return gulp.src(
        files.map(function (file) {
            gutil.log('compile:flash reading ' + file.path);
            return file.path;
        }), {read: false})
        .pipe(shell(
            [
                /* sample expected command:
                 * ./vendor/flex_sdk_4.6/bin/mxmlc
                 *      -output ./build/dummy-vpaid-as3.swf
                 *      -runtime-shared-library-path=./lib/AS3-IABLib-master/bin/IABLib.swc,...
                 *      -library-path=./lib/AS3-IABLib-master/bin/IABLib.swc,... // OK
                 *      -include-libraries=./lib/AS3-IABLib-master/bin/IABLib.swc,... // OK
                 *      -external-library-path=./lib/AS3-IABLib-master/bin/IABLib.swc,...
                 *      ./src/vn/lowngow/SampleAd.as
                 *      -compiler.source-path ./src/
                 *      -target-player=11.1
                 */
                '<%= mxmlc %>'
                + ' -output <%= fileOutput(file.path) %>'
                + ' -library-path=<%= libFiles %>'
                + ' <%= file.path %>'
                + ' -compiler.source-path <%= srcPath %>'
                + ' -target-player=<%= flashVersion %>'
                + ' -static-link-runtime-shared-libraries=true'
            ],
            {
                templateData: {
                    fileOutput: function (filePath) {
                        return _.find(files, function (file) {
                            return filePath.indexOf(file.path.substring(1, file.path.length)) > -1; // cutoff '.' at beginning of file.path
                        }).fileOutputPath;
                    },
                    mxmlc: flexSDK,
                    srcPath: flashSrcPath,
                    flashVersion: '11.1', // version 11.1 is minimum version for flex builder 4.6
                    libFiles: libFiles
                },
                verbose: true,
                errorMessage: 'Command `<%= command %>` failed with exit code <%= error.code %>'
            }
        )
    );
});

gulp.task('default', ['compile:flash']);
