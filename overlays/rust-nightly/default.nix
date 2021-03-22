{ rustChannelOf }:

let
  channel = rustChannelOf {
    channel = "nightly";
    date = "2021-02-26";
    sha256 = "0j2pd8b9pbwgysray9fz7fhdihffqdrghyp1xaxzsy0lzknghf45";
  };
in channel.rust.override { extensions = ["rust-src"]; }
