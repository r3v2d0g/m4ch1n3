{ fetchFromGitHub, paper-icon-theme }:

paper-icon-theme.overrideAttrs (prev: {
  version = "2020-03-12";
  src = fetchFromGitHub {
    owner = "snwh";
    repo = "paper-icon-theme";
    rev = "aa3e8af7a1f0831a51fd7e638a4acb077a1e5188";
    sha256 = "0x6qzch4rrc8firb1dcf926j93gpqxvd7h6dj5wwczxbvxi5bd77";
  };
})
