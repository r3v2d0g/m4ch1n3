{ rustChannelOf }:

let
  channel = rustChannelOf {
    channel = "nightly";
    date = "2021-06-15";
    sha256 = "1hrgvv48zd479jkn3lpb78miycy8m347pn5gvb7lz9lsxmzhyiw4";
  };
in channel.rust.override { extensions = ["rust-src"]; }
