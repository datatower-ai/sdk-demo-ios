#!/usr/bin/perl
use strict;
use utf8;
#use warnings;
no warnings;
use feature "switch";
use Cwd qw(cwd);
use File::Spec::Functions qw(catfile);
use File::Copy;
use File::Path qw(rmtree make_path);
use File::Basename;
use Storable qw(dclone);

# Known bugs:
# idb install package to simulator on ARM macs:
# https://github.com/facebook/idb/issues/814

# Actions:
# {help, init, build, runDemoObjc, runDemoSwift, archive, clean}

our $DTSDK_IS_RELEASE_BUILD = 0;
our $DTSDK_RUN_DEMO_ON_UDID = "";

our $dtsdk_project_root_dir = undef;
our $dtsdk_build_output_dir = undef;

sub main {
    my($action) = @_;
    if (!defined($action)) {
        &execActionPrintHelpMessage();
        exit;
    }

    $dtsdk_project_root_dir = cwd();
    $dtsdk_build_output_dir = catfile($dtsdk_project_root_dir, ".build");

    given($action) {
        when("help") {
            &execActionPrintHelpMessage();
        }
        when("doctor") {
            &execActionCheckBuildEnvironment();
        }
        when("init") {
            &execActionInit();
        }
        when("build") {
            &execActionBuild();
        }
        when("runDemoObjc") {
            &execActionRunDemoObjc();
        }
        when("dist") {
            &execActionDist();
        }
        when("clean") {
            &execActionClean();
        }
        default {
            die("Unknown action");
        }
    }
}

sub execActionPrintHelpMessage {
    my $message = <<EOF;
    |Usage: perl ./build.pl <action>
    |
    |help:
    |  Prints help message.
    |
    |doctor:
    |  Checks requirements for building & running this project.
    |
    |init:
    |  Initialize this project, including setting up dependencies.
    |
    |build:
    |  Build this project, including demo apps.
    |
    |runDemoObjc:
    |  Run demo app written in Objective-C.
    |
    |runDemoSwift:
    |  Run demo app written in Swift.
    |
    |archive:
    |  Archive SDK into an xcframework.
    |
    |clean:
    |  Clean build outputs.
    |
EOF
    $message =~ s/^\s+\|//gm;
    print($message);
}

sub execActionInit {
    my $exitCode = system("git", "submodule", "update", "--recursive", "--init");
    if ($exitCode != 0) {
        exit($exitCode);
    }

    $exitCode = system("pod", "install");
    if ($exitCode != 0) {
        exit($exitCode);
    }
}

sub execActionCheckBuildEnvironment {
    my $isCheckFailed = 0;
    if (system("xcodebuild", "-version") != 0) {
        $isCheckFailed = 1;
        print("Missing Xcode, please install Xcode.\n");
    }
    print("\n");

    if (system("idb_companion", "--version") != 0) {
        $isCheckFailed = 1;
        print("idb isn't installed properly, see: https://fbidb.io/docs/installation\n");
    }
    if (system("bash", "-c", "idb --help > /dev/null") != 0) {
        $isCheckFailed = 1;
        print("idb isn't installed properly, see: https://fbidb.io/docs/installation\n");
    }

    if (!$isCheckFailed) {
        print("\nYou're good to go.\n");
    }
}

sub configureEnvironmentVariables {
    my $envVar = $ENV{"DTSDK_IS_RELEASE_BUILD"};
    if (!defined($envVar)) {
        $DTSDK_IS_RELEASE_BUILD = 0;
    } elsif (lc($envVar) eq "true" or lc($envVar) eq "1") {
        $DTSDK_IS_RELEASE_BUILD = 1;
    } else {
        $DTSDK_IS_RELEASE_BUILD = 0;
    }

    $envVar = $ENV{"DTSDK_RUN_DEMO_ON_UDID"};
    if (defined($envVar)) {
        $DTSDK_RUN_DEMO_ON_UDID = $envVar;
    }
}

sub execActionBuild {
    my @cmdBase = ("xcodebuild",
        "-workspace", "demo.xcworkspace",
        "-destination", "platform=iOS",
        "-derivedDataPath", $dtsdk_build_output_dir,
        "-allowProvisioningUpdates"
    );
    my @cmd = @{dclone(\@cmdBase)};
    push(@cmd, "-scheme", "demoObjc");
    push(@cmd, "-configuration");
    if ($DTSDK_IS_RELEASE_BUILD eq 1) {
        push(@cmd, "Release")
    } else {
        push(@cmd, "Debug")
    }
    push(@cmd, "build");
    my $exitCode = system(@cmd);
}

sub execActionRunDemoObjc {
    &configureEnvironmentVariables();
    if (length($DTSDK_RUN_DEMO_ON_UDID) == 0) {
        print("Please specify your iOS device to env var 'DTSDK_RUN_DEMO_ON_UDID'.\n");
        print("Run 'idb list-targets' to list available devices.\n");
        exit(1);
    }

    my $appToInstall = catfile($dtsdk_project_root_dir,
        ".build", "Build", "Products", "Debug-iphoneos", "demoObjc.app");
    if (!-e $appToInstall) {
        die("Please build the project first by running command './build.pl build'");
    }

    my $exitCode = system("idb",
        "install",
        "--udid", $DTSDK_RUN_DEMO_ON_UDID,
        $appToInstall
    );
}

sub execActionRunDemoSwift {
    die("Unimplemented");
}

sub execActionDist {
    die("Unimplemented");
}

sub execActionClean {
    rmtree($dtsdk_build_output_dir);
}

&main(@ARGV);
